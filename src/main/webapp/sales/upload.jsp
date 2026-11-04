<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BizMate | 매출 데이터 업로드</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/upload.css">
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

        <main class="main-content upload-main">
            <section class="upload-intro">
                <h2>매출 파일을 업로드해 주세요</h2>
                <p>업로드한 파일을 분석해 매출 현황과 경영 인사이트를 제공해 드려요.</p>
            </section>

            <!-- 나중에 form action과 method를 Servlet 방식에 맞게 변경 -->
            <form class="upload-card" id="uploadForm">
                <input type="file"
                       id="salesFile"
                       accept=".csv,.xls,.xlsx"
                       hidden>

                <label for="salesFile" class="file-select-area">
                    <span class="upload-icon" aria-hidden="true">↑</span>
                    <strong>클릭하여 매출 파일을 선택하세요</strong>
                    <span>CSV, XLS, XLSX 파일을 지원합니다.</span>
                </label>

                <p class="upload-guide">
                    최대 파일 크기: 10MB
                </p>

                <!-- 파일을 선택한 뒤 JavaScript가 표시 -->
                <div class="selected-file" id="selectedFile" hidden>
                    <div>
                        <p class="selected-file-label">선택한 파일</p>
                        <strong id="fileName"></strong>
                        <span id="fileSize"></span>
                    </div>

                    <button type="button" class="remove-file-button" id="removeFile">
                        선택 취소
                    </button>
                </div>

                <!-- 오류가 있을 때 JavaScript가 표시 -->
                <p class="upload-error" id="uploadError" role="alert" hidden></p>

                <!-- 다음 단계에서 미리보기 화면으로 이동 -->
                <button type="button"
                        class="next-button"
                        id="nextButton"
                        disabled>
                    다음: 파일 미리보기
                </button>
            </form>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/upload.js"></script>
</body>
</html>