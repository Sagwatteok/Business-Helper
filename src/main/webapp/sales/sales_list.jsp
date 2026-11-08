<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 매출 데이터</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/preview.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
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
            <section class="preview-table-card">
                <div class="card-header">
                    <div>
                        <h2>11월 매출 내역</h2>
                        <p>샘플 데이터입니다. 상품별 매출 내역을 확인하세요.</p>
                    </div>
                    <div class="sales-header-actions">
                        <a href="upload.jsp" class="secondary-button">CSV로 가져오기</a>
                        <a href="sales_form.jsp" class="primary-button">+ 매출 추가</a>
                        <a href="sales_edit.jsp" class="sales-action-button sales-edit-button">수정</a>
                    </div>
                </div>
                <div class="sales-summary">
                    <p>2026년 11월 등록 매출 합계</p>
                    <strong>₩ 20,500</strong>
                </div>
                <div class="table-scroll">
                    <table class="preview-table sales-table">
                        <thead>
                        <tr>
                            <th scope="col">판매일자</th>
                            <th scope="col">상품명</th>
                            <th scope="col">수량</th>
                            <th scope="col">품목 합계</th>
                            <th scope="col">주문 경로</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr><td>2026-11-01 09:12</td><td>아메리카노</td><td>2</td><td class="sales-amount">₩ 9,000</td><td>매장 POS</td></tr>
                        <tr><td>2026-11-01 09:18</td><td>카페라떼</td><td>1</td><td class="sales-amount">₩ 5,500</td><td>키오스크</td></tr>
                        <tr><td>2026-11-01 09:25</td><td>바닐라라떼</td><td>1</td><td class="sales-amount">₩ 6,000</td><td>배달의민족</td></tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</div>
</body>
</html>
