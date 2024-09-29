package io.good.gooddev_web.search.dto;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
@NoArgsConstructor
@AllArgsConstructor
public class PageRequestDTO {
	private String mid;
	private int page = 1;
	private int size = 10;
	private String keyword;
	private String category_no;
    private String searchType;
    

	public int getSkip() {
		return (page-1)*size;
	}

	public String getLink() {
		StringBuilder builder = new StringBuilder();
 		builder.append("page=" + page);
		builder.append("&size=" + size);
		if(keyword != null) {
			try {
				builder.append("&keyword=" + URLEncoder.encode(keyword,"UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
        if(category_no != null) {
			builder.append("&category_no=" +category_no);
		}

		// if(searchType != null) {
		// 	builder.append("&searchType=" + searchType);
		//  log.info(str);
		// 	}
		// }
		return builder.toString();
	}
	public String getParam(int page)  {
		StringBuilder builder = new StringBuilder();
		builder.append("page=" + page);
		builder.append("&size=" + this.size);
		
		
		if (keyword != null && keyword.length() > 0) {
			try {
				//keyword = "value=10&key=20"
				builder.append("&keyword=" + URLEncoder.encode(keyword, "UTF-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return builder.toString();
	}

}


