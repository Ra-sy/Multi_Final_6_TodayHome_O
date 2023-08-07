package test.com.todayhome.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {

	private int num;
	private String name;
	private String email;
	private String pw;
	private String nickname;
	private String auth;
	private String sex;
	private String birth;
	private String img;
	private String introduce;
	
	private MultipartFile imgFile;

	private int seqNxtVal;

}
