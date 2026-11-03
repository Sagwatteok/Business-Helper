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
            <span class="brand-mark"></span>
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

            <section class="dashboard-placeholder">
                <h2>최근 7일 매출 추이</h2>
                <p>다음 단계에서 이 영역에 Chart.js 차트를 추가합니다.</p>
            </section>
        </main>
    </div>
</div>
</body>
</html>
