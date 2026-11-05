<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
          href="${pageContext.request.contextPath}/css/mapping.css">
</head>

<body>
<div class="app-layout">

    <aside class="sidebar">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="brand">
            <img src="${pageContext.request.contextPath}/images/bizmate-logo.png"
                 alt="BizMate"
                 class="brand-logo">
        </a>

        <nav class="sidebar-nav" aria-label="주요 메뉴">
            <a href="${pageContext.request.contextPath}/dashboard.jsp" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                대시보드
            </a>

            <a href="#" class="nav-item is-active">
                <span class="nav-icon" aria-hidden="true"></span>
                매출 데이터
            </a>

            <a href="#" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                상품 관리
            </a>

            <a href="#" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                비용 관리
            </a>

            <a href="#" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                분석 리포트
            </a>

            <a href="#" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                AI 경영 코칭
            </a>
        </nav>

        <div class="sidebar-bottom">
            <a href="#" class="nav-item">
                <span class="nav-icon" aria-hidden="true"></span>
                설정
            </a>
        </div>
    </aside>

    <div class="page-area">
        <header class="top-header">
            <div>
                <p class="page-eyebrow">Sales Data</p>
                <h1>매출 데이터 업로드</h1>
            </div>
        </header>

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
                            <strong>판매일자</strong>
                            <span class="required-badge">필수</span>
                            <p>거래가 발생한 날짜와 시간입니다.</p>
                        </div>

                        <select class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="transactionDate" selected>거래일시</option>
                            <option value="productName">메뉴명</option>
                            <option value="quantity">판매수량</option>
                            <option value="salesAmount">판매금액</option>
                            <option value="orderNo">주문번호</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <strong>상품명</strong>
                            <span class="required-badge">필수</span>
                            <p>판매한 메뉴 또는 상품 이름입니다.</p>
                        </div>

                        <select class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="transactionDate">거래일시</option>
                            <option value="productName" selected>메뉴명</option>
                            <option value="quantity">판매수량</option>
                            <option value="salesAmount">판매금액</option>
                            <option value="orderNo">주문번호</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <strong>수량</strong>
                            <span class="required-badge">필수</span>
                            <p>한 주문에서 판매한 상품 수량입니다.</p>
                        </div>

                        <select class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="transactionDate">거래일시</option>
                            <option value="productName">메뉴명</option>
                            <option value="quantity" selected>판매수량</option>
                            <option value="salesAmount">판매금액</option>
                            <option value="orderNo">주문번호</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <strong>품목 합계</strong>
                            <span class="required-badge">필수</span>
                            <p>해당 상품의 총 판매 금액입니다.</p>
                        </div>

                        <select class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="transactionDate">거래일시</option>
                            <option value="productName">메뉴명</option>
                            <option value="quantity">판매수량</option>
                            <option value="salesAmount" selected>판매금액</option>
                            <option value="orderNo">주문번호</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <strong>주문번호</strong>
                            <span class="optional-badge">선택</span>
                            <p>주문을 구분할 수 있는 번호입니다.</p>
                        </div>

                        <select class="mapping-select">
                            <option value="">연결하지 않음</option>
                            <option value="transactionDate">거래일시</option>
                            <option value="productName">메뉴명</option>
                            <option value="quantity">판매수량</option>
                            <option value="salesAmount">판매금액</option>
                            <option value="orderNo" selected>주문번호</option>
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

<script src="${pageContext.request.contextPath}/js/mapping.js"></script>
</body>
</html>