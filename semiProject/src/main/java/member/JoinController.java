package member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		}else if(uri.indexOf("dbCheckId.do") != -1) {
			String userid=request.getParameter("userid");
			System.out.println("가져온 아이디 값"+userid);
			int result=dao.selectAllId(userid);
			HttpSession session=request.getSession();
			session.setAttribute("result", result);
			String page="/shop/dbCheckId.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page); 
			rd.forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
