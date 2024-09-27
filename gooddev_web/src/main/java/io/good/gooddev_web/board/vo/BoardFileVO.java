package io.good.gooddev_web.board.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardFileVO {
	private String fid;
	private int bno;
	private String file_name;
	private String file_type;
	private int file_size;
}