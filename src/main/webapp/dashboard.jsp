<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대시보드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="app-layout">
    <!-- 왼쪽 공통 메뉴 -->
    <aside class="sidebar">
        <a href="#" class="brand">
            <img src="${pageContext.request.contextPath}/images/bizmate-logo.png"
                 alt="BizMate"
                 class="brand-logo">
        </a>

        <nav class="sidebar-nav">
            <a href="dashboard.jsp" class="nav-item">
                <span class="nav-icon"></span>
                대시보드
            </a>
            <a href="#" class="nav-item">
                <span class="nav-icon"></span>
                매출 데이터
            </a>
            <a href="#" class="nav-item">
                <span class="nav-icon"></span>
                상품 관리
            </a>
            <a href="#" class="nav-item">
                <span class="nav-icon"></span>
                비용 관리
            </a>
            <a href="#" class="nav-item">
                <span class="nav-icon"></span>
                분석 리포트
            </a>
            <a href="#" class="nav-item">
                <span class="nav-icon"></span>
                AI 경영 코칭
            </a>
        </nav>

        <div class="sidebar-bottom">
            <a href="#" class="nav-item">
                <span class="nav-icon"></span>
                설정
            </a>
        </div>
    </aside>

    <div class="page-area">
        <!-- 상단 공통 헤더 -->
        <header class="top-header">
            <div>
                <p class="page-eyebrow">BizMate Dashboard</p>
                <h1>대시보드</h1>
            </div>

            <div class="header-actions">
                <button type="button" class="business-button">우리 동네 카페</button>
                <button type="button" class="profile-button">김</button>
            </div>
        </header>

        <main class="main-content">
            <section class="welcome-section">
                <div>
                    <h2>오늘의 매장 현황이에요</h2>
                    <p>2026년 11월 3일 기준 운영 데이터를 확인해 보세요.</p>
                </div>

                <a href="#" class="primary-button">매출 파일 업로드</a>
            </section>

            <!-- 핵심 지표 -->
            <section class="metric-grid">
                <article class="metric-card">
                    <p class="metric-label">오늘 매출</p>
                    <strong class="metric-value">₩ 428,000</strong>
                    <p class="metric-change positive">▲ 어제보다 12.4%</p>
                </article>

                <article class="metric-card">
                    <p class="metric-label">오늘 비용</p>
                    <strong class="metric-value">₩ 96,000</strong>
                    <p class="metric-description">재료비, 배달비 포함</p>
                </article>

                <article class="metric-card">
                    <p class="metric-label">오늘 순이익</p>
                    <strong class="metric-value">₩ 332,000</strong>
                    <p class="metric-change positive">▲ 어제보다 8.1%</p>
                </article>

                <article class="metric-card">
                    <p class="metric-label">주문 수</p>
                    <strong class="metric-value">87건</strong>
                    <p class="metric-description">평균 객단가 ₩ 4,920</p>
                </article>
            </section>

            <section class="sales-chart-card">
                <div class="card-header">
                    <div>
                        <h2>최근 7일 매출 추이</h2>
                        <p>10월 28일 ~ 11월 3일</p>
                    </div>

                    <button type="button" class="period-button">
                        최근 7일
                    </button>
                </div>

                <div class="sales-summary">
                    <p>이번 주 총매출</p>
                    <strong>₩ 2,840,000</strong>
                    <span class="metric-change positive">▲ 지난주보다 8.1%</span>
                </div>

                <div class="chart-area">
                    <canvas id="weeklySalesChart"></canvas>
                </div>
            </section>

            <section class="top-product-card">
                <div class="card-header">
                    <div>
                        <h2>인기 상품 TOP 3</h2>
                        <p>최근 7일 판매량 기준</p>
                    </div>

                    <a href="#" class="text-link">전체 상품 보기</a>
                </div>

                <table class="top-product-table">
                    <thead>
                    <tr>
                        <th scope="col">순위</th>
                        <th scope="col">상품명</th>
                        <th scope="col">판매 수량</th>
                        <th scope="col">매출액</th>
                    </tr>
                    </thead>

                    <tbody>
                    <tr>
                        <td><span class="rank-badge rank-first">1</span></td>
                        <td>아메리카노</td>
                        <td>128잔</td>
                        <td class="sales-amount">₩ 576,000</td>
                    </tr>

                    <tr>
                        <td><span class="rank-badge">2</span></td>
                        <td>카페라떼</td>
                        <td>86잔</td>
                        <td class="sales-amount">₩ 473,000</td>
                    </tr>

                    <tr>
                        <td><span class="rank-badge">3</span></td>
                        <td>바닐라라떼</td>
                        <td>64잔</td>
                        <td class="sales-amount">₩ 384,000</td>
                    </tr>
                    </tbody>
                </table>
            </section>

            <section class="ai-insight-card">
                <div class="insight-icon" aria-hidden="true">✦</div>

                <div class="insight-content">
                    <p class="insight-eyebrow">AI 경영 인사이트</p>
                    <h2>오늘의 매출 기회</h2>

                    <p class="insight-message">
                        아메리카노 매출이 어제보다 12.4% 증가했어요.
                    </p>

                    <p class="insight-recommendation">
                        오후 2~4시에 세트 할인 행사를 운영해 추가 주문을 유도해 보세요.
                    </p>

                    <a href="#" class="insight-link">
                        분석 자세히 보기 →
                    </a>
                </div>
            </section>

        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>
