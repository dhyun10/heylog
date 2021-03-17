package com.myblog.heylog.blog;

public class Reply {
	private int guestNum, replyNum, boardNum;
	private String userId, userNick;
	private String content;
	private String created;
	private int replyType;
	private String secretType;
	
	public int getGuestNum() {
		return guestNum;
	}
	public void setGuestNum(int guestNum) {
		this.guestNum = guestNum;
	}
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserNick() {
		return userNick;
	}
	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public int getReplyType() {
		return replyType;
	}
	public void setReplyType(int replyType) {
		this.replyType = replyType;
	}
	public String getSecretType() {
		return secretType;
	}
	public void setSecretType(String secretType) {
		this.secretType = secretType;
	}
	
}
