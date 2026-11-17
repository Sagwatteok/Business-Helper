<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${requestScope.dashboardDate == null}">
    <jsp:forward page="/dashboard" />
</c:if>

<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BizMate | 대시보드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
<div class="app-layout">
    <!-- 왼쪽 공통 메뉴 -->
    <jsp:include page="/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="dashboard" />
    </jsp:include>

    <div class="page-area">
        <!-- 상단 공통 헤더 -->
        <ui:header eyebrow="BizMate Dashboard" title="대시보드">
            <div class="header-actions">
                <button type="button" class="business-button">우리 동네 카페</button>
                <button type="button" class="profile-button">김</button>
            </div>
        </ui:header>

        <main class="main-content">
            <section class="welcome-section">
                <div>
                    <h2>오늘의 매장 현황이에요</h2>
                    <p>
                        <c:out value="${requestScope.dashboardDate}" />
                        기준 운영 데이터를 확인해 보세요.
                    </p>
                </div>

                <a href="${pageContext.request.contextPath}/sales/upload.jsp"
                   class="primary-button">매출 파일 업로드</a>
            </section>

            <!-- 핵심 지표 -->
            <section class="metric-grid">
                <article class="metric-card">
                    <p class="metric-label">오늘 매출</p>
                    <strong class="metric-value">
                        ₩ <fmt:formatNumber value="${requestScope.todaySalesAmount}" pattern="#,##0" />
                    </strong>
                    <p class="metric-description">오늘 판매일시 기준 합계</p>
                </article>

                <article class="metric-card">
                    <p class="metric-label">오늘 지출</p>
                    <strong class="metric-value">
                        ₩ <fmt:formatNumber value="${requestScope.todayExpenseAmount}" pattern="#,##0" />
                    </strong>
                    <p class="metric-description">오늘 지출일 기준 합계</p>
                </article>

                <article class="metric-card">
                    <p class="metric-label">오늘 차액</p>
                    <strong class="metric-value">
                        ₩ <fmt:formatNumber value="${requestScope.todayBalance}" pattern="#,##0" />
                    </strong>
                    <p class="metric-description">오늘 매출에서 오늘 지출을 뺀 금액</p>
                </article>

                <article class="metric-card">
                    <p class="metric-label">주문 수</p>
                    <strong class="metric-value">—</strong>
                    <p class="metric-description">집계 연결 예정</p>
                </article>
            </section>

            <section class="sales-chart-card">
                <div class="card-header">
                    <div>
                        <h2>최근 7일 매출 추이</h2>
                        <p>
                            <c:out value="${requestScope.weeklySalesStartDate}" />
                            ~
                            <c:out value="${requestScope.dashboardDate}" />
                        </p>
                    </div>

                    <button type="button" class="period-button">
                        최근 7일
                    </button>
                </div>

                <div class="sales-summary">
                    <p>최근 7일 총매출</p>
                    <strong>
                        ₩ <fmt:formatNumber value="${requestScope.weeklySalesTotal}" pattern="#,##0" />
                    </strong>
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

<div id="weekly-sales-data" hidden="hidden">
    <c:forEach var="label" items="${requestScope.weeklySalesLabels}" varStatus="status">
        <span data-label="${label}"
              data-amount="${requestScope.weeklySalesAmounts[status.index]}"></span>
    </c:forEach>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js?v=20261117"></script>
</body>
</html>
