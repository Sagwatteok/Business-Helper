<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty requestScope.csvUpload or empty requestScope.csvMapping}">
    <c:redirect url="/expense/expense_mapping.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>BizMate | 지출 내역 확인·보완</title>

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
      <c:if test="${not empty requestScope.importError}">
        <p><c:out value="${requestScope.importError}" /></p>
      </c:if>
      <form id="expenseCsvForm" action="${pageContext.request.contextPath}/expense/import" method="post" novalidate>
        <input type="hidden" name="csvDraftToken" value="<c:out value="${requestScope.csvDraftToken}" />">
        <div id="expenseSubmittedValues" hidden></div>
      <section class="preview-table-card">
        <div class="card-header">
          <div>
            <h2>지출 내역 확인·보완</h2>
            <p>총 ${requestScope.csvUpload.rowCount}건입니다. 수정할 값을 클릭하고 비어 있는 항목을 입력해 주세요. 메모는 선택 사항입니다.</p>
          </div>
        </div>

        <div class="table-scroll">
          <table class="preview-table expense-table expense-review-table">
            <thead>
            <tr>
              <th scope="col">지출일</th>
              <th scope="col">분류</th>
              <th scope="col">지출 내용</th>
              <th scope="col">금액</th>
              <th scope="col">메모 (선택)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="row" items="${requestScope.csvUpload.rows}" varStatus="status">
              <tr data-row-index="${status.index}">
                <td data-edit="date"><c:out value="${row[requestScope.csvMapping.expenseDateColumn]}" /></td>
                <td data-edit="category"><c:out value="${row[requestScope.csvMapping.categoryColumn]}" /></td>
                <td data-edit="description"><c:out value="${row[requestScope.csvMapping.descriptionColumn]}" /></td>
                <td class="expense-amount" data-edit="amount"><c:out value="${row[requestScope.csvMapping.amountColumn]}" /></td>
                <td>
                  <input type="text" class="expense-review-memo" title="메모" placeholder="메모 입력" value="<c:out value="${not empty requestScope.importError ? paramValues.memo[status.index] : (requestScope.csvMapping.memoColumn == -1 ? '' : row[requestScope.csvMapping.memoColumn])}" />">
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>

        <div class="preview-actions">
          <a href="expense_mapping.jsp" class="secondary-button">이전: 열 매핑</a>
          <button type="submit" id="expense-review-check" class="secondary-button">지출에 반영</button>
        </div>

        <p id="expense-review-result" hidden></p>

      </section>
      </form>
    </main>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/expense_review.js?v=20261124"></script>
</body>
</html>
