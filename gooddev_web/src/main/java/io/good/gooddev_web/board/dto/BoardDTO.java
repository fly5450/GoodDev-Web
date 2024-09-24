package io.good.gooddev_web.board.dto;

import java.time.LocalDate;

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
	private String boardPassword;
	private int categoryNo;
	private int viewCnt;
	private LocalDate insertDate;
	private int parentBno;
	private String deleteYn;
	private int likeCnt;
	private int hateCnt;


}
