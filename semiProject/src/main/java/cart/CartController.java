package cart;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.dao.CartDAO;
import cart.dto.CartDTO;


@WebServlet("/cart_servlet/*")
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {	
		String uri=request.getRequestURI();
		String path=request.getContextPath();
		CartDAO dao=new CartDAO();
		HttpSession session=request.getSession();
		String userid=(String)session.getAttribute("userid");//세션변수
		
		//장바구니 추가
		if(uri.indexOf("insert.do") != -1) {
			
			if(userid==null) {//로그아웃 상태
				String page=path+"/shop/login.jsp";
				response.sendRedirect(page);//로그인 페이지로 이동
			}else if(userid != null){//로그인 상태
				CartDTO dto=new CartDTO();
				dto.setUserid(userid);
				dto.setProduct_code(Integer.parseInt(request.getParameter("product_code")));
				dto.setAmount(Integer.parseInt(request.getParameter("amount")));
				dao.insert_cart(dto);//저장
				String page=path+"/cart_servlet/list.do";
				response.sendRedirect(page);//목록으로 이동
			}
			
		//장바구니 목록
		}else if(uri.indexOf("list.do") != -1) {
				int sum_money=dao.sum_money(userid);//총금액
				int fee=sum_money>=50000 ? 0 : 2500;//배송비 계산
				int sum=sum_money+fee;//총금액+배송비
				Map<String, Object> map=new HashMap<>();
				map.put("sum_money", sum_money);
				map.put("fee", fee);
				map.put("sum", sum);
				request.setAttribute("map", map);//저장
				List<CartDTO> items=dao.list_cart(userid);//장바구니 세부목록
				request.setAttribute("list", items);
				String page="/shop/cart_list.jsp";//출력페이지
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			
		//장바구니 삭제
		}else if(uri.indexOf("delete.do") != -1) {
			dao.delete_cart(Integer.parseInt(request.getParameter("cart_id")));
			String page=path+"/cart_servlet/list.do";
			response.sendRedirect(page);//목록으로 이동
	
		//장바구니 비우기
		}else if(uri.indexOf("delete_all.do")!= -1) {
			dao.clear_cart(userid);
			String page=path+"/cart_servlet/list.do";
			response.sendRedirect(page);//목록으로 이동
			
		//장바구니 수정
		}else if(uri.indexOf("update.do") != -1) {
			//수정한 항목이 다수일 수 있으므로 배열로 처리
			String[] product_code=request.getParameterValues("product_code");
			String[] amount=request.getParameterValues("amount");
			String[] cart_id=request.getParameterValues("cart_id");
			
			for(int i=0; i<product_code.length; i++) {
				CartDTO dto=new CartDTO();
				dto.setUserid(userid);
				dto.setCart_id(Integer.parseInt(cart_id[i]));
				dto.setAmount(Integer.parseInt(amount[i]));
				dao.update_cart(dto);
			}
			String page=path+"/cart_servlet/list.do";
			response.sendRedirect(page);//목록으로 이동
	}
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
