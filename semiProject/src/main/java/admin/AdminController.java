package admin;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.dao.AdminDAO;
import admin.dto.AdminDTO;
import common.Constants;
import product.dao.ProductDAO;
import product.dto.ProductDTO;


@WebServlet("/admin_servlet/*")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String uri=request.getRequestURI();
		String path=request.getContextPath();
		
		//관리자 로그인
		if(uri.indexOf("login.do")!= -1) {
			AdminDAO dao=new AdminDAO();
			String userid=request.getParameter("userid");
			String passwd=request.getParameter("passwd");
			AdminDTO dto=new AdminDTO();
			dto.setUserid(userid);
			dto.setPasswd(passwd);
			String name=dao.login(dto);
			
			String page="";
			if(name==null) {//관리자 로그인 실패
				page=path+"/shop/admin_login.jsp?message=error";
			}else {//관리자 로그인 성공
				HttpSession session=request.getSession();//세션 생성
				//세션변수 저장
				session.setAttribute("admin_userid", dto.getUserid());
				session.setAttribute("userid", userid);
				session.setAttribute("name", name);
				session.setAttribute("result", name+"님 환영합니다!🙌");
				page=path+"/shop/admin_result.jsp";
			}
			response.sendRedirect(page);//페이지 이동
			
			
		//관리자 로그아웃
		}else if(uri.indexOf("logout.do") != -1) {
			HttpSession session=request.getSession();
			session.invalidate();
			String page=path+"/shop/admin_login.jsp?message=logout";
			response.sendRedirect(page);
		
		//상품 등록
		}else if(uri.indexOf("insert_product.do") != -1) {
			ProductDAO dao=new ProductDAO();
			//배포 디렉토리에 이미지 업로드
			ServletContext application=request.getSession().getServletContext();
			String img_path=application.getRealPath("/shop/images/");
			new File(img_path).mkdir();//make directory
			//파일 첨부
			MultipartRequest multi=new MultipartRequest(request, img_path,
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			String product_name=multi.getParameter("product_name");
			int price=Integer.parseInt(multi.getParameter("price"));
			String description=multi.getParameter("description");
			String filename=" ";
			try {
				Enumeration files=multi.getFileNames();
				while(files.hasMoreElements()) {
					String file1=(String)files.nextElement();
					filename=multi.getFilesystemName(file1);//첨부파일 이름
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			ProductDTO dto=new ProductDTO();
			dto.setProduct_name(product_name);
			dto.setPrice(price);
			dto.setDescription(description);
			//첨부파일이 없을 때
			if(filename==null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dao.insertProduct(dto);//레코드 저장
			//목록으로 이동
			String page=path+"/product_servlet/list.do";
			response.sendRedirect(page);
			
		//상품 상세정보
		}else if(uri.indexOf("edit.do") != -1) {
			ProductDAO dao=new ProductDAO();
			//상품코드
			int product_code=Integer.parseInt(request.getParameter("product_code"));
			ProductDTO dto=dao.detailProduct(product_code);
			request.setAttribute("dto", dto);//저장
			String page="/shop/product_edit.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);//출력 페이지로 이동
		
		//상품 정보수정
		}else if(uri.indexOf("update.do") != -1) {
			ProductDAO dao=new ProductDAO();
			//배포 디렉토리에 이미지 업로드
			ServletContext application=request.getSession().getServletContext();
			String img_path=application.getRealPath("/shop/images/");
			//파일 첨부
			MultipartRequest multi=new MultipartRequest(request, img_path,
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			String product_name=multi.getParameter("product_name");
			int price=Integer.parseInt(multi.getParameter("price"));
			String description=multi.getParameter("description");
			int product_code=Integer.parseInt(multi.getParameter("product_code"));
			String filename=" ";
			try {
				Enumeration files=multi.getFileNames();
				while(files.hasMoreElements()) {
					String file1=(String)files.nextElement();
					filename=multi.getFilesystemName(file1);//첨부파일 이름
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			ProductDTO dto=new ProductDTO();
			dto.setProduct_name(product_name);
			dto.setPrice(price);
			dto.setDescription(description);
			dto.setProduct_code(product_code);
			//새로운 첨부파일이 없을 때
			if(filename==null || filename.trim().equals("")) {
				ProductDTO dto2=dao.detailProduct(product_code);//기존 레코드 정보
				filename=dto2.getFilename();
				dto.setFilename(filename);
			}else {//새로운 첨부파일이 있을 때
				dto.setFilename(filename);
			}
			
			dao.updateProduct(dto);//레코드 수정
			//목록으로 이동
			String page=path+"/product_servlet/list.do";
			response.sendRedirect(page);
		
		//상품 삭제
		}else if(uri.indexOf("delete.do") != -1) {
			ProductDAO dao=new ProductDAO();
			ServletContext application=request.getSession().getServletContext();
			String img_path=application.getRealPath("/shop/images/");
			MultipartRequest multi=new MultipartRequest(request, img_path,
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int product_code=Integer.parseInt(multi.getParameter("product_code"));//상품코드
			dao.deleteProduct(product_code);
			String page=path+"/product_servlet/list.do";
			response.sendRedirect(page);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
