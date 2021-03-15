package com.myblog.heylog.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myblog.heylog.manage.ManageService;

@Controller("member.memberController")
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private ManageService mService;
	
	@Autowired
	private UserMailSendService mailsender;

	@RequestMapping(value = "sign", method = RequestMethod.GET)
	public String sign() throws Exception {
		return ".member.sign";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String signin() throws Exception {
		return ".member.sign.login";
	}
	
	@RequestMapping(value = "loginOk", method = RequestMethod.POST)
	public String login(
			@RequestParam String userId,
			@RequestParam String userPwd,
			HttpSession session,
			Model model
			) throws Exception {
		Member dto=service.loginMember(userId);
		
		if(dto==null) {
			model.addAttribute("message", "존재하지 않는 계정입니다.");
			return ".member.sign.login";
		} else if(! userPwd.equals(dto.getUserPwd())) {	
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return ".member.sign.login";
		}
		
		if(dto!=null)
			service.updateLastLogin(dto.getUserId());
		
		SessionInfo info=new SessionInfo();
		info.setUserId(dto.getUserId());
		info.setUserName(dto.getUserName());
		info.setUserNick(dto.getUserNick());
		
		session.setMaxInactiveInterval(30*60);
		
		session.setAttribute("member", info);
		
		return "redirect:/main";
	}
	
	@RequestMapping(value = "logout")
	public String logout(HttpSession session) {
		
		session.removeAttribute("member");
		session.invalidate();
		
		return "redirect:/main";
	}
	
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String joinForm() throws Exception {
		return ".member.sign.join";
	}
	
	@RequestMapping(value = "check_id")
	@ResponseBody
	public int check_id(
			@RequestParam String userId
			) throws Exception {
		return service.check_id(userId);
	}
	
	@RequestMapping(value = "joinOk", method = RequestMethod.POST)
	public String joinSubmit(
			Member dto,
			HttpServletRequest request
			) throws Exception {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userId", dto.getUserId());
		map.put("userNick", dto.getUserId());
		map.put("blogName", dto.getUserId()+"님의 블로그");
		map.put("blogContent", "환영합니다! "+dto.getUserId()+"님의 블로그입니다 ^^*");
			
		try {
			String email=dto.getEmail1()+"@"+dto.getEmail2();
			service.insertMember(dto);
			mService.insertBlog(map);
			mailsender.mailSendWithUserKey(email, dto.getUserId(), request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ".member.sign.joinOk";
	}
	
	@RequestMapping(value = "key_alter", method = RequestMethod.GET)
	public String key_alterConfirm(
			@RequestParam String userId,
			@RequestParam("userkey") String key
			) throws Exception {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("userkey", key);
		
		service.alter_userKey(map);
		
		return ".member.sign.complete";
	}
	
	
	@RequestMapping(value = "findId", method = RequestMethod.GET)
	public String fintIdForm() throws Exception {
		return "/member/sign/findId";
	}
	
	@RequestMapping(value = "findId", method = RequestMethod.POST)
	@ResponseBody
	public String findId(
			Member dto
			) throws Exception {		
		String result= service.searchId(dto);
		return result;
	}
	
	@RequestMapping(value = "findPwd", method = RequestMethod.GET)
	public String findPwdForm() throws Exception {
		return "/member/sign/findPwd";
	}
	
	@RequestMapping(value = "findPwd", method = RequestMethod.POST)
	@ResponseBody
	public String findPwd(
			@RequestParam String userId,
			@RequestParam String email,
			HttpServletRequest request
			) throws Exception {
		String msg="true";
		try {
			mailsender.mailSendWithUserPassword(email, userId, request);
		} catch (Exception e) {
			e.printStackTrace();
			msg="false";
		}		
		return msg;
	}
	
	@RequestMapping("home")
	public String home(
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readMember(info.getUserId());
		
		model.addAttribute("dto", dto);
		
		return ".four.mypage.mypage.home";
	}
	
	@RequestMapping("setting")
	public String info() throws Exception {
		return ".four.mypage.mypage.setting";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readMember(info.getUserId());
		
		model.addAttribute("dto", dto);
		
		return ".four.mypage.mypage.update";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public String updateSubmit(
			Member dto,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");		
		String msg="true";
		dto.setUserId(info.getUserId());
		
		try {
			service.updateMember(dto);	
		} catch (Exception e) {
			msg="false";
		}
		
		return msg;
	}
	
	@RequestMapping(value = "updatePwd", method = RequestMethod.GET)
	public String updatePwd(
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readMember(info.getUserId());
		
		model.addAttribute("dto", dto);
		
		return ".four.mypage.mypage.updatePwd";
	}
	
	@RequestMapping(value = "updatePwd", method = RequestMethod.POST)
	@ResponseBody
	public String updatePwdSubmit(
			HttpSession session,
			@RequestParam String userPwd
			) throws Exception {		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String msg="true";
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		map.put("userPwd", userPwd);
		
		try {
			service.updatePwd(map);	
		} catch (Exception e) {
			msg="false";
		}
		
		return msg;
	}
	
	@RequestMapping(value = "delete",method = RequestMethod.GET)
	public String deleteCheck(
			HttpSession session,
			Model model
			) throws Exception {		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readMember(info.getUserId());
			
		model.addAttribute("dto", dto);
		
		return ".four.mypage.mypage.checkPwd";
	}
	
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String msg="true";
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userId", info.getUserId());
		
		try {
			service.deleteMember(map);	
		} catch (Exception e) {
			e.printStackTrace();
			msg="false";
		}
		
		session.removeAttribute("member");
		session.invalidate();
		
		return msg;
	}

}
