<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BizMate | 데이터 검증 결과</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/upload.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">
</head>

<body>
<div class="app-layout">

    <jsp:include page="/WEB-INF/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="sales" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Sales Data" title="매출 데이터 업로드" />

        <main class="main-content preview-main">
            <section class="preview-intro">
                <h2>데이터 검증 결과</h2>
                <p>샘플 데이터로 정상 행과 오류 행의 표시 방식을 확인할 수 있어요.</p>
            </section>

            <section class="file-summary-card">
                <div class="file-summary-content">
                    <strong>sales_2026_11.csv</strong>
                    <div class="file-summary-detail">
                        <span>전체 248행</span>
                        <span>정상 246행</span>
                        <span>오류 2행</span>
                    </div>
                </div>
            </section>

            <section class="preview-table-card">
                <h2 id="error-heading">수정이 필요한 행</h2>

                <div class="table-scroll">
                    <table class="preview-table">
                        <thead>
                        <tr>
                            <th scope="col">파일 행 번호</th>
                            <th scope="col">항목</th>
                            <th scope="col">오류 내용</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>12행</td>
                            <td>판매수량</td>
                            <td>값이 비어 있습니다.</td>
                        </tr>
                        <tr>
                            <td>38행</td>
                            <td>판매금액</td>
                            <td>숫자로 읽을 수 없는 값입니다.</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <div class="preview-actions">
                <a href="mapping.jsp" class="secondary-button">
                    이전: 열 매핑
                </a>
            </div>
        </main>
    </div>
</div>

</body>
</html>
