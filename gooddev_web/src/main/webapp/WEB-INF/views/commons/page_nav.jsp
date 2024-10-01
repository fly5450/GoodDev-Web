<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="pagination-container">
	<ul class="pagination">
		<c:if test="${not empty pageResponseDTO && not empty pageRequestDTO}">
			<li>
				<button id="prev" class="page-button" data-page="${pageResponseDTO.start - 1}" style="display: none;">이전</button>
			</li>
			<c:forEach var="num" begin="${pageResponseDTO.start}" end="${pageResponseDTO.end}">
				<li id="page-list" class="page-item">
				<button class="page-button ${pageResponseDTO.page == num ? 'active' : ''}" data-page="${num}">
					${num}
				</button>
			</li>
			</c:forEach>
			<button id="next" class="page-button" data-page="${pageResponseDTO.end+1}">다음</button>
		</c:if>
	</ul>
</div>


<script>
	const prevButton = document.getElementById('prev');
    if (!${pageResponseDTO.prev}) {
        prevButton.style.display = 'none';
    }

	const nextButton = document.getElementById('next');
    if (!${pageResponseDTO.next}) {
        nextButton.style.display = 'none';
    }


	async function doFetch(url, bodyData) {
		const response = await fetch(url, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			},
			body: bodyData
		});

		const json = await response.json();
		return json;
	}
</script>
