package com.myblog.heylog.manage;

import java.io.File;
import java.util.HashMap;
import java.util.List;
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

import com.myblog.heylog.blog.Blog;
import com.myblog.heylog.blog.BlogService;
import com.myblog.heylog.blog.Reply;
import com.myblog.heylog.common.MyUtil;
import com.myblog.heylog.member.SessionInfo;

@Controller("manage.manageController")
@RequestMapping("/manage/*")
public class ManageController {
	
	@Autowired
	private ManageService service;
	
	@Autowired
	private BlogService bService;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("home")
	public String home() throws Exception {
		return ".four.manage.blog.home";
	}
	
	@RequestMapping(value = "setting", method = RequestMethod.GET)
	public String setting(
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Manage dto=service.readBlog(info.getUserId());
		
		model.addAttribute("dto", dto);
		
		return ".four.manage.blog.blogset";
	}
	
	@RequestMapping(value = "setting", method = RequestMethod.POST)
	@ResponseBody
	public String updateBlog(
			Manage dto,
			HttpSession session
			) throws Exception {
		String state="true";

		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"blog";

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		info.setUserNick(dto.getUserNick());
		
		try {
			service.updateBlog(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
		return state;
	}
	
	@RequestMapping("category")
	public String category(
			Model model,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Manage dto=service.readBlog(info.getUserId());
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("blogNum", dto.getBlogNum());
		
		List<Manage> list=service.listCategory(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		
		return ".four.manage.blog.category";
	}
	
	@RequestMapping(value = "insertCate", method = RequestMethod.POST)
	@ResponseBody
	public String insertCate(
			Manage dto
			) throws Exception {
		String state="true";
		try {
			service.insertCategory(dto);
		} catch (Exception e) {
			state="false";
		}
		return state;
	}
	
	@RequestMapping(value = "updateCate", method = RequestMethod.POST)
	@ResponseBody
	public String updateCate(
			Manage dto
			) throws Exception {
		String state="true";
		try {
			service.updateCategory(dto);
		} catch (Exception e) {
			state="false";
		}
		return state;
	}

	@RequestMapping(value = "deleteCate", method = RequestMethod.POST)
	@ResponseBody
	public String deleteCate(
			Manage dto
			) throws Exception {
		String state="true";
		
		try {
			service.deleteCategory(dto);
		} catch (Exception e) {
			state="false";
		}
		return state;
	}
	
	@RequestMapping(value = "guestbook", method = RequestMethod.GET)
	public String guestbook(			
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value = "rows", defaultValue = "10") int rows,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Manage dto=service.readBlog(info.getUserId());
		Map<String, Object> map=new HashMap<String, Object>();

		int total_page;
		int dataCount;
		
		map.put("blogNum", dto.getBlogNum());
		
		dataCount=bService.dataCount(map);
		total_page=myUtil.pageCount(rows, dataCount);
		
		if (total_page < current_page)
			current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		
		List<Blog> list=bService.listGuest(map);
		
		String cp = req.getContextPath();
		String listUrl = cp + "/manage/guestbook";
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);

		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("rows", rows);
		
		return ".four.manage.blog.guestbook";
	}
	
	@RequestMapping(value = "updateGuestSecret", method = RequestMethod.POST)
	@ResponseBody
	public String updateGuestSecretType(
			Blog dto
			) throws Exception {
		String state="true";
		try {
			service.updateGuestSecret(dto);	
		} catch (Exception e) {
			state="false";
			e.printStackTrace();
		}

		return state;
	}
	
	@RequestMapping(value = "reply")
	public String reply(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value = "rows", defaultValue = "10") int rows,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Map<String, Object> map=new HashMap<String, Object>();

		int total_page;
		int dataCount;
		
		map.put("userId", info.getUserId());
		
		dataCount=service.replyCount(info.getUserId());
		total_page=myUtil.pageCount(rows, dataCount);
		
		if (total_page < current_page)
			current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		
		List<Reply> list=service.listReply(map);
		
		String cp = req.getContextPath();
		String listUrl = cp + "/manage/reply";
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);

		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("rows", rows);
		
		return ".four.manage.blog.reply";
	}
	
	@RequestMapping(value = "updateReplySecret", method = RequestMethod.POST)
	@ResponseBody
	public String updateReplySecret(
			Reply dto
			) throws Exception {
		String state="true";
		try {
			service.updateReplySecret(dto);	
		} catch (Exception e) {
			state="false";
			e.printStackTrace();
		}

		return state;
	}
}
