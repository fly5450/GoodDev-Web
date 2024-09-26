package io.good.gooddev_web.board.dto;

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
public class CommentDTO {

	private int cno;
	private String mid;
	private String comment_content;
	private int bno;
	private int parent_cno;
	private String deleteYn;
	
}
