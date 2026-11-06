<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 비용 열 매핑</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/product.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/expense.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/mapping.css">
</head>

<body>
<div class="app-layout">
    <jsp:include page="/WEB-INF/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="expense" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Expenses" title="비용 관리" />

        <main class="main-content mapping-main">
            <section class="mapping-intro">
                <h2>비용 파일의 열을 연결해 주세요</h2>
                <p>샘플 파일의 열을 BizMate 비용 항목과 연결합니다.</p>
            </section>

            <section class="mapping-card">
                <div class="card-header">
                    <div>
                        <h2>열 매핑</h2>
                        <p>필수 항목을 모두 연결해 주세요. 메모는 확인 단계에서 행별로 추가할 수 있습니다.</p>
                    </div>
                </div>

                <div class="mapping-list" id="expense-mapping-list">
                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-expense-date" class="mapping-field-label">지출일</label>
                            <span class="required-badge">필수</span>
                            <p>비용을 지출한 날짜입니다.</p>
                        </div>
                        <select id="map-expense-date" class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="expenseDate" selected>지출일</option>
                            <option value="category">분류</option>
                            <option value="description">지출 내용</option>
                            <option value="amount">금액</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-category" class="mapping-field-label">분류</label>
                            <span class="required-badge">필수</span>
                            <p>재료비, 임대료처럼 지출의 종류를 구분하는 항목입니다.</p>
                        </div>
                        <select id="map-category" class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="expenseDate">지출일</option>
                            <option value="category" selected>분류</option>
                            <option value="description">지출 내용</option>
                            <option value="amount">금액</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-description" class="mapping-field-label">지출 내용</label>
                            <span class="required-badge">필수</span>
                            <p>원두 구입, 포장 용기 구입처럼 무엇에 돈을 썼는지 나타냅니다.</p>
                        </div>
                        <select id="map-description" class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="expenseDate">지출일</option>
                            <option value="category">분류</option>
                            <option value="description" selected>지출 내용</option>
                            <option value="amount">금액</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-amount" class="mapping-field-label">금액</label>
                            <span class="required-badge">필수</span>
                            <p>해당 지출 건에 실제로 지불한 금액입니다.</p>
                        </div>
                        <select id="map-amount" class="mapping-select" required>
                            <option value="">열을 선택하세요</option>
                            <option value="expenseDate">지출일</option>
                            <option value="category">분류</option>
                            <option value="description">지출 내용</option>
                            <option value="amount" selected>금액</option>
                        </select>
                    </div>

                    <div class="mapping-row">
                        <div class="mapping-label">
                            <label for="map-memo" class="mapping-field-label">메모</label>
                            <span class="optional-badge">선택</span>
                            <p>구매처나 영수증 정보를 기록하는 항목입니다. 파일에 메모 열이 없으면 연결하지 않음으로 두세요.</p>
                        </div>
                        <select id="map-memo" class="mapping-select">
                            <option value="">연결하지 않음</option>
                        </select>
                    </div>
                </div>
            </section>

            <div class="mapping-actions">
                <a href="expense_preview.jsp" class="secondary-button">이전 단계로 이동</a>
                <button type="button" id="expense-mapping-next" class="mapping-next-button" disabled>
                    다음 단계로 이동
                </button>
            </div>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/expense_mapping.js"></script>
</body>
</html>
