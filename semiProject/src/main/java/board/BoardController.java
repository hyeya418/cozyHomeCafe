package board;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

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

import board.dao.BoardDAO;
import board.dto.BoardCommentDTO;
import board.dto.BoardDTO;
import common.Constants;
import page.Pager;

@WebServlet("/board_servlet/*")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
				throws ServletException, IOException {
		//클라이언트에서 요청한 주소 처리
		String url=request.getRequestURL().toString();//getRequestURL()은 toString()처리까지 해줘야 한다.
		//컨텍스트 패스
		String path=request.getContextPath();
		BoardDAO dao=new BoardDAO();
		
		//게시글 목록
		if(url.indexOf("list.do") != -1) {
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
			
			//System.out.println("list.do 호출");//테스트
			List<BoardDTO> list=dao.list(start, end);
			request.setAttribute("list", list);
			//페이지 네비게이션 출력을 위한 정보 전달
			request.setAttribute("page", pager);
			//포워딩
			String page="/board/list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		//게시글 등록
		}else if(url.indexOf("insert.do") != -1) {
			//배포 디렉토리에 이미지 업로드
			ServletContext application=request.getSession().getServletContext();
			String img_path=application.getRealPath("/board/review/");
			//파일 첨부
			MultipartRequest multi=new MultipartRequest(request, img_path,
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			String writer=multi.getParameter("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String filename=" ";
			int filesize=0;
			try {
				Enumeration files=multi.getFileNames();
				while(files.hasMoreElements()) {
					String file1=(String)files.nextElement();
					filename=multi.getFilesystemName(file1);//첨부파일 이름
					File f1=multi.getFile(file1);
					if(f1 != null) {
						filesize=(int)f1.length();//파일 사이즈 저장
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			BoardDTO dto=new BoardDTO();
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			//첨부파일이 없는 경우
			if(filename==null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			dao.insert(dto);//레코드 저장
			//목록으로 이동
			String page=path+"/board_servlet/list.do";
			response.sendRedirect(page);
			
		//게시글 상세정보
		}else if(url.indexOf("view.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			//조회수 증가 제한
			HttpSession session=request.getSession();
			//조회수 증가 처리
			dao.plusReadCount(num, session);
			
			//상세정보 처리
			BoardDTO dto=dao.view(num);
			//request영역에 저장
			request.setAttribute("dto", dto);
			//포워딩
			String page="/board/view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		
		//댓글 목록
		}else if(url.indexOf("commentList.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			//System.out.println("댓글을 위한 게시물 번호 : "+num);//테스트
			
			//댓글 목록 리턴
			List<BoardCommentDTO> list=dao.commentList(num);
			request.setAttribute("list", list);
			//포워딩
			String page="/board/comment_list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);

		//댓글 등록
		}else if(url.indexOf("comment_add.do") != -1) {
			int board_num=Integer.parseInt(request.getParameter("board_num"));
			String writer=request.getParameter("writer");
			String content=request.getParameter("content");
			//dto생성
			BoardCommentDTO dto=new BoardCommentDTO();
			dto.setBoard_num(board_num);
			dto.setWriter(writer);
			dto.setContent(content);
			//dao에 저장
			dao.commentAdd(dto);
			
		//답글 작성 창
		}else if(url.indexOf("reply.do") != -1) {
			int num = Integer.parseInt(request.getParameter("num"));
			BoardDTO dto=dao.view(num);
			dto.setContent("-----Original Contents-----\n"+dto.getContent());
			request.setAttribute("dto", dto);
			String page="/board/reply.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		
		//답글 등록
		}else if(url.indexOf("insertReply.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			BoardDTO dto=dao.view(num);
			int ref=dto.getRef();//답변 그룹번호
			int re_step=dto.getRe_step()+1; //출력순번(수정 +1)
			int re_level=dto.getRe_level()+1; //답변 단계(수정 +1)
			String writer=request.getParameter("writer");
			String subject=request.getParameter("subject");
			String content=request.getParameter("content");
			String passwd=request.getParameter("passwd");			
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			dto.setRef(ref);
			dto.setRe_step(re_step);
			dto.setRe_level(re_level);
			//첨부파일 관련 정보
			dto.setFilename("-");
			dto.setFilesize(0);
			//답글 순서 조정
			dao.updateStep(ref, re_step);
			//답글 쓰기
			dao.reply(dto);
			//답글 쓴 이후에 페이지 이동
			String page=path+"/board_servlet/list.do";
			response.sendRedirect(page);
			
		//수정/삭제 버튼 클릭 시 게시글 비밀번호 확인
		}else if(url.indexOf("pass_check.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			//입력한 비밀번호
			String passwd=request.getParameter("passwd");
			//비밀번호가 맞는지 확인
			String result=dao.passwdCheck(num, passwd);
			String page="";
			if(result != null) {//비밀번호가 일치하면
				page="/board/edit.jsp";
				request.setAttribute("dto", dao.view(num));
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {//비밀번호가 일치하지 않으면
				page=path+"/board_servlet/view.do?num="+num+"&message=error";
				response.sendRedirect(page);
			}
	
		//게시글 수정
		}else if(url.indexOf("update.do") != -1) {
			ServletContext application=request.getSession().getServletContext();
			String img_path=application.getRealPath("/board/review/");
			//파일 첨부
			MultipartRequest multi=new MultipartRequest(request, img_path,
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			String writer=multi.getParameter("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String filename=" ";//공백 1개
			int filesize=0;
			try {
				//첨부파일의 집합
				Enumeration<String> files=multi.getFileNames();
				//다음요소가 있으면
				while (files.hasMoreElements()) {
					String file1 = (String)files.nextElement();
					filename=multi.getFilesystemName(file1);
					File f1=multi.getFile(file1);
					if(f1 != null) {
						filesize=(int)f1.length();//파일 사이즈 저장
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			BoardDTO dto=new BoardDTO();
			dto.setNum(num);
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			
			//새로운 첨부파일이 없을 때(테이블의 기존정보를 가져옴)
			if(filename == null || filename.trim().equals("")) {
				BoardDTO dto2=dao.view(num);//기존 레코드 정보
				String fName=dto2.getFilename();
				int fSize=dto2.getFilesize();
				dto.setFilename(fName);
				dto.setFilesize(fSize);
			}else {//새로운 첨부파일이 있을 때
				dto.setFilename(filename);
				dto.setFilesize(filesize);
			}
			
			//레코드 수정
			dao.update(dto);
			//수정 후 페이지 이동
			String page=path+"/board_servlet/list.do";
			response.sendRedirect(page);
			
		//게시글 삭제
		}else if(url.indexOf("delete.do") != -1) {
			ServletContext application=request.getSession().getServletContext();
			String img_path=application.getRealPath("/board/review/");
			MultipartRequest multi=new MultipartRequest(request, img_path,
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			//삭제할 게시물 번호
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete(num);
			//삭제 후 페이지 이동
			String page=path+"/board_servlet/list.do";
			response.sendRedirect(page);
			
		//게시글 검색
		}else if(url.indexOf("search.do") != -1) {
			//검색 옵션과 검색 키워드
			String search_option=request.getParameter("search_option");
			String keyword=request.getParameter("keyword");
			List<BoardDTO> list=dao.searchList(search_option,keyword);
			//검색 값을 웹 영역에 저장
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			//포워딩
			String page="/board/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		
		//최신 리뷰 목록
		}else if(url.indexOf("newList.do") != -1) {
			List<BoardDTO> list=dao.newListReview();
			request.setAttribute("list", list);
			String page="/board/list_new.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
