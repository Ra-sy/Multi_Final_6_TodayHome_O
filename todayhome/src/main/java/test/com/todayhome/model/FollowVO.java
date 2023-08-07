package test.com.todayhome.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FollowVO {
	private int num;
	private int mbrNum;
	private String mbrNickname;
	private String mbrImg;
	private String mbrIntroduce;
	private int cnt;

}
