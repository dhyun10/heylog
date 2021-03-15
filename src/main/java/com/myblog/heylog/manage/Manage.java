package com.myblog.heylog.manage;

import org.springframework.web.multipart.MultipartFile;

public class Manage {
	private String userId, userNick;
	private String blogName;
	private String blogContent;
	private String thumbnail;
	private MultipartFile uploads;
	
	private int blogNum, categoryNum, subNum;
	private String category;
	private int enabled;
	
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
	public String getBlogName() {
		return blogName;
	}
	public void setBlogName(String blogName) {
		this.blogName = blogName;
	}
	public String getBlogContent() {
		return blogContent;
	}
	public void setBlogContent(String blogContent) {
		this.blogContent = blogContent;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public MultipartFile getUploads() {
		return uploads;
	}
	public void setUploads(MultipartFile uploads) {
		this.uploads = uploads;
	}
	public int getBlogNum() {
		return blogNum;
	}
	public void setBlogNum(int blogNum) {
		this.blogNum = blogNum;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public int getSubNum() {
		return subNum;
	}
	public void setSubNum(int subNum) {
		this.subNum = subNum;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	
	
}
