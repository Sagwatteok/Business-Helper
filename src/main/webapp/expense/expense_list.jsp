<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 지출 관리</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/expense.css">
</head>

<body>
<div class="app-layout">
    <jsp:include page="/WEB-INF/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="expense" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Expenses" title="지출 관리" />

        <main class="main-content preview-main">
            <section class="preview-table-card">
                <div class="card-header">
                    <div>
                        <h2>11월 지출 내역</h2>
                        <p>매장 운영에 실제로 지출한 내역을 확인하세요.</p>
                    </div>

                    <div class="expense-header-actions">
                        <a href="expense_upload.jsp"
                           class="secondary-button">CSV로 가져오기</a>
                        <a href="expense_form.jsp" class="primary-button expense-action-button">+ 지출 추가</a>
                        <a href="expense_edit.jsp" class="expense-action-button expense-edit-button">수정</a>
                    </div>
                </div>

                <div class="sales-summary">
                    <p>2026년 11월 등록 지출 합계</p>
                    <strong>₩ 812,000</strong>
                </div>

                <div class="table-scroll">
                    <table class="preview-table expense-table">
                        <thead>
                        <tr>
                            <th scope="col">지출일</th>
                            <th scope="col">분류</th>
                            <th scope="col">지출 내용</th>
                            <th scope="col">금액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>2026-11-05</td>
                            <td>기타</td>
                            <td>포장 용기 구입</td>
                            <td class="expense-amount">₩ 32,000</td>
                        </tr>
                        <tr>
                            <td>2026-11-03</td>
                            <td>재료비</td>
                            <td>원두 구입</td>
                            <td class="expense-amount">₩ 80,000</td>
                        </tr>
                        <tr>
                            <td>2026-11-01</td>
                            <td>임대료</td>
                            <td>11월 매장 임대료</td>
                            <td class="expense-amount">₩ 700,000</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</div>

</body>
</html>
