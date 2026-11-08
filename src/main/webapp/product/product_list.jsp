<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
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
  <jsp:include page="/WEB-INF/views/sidebar.jsp">
    <jsp:param name="activeMenu" value="product" />
  </jsp:include>

  <div class="page-area">
    <ui:header eyebrow="Products" title="상품 관리" />

    <main class="main-content preview-main">
      <section class="preview-table-card product-list-card">
        <div class="card-header">
          <div>
            <h2 id="product-list-title">상품 목록</h2>
            <p>매장에서 판매하는 상품의 가격과 상태를 확인하세요.</p>
            <p id="product-margin-note">
              금액은 상품 1개 기준입니다. 예상 마진은 판매가에서 추정 원가를 뺀 금액입니다.
            </p>
          </div>

          <div class="product-header-actions">
            <a href="product_form.jsp" class="primary-button">상품 등록</a>
            <a href="product_edit.jsp" class="secondary-button">수정</a>
          </div>
        </div>

        <div class="table-scroll">
          <table class="preview-table product-table">
            <thead>
            <tr>
              <th scope="col">상품명</th>
              <th scope="col">카테고리</th>
              <th scope="col">판매가</th>
              <th scope="col">추정 원가</th>
              <th scope="col">예상 마진</th>
              <th scope="col">판매 상태</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <th scope="row">아메리카노</th>
              <td>커피</td>
              <td>₩ 4,500</td>
              <td>₩ 1,200</td>
              <td>₩ 3,300</td>
              <td>판매 중</td>
            </tr>
            <tr>
              <th scope="row">카페라떼</th>
              <td>커피</td>
              <td>₩ 5,500</td>
              <td>₩ 1,800</td>
              <td>₩ 3,700</td>
              <td>판매 중</td>
            </tr>
            <tr>
              <th scope="row">바닐라라떼</th>
              <td>커피</td>
              <td>₩ 6,000</td>
              <td>₩ 2,100</td>
              <td>₩ 3,900</td>
              <td class="product-status-inactive">판매 중지</td>
            </tr>
            </tbody>
          </table>
        </div>
      </section>
    </main>
  </div>
</div>

</body>
</html>
