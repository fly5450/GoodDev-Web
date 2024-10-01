<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <div>
        <p>실시간 TOP10</p>
    </div>
    <div>
        <table>
            <tbody>
                <c:forEach var="board" items="${topTenList}"> <!-- TOP 10 리스트를 위한 데이터 -->
                    <tr>     
                    	<td><a href="#" class="list-title" data-board-bno="${board.bno}" data-page="${pageResponse.page}" data-link="${pageRequestDTO.link}">${board.title}</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
	<script>
		
		document.addEventListener('DOMContentLoaded', function() {
			let links = document.querySelectorAll('.list-title');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    let boardBno = link.getAttribute('data-board-bno');
                    let pageLink = link.getAttribute('data-link');
                    let page = link.getAttribute('data-page');
                    let encodedLink = encodeURIComponent(pageLink);
                    link.href = "read?bno=" + boardBno + "&link="+encodedLink;
                });
            });
            links = document.querySelectorAll('.board-list-insert');
            links.forEach(function(link) {
                link.addEventListener('click', function() {
                    let category_no = link.getAttribute('data-category_no');
                    link.href = "insert?" +"category_no="+ category_no;
                });
            });
        });
	</script>
