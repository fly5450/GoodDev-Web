package io.good.gooddev_web.admin.dto;

import java.util.List;

import lombok.Data;

@Data
public class PageResponseDTO<E> {
	//출력 데이터 페이지네이션(.페이지 네비게이션에 대한 사이즈)
	private int page;	//액티브 페이지
	private int size = 10 ;
	private int total;       // 전체 회원 수
	private int begin;	//페이지 시작 번호
	private int end;	//페이지 끝 번호
	
	//이전 다음 버튼 출력 여부
	private boolean prev;
	private boolean next;
	
	private List<E> list;
	
	public PageResponseDTO(PageRequestDTO pageRequestDTO, List<E> list ,int total) {
		this.page = pageRequestDTO.getPage();
		this.size = pageRequestDTO.getSize();
		this.list = list;
		
		this.end = (int) Math.ceil(page/10.0) * 10;
		this.begin = end - 9;

		//최종 페이지 값 보정
		int last = (int)Math.ceil(total/ (float)size);
		this.end = last < this.end ? last : this.end;
		
		this.prev = this.begin > 1;
		this.next = total > this.end * this.size; 
		
		//정수 int는 실수를 계산하지않으므로 float을 이용해 계산후 형변환
//		this.end = (int) Math.ceil(page/(float) size) * size; 
//		this.begin = end - (size - 1);
	}
}
 