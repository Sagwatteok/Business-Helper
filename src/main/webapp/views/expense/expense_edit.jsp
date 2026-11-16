<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${requestScope.expenses == null}">
    <jsp:forward page="/expense/edit" />
</c:if>

<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 지출 수정</title>

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
            <section class="preview-table-card expense-edit-card">
                <div class="card-header">
                    <div>
                        <h2>지출 내역 수정</h2>
                        <p>수정할 값을 클릭하세요.</p>
                    </div>

                    <a href="expense_list.jsp" class="secondary-button">목록으로</a>
                </div>

                <div class="sales-summary">
                    <p>표시 중인 지출 합계</p>
                    <strong id="expense-edit-total">
                        ₩ <fmt:formatNumber value="${requestScope.totalExpenseAmount}" pattern="#,##0" />
                    </strong>
                </div>

                <c:if test="${not empty requestScope.errorMessage}">
                    <p><c:out value="${requestScope.errorMessage}" /></p>
                </c:if>

                <form id="expense-edit-form" action="${pageContext.request.contextPath}/expense/edit" method="post">

                <div class="table-scroll">
                    <table class="preview-table expense-table expense-edit-table">
                        <thead>
                        <tr>
                            <th scope="col">지출일</th>
                            <th scope="col">분류</th>
                            <th scope="col">지출 내용</th>
                            <th scope="col">금액</th>
                            <th scope="col">삭제</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="expense" items="${requestScope.expenses}">
                            <tr data-expense-id="${expense.expenseId}">
                                <td data-field="date" data-value="${expense.expenseDate}">
                                    <c:out value="${expense.expenseDate}" />
                                </td>
                                <td data-field="category">
                                    <c:out value="${expense.category}" />
                                </td>
                                <td data-field="description">
                                    <c:out value="${expense.description}" />
                                </td>
                                <td data-field="amount" data-value="${expense.amount}"
                                    class="expense-amount">
                                    ₩ <fmt:formatNumber value="${expense.amount}" pattern="#,##0" />
                                </td>
                                <td>
                                    <button type="button" class="expense-delete-button" disabled>
                                        삭제
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <p id="expense-empty-message" hidden>표시할 지출 내역이 없습니다.</p>
                </div>

                <div class="preview-actions expense-edit-actions">
                    <a href="expense_list.jsp" class="secondary-button">취소</a>
                    <button type="button" id="expense-edit-save"
                            class="primary-button" disabled>
                        저장
                    </button>
                </div>
                </form>
            </section>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/expense_edit.js"></script>
</body>
</html>
