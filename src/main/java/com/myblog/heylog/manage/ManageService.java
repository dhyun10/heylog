package com.myblog.heylog.manage;

import java.util.List;
import java.util.Map;

import com.myblog.heylog.blog.Blog;
import com.myblog.heylog.blog.Reply;

public interface ManageService {
	public void insertBlog(Map<String, Object> map) throws Exception;
	public void updateBlog(Manage dto, String pathname) throws Exception;
	public Manage readBlog(String userId);
	
	public void insertCategory(Manage dto) throws Exception;
	public void updateCategory(Manage dto) throws Exception;
	public void deleteCategory(Manage dto) throws Exception;
	public List<Manage> listCategory(Map<String, Object> map) throws Exception;
	
	public void updateGuestSecret(Blog dto) throws Exception;
	
	public List<Reply> listReply(Map<String, Object> map) throws Exception;
	public int replyCount(String userId);
	public void updateReplySecret(Reply dto) throws Exception;
}
