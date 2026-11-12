<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
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
                        <p>샘플 데이터입니다. 수정할 값을 클릭하세요. 예상 마진은 자동 계산됩니다.</p>
                    </div>

                    <a href="product_list.jsp" class="secondary-button">목록으로</a>
                </div>

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
                        <tr>
                            <th scope="row" data-field="name">아메리카노</th>
                            <td data-field="category">커피</td>
                            <td data-field="price" data-value="4500">₩ 4,500</td>
                            <td data-field="cost" data-value="1200">₩ 1,200</td>
                            <td class="product-edit-margin">₩ 3,300</td>
                            <td data-field="status">판매 중</td>
                            <td>
                                <button type="button" class="product-delete-button">삭제</button>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" data-field="name">카페라떼</th>
                            <td data-field="category">커피</td>
                            <td data-field="price" data-value="5500">₩ 5,500</td>
                            <td data-field="cost" data-value="1800">₩ 1,800</td>
                            <td class="product-edit-margin">₩ 3,700</td>
                            <td data-field="status">판매 중</td>
                            <td>
                                <button type="button" class="product-delete-button">삭제</button>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" data-field="name">바닐라라떼</th>
                            <td data-field="category">커피</td>
                            <td data-field="price" data-value="6000">₩ 6,000</td>
                            <td data-field="cost" data-value="2100">₩ 2,100</td>
                            <td class="product-edit-margin">₩ 3,900</td>
                            <td data-field="status" class="product-status-inactive">판매 중지</td>
                            <td>
                                <button type="button" class="product-delete-button">삭제</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>

                    <p id="product-empty-message" hidden>표시할 상품이 없습니다.</p>
                </div>

                <div class="preview-actions product-edit-actions">
                    <a href="product_list.jsp" class="secondary-button">취소</a>
                    <button type="button" id="product-edit-save" class="primary-button">저장</button>
                </div>
            </section>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/product_edit.js"></script>
</body>
</html>
