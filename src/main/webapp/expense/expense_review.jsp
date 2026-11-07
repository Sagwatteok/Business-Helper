<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
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
        href="${pageContext.request.contextPath}/css/product.css">
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/css/expense.css">
</head>

<body>
<div class="app-layout">
  <jsp:include page="/WEB-INF/views/sidebar.jsp">
    <jsp:param name="activeMenu" value="expense" />
  </jsp:include>

  <div class="page-area">
    <ui:header eyebrow="Expenses" title="비용 관리" />

    <main class="main-content preview-main">
      <section class="preview-table-card">
        <div class="card-header">
          <div>
            <h2>지출 내역 확인·보완</h2>
            <p>샘플 3건입니다. 수정할 지출일·분류·지출 내용·금액을 클릭해 변경할 수 있어요. 비어 있는 금액을 입력하고 필요한 지출에 메모를 추가해 주세요.</p>
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
            <tr>
              <td data-edit="date">2026-11-05</td>
              <td data-edit="category">기타</td>
              <td data-edit="description">포장 용기 구입</td>
              <td class="expense-amount" data-edit="amount" data-value="32000">₩ 32,000</td>
              <td>
                <input type="text" class="expense-review-memo"
                       title="포장 용기 구입 메모" placeholder="메모 입력">
              </td>
            </tr>
            <tr>
              <td data-edit="date">2026-11-03</td>
              <td data-edit="category">재료비</td>
              <td data-edit="description">원두 구입</td>
              <td class="expense-amount" data-edit="amount" data-value=""></td>
              <td>
                <input type="text" class="expense-review-memo"
                       title="원두 구입 메모" placeholder="메모 입력">
              </td>
            </tr>
            <tr>
              <td data-edit="date">2026-11-01</td>
              <td data-edit="category">임대료</td>
              <td data-edit="description">11월 매장 임대료</td>
              <td class="expense-amount" data-edit="amount" data-value="700000">₩ 700,000</td>
              <td>
                <input type="text" class="expense-review-memo"
                       title="11월 매장 임대료 메모" placeholder="메모 입력">
              </td>
            </tr>
            </tbody>
          </table>
        </div>

        <div class="preview-actions">
          <a href="expense_mapping.jsp" class="secondary-button">이전: 열 매핑</a>
        </div>
      </section>
    </main>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/expense_review.js"></script>
</body>
</html>
