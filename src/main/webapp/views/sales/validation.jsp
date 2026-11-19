<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty requestScope.csvUpload or empty requestScope.csvMapping}">
    <c:redirect url="/sales/mapping.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BizMate | 매출 내역 확인·보완</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sales.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/sales_review.css">
</head>

<body>
<div class="app-layout">

    <jsp:include page="/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="sales" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Sales Data" title="매출 데이터" />

        <main class="main-content preview-main">
            <c:if test="${not empty requestScope.importError}">
                <p class="sales-edit-error">
                    <c:out value="${requestScope.importError}" />
                </p>
            </c:if>
            <form id="salesCsvForm"
                  action="${pageContext.request.contextPath}/sales/import"
                  method="post"
                  novalidate>

                <input type="hidden"
                       name="csvDraftToken"
                       value="<c:out value="${requestScope.csvDraftToken}" />">

                <div id="csvSubmittedValues" hidden></div>
            <section class="preview-table-card">
                <div class="card-header">
                    <div>
                        <h2>매출 내역 확인·보완</h2>
                        <p>
                            총 ${requestScope.csvUpload.rowCount}건입니다.
                            수정할 값을 클릭하고 비어 있는 항목을 입력해 주세요.
                        </p>
                        <p id="sales-amount-guide"></p>
                    </div>
                </div>
                <div class="table-scroll">
                    <table class="preview-table sales-table sales-review-table"
                           data-amount-basis="${requestScope.amountBasis}">
                        <thead>
                        <tr>
                            <th scope="col">판매일자</th>
                            <th scope="col">상품명</th>
                            <th scope="col">수량</th>
                            <th scope="col" id="sales-amount-heading">품목 합계</th>
                            <th scope="col" class="sales-line-total" hidden>품목 합계</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="row"
                                   items="${requestScope.csvUpload.rows}"
                                   varStatus="status">
                            <tr data-row-index="${status.index}">
                                <td data-edit="date">
                                    <c:out value="${row[requestScope.csvMapping.saleDateColumn]}" />
                                </td>
                                <td data-edit="product">
                                    <c:out value="${row[requestScope.csvMapping.productNameColumn]}" />
                                </td>
                                <td data-edit="quantity">
                                    <c:out value="${row[requestScope.csvMapping.quantityColumn]}" />
                                </td>
                                <td data-edit="amount">
                                    <c:out value="${row[requestScope.csvMapping.amountColumn]}" />
                                </td>
                                <td class="sales-line-total" hidden></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="preview-actions">
                    <a href="mapping.jsp" id="sales-review-back" class="secondary-button">이전: 열 매핑</a>
                    <button type="submit"
                            id="sales-review-check"
                            class="secondary-button">매출에 반영</button>
                </div>
                <p id="sales-review-result" hidden></p>
            </section>
            </form>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sales_review.js?v=20261119"></script>
</body>
</html>
