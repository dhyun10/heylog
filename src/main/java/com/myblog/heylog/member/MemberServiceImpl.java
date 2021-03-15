package com.myblog.heylog.member;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myblog.heylog.common.dao.CommonDAO;

@Service("member.memberService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			if(dto.getTel1().length()!=0&&dto.getTel2().length()!=0&&dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1()+dto.getTel2()+dto.getTel3());
			}
			if(dto.getEmail1().length()!=0&&dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
			}
			if(dto.getYear().length()!=0&&dto.getMonth().length()!=0&&dto.getDay().length()!=0) {
				dto.setBirth(dto.getYear()+"-"+dto.getMonth()+"-"+dto.getDay());
			}
			
			dao.insertData("member.insertMember1", dto);
			dao.insertData("member.insertMember2", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public int check_id(String userId) throws Exception {
		int result=0;
		try {
			result=dao.selectOne("member.check_id", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int check_email(String email) throws Exception {
		int result=0;
		try {
			result=dao.selectOne("member.check_email", email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Member loginMember(String userId) {
		Member dto=null;
		try {
			dto=dao.selectOne("member.loginMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateLastLogin(String userId) throws Exception {
		try {
			dao.updateData("member.updateLastLogin", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public String searchId(Member dto) throws Exception {
		String result="";
		try {
			result=dao.selectOne("member.searchId", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void getKey(Map<String, Object> map) {
		try {
			dao.insertData("member.getKey", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void alter_userKey(Map<String, Object> map) {
		try {
			dao.updateData("member.alter_userkey", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void searchPassword(Map<String, Object> map) {
		try {
			dao.updateData("member.searchPassword", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Member readMember(String userId) {
		Member dto=null;
		try {
			dto=dao.selectOne("member.readMember", userId);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if(dto.getTel()!=null) {
					dto.setTel1(dto.getTel().substring(0, 3));
					dto.setTel2(dto.getTel().substring(3, 7));
					dto.setTel3(dto.getTel().substring(7));
				}
				
				if(dto.getBirth()!=null) {
					String [] s=dto.getBirth().split("-");
					dto.setYear(s[0]);
					dto.setMonth(s[1]);
					dto.setDay(s[2]);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			if(dto.getTel1().length()!=0&&dto.getTel2().length()!=0&&dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1()+dto.getTel2()+dto.getTel3());
			}
			if(dto.getEmail1().length()!=0&&dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1()+"@"+dto.getEmail2());
			}
			if(dto.getYear().length()!=0&&dto.getMonth().length()!=0&&dto.getDay().length()!=0) {
				dto.setBirth(dto.getYear()+"-"+dto.getMonth()+"-"+dto.getDay());
			}
			
			dao.updateData("member.updateMember1", dto);
			dao.updateData("member.updateMember2", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("member.deleteMember1", map);
			dao.deleteData("member.deleteMember2", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updatePwd(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("member.updatePwd", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
}
