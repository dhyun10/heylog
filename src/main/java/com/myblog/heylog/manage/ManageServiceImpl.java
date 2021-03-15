package com.myblog.heylog.manage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myblog.heylog.blog.Blog;
import com.myblog.heylog.common.FileManager;
import com.myblog.heylog.common.dao.CommonDAO;

@Service("manage.manageService")
public class ManageServiceImpl implements ManageService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager file;
	
	@Override
	public void insertBlog(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("manage.insertBlog", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateBlog(Manage dto, String pathname) throws Exception {
		try {
			String imgFileName=file.doFileUpload(dto.getUploads(), pathname);
			dto.setThumbnail(imgFileName);

			dao.updateData("manage.updateBlog", dto);
			dao.updateData("manage.updateNick", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Manage readBlog(String userId) {
		Manage dto=null;
		try {
			dto=dao.selectOne("manage.readBlog", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void insertCategory(Manage dto) throws Exception {
		try {
			dao.insertData("manage.insertCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Manage> listCategory(Map<String, Object> map) throws Exception {
		List<Manage> list=null;
		try {
			list=dao.selectList("manage.listCategory", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateCategory(Manage dto) throws Exception {
		try {
			dao.updateData("manage.updateCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteCategory(Manage dto) throws Exception {
		try {
			dao.deleteData("manage.deleteCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateGuestSecret(Blog dto) throws Exception {
		try {
			dao.updateData("manage.updateGuestSecretType", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
