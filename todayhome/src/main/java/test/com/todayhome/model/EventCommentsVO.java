package test.com.todayhome.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class EventCommentsVO {
	
	private int num;
	private int evnum;
	private Timestamp wdate;
	private String content;
	private int mnum;
	
	private String mbrImg;
	private String mbrNickname;

}
