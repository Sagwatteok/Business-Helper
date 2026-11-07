<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BizMate | 데이터 열 매핑</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/upload.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mapping.css?v=2">
</head>

<body>
<div class="app-layout">

    <jsp:include page="/WEB-INF/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="sales" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Sales Data" title="매출 데이터 업로드" />

        <main class="main-content mapping-main">
            <section class="mapping-intro">
                <h2>데이터 열을 연결해 주세요</h2>
                <p>업로드한 파일의 열을 BizMate가 사용하는 데이터 항목과 연결합니다.</p>
            </section>

            <section class="file-summary-card">
                <div class="file-summary-icon" aria-hidden="true">⌁</div>

                <div class="file-summary-content">
                    <p class="file-summary-label">업로드할 파일</p>
                    <strong>sales_2026_11.csv</strong>

                    <div class="file-summary-detail">
                        <span>CSV 파일</span>
                        <span aria-hidden="true">·</span>
                        <span>총 248행</span>
                    </div>
                </div>
            </section>

            <section class="mapping-card">
                <div class="card-header">
                    <div>
                        <h2>열 매핑</h2>
                        <p>필수 항목은 반드시 연결해 주세요.</p>
                    </div>
                </div>

                <div class="mapping-list">
                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-sale-date" class="mapping-field-label">판매일자</label>
                            <span class="required-badge">필수</span>
                            <p>거래가 발생한 날짜와 시간입니다.</p>
                        </div>

                        <select id="map-sale-date" class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="transactionDate" selected>거래일시</option>
                            <option value="productName">메뉴명</option>
                            <option value="quantity">판매수량</option>
                            <option value="salesAmount">판매금액</option>
                            <option value="orderNo">주문번호</option>
                            <option value="unitPrice">단가</option>
                            <option value="orderChannel">주문경로</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-product-name" class="mapping-field-label">상품명</label>
                            <span class="required-badge">필수</span>
                            <p>판매한 메뉴 또는 상품 이름입니다.</p>
                        </div>

                        <select id="map-product-name" class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="transactionDate">거래일시</option>
                            <option value="productName" selected>메뉴명</option>
                            <option value="quantity">판매수량</option>
                            <option value="salesAmount">판매금액</option>
                            <option value="orderNo">주문번호</option>
                            <option value="unitPrice">단가</option>
                            <option value="orderChannel">주문경로</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-quantity" class="mapping-field-label">수량</label>
                            <span class="required-badge">필수</span>
                            <p>한 주문에서 판매한 상품 수량입니다.</p>
                        </div>

                        <select id="map-quantity" class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="transactionDate">거래일시</option>
                            <option value="productName">메뉴명</option>
                            <option value="quantity" selected>판매수량</option>
                            <option value="salesAmount">판매금액</option>
                            <option value="orderNo">주문번호</option>
                            <option value="unitPrice">단가</option>
                            <option value="orderChannel">주문경로</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="amount-basis" class="mapping-field-label">금액 기준</label>
                            <span class="required-badge">필수</span>
                            <p id="amount-example" aria-live="polite">품목 합계 열의 금액을 그대로 사용합니다.</p>
                        </div>

                        <select id="amount-basis" class="mapping-select" aria-describedby="amount-example" required>
                            <option value="lineTotal" selected>품목 합계</option>
                            <option value="unitPrice">단가</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-line-total" class="mapping-field-label">금액 열</label>
                            <span class="required-badge">필수</span>
                            <p>선택한 금액 기준에 해당하는 원본 파일 열을 연결합니다.</p>
                        </div>

                        <select id="map-line-total" class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="transactionDate">거래일시</option>
                            <option value="productName">메뉴명</option>
                            <option value="quantity">판매수량</option>
                            <option value="salesAmount" selected>판매금액</option>
                            <option value="orderNo">주문번호</option>
                            <option value="unitPrice">단가</option>
                            <option value="orderChannel">주문경로</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-order-no" class="mapping-field-label">주문번호</label>
                            <span class="optional-badge">선택</span>
                            <p>주문을 구분할 수 있는 번호입니다.</p>
                        </div>

                        <select id="map-order-no" class="mapping-select">
                            <option value="">연결하지 않음</option>
                            <option value="transactionDate">거래일시</option>
                            <option value="productName">메뉴명</option>
                            <option value="quantity">판매수량</option>
                            <option value="salesAmount">판매금액</option>
                            <option value="orderNo" selected>주문번호</option>
                            <option value="unitPrice">단가</option>
                            <option value="orderChannel">주문경로</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-order-channel" class="mapping-field-label">주문 경로</label>
                            <span class="optional-badge">선택</span>
                            <p>매장 POS, 키오스크처럼 주문이 접수된 곳입니다.</p>
                        </div>

                        <select id="map-order-channel" class="mapping-select">
                            <option value="" selected>연결하지 않음</option>
                            <option value="orderChannel">주문경로</option>
                        </select>
                    </div>
                </div>
            </section>

            <div class="mapping-actions">
                <a href="preview.jsp" class="secondary-button">
                    이전: 파일 미리보기
                </a>

                <!-- validation.jsp를 만든 뒤 href를 연결 -->
                <button type="button"
                        class="mapping-next-button"
                        id="mappingNextButton"
                        disabled>
                    다음: 데이터 검증
                </button>
            </div>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/mapping.js?v=3"></script>
</body>
</html>
