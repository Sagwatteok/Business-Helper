<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 지출 CSV 가져오기</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/expense.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/upload.css">
</head>

<body>
<div class="app-layout">
    <jsp:include page="/WEB-INF/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="expense" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Expenses" title="지출 관리" />

        <main class="main-content upload-main">
            <section class="upload-intro">
                <h2>지출 CSV 파일을 선택해 주세요</h2>
                <p>지출일, 분류, 지출 내용, 금액이 들어 있는 CSV 파일을 선택하세요.</p>
            </section>

            <section class="upload-card">
                <input type="file" id="expense-csv" accept=".csv,.xls,.xlsx" hidden>

                <label for="expense-csv" class="file-select-area">
                    <span class="upload-icon">↑</span>
                    <strong>클릭하여 지출 파일을 선택하세요</strong>
                    <span>CSV, XLS, XLSX 파일을 지원합니다.</span>
                </label>

                <p class="upload-guide">최대 파일 크기: 10MB</p>

                <div class="selected-file" id="expense-selected-file" hidden>
                    <div>
                        <p class="selected-file-label">선택한 파일</p>
                        <strong id="expense-file-name"></strong>
                        <span id="expense-file-size"></span>
                    </div>

                    <button type="button" class="remove-file-button" id="expense-remove-file">
                        선택 취소
                    </button>
                </div>

                <p class="upload-error" id="expense-csv-error" hidden></p>

                <button type="button" class="next-button" id="expense-preview-button" disabled>
                    다음: 미리보기
                </button>

                <div class="preview-actions">
                    <a href="expense_list.jsp" class="secondary-button">취소</a>
                </div>
            </section>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/expense_upload.js"></script>
</body>
</html>
