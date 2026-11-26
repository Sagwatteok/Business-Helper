package com.bizmate.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bizmate.dao.ProductDao;
import com.bizmate.model.Product;

@WebServlet("/product/edit")
public class ProductEditServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("products", productDao.findAll());
        } catch (SQLException e) {
            throw new ServletException("상품 목록을 조회하지 못했습니다.", e);
        }

        request.getRequestDispatcher("/views/product/product_edit.jsp").forward(request, response);
    }

    @Override
    //수정 화면에서 보낸 여러 상품을 검사하고 모두 정상이면 DB에 변경값을 반영하는 메서드
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String[] productIds = getValues(request, "productId");
        String[] productNames = getValues(request, "productName");
        String[] categories = getValues(request, "category");
        String[] salePrices = getValues(request, "salePrice");
        String[] estimatedCosts = getValues(request, "estimatedCost");
        String[] saleStatuses = getValues(request, "saleStatus");
        String[] deletedProductIds = getValues(request, "deletedProductId");

        int count = productIds.length;

        if (productNames.length != count || categories.length != count
                || salePrices.length != count || estimatedCosts.length != count
                || saleStatuses.length != count) {

            showEditError(request, response, "전송된 상품 정보의 개수가 맞지 않습니다.");
            return;
        }

        List<Product> updatedProducts = new ArrayList<>();
        Set<String> checkedIds = new HashSet<>();

        for (int i = 0; i < count; i++) {
            if (!checkedIds.add(productIds[i])) {
                showEditError(request, response, "같은 상품이 중복 전송되었습니다.");
                return;
            }

            String errorMessage = validateProduct(productNames[i], categories[i], salePrices[i], estimatedCosts[i], saleStatuses[i]);
            if (errorMessage != null) {
                showEditError(request, response, (i + 1) + "번째 상품: " + errorMessage);
                return;
            }

            updatedProducts.add(new Product(productIds[i], productNames[i].trim(), categories[i], Long.parseLong(salePrices[i]), Long.parseLong(estimatedCosts[i]), saleStatuses[i]));
        }

        for (String productId : deletedProductIds) {
            if (!checkedIds.add(productId)) {
                showEditError(request, response, "수정 또는 삭제 대상 상품 ID가 중복되었습니다.");
                return;
            }
        }

        try {
            productDao.saveChanges(updatedProducts, deletedProductIds);
        } catch (SQLException e) {
            log("상품 수정 및 삭제 실패", e);
            showEditError(request, response, "상품 변경 사항을 저장하지 못했습니다. 목록을 확인한 뒤 다시 시도해 주세요.");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/product/list");
    }
    
    //수정값을 서버에서 검사
    private String validateProduct(String productName, String category, String salePrice, String estimatedCost,String saleStatus) {

        if (productName == null || productName.trim().isEmpty()) {
            return "상품명을 입력해 주세요.";
        }

        List<String> categories = Arrays.asList("커피", "음료", "디저트", "식사", "주류", "굿즈", "기타");

        if (!categories.contains(category)) {
            return "카테고리를 확인해 주세요.";
        }

        if (!("active".equals(saleStatus) || "inactive".equals(saleStatus))) {
            return "판매 상태를 확인해 주세요.";
        }

        try {
            long price = Long.parseLong(salePrice);
            long cost = Long.parseLong(estimatedCost);

            if (price < 0 || cost < 0) {
                return "판매가와 추정 원가는 0 이상의 정수로 입력해 주세요.";
            }
        } catch (NumberFormatException e) {
            return "판매가와 추정 원가는 0 이상의 정수로 입력해 주세요.";
        }

        return null;
    }

    //오류 안내 메서드
    private void showEditError(HttpServletRequest request, HttpServletResponse response, String message)throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        doGet(request, response);
    }
    
    //빈 배열 처리
    private String[] getValues(HttpServletRequest request, String name) {
        String[] values = request.getParameterValues(name);
        return values == null ? new String[0] : values;
    }
}
