package com.myblog.heylog.blog;

import java.util.HashMap;
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

	@Override
	public void insertBoard(Board dto) throws Exception {
		try {
			int b_seq=dao.selectOne("blog.board_seq");
			dto.setBoardNum(b_seq);
			
			dao.insertData("blog.insertBoard", dto);
			
			Map<String, Object> map=new HashMap<String, Object>();
			String [] tags=dto.getTag().split(",");

			
			for(int i=0; i<tags.length; i++) {
				int seq=dao.selectOne("blog.tag_seq");
				
				map.put("tagNum", seq);
				map.put("tag", tags[i]);
				map.put("boardNum", b_seq);
				
				insertTag(map);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateBoard(Board dto) throws Exception {
		try {
			dao.updateData("blog.updateBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteBoard(int boardNum) throws Exception {
		try {
			dao.deleteData("blog.deleteBoard", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) throws Exception {
		List<Board> list=null;
		try {
			list=dao.selectList("blog.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int boardCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("blog.boardCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Board readBoard(Map<String, Object> map) {
		Board dto=null;
		try {
			dto=dao.selectOne("blog.readBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateHitCount(int boardNum) throws Exception {
		int result=0;
		try {
			result=dao.updateData("blog.updateHitCount", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertTag(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("blog.insertTag", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Board> listTag(int boardNum) throws Exception {
		List<Board> list=null;
		try {
			list=dao.selectList("blog.readTag", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertBoardReply(Reply dto) throws Exception {
		try {
			int seq=dao.selectOne("blog.reply_seq");
			dto.setReplyNum(seq);
			
			dao.insertData("blog.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateBoardReply(Reply dto) throws Exception {
		try {
			dao.updateData("blog.updateReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteBoardReply(Reply dto) throws Exception {
		try {
			dao.deleteData("blog.deleteReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	@Override
	public void insertReplyAnswer(Reply dto) throws Exception {
		try {
			int seq=dao.selectOne("blog.reply_seq");
			dto.setReplyNum(seq);
			
			int min=dao.selectOne("blog.replyMinSort", dto);
			dto.setGrpOrd(min);
			
			if(min != 0) {
				dao.updateData("blog.replyUpdateSort", dto);	
				dao.insertData("blog.insertAnswer", dto);		
			} else {
				int max=dao.selectOne("blog.replyMaxSort", dto);
				dto.setGrpOrd(max);
				dao.insertData("blog.insertAnswer", dto);	
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int boardReplyCount(int boardNum) {
		int result=0;
		try {
			result=dao.selectOne("blog.replyCount", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Reply> listBoardReply(int boardNum) throws Exception {
		List<Reply> list=null;
		try {
			list=dao.selectList("blog.listBoardReply", boardNum);
			
			for(int i=0; i<list.size(); i++) {
				String user=dao.selectOne("blog.replyUser", list.get(i).getReplyType());
				list.get(i).setReplyUser(user);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoardLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void likeUser(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void likeCount(int boardNum) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Reply listReplyUser(int replyType) throws Exception {
		Reply user=null;
		try {
			user=dao.selectOne("blog.replyUser", replyType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

}
