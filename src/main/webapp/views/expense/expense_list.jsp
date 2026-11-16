<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${requestScope.expenses == null}">
    <jsp:forward page="/expense/list" />
</c:if>

<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 지출 관리</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/expense.css">
</head>

<body>
<div class="app-layout">
    <jsp:include page="/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="expense" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Expenses" title="지출 관리" />

        <main class="main-content preview-main">
            <section class="preview-table-card">
                <div class="card-header">
                    <div>
                        <h2>지출 내역</h2>
                        <p>매장 운영에 실제로 지출한 내역을 확인하세요.</p>
                    </div>

                    <div class="expense-header-actions">
                        <a href="expense_upload.jsp"
                           class="secondary-button">CSV로 가져오기</a>
                        <a href="expense_form.jsp" class="primary-button expense-action-button">+ 지출 추가</a>
                        <a href="expense_edit.jsp" class="expense-action-button expense-edit-button">수정</a>
                    </div>
                </div>

                <div class="sales-summary">
                    <p>등록 지출 합계</p>
                    <strong>
                        ₩ <fmt:formatNumber value="${requestScope.totalExpenseAmount}" pattern="#,##0" />
                    </strong>
                </div>

                <div class="table-scroll">
                    <table class="preview-table expense-table">
                        <thead>
                        <tr>
                            <th scope="col">지출일</th>
                            <th scope="col">분류</th>
                            <th scope="col">지출 내용</th>
                            <th scope="col">금액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="expense" items="${requestScope.expenses}">
                            <tr>
                                <td>
                                    <c:out value="${expense.expenseDate}" />
                                </td>
                                <td>
                                    <c:out value="${expense.category}" />
                                </td>
                                <td>
                                    <c:out value="${expense.description}" />
                                </td>
                                <td class="expense-amount">
                                    ₩ <fmt:formatNumber value="${expense.amount}" pattern="#,##0" />
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty requestScope.expenses}">
                            <tr>
                                <td colspan="4">등록된 지출이 없습니다.</td>
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
