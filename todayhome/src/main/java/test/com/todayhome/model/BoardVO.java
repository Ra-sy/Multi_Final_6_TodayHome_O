package test.com.todayhome.model;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO {
	private int num;
	private int boardNo;
	private String title;
	private String content;
	private String imgThumb;
	private Timestamp wdate;
	private int vcount;
	private String tag;
	private int brdMnum;
	private int usrMnum;
	private int seqNxtVal;

	private String type;
	private String sqft;
	private String familyType;
	private String workingArea;
	private String worker;
	private String roomNum;
	private String direction;
	private String year;
	private String location;

	private String livingtype;
	private String cooktype;
	private String dailytype;

	private String mbrImg;
	private String mbrNickname;
	private String mbrIntroduce;

	private int cnt;
	private int fvYn;
	private int fvCnt;
	private int cmtCnt;

	private MultipartFile thumbFile;
	private MultipartFile imgFile;
	
	private String nickname;
}
