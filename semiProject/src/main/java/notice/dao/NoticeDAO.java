package notice.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import notice.dto.NoticeCommentDTO;
import notice.dto.NoticeDTO;
import sqlmap.MybatisManager;

public class NoticeDAO {

	//공지사항 목록
	public List<NoticeDTO> list(int start, int end) {
		List<NoticeDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			Map<String,Object> map=new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list=session.selectList("notice.list", map);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int count() {
		int result=0;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			result=session.selectOne("notice.count");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//공지사항 등록
	public void insert(NoticeDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.insert("notice.insert", dto);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//조회수 증가
	public void plusReadCount(int num, HttpSession count_session) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			//조회수 매크로 제한
			long read_time=0;
			if(count_session.getAttribute("read_time_"+num) != null) {
				read_time=(long)count_session.getAttribute("read_time_"+num);
			}
			long current_time=System.currentTimeMillis();//현재시간
			if(current_time-read_time>5*1000) {
				session.update("notice.plusReadCount", num);
				session.commit();
				count_session.setAttribute("read_time_"+num, current_time);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//상세 정보
	public NoticeDTO view(int num) {
		NoticeDTO dto=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			dto=session.selectOne("notice.view", num);
			String content=dto.getContent();
			content=content.replace("\n", "<br>");
			dto.setContent(content);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	//게시글 비밀번호 확인
	public String passwdCheck(int num, String passwd) {
		String result="";
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			Map<String,Object> map=new HashMap<>();
			map.put("num", num);
			map.put("passwd", passwd);
			result=session.selectOne("notice.passwd_check", map);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//첨부파일 이름찾기
	public String getFileName(int num) {
		String result="";
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			result=session.selectOne("notice.getFileName", num);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//공지사항 수정
	public void update(NoticeDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.update("notice.update", dto);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//공지사항 삭제
	public void delete(int num) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.update("notice.delete", num);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//댓글 목록
	public List<NoticeCommentDTO> commentList(int num) {
		List<NoticeCommentDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			list=session.selectList("notice.commentList", num);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//댓글 등록
	public void commentAdd(NoticeCommentDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.insert("notice.commentAdd", dto);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//답글 순서 조정
	public void updateStep(int ref, int re_step) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			NoticeDTO dto=new NoticeDTO();
			dto.setRef(ref);
			dto.setRe_step(re_step);
			session.update("notice.updateStep", dto);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//답글 작성
	public void reply(NoticeDTO dto) {
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			session.insert("notice.reply", dto);
			session.commit();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//검색
	public List<NoticeDTO> searchList(String search_option, String keyword) {
		List<NoticeDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			Map<String,String> map=new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", "%"+keyword+"%");
			list=session.selectList("notice.searchList", map);
		}catch (Exception e) {
			e.printStackTrace();
		}//finally절 생략 가능
		return list;
	}

	//최신 공지사항 목록
	public List<NoticeDTO> newListNotice() {
		List<NoticeDTO> list=null;
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			list=session.selectList("notice.newList_notice");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
}
