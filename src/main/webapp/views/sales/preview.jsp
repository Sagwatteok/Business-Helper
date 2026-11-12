<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
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
                    <strong>sales_2026_11.csv</strong>

                    <div class="file-summary-detail">
                        <span>CSV 파일</span>
                        <span aria-hidden="true">·</span>
                        <span>총 248행</span>
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
                            <th scope="col">거래일시</th>
                            <th scope="col">메뉴명</th>
                            <th scope="col">판매수량</th>
                            <th scope="col">판매금액</th>
                            <th scope="col">주문번호</th>
                            <th scope="col">단가</th>
                            <th scope="col">주문경로</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr>
                            <td>2026-11-01 09:12</td>
                            <td>아메리카노</td>
                            <td>2</td>
                            <td>₩ 9,000</td>
                            <td>A-1001</td>
                            <td>₩ 4,500</td>
                            <td>매장 POS</td>
                        </tr>

                        <tr>
                            <td>2026-11-01 09:18</td>
                            <td>카페라떼</td>
                            <td>1</td>
                            <td>₩ 5,500</td>
                            <td>A-1002</td>
                            <td>₩ 5,500</td>
                            <td>키오스크</td>
                        </tr>

                        <tr>
                            <td>2026-11-01 09:25</td>
                            <td>바닐라라떼</td>
                            <td>1</td>
                            <td>₩ 6,000</td>
                            <td>A-1003</td>
                            <td>₩ 6,000</td>
                            <td>배달의민족</td>
                        </tr>

                        <tr>
                            <td>2026-11-01 09:31</td>
                            <td>아메리카노</td>
                            <td>3</td>
                            <td>₩ 13,500</td>
                            <td>A-1004</td>
                            <td>₩ 4,500</td>
                            <td>매장 POS</td>
                        </tr>

                        <tr>
                            <td>2026-11-01 09:42</td>
                            <td>카페라떼</td>
                            <td>2</td>
                            <td>₩ 11,000</td>
                            <td>A-1005</td>
                            <td>₩ 5,500</td>
                            <td>키오스크</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <div class="preview-actions">
                <a href="upload.jsp" class="secondary-button">
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
