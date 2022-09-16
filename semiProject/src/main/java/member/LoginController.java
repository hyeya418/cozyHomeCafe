package member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.dao.MemberDAO;
import member.dto.MemberDTO;


@WebServlet("/login_servlet/*")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String uri=request.getRequestURI();//요청한 주소
		String path=request.getContextPath();
		MemberDAO dao=new MemberDAO();
		
		//회원 로그인
		if(uri.indexOf("login.do") != -1) {
			String userid=request.getParameter("userid");
			String pw1=request.getParameter("pw1");
			MemberDTO dto=new MemberDTO();
			dto.setUserid(userid);
			dto.setPw1(pw1);
			String name=dao.login(dto);
			
			String page="";
			if(name==null) {//로그인 실패
				page=path+"/shop/login.jsp?message=error";
				response.sendRedirect(page);
			}else {//로그인 성공
				HttpSession session=request.getSession();
				session.setAttribute("userid", userid);
				session.setAttribute("name", name);
				request.setAttribute("result", name+"님 환영합니다!🙌");
				page="/shop/mypage.jsp";
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
			
		//회원 로그아웃
		}else if(uri.indexOf("logout.do") != -1) {
			HttpSession session=request.getSession();
			session.invalidate();//세션 초기화
			String page=path+"/shop/login.jsp?message=logout";
			response.sendRedirect(page);
		
		//아이디 찾기
		}else if(uri.indexOf("remind_id.do")!= -1) {
			String email=request.getParameter("email");
			MemberDTO dto=new MemberDTO();
			dto.setEmail(email);
			String result=dao.remindIdCheck(dto);
			//System.out.println(result);
			request.setAttribute("result", result);
			String page="";
			page="/shop/remind_id_result.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		//비밀번호 찾기
		}else if(uri.indexOf("remind_pw.do")!= -1) {
			String userid=request.getParameter("userid");
			String email=request.getParameter("email");
			MemberDTO dto=new MemberDTO();
			dto.setUserid(userid);
			dto.setEmail(email);
			String result=dao.remindPwCheck(dto);
			//System.out.println(result);
			request.setAttribute("result", result);
			String page="";
			page="/shop/remind_pw_result.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		}
		
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
