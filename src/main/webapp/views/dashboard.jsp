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
                        <h2><c:out value="${requestScope.salesPeriodLabel}" /> 매출 추이</h2>
                        <p>
                            <c:out value="${requestScope.salesStartDate}" />
                            ~
                            <c:out value="${requestScope.dashboardDate}" />
                        </p>
                    </div>

                    <form action="${pageContext.request.contextPath}/dashboard" method="get">
                        <input type="hidden" name="topPeriod" value="${requestScope.topProductsPeriod}">
                        <select id="salesPeriod" name="period" class="period-button" title="매출 조회 기간">
                            <option value="7d" ${requestScope.salesPeriod == '7d' ? 'selected' : ''}>최근 7일</option>
                            <option value="1m" ${requestScope.salesPeriod == '1m' ? 'selected' : ''}>1개월</option>
                            <option value="3m" ${requestScope.salesPeriod == '3m' ? 'selected' : ''}>3개월</option>
                            <option value="6m" ${requestScope.salesPeriod == '6m' ? 'selected' : ''}>6개월</option>
                            <option value="1y" ${requestScope.salesPeriod == '1y' ? 'selected' : ''}>1년</option>
                        </select>
                        <noscript><button type="submit" class="period-button">조회</button></noscript>
                    </form>
                </div>

                <div class="sales-summary">
                    <p><c:out value="${requestScope.salesPeriodLabel}" /> 총매출</p>
                    <strong>
                        ₩ <fmt:formatNumber value="${requestScope.salesTotal}" pattern="#,##0" />
                    </strong>
                </div>

                <div class="chart-area">
                    <canvas id="salesChart"></canvas>
                </div>
            </section>

            <section class="top-product-card">
                <div class="card-header">
                    <div>
                        <h2>인기 상품 TOP 3</h2>
                        <p><c:out value="${requestScope.topProductsPeriodLabel}" /> 판매량 기준</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/dashboard" method="get">
                        <input type="hidden" name="period" value="${requestScope.salesPeriod}">
                        <select id="topProductsPeriod" name="topPeriod" class="period-button" title="인기 상품 조회 기간">
                            <option value="daily" ${requestScope.topProductsPeriod == 'daily' ? 'selected' : ''}>일간</option>
                            <option value="weekly" ${requestScope.topProductsPeriod == 'weekly' ? 'selected' : ''}>주간</option>
                            <option value="monthly" ${requestScope.topProductsPeriod == 'monthly' ? 'selected' : ''}>월간</option>
                            <option value="yearly" ${requestScope.topProductsPeriod == 'yearly' ? 'selected' : ''}>연간</option>
                        </select>
                        <noscript><button type="submit" class="period-button">조회</button></noscript>
                        <a href="#" class="text-link">전체 상품 보기</a>
                    </form>
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
                    <c:forEach var="summary" items="${requestScope.topProducts}" varStatus="status">
                        <tr>
                            <td>
            					<span class="rank-badge ${status.first ? 'rank-first' : ''}">
                    				${status.count}
            					</span>
                            </td>
                            <td>
                                <c:out value="${summary.productName}" />
                            </td>
                            <td>
                                <fmt:formatNumber value="${summary.totalQuantity}" pattern="#,##0" />개
                            </td>
                            <td class="sales-amount">
                                ₩ <fmt:formatNumber value="${summary.totalAmount}" pattern="#,##0" />
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty requestScope.topProducts}">
                        <tr>
                            <td colspan="4"><c:out value="${requestScope.topProductsPeriodLabel}" /> 매출 내역이 없습니다.</td>
                        </tr>
                    </c:if>
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

<div id="sales-chart-data" hidden="hidden">
    <c:forEach var="label" items="${requestScope.salesLabels}" varStatus="status">
        <span data-label="${label}" data-amount="${requestScope.salesAmounts[status.index]}"></span>
    </c:forEach>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js?v=20261124-3"></script>
</body>
</html>
