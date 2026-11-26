package com.bizmate.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PushbackReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import com.bizmate.model.CsvUploadData;

//CSV파일을 한 행씩 읽음
public class CsvReader {

    public static CsvUploadData readFile(InputStream input, String fileName)
            throws IOException {

        try (PushbackReader reader = new PushbackReader(new InputStreamReader(input, StandardCharsets.UTF_8.newDecoder()), 1)) {

            int first = reader.read();

            if (first != -1 && first != '\uFEFF') {
                reader.unread(first);
            }

            List<String> headers = readRow(reader);

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

            while ((row = readRow(reader)) != null) {
                if (row.size() == 1 && row.get(0).isEmpty()) {
                    continue;
                }

                if (row.size() != headers.size()) {
                    throw new IllegalArgumentException(
                            (rows.size() + 1) + "번째 데이터의 열 개수가 맞지 않습니다.");
                }

                if (rows.size() >= 10000) {
                    throw new IllegalArgumentException("데이터는 최대 10,000행까지 업로드할 수 있습니다.");
                }

                rows.add(row);
            }

            if (rows.isEmpty()) {
                throw new IllegalArgumentException("파일에 데이터가 없습니다.");
            }

            return new CsvUploadData(fileName, headers, rows);
        }
    }

    public static List<String> readRow(PushbackReader reader) throws IOException {

        List<String> row = new ArrayList<>();
        StringBuilder field = new StringBuilder();

        boolean insideQuotes = false;
        boolean quoteClosed = false;
        boolean hasContent = false;

        int value;

        while ((value = reader.read()) != -1) {
            hasContent = true;
            char character = (char) value;

            if (insideQuotes) {
                if (character == '"') {
                    int next = reader.read();

                    if (next == '"') {
                        field.append('"');
                    } else {
                        insideQuotes = false;
                        quoteClosed = true;

                        if (next != -1) {
                            reader.unread(next);
                        }
                    }
                } else {
                    field.append(character);
                }

                continue;
            }

            if (character == ',') {
                row.add(field.toString());
                field.setLength(0);
                quoteClosed = false;
                continue;
            }

            if (character == '\r' || character == '\n') {
                if (character == '\r') {
                    int next = reader.read();

                    if (next != '\n' && next != -1) {
                        reader.unread(next);
                    }
                }

                row.add(field.toString());
                return row;
            }

            if (quoteClosed) {
                throw new IOException("닫는 따옴표 뒤에 잘못된 문자가 있습니다.");
            }

            if (character == '"') {
                if (field.length() > 0) {
                    throw new IOException("따옴표는 항목의 시작에만 사용할 수 있습니다.");
                }
                insideQuotes = true;
            } else {
                field.append(character);
            }
        }

        if (insideQuotes) {
            throw new IOException("닫히지 않은 따옴표가 있습니다.");
        }

        if (!hasContent) {
            return null;
        }

        row.add(field.toString());
        return row;
    }
}
