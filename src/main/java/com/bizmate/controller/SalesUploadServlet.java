package com.bizmate.controller;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PushbackReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bizmate.model.CsvUploadData;
import com.bizmate.util.CsvReader;

//미리보기용 데이터를 세션에 보관
@WebServlet("/sales/upload")
@MultipartConfig(
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 11 * 1024 * 1024
) //파일을 받도록 설정(10MB, 11MB)
public class SalesUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/views/sales/upload.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        request.getSession().removeAttribute("salesCsvDraft");
        request.getSession().removeAttribute("salesCsvUpload");

        Part file;

        try {
            file = request.getPart("salesFile"); //파일 전송 항목 가져옴
        } catch (IllegalStateException e) {
            showUploadError(request, response, "파일 크기는 10MB 이하여야 합니다.");
            return;
        } catch (ServletException e) {
            showUploadError(request, response, "파일 전송 형식을 확인해 주세요.");
            return;
        }

        if (file == null || file.getSize() == 0) {
            showUploadError(request, response, "CSV 파일을 선택해 주세요.");
            return;
        }

        String fileName = file.getSubmittedFileName();

        if (fileName == null
                || !fileName.toLowerCase(Locale.ROOT).endsWith(".csv")) {
            showUploadError(request, response, "CSV 파일만 업로드할 수 있습니다.");
            return;
        }

        CsvUploadData uploadData;

        try {
            uploadData = readCsv(file, fileName);
        } catch (IllegalArgumentException e) {
            showUploadError(request, response, e.getMessage());
            return;
        } catch (IOException e) {
            showUploadError(request, response,
                    "파일을 읽을 수 없습니다. UTF-8 인코딩과 CSV 형식을 확인해 주세요.");
            return;
        }

        request.getSession().setAttribute("salesCsvUpload", uploadData);

        response.sendRedirect(request.getContextPath() + "/sales/preview.jsp");
    }

    private CsvUploadData readCsv(Part file, String fileName) throws IOException {

        try (PushbackReader reader = new PushbackReader(
                new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8.newDecoder()), 1)) {

            int first = reader.read();

            if (first != -1 && first != '\uFEFF') {
                reader.unread(first);
            }

            List<String> headers = CsvReader.readRow(reader);

            if (headers == null) {
                throw new IllegalArgumentException("파일에 열 이름이 없습니다.");
            }

            for (String header : headers) {
                if (header.trim().isEmpty()) {
                    throw new IllegalArgumentException("열 이름에 빈칸이 있습니다.");
                }
            }

            List<List<String>> rows = new ArrayList<>();
            List<String> row;

            while ((row = CsvReader.readRow(reader)) != null) {
                if (row.size() == 1 && row.get(0).isEmpty()) {
                    continue;
                }

                if (row.size() != headers.size()) {
                    throw new IllegalArgumentException(
                            (rows.size() + 1) + "번째 데이터의 열 개수가 맞지 않습니다.");
                }

                if (rows.size() >= 10000) {
                    throw new IllegalArgumentException(
                            "데이터는 최대 10,000행까지 업로드할 수 있습니다.");
                }

                rows.add(row);
            }

            if (rows.isEmpty()) {
                throw new IllegalArgumentException("파일에 매출 데이터가 없습니다.");
            }

            return new CsvUploadData(fileName, headers, rows);
        }
    }

    private void showUploadError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("uploadError", message);

        request.getRequestDispatcher("/views/sales/upload.jsp")
                .forward(request, response);
    }
}