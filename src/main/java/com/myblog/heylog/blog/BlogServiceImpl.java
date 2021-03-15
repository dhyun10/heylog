package com.myblog.heylog.blog;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myblog.heylog.common.dao.CommonDAO;

@Service("sevice.blogService")
public class BlogServiceImpl implements BlogService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertGuest(Blog dto) throws Exception {
		try {
			dao.insertData("blog.insertGuest", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateGuest(Blog dto) throws Exception {
		try {
			dao.updateData("blog.updateGuest", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteGuest(Blog dto) throws Exception {
		try {
			dao.deleteData("blog.deleteGuest", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Blog> listGuest(Map<String, Object> map) throws Exception {
		List<Blog> list=null;
		try {
			list=dao.selectList("blog.listGuest", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("blog.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertGuestReply(Reply dto) throws Exception {
		try {
			dao.insertData("blog.insertGuestReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteGuestReply(int replyNum) throws Exception {
		try {
			dao.deleteData("blog.deleteGuestReply", replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int guestReplyCount(int guestNum) {
		int result=0;
		try {
			result=dao.selectOne("blog.guestReplyCount", guestNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Reply> listGuestReply(int guestNum) throws Exception {
		List<Reply> list=null;
		try {
			list=dao.selectList("blog.listGuestReply", guestNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
