<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
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
            <p>샘플 데이터입니다. 선택한 CSV의 내용은 아직 표시하지 않습니다.</p>
          </div>
        </div>

        <div class="preview-actions">
          <a href="expense_upload.jsp" class="secondary-button">이전: 파일 다시 선택</a>
          <a href="expense_mapping.jsp" class="secondary-button">다음 단계로 이동</a>
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
            <tr>
              <td>2026-11-05</td>
              <td>기타</td>
              <td>포장 용기 구입</td>
              <td class="expense-amount">₩ 32,000</td>
            </tr>
            <tr>
              <td>2026-11-03</td>
              <td>재료비</td>
              <td>원두 구입</td>
              <td class="expense-amount">₩ 80,000</td>
            </tr>
            <tr>
              <td>2026-11-01</td>
              <td>임대료</td>
              <td>11월 매장 임대료</td>
              <td class="expense-amount">₩ 700,000</td>
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
