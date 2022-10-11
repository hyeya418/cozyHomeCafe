package product;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import page.Pager;
import product.dao.ProductDAO;
import product.dto.ProductDTO;


@WebServlet("/product_servlet/*")
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String uri=request.getRequestURI();//요청한 주소
		ProductDAO dao=new ProductDAO();
		String page="";
		
		//상품 목록
		if(uri.indexOf("list.do") != -1) {
			//페이지 네비게이션
			//게시물 개수 계산
			int count=dao.count();
			//페이지 나누기를 위한 처리
			int curPage=1;
			//숫자데이터는 null포인트 exception이 일어날 가능성이 높으므로 if문처리
			if(request.getParameter("curPage") != null) {
				curPage=Integer.parseInt(request.getParameter("curPage"));
			}
			Pager pager=new Pager(count, curPage);
			int start=pager.getPageBegin();
			int end=pager.getPageEnd();
			
			List<ProductDTO> items=dao.listProduct(start, end);
			request.setAttribute("list", items);//저장
			request.setAttribute("page", pager);
			page="/shop/product_list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);//출력 페이지로 이동
			
		//상품 상세정보
		}else if(uri.indexOf("detail.do") != -1) {
			//상품코드
			int product_code=Integer.parseInt(request.getParameter("product_code"));
			ProductDTO dto=dao.detailProduct(product_code);
			request.setAttribute("dto", dto);//저장
			page="/shop/product_detail.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);//출력 페이지로 이동
		
		//신상품 목록
		}else if(uri.indexOf("newList.do") != -1) {
			List<ProductDTO> items=dao.newListProduct();
			request.setAttribute("list", items);//저장
			page="/shop/product_list_new.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);//출력 페이지로 이동
		
		//상품 검색
		}else if(uri.indexOf("search.do") != -1) {
			String keyword=request.getParameter("keyword");
			List<ProductDTO> list=dao.searchList(keyword);
			request.setAttribute("list", list);
			request.setAttribute("keyword", keyword);
			page="/shop/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);

		//상품 체크박스 순 정렬
		}else if(uri.indexOf("sort_list.do") != -1) {
			String sort_standard=request.getParameter("sort_standard");
			System.out.println(sort_standard);
			List<ProductDTO> list=dao.sortList(sort_standard);
			request.setAttribute("list", list);
			request.setAttribute("sort_standard", sort_standard);
			page="/shop/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
