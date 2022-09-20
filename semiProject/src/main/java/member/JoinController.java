package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
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
		
		//아이디 중복 확인
//		}else if(uri.indexOf("idCheck.do") != -1) {
//			String userid=request.getParameter("userid");
//			PrintWriter out=response.getWriter();
//			
//			MemberDTO dto=new MemberDTO();
//			dto.setUserid(userid);
//			int result=dao.idCheck(dto);
//			
//			if(result == 0) {
//				System.out.println("사용 가능한 아이디입니다.");
//			}else if(result == 1) {
//				System.out.println("사용중인 아이디입니다.");
//			}
//			
//			out.write(result);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
