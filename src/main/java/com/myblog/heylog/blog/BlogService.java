package com.myblog.heylog.blog;

import java.util.List;
import java.util.Map;

public interface BlogService {
	public void insertGuest(Blog dto) throws Exception;
	public void updateGuest(Blog dto) throws Exception;
	public void deleteGuest(Blog dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	
	public List<Blog> listGuest(Map<String, Object> map) throws Exception;
	
	public void insertGuestReply(Reply dto) throws Exception;
	public void deleteGuestReply(int replyNum) throws Exception;
	
	public int guestReplyCount(int guestNum);
	
	public List<Reply> listGuestReply(int guestNum) throws Exception;
	
	public void insertBoard(Board dto) throws Exception;
	public void updateBoard(Board dto) throws Exception;
	public void deleteBoard(Board dto) throws Exception;
	
	public List<Board> listBoard(int categoryNum) throws Exception;
	
}
