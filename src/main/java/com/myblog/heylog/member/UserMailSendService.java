package com.myblog.heylog.member;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service("mail.mailService")
public class UserMailSendService {
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private MemberService service;
	
	private String init() {
		Random ran=new Random();
		StringBuffer sb=new StringBuffer();
		int num=0;
		
		do {
			num=ran.nextInt(75)+48;
			if((num>=48 && num<=57) || (num>=65 && num <=90) || (num>=97 && num <=122)) {
				sb.append((char)num);
			} else {
				continue;
			}
		} while (sb.length() <size);
		if(lowerCheck) {
			return sb.toString().toLowerCase();
		}
		
		return sb.toString();
	}
	
	private boolean lowerCheck;
	private int size;
	
	public String getKey(boolean lowerCheck, int size) {
		this.lowerCheck=lowerCheck;
		this.size=size;
		return init();
	}
	
	public void mailSendWithUserKey(String email, String userId, HttpServletRequest request) {
		String key=getKey(false, 20);
		
		Map<String, Object> map=new HashMap<>();
		map.put("userId", userId);
		map.put("userkey", key);
		
		service.getKey(map);
		
		MimeMessage mail=mailSender.createMimeMessage();
		String htmlStr="<h2>안녕하세요 회원님! HEYLOG입니다</h2><br><br>"
				+"<h3>"+userId+"님</h3>"+"<p>인증하기 버튼을 누르시면 로그인을 하실 수 있습니다 :"
				+ "<a href='http://localhost:9090"+request.getContextPath()
				+"/member/key_alter?userId="+ userId +"&userkey="+key+"'>인증하기</a></p>";
		try {
			mail.setSubject("[HEYLOG] 회원가입 인증메일입니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}
	
	public void mailSendWithUserPassword(String email, String userId, HttpServletRequest request) {
		String key=getKey(false, 8);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("email", email);
		map.put("userPwd", key);
		
		MimeMessage mail=mailSender.createMimeMessage();
		String htmlStr="<h2>안녕하세요 회원님! HEYLOG입니다</h2><br><br>"
				+"<h3>"+userId+"님</h3>"+"<p>발급된 임시비밀번호는 : <h2>"+key+"</h2> 이며 로그인 후 마이페이지에서 변경해주세요."
				+ "<a href='http://localhost:9090"+request.getContextPath()
				+"/member/login'>로그인 하러하기</a></p>";
		try {
			mail.setSubject("[HEYLOG] 임시 비밀번호가 발급되었습니다.", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		service.searchPassword(map);

	}
}
