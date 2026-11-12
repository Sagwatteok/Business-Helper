package com.bizmate.controller;

import java.io.IOException;
import java.util.List;

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
}
