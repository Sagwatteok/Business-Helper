<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="brand">
            <img src="${pageContext.request.contextPath}/images/bizmate-logo.png"
                 alt="BizMate"
                 class="brand-logo">
        </a>

        <nav class="sidebar-nav">
            <a href="${pageContext.request.contextPath}/dashboard.jsp" class="nav-item ${param.activeMenu eq 'dashboard' ? 'is-active' : ''}">
                <span class="nav-icon" aria-hidden="true"></span>
                대시보드
            </a>

            <a href="${pageContext.request.contextPath}/sales/sales_list.jsp" class="nav-item ${param.activeMenu eq 'sales' ? 'is-active' : ''}">
                <span class="nav-icon" aria-hidden="true"></span>
                매출 데이터
            </a>

            <a href="${pageContext.request.contextPath}/expense/expense_list.jsp"
               class="nav-item ${param.activeMenu eq 'expense' ? 'is-active' : ''}">
                <span class="nav-icon"></span>
                지출 관리
            </a>

            <a href="${pageContext.request.contextPath}/product/product_list.jsp"
               class="nav-item ${param.activeMenu eq 'product' ? 'is-active' : ''}">
                <span class="nav-icon" aria-hidden="true"></span>
                상품 관리
            </a>

            <a href="#" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                분석 리포트
            </a>

            <a href="#" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                AI 경영 코칭
            </a>
        </nav>

        <div class="sidebar-bottom">
            <a href="#" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                설정
            </a>
        </div>
    </aside>
