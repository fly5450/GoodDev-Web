<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
Object obj1 = request.getAttribute("pageRequestDTO");
Object obj2 = request.getAttribute("pageResponseDTO");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
   		<link
           href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
           rel="stylesheet"
           integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
           crossorigin="anonymous"/>
       	<script
           src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
           integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
           crossorigin="anonymous">
           </script>
    
    <!-- external css -->
    <link rel="stylesheet" href="<c:url value='/resources/css/page_nav.css'/>">
     
</head>   
<body>
	<!-- 페이지네이션 양식 스크립트 부분 고쳐서 사용할 것-->
	<div class="float-end" >
	    <ul class="pagination flex-wrap" >
	        <c:if test="${not empty pageResponseDTO && not empty pageRequestDTO}">
	            <c:if test="${pageResponseDTO.prev}">
	                <li class="page-item" ><a class="page-link" href="#" data-param="${pageRequestDTO.getParam(pageResponseDTO.start-1)}">이전</a></li>
	            </c:if>
	
	            <c:forEach var="num" begin="${pageResponseDTO.start}" end="${pageResponseDTO.end}">
	                <li class="page-item ${pageResponseDTO.page == num ? 'active' : ''}">
	                    <a class="page-link" href="?page=${num}&size=${pageResponseDTO.size}" data-param="${pageRequestDTO.getParam(num)}">${num}</a>
	                </li>		
	            </c:forEach>
				
	            <c:if test="${pageResponseDTO.next}">
	                <li class="page-item"><a class="page-link"href="#" data-param="${pageRequestDTO.getParam(pageResponseDTO.end+1)}">다음</a></li>
	            </c:if>
	        </c:if>
	    </ul>
	</div>
	<script>
		document.querySelectorAll(".page-link").forEach(item => {
		    item.addEventListener('click', e => {
		        e.preventDefault();
		        e.stopPropagation();
		        
		        const param = e.target.getAttribute("data-param");
	            self.location = "memberList?" + param; // 경로
		    });
		});
	</script>
</body>
</html>