package com.myblog.heylog.member;

import java.util.Map;

public interface MemberService {
	public void insertMember(Member dto) throws Exception;
	public int check_id(String userId) throws Exception;
	public int check_email(String email) throws Exception;
	
	public void getKey(Map<String, Object> map);
	public void alter_userKey(Map<String, Object> map);
	
	public Member readMember(String userId);
	
	public void updateMember(Member dto) throws Exception;
	public void updatePwd(Map<String, Object> map) throws Exception;
	public void deleteMember(Map<String, Object> map) throws Exception;
	
	public Member loginMember(String userId);
	public void updateLastLogin(String userId) throws Exception;
	
	public String searchId(Member dto) throws Exception;
	public void searchPassword(Map<String, Object> map);
}
