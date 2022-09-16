package admin.dao;

import org.apache.ibatis.session.SqlSession;

import admin.dto.AdminDTO;
import sqlmap.MybatisManager;

public class AdminDAO {
	//관리자 로그인
	public String login(AdminDTO dto) {
		String name="";
		try(SqlSession session=MybatisManager.getInstance().openSession()){
			name=session.selectOne("admin.login", dto);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return name;
	}
}
