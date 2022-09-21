package member.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import member.dto.MemberDTO;
import sqlmap.MybatisManager;

public class MemberDAO {
	//회원 로그인
	public String login(MemberDTO dto) {
		String name="";
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			name=session.selectOne("member.login", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return name;
	}
	//회원 가입
	public void insert(MemberDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			session.insert("member.insert", dto);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//회원 정보
	public MemberDTO view(String userid) {
		MemberDTO dto=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			dto=session.selectOne("member.view", userid);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	//아이디찾기
	public String remindIdCheck(MemberDTO dto) {
		String result_="";
		String result="";
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			result_=session.selectOne("member.remindIdCheck", dto);
			if(result_==null) {
				result="가입하지 않은 이메일입니다.";
			}else {
				result="가입한 아이디는 "+result_+"입니다.";
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//비밀번호 찾기
	public String remindPwCheck(MemberDTO dto) {
		String result_="";
		String result="";
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			result_=session.selectOne("member.remindPwCheck", dto);
			if(result_==null) { 
				result="가입하지 않은 아이디입니다. \n다시 입력하려면 취소를 누르세요."; 
			}else {
				result="비밀번호는 "+result_+"입니다. \n\n로그인 페이지로 이동하시겠습니까?"; 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//회원 정보수정
	public void update(MemberDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			session.update("member.update", dto);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//회원 탈퇴
	public void delete(String userid) {
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			session.delete("member.delete", userid);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//회원 탈퇴 시 비밀번호 확인
	public String pwCheck(String userid, String pw1) {
		String result="";
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			Map<String,Object> map=new HashMap<>();
			map.put("userid", userid);
			map.put("pw1", pw1);
			result=session.selectOne("member.pw_check", map);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//아이디 중복 확인
	public int selectAllId(String userid) {
		int result=-1;//오류 발생
		String result_="";
		
		try(SqlSession session=MybatisManager.getInstance().openSession()) {
			result_=session.selectOne("member.selectIdAll",userid);
			if(result_!=null) {//사용중인 아이디일 때
				result=1;
				System.out.println("result값 : "+result);
			}else {
				result=0;
				System.out.println("result값 : "+result);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
}
