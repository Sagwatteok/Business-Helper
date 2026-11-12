<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>BizMate | 상품 관리</title>

  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/dashboard.css">
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/preview.css">
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/product.css">
</head>

<body>
<div class="app-layout">
  <jsp:include page="/views/sidebar.jsp">
    <jsp:param name="activeMenu" value="product" />
  </jsp:include>

  <div class="page-area">
    <ui:header eyebrow="Products" title="상품 관리" />

    <main class="main-content preview-main">
      <section class="preview-table-card product-form-card">
        <h2 id="product-form-title">상품 정보 입력</h2>

        <c:if test="${not empty requestScope.errorMessage}">
          <p><c:out value="${requestScope.errorMessage}" /></p>
        </c:if>

        <form id="product-form"
              action="${pageContext.request.contextPath}/product/list"
              method="post">
          <p>
            <label for="product-name">상품명</label><br>
            <input id="product-name" name="productName" type="text" required>
          </p>

          <p>
            <label for="category">카테고리</label><br>
            <select id="category" name="category" required>
              <option value="">카테고리를 선택하세요</option>
              <option>커피</option>
              <option>음료</option>
              <option>디저트</option>
              <option>식사</option>
              <option>주류</option>
              <option>굿즈</option>
              <option>기타</option>
            </select>
          </p>

          <p>
            <label for="sale-price">판매가 (원)</label><br>
            <input id="sale-price" name="salePrice" type="number"
                   min="0" step="1" required>
          </p>

          <p>
            <label for="estimated-cost">상품 1개당 추정 원가 (원)</label><br>
            <input id="estimated-cost" name="estimatedCost" type="number"
                   min="0" step="1" required>
          </p>

          <p class="product-margin">
            예상 마진
            <output id="estimated-margin" for="sale-price estimated-cost">—</output>
          </p>

          <p class="product-sale-status">
            <label for="sale-status">판매 상태</label><br>
            <select id="sale-status" name="saleStatus">
              <option value="active">판매 중</option>
              <option value="inactive">판매 중지</option>
            </select>
          </p>

          <div id="margin-warning" class="product-margin-warning" hidden="hidden">
            <p id="margin-warning-message"></p>
            <div class="product-margin-warning-actions">
              <button id="confirm-negative-margin" type="button">그래도 등록</button>
              <button id="cancel-negative-margin" type="button">다시 입력</button>
            </div>
          </div>

          <div class="preview-actions">
            <a href="product_list.jsp" class="secondary-button">취소</a>
            <button id="product-submit" type="submit">상품 등록</button>
          </div>
        </form>
      </section>
    </main>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/product_form.js"></script>
</body>
</html>
