package test.com.todayhome.model;

import java.sql.Date;

import lombok.Data;

@Data
public class EventVO {
	
	private int num;
	private String title;
	private String content;
	private String img;
	private Date startdate;
	private Date enddate;
	private String contentimg;

}
