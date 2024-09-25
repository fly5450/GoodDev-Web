package io.good.gooddev_web.admin.dto;

import java.net.URLEncoder;
import java.time.LocalDate;

import lombok.Builder;
import lombok.Builder.Default;
import lombok.Data;

@Data
@Builder
public class PageRequestDTO {
	private int page = 1;	//시작 페이지
	private int size = 10;  //페이지 사이즈의 기본값은 10
	
	private String [] types;
	private String keyword;
	private LocalDate from;
	private LocalDate to;
	
	
	public int getSkip() {	//넘길 페이지
		return (page - 1) * size;
	}

	public String getLink() {
		return getParam(this.page);
	}
	
	public String getParam(int page)  {
		StringBuilder builder = new StringBuilder();
		builder.append("page=" + page);
		builder.append("&size=" + size);
		
//		if (finished) {
//			builder.append("&finished=1");
//		}
		
		if (types != null && types.length > 0) {
		    for (String type : types) {
		       builder.append("&types=" + type);
		    }
		}
		
		if (types != null && types.length > 0) {
			for (String type : types) {
				builder.append("&types=" + type);
			}
		}
		
		if (keyword != null && keyword.length() > 0) {
			try {
				builder.append("&keyword=" + URLEncoder.encode(keyword, "UTF-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (from != null) {
			builder.append("&from=" + from.toString());
		}
		
		if (to != null) {
			builder.append("&to=" + to.toString());
		}
		
		return builder.toString();
	}
	
}
