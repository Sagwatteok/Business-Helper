package com.bizmate.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bizmate.dao.ProductDao;
import com.bizmate.model.Product;

@WebServlet("/product/list")
public class ProductListServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("products", productDao.findAll());
        } catch (SQLException e) {
            throw new ServletException("상품 목록을 조회하지 못했습니다.", e);
        }

        request.getRequestDispatcher("/views/product/product_list.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        //문자열 가져오기
        String productName = request.getParameter("productName");
        String category = request.getParameter("category");
        String saleStatus = request.getParameter("saleStatus");

        List<String> categories = Arrays.asList("커피", "음료", "디저트", "식사", "주류", "굿즈", "기타"); //괄호 안의 값들을 List로 묶어줌

        //상품명이 null이거나 공백인 경우 or 허용된 카테고리가 아닌 경우 or 판매 상태가 active도 inactive도 아닌 경우
        if (productName == null || productName.trim().isEmpty() || !categories.contains(category)
                || !("active".equals(saleStatus) || "inactive".equals(saleStatus)) ) {
            error(request, response, "상품명, 카테고리와 판매 상태를 확인해 주세요.");
            return;
        }

        long salePrice;
        long estimatedCost;

        try{
            //사용자가 입력한 값 변환
            salePrice = Long.parseLong(request.getParameter("salePrice"));
            estimatedCost = Long.parseLong(request.getParameter("estimatedCost"));

            if (salePrice < 0 || estimatedCost < 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            error(request, response, "판매가와 추정 원가는 0 이상의 정수로 입력해 주세요.");
            return;
        }

        Product product = new Product(productName.trim(), category, salePrice, estimatedCost, saleStatus);

		try {
			productDao.insert(product);
		} catch (SQLException e) {
			log("상품 등록 실패", e);
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			error(request, response, "상품을 저장하지 못했습니다. 다시 시도해 주세요.");
			return;
		}

        request.getSession().setAttribute("productSaved", true);
        response.sendRedirect(request.getContextPath() + "/product/list"); //프로젝트 기본 주소와 상품 목록 경로 합침
    }


    //에러 처리 메서드
    private void error(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/views/product/product_form.jsp").forward(request, response);
    }
}
