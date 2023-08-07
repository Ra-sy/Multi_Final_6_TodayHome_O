package test.com.todayhome.controller.mypage;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import test.com.todayhome.model.MemberVO;
import test.com.todayhome.service.MemberService;

import javax.servlet.http.HttpSession;

@Controller
@Slf4j
public class MyPageViewController {

    @Autowired
    MemberService memberService;

    @RequestMapping(value = "/myPage/user/{num}/pwCheck", method = RequestMethod.GET)
    public String myPagePwCheck(@PathVariable("num") int num, HttpSession session, Model model) {
        log.info("/myPagePwCheck");

        int currUserNum = Integer.parseInt(String.valueOf(session.getAttribute("user_id")));

        MemberVO pMember = new MemberVO();
        pMember.setNum(currUserNum);
        MemberVO member = memberService.mSelectOne(pMember);

        model.addAttribute("memberModel", member);

        return "myPage/myPagePwCheck";
    }

    @RequestMapping(value = "/myPage/user/{num}/update", method = RequestMethod.GET)
    public String myPageUpdate(@PathVariable("num") int num, HttpSession session, Model model) {
        log.info("/myPageUpdate");

        int currUserNum = Integer.parseInt(String.valueOf(session.getAttribute("user_id")));

        MemberVO pMember = new MemberVO();
        pMember.setNum(currUserNum);
        MemberVO member = memberService.mSelectOne(pMember);

        model.addAttribute("memberModel", member);

        return "myPage/myPageUpdate";
    }

}
