package com.bizmate.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bizmate.model.Product;

@WebServlet("/product/list")
public class ProductListServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = new ArrayList<>();

        products.add(new Product(
                "아메리카노", "커피", 4500, 1200, "active"));

        products.add(new Product(
                "카페라떼", "커피", 5500, 1800, "active"));

        products.add(new Product(
                "바닐라라떼", "커피", 6000, 2100, "inactive"));

        request.setAttribute("products", products);

        request.getRequestDispatcher("/product/product_list.jsp")
                .forward(request, response);
    }
}
