<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!-- Ajax위한 Spring Security csrf 토큰 값 가져오기-->
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/header/js/jquery.js"></script>

<!-- Ajax에서 Post 요청마다 csrf 토큰 값 넘겨주기 위한 스크립트 -->
<script src="${pageContext.request.contextPath}/header/js/csrf.js"></script>

<!-- header에 대한 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/header/css/header.css">

<!-- 구글 CDN을 통한 폰트 적용  Noto Sans -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">