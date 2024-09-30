<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination-container">
	<ul class="pagination">
		<c:if test="${not empty pageResponseDTO && not empty pageRequestDTO}">
			<c:if test="${pageResponseDTO.prev}">
				<li><a href="#" data-param="${pageRequestDTO.getParam(pageResponseDTO.start-1)}">이전</a></li>
			</c:if>
			<c:forEach var="num" begin="${pageResponseDTO.start}" end="${pageResponseDTO.end}">
				<li class="${pageResponseDTO.page == num ? 'active' : ''}">
					<a href="?page=${num}&size=${pageResponseDTO.size}" data-param="${pageRequestDTO.getParam(num)}">${num}</a>
				</li>
			</c:forEach>
			<c:if test="${pageResponseDTO.next}">
				<li><a href="#" data-param="${pageRequestDTO.getParam(pageResponseDTO.end+1)}">다음</a></li>
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
		console.log("Redirecting to: list?" + param);
		self.location = "list?" + param;
	});
});

</script>
