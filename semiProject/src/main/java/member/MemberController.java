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

@WebServlet("/member_servlet/*")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String uri=request.getRequestURI();//요청한 주소
		String path=request.getContextPath();
		MemberDAO dao=new MemberDAO();
		String page="";
		
		//회원 상세정보
		if(uri.indexOf("view.do") != -1) {
			String userid=request.getParameter("userid");
			MemberDTO dto=dao.view(userid);
			request.setAttribute("dto", dto);
			page="/shop/mypage_edit.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		//회원 정보수정
		}else if(uri.indexOf("update.do") != -1) {
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
			dao.update(dto);
			page=path+"/shop/mypage.jsp";
			response.sendRedirect(page);
			
		//회원 탈퇴
		}else if(uri.indexOf("delete.do") != -1) {
			String userid=request.getParameter("userid");
			dao.delete(userid);
			/*
			 * HttpSession session = request.getSession(); session.invalidate(); //탈퇴시 세션
			 * 초기화
			 */			page=path+"/shop/index.jsp";
			response.sendRedirect(page);
		
		//회원 탈퇴 시 비밀번호 확인
		}else if(uri.indexOf("pass_check.do") != -1) {
			String userid=request.getParameter("userid");
			String pw1=request.getParameter("pw1");
			String result=dao.pwCheck(userid, pw1);
		
			if(result != null) {//비밀번호가 일치하면
				dao.delete(userid);
				request.setAttribute("result", userid+"님 그동안 이용해주셔서 감사합니다.");
				HttpSession session = request.getSession();
				session.invalidate(); //탈퇴시 세션 초기화 
				page="/shop/mypage_delete_ok.jsp";
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {//비밀번호가 틀리면
				page=path+"/shop/mypage_delete.jsp?message=error";
				response.sendRedirect(page);
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
