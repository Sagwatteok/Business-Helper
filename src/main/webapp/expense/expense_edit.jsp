<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 지출 수정</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/product.css">
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
            <section class="preview-table-card expense-edit-card">
                <div class="card-header">
                    <div>
                        <h2>지출 내역 수정</h2>
                        <p>샘플 데이터입니다. 수정할 값을 클릭하세요.</p>
                    </div>

                    <a href="expense_list.jsp" class="secondary-button">목록으로</a>
                </div>

                <div class="sales-summary">
                    <p>표시 중인 지출 합계</p>
                    <strong id="expense-edit-total">₩ 812,000</strong>
                </div>

                <div class="table-scroll">
                    <table class="preview-table expense-table expense-edit-table">
                        <thead>
                        <tr>
                            <th scope="col">지출일</th>
                            <th scope="col">분류</th>
                            <th scope="col">지출 내용</th>
                            <th scope="col">금액</th>
                            <th scope="col">삭제</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td data-field="date">2026-11-05</td>
                            <td data-field="category">기타</td>
                            <td data-field="description">포장 용기 구입</td>
                            <td data-field="amount" data-value="32000"
                                class="expense-amount">₩ 32,000</td>
                            <td>
                                <button type="button" class="expense-delete-button" disabled>
                                    삭제
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td data-field="date">2026-11-03</td>
                            <td data-field="category">재료비</td>
                            <td data-field="description">원두 구입</td>
                            <td data-field="amount" data-value="80000"
                                class="expense-amount">₩ 80,000</td>
                            <td>
                                <button type="button" class="expense-delete-button" disabled>
                                    삭제
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td data-field="date">2026-11-01</td>
                            <td data-field="category">임대료</td>
                            <td data-field="description">11월 매장 임대료</td>
                            <td data-field="amount" data-value="700000"
                                class="expense-amount">₩ 700,000</td>
                            <td>
                                <button type="button" class="expense-delete-button" disabled>
                                    삭제
                                </button>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <p id="expense-empty-message" hidden>표시할 지출 내역이 없습니다.</p>
                </div>

                <div class="preview-actions expense-edit-actions">
                    <a href="expense_list.jsp" class="secondary-button">취소</a>
                    <button type="button" id="expense-edit-save"
                            class="primary-button" disabled>
                        저장
                    </button>
                </div>
            </section>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/expense_edit.js"></script>
</body>
</html>
