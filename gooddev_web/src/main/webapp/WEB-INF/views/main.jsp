<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>main</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous">
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    </head>
    <body>
        <div class="card-body">
            <form action="search" method="post" id = "searchForm">
                <div class="input-group mb-3">
                    <span class="input-group-text">통합검색</span>
                    <input name="keyword" id = "keyword" class="form-control" placeholder="검색어를 입력해주세요">
                </div>
                <input type="submit" class="btn btn-primary" value="검색">
            </form>
        </div>
        <script>
            const form = document.querySelector("#searchForm");
            form.addEventListener("submit", e =>{
                e.preventDefault();

                const keyword = document.querySelector("#keyword").value;

                if (keyword == null || keyword == "") {
                   alert("검색어를 입력해주세요");
                } else if (keyword.length < 2){
                    alert("검색어를 2글자 이상 입력해 주세요");
                } else{
                    form.submit();
                }
            });

            let message = "${message}";
            if (message !== null && message !== "") alert(message);

        </script>
    </body>
</html>