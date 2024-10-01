<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav>
    <div class="menu-item">
        <a href="${pageContext.request.contextPath}/board/list?page=1&size=10&category_no=10" class = "navbar a">공지사항</a>
    </div>
    <div class = "menu-item">
        <a href="#" class = "navbar a">게시판</a>
        <div class="dropdown">
            <div class="dropdown-item">
                <a href="${pageContext.request.contextPath}/board/list?page=1&size=10&category_no=20" class = "navbar a">MSA5차</a>
            </div>
            <div class="dropdown-item">
                <a href="${pageContext.request.contextPath}/board/list?page=1&size=10&category_no=30" class = "navbar a">MSA6차</a>
            </div>
            <div class="dropdown-item">
                <a href="${pageContext.request.contextPath}/board/list?page=1&size=10&category_no=40" class = "navbar a">MSA7차</a>
            </div>
        </div>
    </div>
    <div class="menu-item">
        <a href="${pageContext.request.contextPath}/board/gallery?page=1&size=9&category_no=50">갤러리</a>
    </div> <div class="menu-item">
        <a href="${pageContext.request.contextPath}/board/curicurum">커리큘럼</a>
    </div> <div class="menu-item">
        <a href="https://www.sw.or.kr/site/sw/edu/selectEduListGallery.do" >교육신청</a>
    </div>
</nav>