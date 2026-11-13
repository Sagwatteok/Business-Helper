<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${requestScope.sales == null}">
    <jsp:forward page="/sales/edit" />
</c:if>

<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>BizMate | 매출 수정</title>
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
      <section class="preview-table-card sales-edit-card">
        <div class="card-header">
          <div>
            <h2>매출 내역 수정</h2>
            <p>수정할 값을 클릭하세요.</p>
            <p>금액은 해당 상품 행의 품목 합계입니다.</p>
          </div>

          <a href="sales_list.jsp" class="secondary-button">목록으로</a>
        </div>

        <div class="sales-summary">
          <p>표시 중인 매출 합계</p>
          <strong id="sales-edit-total">
            ₩ <fmt:formatNumber value="${requestScope.totalSalesAmount}" pattern="#,##0" />
          </strong>
        </div>

        <c:if test="${not empty requestScope.errorMessage}">
          <p><c:out value="${requestScope.errorMessage}" /></p>
        </c:if>

        <form id="sales-edit-form" action="${pageContext.request.contextPath}/sales/edit" method="post">

        <div class="table-scroll">
          <table class="preview-table sales-table sales-edit-table">
            <thead>
            <tr>
              <th scope="col">판매일자</th>
              <th scope="col">상품명</th>
              <th scope="col">수량</th>
              <th scope="col">품목 합계</th>
              <th scope="col">주문 경로</th>
              <th scope="col">삭제</th>
            </tr>
            </thead>
            
            <tbody>
            <c:forEach var="sale" items="${requestScope.sales}">
              <tr data-sale-id="${sale.saleId}">
                <td data-field="date" data-value="${sale.saleDate}">
                  <c:out value="${sale.saleDateText}" />
                </td>
                
                <td data-field="product">
                  <c:out value="${sale.productName}" />
                </td>
                
                <td data-field="quantity" data-value="${sale.quantity}">
                  <fmt:formatNumber value="${sale.quantity}" pattern="#,##0" />
                </td>
                
                <td data-field="amount" data-value="${sale.amount}">
                  ₩ <fmt:formatNumber value="${sale.amount}" pattern="#,##0" />
                </td>
                
                <td data-field="channel">
                  <c:out value="${sale.orderChannel}" />
                </td>
                
                <td>
                  <button type="button" class="sales-delete-button" disabled>
                    삭제
                  </button>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>

          <p id="sales-empty-message" hidden>표시할 매출 내역이 없습니다.</p>
        </div>

        <div class="preview-actions sales-edit-actions">
          <a href="sales_list.jsp" class="secondary-button">취소</a>
          <button type="button" id="sales-edit-save"
                  class="primary-button" disabled>저장
          </button>
        </div>
        </form>
      </section>
    </main>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/sales_edit.js"></script>
</body>
</html>
