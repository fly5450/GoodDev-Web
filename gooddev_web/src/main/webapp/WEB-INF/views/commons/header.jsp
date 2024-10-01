<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <div class="header-container">
        <div class="logo-container">
           <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/resources/img/good.png" alt="로고">
            </a>
        </div>
        <div class="search-wrapper">
            <span class="search-label">통합검색</span>
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/search" method="post" id = "searchForm" class="search-form">
                        <input name="keyword" id="keyword" class="search-input" placeholder="검색어를 입력해주세요">
                        <button type="submit" class="search-button">검색</button>
                </form>
            </div>
        </div>
    </div>
</header>