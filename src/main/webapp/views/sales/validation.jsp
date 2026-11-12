<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BizMate | 매출 내역 확인·보완</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sales.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sales_review.css">
</head>

<body>
<div class="app-layout">

    <jsp:include page="/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="sales" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Sales Data" title="매출 데이터" />

        <main class="main-content preview-main">
            <section class="preview-table-card">
                <div class="card-header">
                    <div>
                        <h2>매출 내역 확인·보완</h2>
                        <p>샘플 3건입니다. 수정할 값을 클릭하고 비어 있는 수량과 금액을 입력해 주세요.</p>
                        <p id="sales-amount-guide"></p>
                    </div>
                </div>
                <div class="table-scroll">
                    <table class="preview-table sales-table sales-review-table">
                        <thead>
                        <tr>
                            <th scope="col">판매일자</th>
                            <th scope="col">상품명</th>
                            <th scope="col">수량</th>
                            <th scope="col" id="sales-amount-heading">품목 합계</th>
                            <th scope="col" class="sales-line-total" hidden>품목 합계</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td data-edit="date" data-value="2026-11-01T09:12">2026-11-01 09:12</td>
                            <td data-edit="product">아메리카노</td>
                            <td data-edit="quantity">2</td>
                            <td data-edit="amount" data-value="9000" data-unit-price="4500">₩ 9,000</td>
                            <td class="sales-line-total" hidden></td>
                        </tr>
                        <tr>
                            <td data-edit="date" data-value="2026-11-01T09:18">2026-11-01 09:18</td>
                            <td data-edit="product">카페라떼</td>
                            <td data-edit="quantity"></td>
                            <td data-edit="amount" data-value="5500" data-unit-price="5500">₩ 5,500</td>
                            <td class="sales-line-total" hidden></td>
                        </tr>
                        <tr>
                            <td data-edit="date" data-value="2026-11-01T09:25">2026-11-01 09:25</td>
                            <td data-edit="product">바닐라라떼</td>
                            <td data-edit="quantity">1</td>
                            <td data-edit="amount" data-value="" data-unit-price=""></td>
                            <td class="sales-line-total" hidden></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="preview-actions">
                    <a href="mapping.jsp" id="sales-review-back" class="secondary-button">이전: 열 매핑</a>
                    <button type="button" id="sales-review-check" class="secondary-button">입력 확인 완료</button>
                </div>
                <p id="sales-review-result" hidden></p>
            </section>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sales_review.js?v=2"></script>
</body>
</html>
