package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDAO;
import member.dto.MemberDTO;


@WebServlet("/join_servlet/*")
public class JoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri=request.getRequestURI();
		MemberDAO dao=new MemberDAO();
		
		//회원가입
		if(uri.indexOf("join.do") != -1) {
			String userid=request.getParameter("userid");
			String pw1=request.getParameter("pw1");
			String name=request.getParameter("name");
			String tel=request.getParameter("tel");
			String email=request.getParameter("email");
			
			MemberDTO dto=new MemberDTO();
			dto.setUserid(userid);
			dto.setPw1(pw1);
			dto.setName(name);
			dto.setTel(tel);
			dto.setEmail(email);
			dao.insert(dto);//레코드 저장
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
