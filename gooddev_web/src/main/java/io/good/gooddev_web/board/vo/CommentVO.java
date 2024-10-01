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
	private String bno;
	private String parent_cno;
	private String deleteYn;

	public CommentVO(String bno){
		this(bno,null);
	}
	
	public CommentVO(String bno,String parent_cno){
		this.bno = bno;
		this.parent_cno = parent_cno;
	}
}
