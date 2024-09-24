package io.good.gooddev_web.board.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardDTO {
	
	private Long bno;
	private String title;
	private String content;
	private String mid;
	private String board_password;
	private int category_no;
	private int view_cnt;
	private Date insert_date;
	private int parent_bno;
	private String deleteYn;
	private int like_cnt;
	private int hate_cnt;
	
	public String getFormatDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yy/MM/dd");
		return sdf.format(insert_date);
	}
	
}
