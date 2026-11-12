package com.bizmate.controller;

import java.io.IOException;
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
import javax.servlet.http.HttpSession;

import com.bizmate.model.Product;

@WebServlet("/product/edit")
public class ProductEditServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	@SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<Product> products = (List<Product>) session.getAttribute("products");

        if(products == null) {
        	response.sendRedirect(request.getContextPath()+"/product/list");
        	return;
        }
        
        //상품 목록을 담은 요청을 상품 수정 JSP로 전달
        request.setAttribute("products", products );
        request.getRequestDispatcher("/views/product/product_edit.jsp").forward(request, response);
    }
	
	//상품 ID로 수정 대상 찾기
    private Product findProduct(List<Product> products, String productId) {
        for (Product product : products) {
            if (product.getProductId().equals(productId)) {
                return product;
            }
        }
        return null;
    }

    @Override
    @SuppressWarnings("unchecked")
    //수정 화면에서 보낸 여러 상품을 검사하고 모두 정상이면 세션 상품에 변경값을 반영하는 메서드
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("products") == null) {
            response.sendRedirect(request.getContextPath() + "/product/list");
            return;
        }

        List<Product> products = (List<Product>) session.getAttribute("products");

        String[] productIds = request.getParameterValues("productId");
        String[] productNames = request.getParameterValues("productName");
        String[] categories = request.getParameterValues("category");
        String[] salePrices = request.getParameterValues("salePrice");
        String[] estimatedCosts = request.getParameterValues("estimatedCost");
        String[] saleStatuses = request.getParameterValues("saleStatus");

        if (productIds == null || productNames == null
                || categories == null || salePrices == null
                || estimatedCosts == null || saleStatuses == null) {

            showEditError(request, response, "수정할 상품 정보를 확인해 주세요.");
            return;
        }

        int count = productIds.length;

        if (productNames.length != count || categories.length != count
                || salePrices.length != count || estimatedCosts.length != count
                || saleStatuses.length != count) {

            showEditError(request, response, "전송된 상품 정보의 개수가 맞지 않습니다.");
            return;
        }

        List<Product> targets = new ArrayList<>();
        Set<String> checkedIds = new HashSet<>();

        //검사
        for (int i = 0; i < count; i++) {
            if (!checkedIds.add(productIds[i])) {
                showEditError(request, response, "같은 상품이 중복 전송되었습니다.");
                return;
            }

            Product target = findProduct(products, productIds[i]);
            if (target == null) {
                showEditError(request, response,"목록에 없는 상품입니다. 수정 화면을 다시 열어 주세요.");
                return;
            }

            String errorMessage = validateProduct(productNames[i], categories[i],salePrices[i], estimatedCosts[i], saleStatuses[i]);
            if (errorMessage != null) {
                showEditError(request, response,(i + 1) + "번째 상품: " + errorMessage);
                return;
            }

            targets.add(target);
        }

        //문제가 없다고 검사한 대상 상품 수정
        for (int i = 0; i < count; i++) {
            Product target = targets.get(i);

            target.setProductName(productNames[i].trim());
            target.setCategory(categories[i]);
            target.setSalePrice(Long.parseLong(salePrices[i]));
            target.setEstimatedCost(Long.parseLong(estimatedCosts[i]));
            target.setSaleStatus(saleStatuses[i]);
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
}
