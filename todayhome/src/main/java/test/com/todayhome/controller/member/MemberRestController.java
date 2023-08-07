package test.com.todayhome.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;
import test.com.todayhome.model.MemberVO;
import test.com.todayhome.service.MemberService;

@Slf4j
@Controller
public class MemberRestController {

	@Autowired
	MemberService service;

	@Autowired
	private JavaMailSender mailSender;


    /* 이메일 인증 */
	@ResponseBody
    @RequestMapping(value="/mailCheck", method=RequestMethod.GET)
    public String mailCheckGET(String email) throws Exception{

        /* 뷰(View)로부터 넘어온 데이터 확인 */
        log.info("이메일 데이터 전송 확인");
        log.info("사용자 인증이메일 : " + email);

        /* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;	//111111~999999 범위의 난수
        log.info("인증코드: "+checkNum);	// 랜덤값으로 생성된 인증코드 확인

        /* 이메일 보내기 */
        String setFrom = "werdi717@gmail.com";
        String toMail = email;
        String title = "todayHome 인증코드 이메일";
        String content =
        		"todayHome 인증코드 이메일입니다." +
                "<br><br>" +
                "인증코드는 "+"<strong style='font-weight: bold; font-size: 18px;'>" + checkNum + "</strong>"+" 입니다." +
                "<br>" +
                "해당 인증코드를 인증코드 입력란에 기입해 주세요.";

        //이메일 보내는 코드
        try {

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);

        }catch(Exception e) {
            e.printStackTrace();
        }


        String num = Integer.toString(checkNum);

        return num;

    }

	@ResponseBody
	@RequestMapping(value = "/json_emailCheck", method = RequestMethod.GET)
	public Map<String, String> json_emailCheck(MemberVO vo, Model model) {
		log.info("/json_emailCheck...");
		log.info("{}", vo);// id

		MemberVO vo2 = service.emailCheck(vo);
		log.info("회원정보:{}", vo2);// null or not null

		model.addAttribute("vo2",vo2);

		String msg = "OK";
		if (vo2 != null) {
			msg = "Not OK";
		}

		Map<String, String> map = new HashMap<String, String>();
		map.put("result", msg);
	    if (vo2 != null) {
	        map.put("num", String.valueOf(vo2.getNum())); //num 값을 반환합니다.
	    }
		return map;
	}

//	@ResponseBody
//	@RequestMapping(value = "/json_pwUpdateOK", method = RequestMethod.GET)
//	public Map<String, Integer> json_pwUpdateOK(MemberVO vo) {	//{"result":1}이므로 String, Integer로 설정
//		log.info("/json_pwUpdateOK...{}",vo);
//
//		Map<String, Integer> map = new HashMap<String, Integer>();
//
//		int result = service.pwUpdate(vo);	//MemberVO의 정보를 받아와야 함
//		map.put("result", result);
//
//		return map;	// {"result":1}
//	}

	@RequestMapping(value = "/mJsonSelectAll", method = RequestMethod.GET)
	@ResponseBody
	public List<MemberVO> mJsonSelectAll() {
		log.info("m_rest_selectAll()...");
		List<MemberVO> vos = service.mSelectAll();
		log.info("vos.size={}",vos.size());

		return vos;
	}

	@RequestMapping(value = "/mJsonSelectOne", method = RequestMethod.GET)
	@ResponseBody
	public MemberVO mJsonSelectOne(MemberVO vo) {
		log.info("m_json_selectOne()...");
		MemberVO vo2 = service.mSelectOne(vo);
		log.info("vo2:{}",vo2);

		return vo2;

	}

	@RequestMapping(value = "myPage/user/{num}/mJsonPwCheck", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> mJsonPwCheckMyPage(@PathVariable("num") int num, MemberVO vo) {
		log.info("/mJsonPwCheck");
		log.info("{}", vo);// id

		MemberVO vo2 = service.pwCheck(vo);
		log.info("{}", vo2);// null or not null

		String msg = "NOT OK";
		if (vo2 != null) {
			msg = "OK";
		}

		Map<String, String> map = new HashMap<>();
		map.put("result", msg);
		return map;
	}

	@RequestMapping(value = "/mJsonPwCheck", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, String> mJsonPwCheck(@PathVariable("num") int num, MemberVO vo) {
		log.info("/mJsonPwCheck");
		log.info("{}", vo);// id

		MemberVO vo2 = service.pwCheck(vo);
		log.info("{}", vo2);// null or not null

		String msg = "NOT OK";
		if (vo2 != null) {
			msg = "OK";
		}

		Map<String, String> map = new HashMap<>();
		map.put("result", msg);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/mJsonUpdateOK", method = RequestMethod.POST)
	public Map<String,String> mUpdateOK(MemberVO vo) {
		log.info("mJsonUpdateOK...vo:{}",vo);

		int result = service.mUpdate(vo);
		log.info("result:{}",result);

		String rst = result==1?"1":"0";
		log.info("rst:{}",rst);
		Map<String,String> map = new HashMap<>();

		map.put("result", rst);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/mUpdate/nicknameCheck", method = RequestMethod.GET)
	public String nicknameCheck(MemberVO vo) {
		log.info("/nicknameCheck....{}",vo);
		
		MemberVO vo2 = service.nicknameCheck(vo);
		log.info("{}",vo2);
		if(vo2==null) {
			return "{\"result\":\"OK\"}";
		}else {
			return "{\"result\":\"NotOK\"}";
		}
	}

}
