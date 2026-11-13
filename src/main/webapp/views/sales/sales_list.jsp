<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${requestScope.sales == null}">
    <jsp:forward page="/sales/list" />
</c:if>

<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 매출 데이터</title>
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
            <section class="preview-table-card">
                <div class="card-header">
                    <div>
                        <h2>매출 내역</h2>
						<p>등록된 상품별 매출 내역을 확인하세요.</p>
                    </div>
                    <div class="sales-header-actions">
                        <a href="upload.jsp" class="secondary-button">CSV로 가져오기</a>
                        <a href="sales_form.jsp" class="primary-button sales-action-button">+ 매출 추가</a>
                        <a href="sales_edit.jsp" class="sales-action-button sales-edit-button">수정</a>
                    </div>
                </div>
                <div class="sales-summary">
                    <p>등록 매출 합계</p>
                    <strong>
                        ₩ <fmt:formatNumber value="${requestScope.totalSalesAmount}" pattern="#,##0" />
                    </strong>
                </div>
                <div class="table-scroll">
                    <table class="preview-table sales-table">
                        <thead>
                        <tr>
                            <th scope="col">판매일자</th>
                            <th scope="col">상품명</th>
                            <th scope="col">수량</th>
                            <th scope="col">품목 합계</th>
                            <th scope="col">주문 경로</th>
                        </tr>
                        </thead>
                        
                        <tbody>
                        <c:forEach var="sale" items="${requestScope.sales}">
                            <tr>
                                <td>
                                    <c:out value="${sale.saleDateText}" />
                                </td>
                                <td>
                                    <c:out value="${sale.productName}" />
                                </td>
                                <td>
                                    <fmt:formatNumber value="${sale.quantity}" pattern="#,##0" />
                                </td>
                                <td class="sales-amount">
                                    ₩ <fmt:formatNumber value="${sale.amount}" pattern="#,##0" />
                                </td>
                                <td>
                                    <c:out value="${sale.orderChannel}" />
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty requestScope.sales}">
                            <tr>
                                <td colspan="5">등록된 매출이 없습니다.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</div>
</body>
</html>
