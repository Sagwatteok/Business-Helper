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
            <p>샘플 3건입니다. 메모가 필요한 지출에만 입력해 주세요.</p>
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
              <td>2026-11-05</td>
              <td>기타</td>
              <td>포장 용기 구입</td>
              <td class="expense-amount">₩ 32,000</td>
              <td>
                <input type="text" class="expense-review-memo"
                       title="포장 용기 구입 메모" placeholder="메모 입력">
              </td>
            </tr>
            <tr>
              <td>2026-11-03</td>
              <td>재료비</td>
              <td>원두 구입</td>
              <td class="expense-amount">₩ 80,000</td>
              <td>
                <input type="text" class="expense-review-memo"
                       title="원두 구입 메모" placeholder="메모 입력">
              </td>
            </tr>
            <tr>
              <td>2026-11-01</td>
              <td>임대료</td>
              <td>11월 매장 임대료</td>
              <td class="expense-amount">₩ 700,000</td>
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

</body>
</html>
