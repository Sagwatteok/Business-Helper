<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
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
  <jsp:include page="/WEB-INF/views/sidebar.jsp">
    <jsp:param name="activeMenu" value="sales" />
  </jsp:include>
  <div class="page-area">
    <ui:header eyebrow="Sales Data" title="매출 데이터" />
    <main class="main-content preview-main">
      <section class="preview-table-card sales-edit-card">
        <div class="card-header">
          <div>
            <h2>매출 내역 수정</h2>
            <p>샘플 데이터입니다. 수정할 값을 클릭하세요.</p>
            <p>금액은 해당 상품 행의 품목 합계입니다.</p>
          </div>

          <a href="sales_list.jsp" class="secondary-button">목록으로</a>
        </div>

        <div class="sales-summary">
          <p>표시 중인 매출 합계</p>
          <strong id="sales-edit-total">₩ 20,500</strong>
        </div>

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
            <tr>
              <td data-field="date" data-value="2026-11-01T09:12">
                2026-11-01 09:12
              </td>
              <td data-field="product">아메리카노</td>
              <td data-field="quantity" data-value="2">2</td>
              <td data-field="amount" data-value="9000">₩ 9,000</td>
              <td data-field="channel">매장 POS</td>
              <td>
                <button type="button" class="sales-delete-button" disabled>
                  삭제
                </button>
              </td>
            </tr>
            <tr>
              <td data-field="date" data-value="2026-11-01T09:18">
                2026-11-01 09:18
              </td>
              <td data-field="product">카페라떼</td>
              <td data-field="quantity" data-value="1">1</td>
              <td data-field="amount" data-value="5500">₩ 5,500</td>
              <td data-field="channel">키오스크</td>
              <td>
                <button type="button" class="sales-delete-button" disabled>
                  삭제
                </button>
              </td>
            </tr>
            <tr>
              <td data-field="date" data-value="2026-11-01T09:25">
                2026-11-01 09:25
              </td>
              <td data-field="product">바닐라라떼</td>
              <td data-field="quantity" data-value="1">1</td>
              <td data-field="amount" data-value="6000">₩ 6,000</td>
              <td data-field="channel">배달의민족</td>
              <td>
                <button type="button" class="sales-delete-button" disabled>
                  삭제
                </button>
              </td>
            </tr>
            </tbody>
          </table>

          <p id="sales-empty-message" hidden>표시할 매출 내역이 없습니다.</p>
        </div>

        <div class="preview-actions sales-edit-actions">
          <a href="sales_list.jsp" class="secondary-button">취소</a>
          <button type="button" id="sales-edit-save"
                  class="primary-button" disabled>
            저장
          </button>
        </div>
      </section>
    </main>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/sales_edit.js"></script>
</body>
</html>
