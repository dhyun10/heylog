package com.myblog.heylog.blog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myblog.heylog.common.MyUtil;
import com.myblog.heylog.manage.Manage;
import com.myblog.heylog.manage.ManageService;
import com.myblog.heylog.member.SessionInfo;

@Controller("board.boardController")
@RequestMapping("/*")
public class BoardController {
	
	@Autowired
	private MyUtil myUtil;	
	@Autowired
	private ManageService mService;	
	@Autowired
	private BlogService service;
	
	@RequestMapping("{userId}/category/{category}")
	public String categoryList(
			@PathVariable String userId,
			@PathVariable String category,			
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(value = "rows", defaultValue = "5") int rows,
			HttpServletRequest req,
			Model model
			) throws Exception {

		Manage dto=mService.readBlog(userId);	
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("blogNum", dto.getBlogNum());
		
		List<Manage> list=mService.listCategory(map);
		
		map.put("userId", userId);
		map.put("category", category);
		
		int total_page;

		int boardCount=service.boardCount(map);
		total_page=myUtil.pageCount(rows, boardCount);
		
		if (total_page < current_page)
			current_page = total_page;

        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
		List<Board> bList=service.listBoard(map);
        
		String cp = req.getContextPath();
		String listUrl = cp + "/"+userId+"/category/"+category;

		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("rows", rows);
		
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		model.addAttribute("category", category);
		model.addAttribute("boardCount", boardCount);
		
		model.addAttribute("bList", bList);
		
		return ".blog3.category.list";
	}
	
	@RequestMapping(value = "{userId}/board/write", method = RequestMethod.GET)
	public String writeForm(
			@PathVariable String userId,
			Model model
			) throws Exception {
		Manage dto=mService.readBlog(userId);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("blogNum", dto.getBlogNum());
		
		List<Manage> list=mService.listCategory(map);
		
		model.addAttribute("mode", "write");
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		
		return ".blog3.category.write";
	}
	
	@RequestMapping(value = "{userId}/board/write", method = RequestMethod.POST)
	public String writeSubmit(
			@PathVariable String userId,
			HttpSession session,
			Board dto
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		try {
			dto.setUserId(info.getUserId());
			service.insertBoard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/manage/home";
	}
	
	@RequestMapping(value = "{userId}/{boardNum}")
	public String article(
			@PathVariable String userId,
			@PathVariable int boardNum,
			Model model
			) throws Exception {
		Manage dto=mService.readBlog(userId);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("blogNum", dto.getBlogNum());
		
		List<Manage> list=mService.listCategory(map);
		
		map.put("userId", userId);
		map.put("boardNum", boardNum);
		
		Board bDto=service.readBoard(map);
		
		service.updateHitCount(boardNum);
		List<Board> tagList=service.listTag(boardNum);

		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		
		model.addAttribute("tList", tagList);
		model.addAttribute("bDto", bDto);
		
		return ".blog3.category.article";
	}
	
	@RequestMapping(value = "{userId}/{boardNum}/update", method = RequestMethod.GET)
	public String updateForm(
			@PathVariable String userId,
			@PathVariable int boardNum,
			Model model
			) throws Exception {
		Manage dto=mService.readBlog(userId);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("blogNum", dto.getBlogNum());
		
		List<Manage> list=mService.listCategory(map);
		
		map.put("userId", userId);
		map.put("boardNum", boardNum);
		List<Board> tagList=service.listTag(boardNum);

		Board bDto=service.readBoard(map);

		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		model.addAttribute("bDto", bDto);
		model.addAttribute("mode", "update");
		model.addAttribute("tList", tagList);
		
		
		return ".blog3.category.write";
	}
	
	@RequestMapping(value = "{userId}/{boardNum}/update", method = RequestMethod.POST)
	public String updateSubmit(
			@PathVariable String userId,
			@PathVariable int boardNum,
			Board dto
			) throws Exception {		
		try {
			System.out.println(boardNum);
			dto.setBoardNum(boardNum);
			service.updateBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/"+userId+"/"+boardNum;
	}
	
	@RequestMapping(value = "{userId}/{boardNum}/delete")
	public String deleteBoard(
			@PathVariable String userId,
			@PathVariable int boardNum
			) throws Exception {
		
		service.deleteBoard(boardNum);
		
		return "redirect:/"+userId;
	}
	
	@RequestMapping("{userId}/{boardNum}/insertReply")
	@ResponseBody
	public Map<String, Object> insertBoardReply(
			@PathVariable String userId,
			HttpSession session,
			Reply dto
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		dto.setUserId(info.getUserId());
		String state="true";
		
		try {
			service.insertBoardReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
		Map<String, Object> model=new HashMap<String, Object>();
		
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping("{userId}/{boardNum}/listReply")
	public String listReply(
			@PathVariable String userId,
			@PathVariable int boardNum,
			Model model
			) throws Exception {
		List<Reply> list=service.listBoardReply(boardNum);
		
		model.addAttribute("replyList", list);
		model.addAttribute("userId", userId);
				
		return "blog/category/reply";
	}
	
	@RequestMapping("{userId}/{boardNum}/updateReply")
	@ResponseBody
	public Map<String, Object> updateReply(
			Reply dto
			) {
		String state="true";
		
		try {
			service.updateBoardReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
		Map<String, Object> model=new HashMap<String, Object>();
		
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value = "{userId}/{boardNum}/deleteReply")
	@ResponseBody
	public Map<String, Object> deleteReply(
			Reply dto
			) throws Exception {
		String state="true";
		
		try {
			service.deleteBoardReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
		Map<String, Object> model=new HashMap<>();
		
		model.put("state", state);
		
		return model;
	}
	 
	@RequestMapping(value = "{userId}/{boardNum}/insertAnswer")
	@ResponseBody
	public Map<String, Object> insertAnswer(
		@PathVariable String userId,
		HttpSession session,
		Reply dto
		) throws Exception {
	SessionInfo info=(SessionInfo)session.getAttribute("member");
	dto.setUserId(info.getUserId());
	
	String state="true";
	
	try {
		service.insertReplyAnswer(dto);
	} catch (Exception e) {
		e.printStackTrace();
		state="false";
	}
	Map<String, Object> model=new HashMap<String, Object>();
	
	model.put("state", state);
	
	return model;
	}
}
