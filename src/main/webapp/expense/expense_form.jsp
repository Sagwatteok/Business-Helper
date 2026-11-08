<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>BizMate | 지출 추가</title>

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
    <ui:header eyebrow="Expenses" title="지출 관리" />

    <main class="main-content preview-main">
      <section class="preview-table-card">
        <h2>지출 정보 입력</h2>

        <form id="expense-form" class="expense-form">
          <p>
            <label for="expense-date">지출일</label>
            <input id="expense-date" name="expenseDate" type="date" required>
          </p>

          <p class="expense-category-field">
            <label for="expense-category">분류</label>
            <select id="expense-category" name="category" required>
              <option value="">분류를 선택하세요</option>
              <option>재료비</option>
              <option>임대료</option>
              <option>인건비</option>
              <option>공과금</option>
              <option>기타</option>
            </select>
          </p>

          <p class="expense-description-field">
            <label for="expense-description">지출 내용</label>
            <input id="expense-description" name="description" type="text"
                   placeholder="예: 원두 구입" required>
          </p>

          <p>
            <label for="expense-amount">금액 (원)</label>
            <input id="expense-amount" name="amount" type="number"
                   min="1" step="1" required>
          </p>

          <p class="expense-memo-field">
            <label for="expense-memo">메모 <span>(선택)</span></label>
            <textarea id="expense-memo" name="memo" rows="3"
                      placeholder="예: 구매처, 결제 방법, 영수증 관련 메모"></textarea>
          </p>

          <div class="preview-actions">
            <a href="expense_list.jsp" class="secondary-button">취소</a>
            <button type="submit" class="primary-button">지출 등록</button>
          </div>
        </form>
      </section>
    </main>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/expense_form.js"></script>
</body>
</html>
