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
                        <td><a href="read?bno=${board.bno}&${pageRequestDTO.link}">${board.title}</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>