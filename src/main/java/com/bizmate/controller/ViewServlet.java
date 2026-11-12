package com.bizmate.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 기존 화면 주소를 유지하면서 WEB-INF 안의 JSP로 전달
@WebServlet(urlPatterns = {
    "/dashboard.jsp",
    "/product/product_list.jsp",
    "/product/product_form.jsp",
    "/product/product_edit.jsp",
    "/sales/validation.jsp",
    "/sales/upload.jsp",
    "/sales/sales_list.jsp",
    "/sales/sales_form.jsp",
    "/sales/sales_edit.jsp",
    "/sales/preview.jsp",
    "/sales/mapping.jsp",
    "/expense/expense_edit.jsp",
    "/expense/expense_form.jsp",
    "/expense/expense_upload.jsp",
    "/expense/expense_review.jsp",
    "/expense/expense_preview.jsp",
    "/expense/expense_mapping.jsp",
    "/expense/expense_list.jsp"
})
public class ViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String viewPath = request.getServletPath();

        if ("/product/product_list.jsp".equals(viewPath)) {
            response.sendRedirect(request.getContextPath() + "/product/list");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views" + viewPath)
                .forward(request, response);
    }
}
