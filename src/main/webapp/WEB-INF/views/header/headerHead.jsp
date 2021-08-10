<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!-- Ajax위한 Spring Security csrf 토큰 값 가져오기 -->
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<!-- js 위한 contextPath 세팅 -->
<meta id="_contextPath" name="_contextPath" content="${pageContext.request.contextPath}" />

<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/header/js/jquery.js"></script>

<!-- 제이쿼리 ui -->
<script src="${pageContext.request.contextPath}/header/js/jquery-ui.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/header/css/jquery-ui.css">

<!-- header js -->
<script src="${pageContext.request.contextPath}/header/js/header.js"></script>

<!-- Ajax에서 Post 요청마다 csrf 토큰 값 넘겨주기 위한 스크립트 -->
<script src="${pageContext.request.contextPath}/header/js/csrf.js"></script>

<!-- header css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/header/css/header.css">

<!-- 구글 CDN을 통한 폰트 적용  Noto Sans -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">