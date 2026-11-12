<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${requestScope.products == null}">
    <jsp:forward page="/product/edit" />
</c:if>

<fmt:setLocale value="ko_KR" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>BizMate | 상품 수정</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/preview.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/product.css">
</head>

<body>
<div class="app-layout">
    <jsp:include page="/views/sidebar.jsp">
        <jsp:param name="activeMenu" value="product" />
    </jsp:include>

    <div class="page-area">
        <ui:header eyebrow="Products" title="상품 관리" />

        <main class="main-content preview-main">
            <section class="preview-table-card product-list-card">
                <div class="card-header">
                    <div>
                        <h2 id="product-list-title">상품 목록</h2>
                        <p>수정할 값을 클릭하세요. 예상 마진은 자동 계산됩니다.</p>
                    </div>

                    <a href="product_list.jsp" class="secondary-button">목록으로</a>
                </div>

                <c:if test="${not empty requestScope.errorMessage}"> <!-- 전달한 오류 메시지가 있을 때만 --> 
                    <p><c:out value="${requestScope.errorMessage}" /></p>
                </c:if>

                <form id="product-edit-form" action="${pageContext.request.contextPath}/product/edit" method="post">

                <div class="table-scroll">
                    <table class="preview-table product-table product-edit-table">
                        <thead>
                        <tr>
                            <th scope="col">상품명</th>
                            <th scope="col">카테고리</th>
                            <th scope="col">판매가</th>
                            <th scope="col">추정 원가</th>
                            <th scope="col">예상 마진</th>
                            <th scope="col">판매 상태</th>
                            <th scope="col">삭제</th>
                        </tr>
                        </thead>
                        
                        <tbody>
                        <c:forEach var="product" items="${requestScope.products}">
                            <tr data-product-id="${product.productId}">
                                <th scope="row" data-field="name">
                                    <c:out value="${product.productName}" />
                                </th>
                                
                                <td data-field="category">
                                    <c:out value="${product.category}" />
                                </td>
                                
                                <td data-field="price" data-value="${product.salePrice}">
                                    ₩ <fmt:formatNumber value="${product.salePrice}" pattern="#,##0" />
                                </td>
                                
                                <td data-field="cost" data-value="${product.estimatedCost}">
                                    ₩ <fmt:formatNumber value="${product.estimatedCost}" pattern="#,##0" />
                                </td>
                                
                                <td class="product-edit-margin">
                                    ₩ <fmt:formatNumber value="${product.estimatedMargin}" pattern="#,##0" />
                                </td>
                                
                                <td data-field="status"
                                	<%-- 판매 중지라면 흐린 글자색 적용 --%>
                                    class="${product.saleStatus == 'inactive' ? 'product-status-inactive' : ''}">
                                    <c:if test="${product.saleStatus == 'active'}">
                                        판매 중
                                    </c:if>
                                    <c:if test="${product.saleStatus == 'inactive'}">
                                        판매 중지
                                    </c:if>
                                </td>
                                
                                <td>
                                    <button type="button" class="product-delete-button">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <p id="product-empty-message" hidden>표시할 상품이 없습니다.</p>
                </div>

                <div class="preview-actions product-edit-actions">
                    <a href="product_list.jsp" class="secondary-button">취소</a>
                    <button type="button" id="product-edit-save" class="primary-button">저장</button>
                </div>
                
                </form>
            </section>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/product_edit.js"></script>
</body>
</html>
