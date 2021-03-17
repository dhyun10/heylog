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
	public void deleteBoard(int boardNum) throws Exception;
	
	public List<Board> listBoard(Map<String, Object> map) throws Exception;
	public int boardCount(Map<String, Object> map);
	
	public Board readBoard(Map<String, Object> map);
	public int updateHitCount(int boardNum) throws Exception;
	
	public void insertTag(Map<String, Object> map) throws Exception;
	public List<Board> listTag(int boardNum) throws Exception;
	
	public void insertBoardReply(Reply dto) throws Exception;
	public void updateBoardReply(Reply dto) throws Exception;
	public void deleteBoardReply(Reply dto) throws Exception;
	
	public int boardReplyCount(int boardNum);
	public List<Reply> listBoardReply(int boardNum) throws Exception;

}
