package io.good.gooddev_web.board.vo;

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
public class CommentVO {

	private int cno;
	private String mid;
	private String comment_content;
	private int bno;
	private int parent_cno;
	private String deleteYn;
	
}
