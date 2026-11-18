<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.salesCsvUpload}">
    <c:redirect url="/sales/upload" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BizMate | 파일 미리보기</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">
</head>

<body>
<div class="app-layout">

    <jsp:include page="/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="sales" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Sales Data" title="매출 데이터 업로드" />

        <main class="main-content preview-main">
            <section class="preview-intro">
                <h2>파일 내용을 확인해 주세요</h2>
                <p>열 이름과 일부 데이터를 확인한 뒤, BizMate 데이터 항목과 연결합니다.</p>
            </section>

            <section class="file-summary-card">
                <div class="file-summary-icon" aria-hidden="true">⌁</div>

                <div class="file-summary-content">
                    <p class="file-summary-label">업로드할 파일</p>
                    <strong>
                        <c:out value="${sessionScope.salesCsvUpload.fileName}" />
                    </strong>

                    <div class="file-summary-detail">
                        <span>CSV 파일</span>
                        <span aria-hidden="true">·</span>
                        <span>총 ${sessionScope.salesCsvUpload.rowCount}행</span>
                    </div>
                </div>
            </section>

            <section class="preview-table-card">
                <div class="card-header">
                    <div>
                        <h2>파일 미리보기</h2>
                        <p>처음 5개 행만 표시합니다.</p>
                    </div>
                </div>

                <div class="table-scroll">
                    <table class="preview-table sales-preview-table">
                        <thead>
                        <tr>
                            <c:forEach var="header" items="${sessionScope.salesCsvUpload.headers}">
                                <th scope="col">
                                    <c:out value="${header}" />
                                </th>
                            </c:forEach>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="row"
                                   items="${sessionScope.salesCsvUpload.rows}"
                                   begin="0"
                                   end="4">
                            <tr>
                                <c:forEach var="cell" items="${row}">
                                    <td>
                                        <c:out value="${cell}" />
                                    </td>
                                </c:forEach>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>

            <div class="preview-actions">
                <a href="${pageContext.request.contextPath}/sales/upload" class="secondary-button">
                    이전: 파일 다시 선택
                </a>

                <a href="mapping.jsp" class="primary-button">
                    다음: 열 매핑
                </a>
            </div>
        </main>
    </div>
</div>

</body>
</html>
