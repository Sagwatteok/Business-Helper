<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.expenseCsvUpload}">
    <c:redirect url="/expense/upload" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>BizMate | 지출 CSV 미리보기</title>

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
            <h2>가져올 지출 내역</h2>
            <p><c:out value="${sessionScope.expenseCsvUpload.fileName}" /> / 총 ${sessionScope.expenseCsvUpload.rowCount}행, 처음 5개 행만 표시합니다.</p>
          </div>
        </div>

        <div class="preview-actions">
          <a href="${pageContext.request.contextPath}/expense/upload" class="secondary-button">이전: 파일 다시 선택</a>
          <a href="expense_mapping.jsp" class="secondary-button">다음 단계로 이동</a>
        </div>

        <div class="table-scroll">
          <table class="preview-table expense-table">
            <thead>
            <tr>
              <c:forEach var="csvHeader" items="${sessionScope.expenseCsvUpload.headers}">
                <th scope="col"><c:out value="${csvHeader}" /></th>
              </c:forEach>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="row" items="${sessionScope.expenseCsvUpload.rows}" begin="0" end="4">
              <tr>
                <c:forEach var="cell" items="${row}">
                  <td><c:out value="${cell}" /></td>
                </c:forEach>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </section>
    </main>
  </div>
</div>

</body>
</html>
