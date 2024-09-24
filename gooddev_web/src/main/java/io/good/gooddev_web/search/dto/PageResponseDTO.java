package io.good.gooddev_web.search.dto;

import java.util.List;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PageResponseDTO<T> {
    private int page;
	private double size;
	private int total;
	
	private int start;
	private int end;
	
	private boolean prev;
	
	private boolean next;
	
	private List<T> list;
	
	public PageResponseDTO(PageRequestDTO pageRequest,List<T> list, int total){
		this.page = pageRequest.getPage();
		this.size = pageRequest.getSize();
		this.total = total;
		this.end = (int) (Math.ceil(page/size)*size);
		this.start = end-((int)size-1);
		int last = (int)Math.ceil(total/size);
		this.end = end > last ? last : end;
		this.prev = this.start > 1;
		this.next = total>this.end*this.size;
		this.list = list;
		
	
	}

}
