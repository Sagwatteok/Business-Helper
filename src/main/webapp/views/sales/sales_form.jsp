<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 매출 추가</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/preview.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sales.css">
</head>
<body>
<div class="app-layout">
    <jsp:include page="/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="sales" />
    </jsp:include>
    <div class="page-area">
        <ui:header eyebrow="Sales Data" title="매출 데이터" />
        <main class="main-content preview-main">
            <section class="preview-table-card sales-form-card">
                <h2>매출 정보 입력</h2>
                <p>금액에는 해당 상품 행의 품목 합계를 입력하세요.</p>

                <c:if test="${not empty requestScope.errorMessage}">
                    <p><c:out value="${requestScope.errorMessage}" /></p>
                </c:if>
                
                      <form id="sales-form" class="sales-form"
                      action="${pageContext.request.contextPath}/sales/list"
                      method="post">
                      
                    <p>
                        <label for="sales-date">판매일자</label>
                        <input id="sales-date" name="saleDate" type="datetime-local" required>
                    </p>
                    <p>
                        <label for="sales-product">상품명</label>
                        <input id="sales-product" name="productName" type="text" placeholder="예: 아메리카노" required>
                    </p>
                    <p>
                        <label for="sales-quantity">수량</label>
                        <input id="sales-quantity" name="quantity" type="number" min="1" step="1" required>
                    </p>
                    <p>
                        <label for="sales-amount">품목 합계 (원)</label>
                        <input id="sales-amount" name="amount" type="number" min="1" step="1" placeholder="금액 입력" required>
                    </p>
                    <p>
                        <label for="sales-order">주문번호 (선택)</label>
                        <input id="sales-order" name="orderNo" type="text">
                    </p>
                    <p>
                        <label for="sales-channel">주문 경로 (선택)</label>
                        <input id="sales-channel" name="orderChannel" type="text" placeholder="예: 매장 POS">
                    </p>
                    <div class="preview-actions">
                        <a href="sales_list.jsp" class="secondary-button">취소</a>
                        <button type="submit" class="primary-button">매출 등록</button>
                    </div>
                </form>
            </section>
        </main>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/sales_form.js"></script>
</body>
</html>
