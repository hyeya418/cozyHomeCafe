package notice;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.Constants;
import notice.dao.NoticeDAO;
import notice.dto.NoticeCommentDTO;
import notice.dto.NoticeDTO;
import page.Pager;

@WebServlet("/notice_servlet/*")
public class NoticeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String uri=request.getRequestURI();//요청한 주소
		String path=request.getContextPath();
		NoticeDAO dao=new NoticeDAO();
		String page="";
		
		//공지사항 목록
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
			
			List<NoticeDTO> list=dao.list(start,end);
			request.setAttribute("list", list);
			//페이지 네비게이션 출력을 위한 정보 전달
			request.setAttribute("page", pager);
			//포워딩
			page="/notice/list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		//공지사항 등록
		}else if(uri.indexOf("insert.do") != -1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);//업로드 디렉토리
			if(!uploadDir.exists()) {//업로드 디렉토리가 없을 때
				uploadDir.mkdir();//디렉토리 생성
			}
			MultipartRequest multi=new MultipartRequest(request, Constants.UPLOAD_PATH, 
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			String writer=multi.getParameter("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String filename=" ";
			int filesize=0;
			try {
				//첨부파일의 집합
				Enumeration files=multi.getFileNames();
				//다음요소가 있으면
				while(files.hasMoreElements()) {
					String file1=(String)files.nextElement();
					filename=multi.getFilesystemName(file1);
					File f1=multi.getFile(file1);
					if(f1 != null) {
						filesize=(int)f1.length();//파일 사이즈저장
					}
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			NoticeDTO dto=new NoticeDTO();
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			if(filename==null || filename.trim().equals("")) {
				filename="-";
			}
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			dao.insert(dto);
			page=path+"/notice_servlet/list.do";
			response.sendRedirect(page);
			
		//공지사항 상세 정보
		}else if(uri.indexOf("view.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			//조회수 증가
			HttpSession session=request.getSession();
			dao.plusReadCount(num, session);
			
			//상세 정보
			NoticeDTO dto=dao.view(num);
			request.setAttribute("dto", dto);
			page="/notice/view.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		//게시글 비밀번호 확인
		}else if(uri.indexOf("pass_check.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String passwd=request.getParameter("passwd");
			String result=dao.passwdCheck(num, passwd);
			if(result != null) {//비밀번호가 일치하면
				page="/notice/edit.jsp";
				request.setAttribute("dto", dao.view(num));
				RequestDispatcher rd=request.getRequestDispatcher(page);
				rd.forward(request, response);
			}else {//비밀번호가 일치하지 않으면
				page=path+"/notice_servlet/view.do?num="+num+"&message=error";
				response.sendRedirect(page);
			}
			
		//공지사항 수정
		}else if(uri.indexOf("update.do") != -1) {
			File uploadDir=new File(Constants.UPLOAD_PATH);//업로드 디렉토리
			if(!uploadDir.exists()) {//업로드 디렉토리가 없을 때
				uploadDir.mkdir();//디렉토리 생성
			}
			MultipartRequest multi=new MultipartRequest(request, Constants.UPLOAD_PATH, 
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			String writer=multi.getParameter("writer");
			String subject=multi.getParameter("subject");
			String content=multi.getParameter("content");
			String passwd=multi.getParameter("passwd");
			String filename=" ";
			int filesize=0;
			try {
				//첨부파일의 집합
				Enumeration<String> files=multi.getFileNames();
				//다음요소가 있으면
				while(files.hasMoreElements()) {
					String file1=(String)files.nextElement();
					filename=multi.getFilesystemName(file1);
					File f1=multi.getFile(file1);
					if(f1 != null) {
						filesize=(int)f1.length();//파일 사이즈저장
					}
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			NoticeDTO dto=new NoticeDTO();
			dto.setNum(num);
			dto.setWriter(writer);
			dto.setSubject(subject);
			dto.setContent(content);
			dto.setPasswd(passwd);
			//새로운 첨부파일이 없을 때(기존 정보)
			if(filename==null || filename.trim().equals("")) {
				NoticeDTO dto2=dao.view(num);
				String fName=dto2.getFilename();
				int fSize=dto2.getFilesize();
				dto.setFilename(fName);
				dto.setFilesize(fSize);
			//새로운 첨부파일이 있을 때
			}else {				
			dto.setFilename(filename);
			dto.setFilesize(filesize);
			}
			
			//첨부파일 삭제 처리
			String fileDel=multi.getParameter("fileDel");
			//체크박스에 체크되어 있으면
			if(fileDel != null && fileDel.equals("on")) {
				String fileName=dao.getFileName(num);
				File f=new File(Constants.UPLOAD_PATH+fileName);
				f.delete();//파일 삭제
				dto.setFilename("-");
				dto.setFilesize(0);
			}
			//레코드 수정
			dao.update(dto);
			page=path+"/notice_servlet/list.do";
			response.sendRedirect(page);
			
		//공지사항 삭제
		}else if(uri.indexOf("delete.do") != -1) {
			MultipartRequest multi=new MultipartRequest(request, Constants.UPLOAD_PATH, 
					Constants.MAX_UPLOAD, "utf-8", new DefaultFileRenamePolicy());
			int num=Integer.parseInt(multi.getParameter("num"));
			dao.delete(num);
			page=path+"/notice_servlet/list.do";
			response.sendRedirect(page);
		
		//댓글 목록
		}else if(uri.indexOf("commentList.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			List<NoticeCommentDTO> list=dao.commentList(num);
			request.setAttribute("list", list);
			page="/notice/comment_list.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
			
		//댓글 등록
		}else if(uri.indexOf("comment_add.do") != -1) {
			int notice_num=Integer.parseInt(request.getParameter("notice_num"));
			String writer=request.getParameter("writer");
			String content=request.getParameter("content");
			NoticeCommentDTO dto=new NoticeCommentDTO();
			dto.setNotice_num(notice_num);
			dto.setWriter(writer);
			dto.setContent(content);
			dao.commentAdd(dto);		
			
		//첨부파일 다운로드
		}else if(uri.indexOf("download.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			String filename=dao.getFileName(num);
			
			String file_path=Constants.UPLOAD_PATH+filename;//업로드된 파일의 위치정보 값을 저장
			byte b[]=new byte[4096];//byte배열 생성
			FileInputStream fis=new FileInputStream(file_path);//업로드된 파일을 읽기 위한 스트림 생성
			String mimeType=getServletContext().getMimeType(file_path);
			
			if(mimeType==null) {
				mimeType="application/octet-stream;charset=utf-8";
			}
			//한글 파일명을 받기 위한 인코딩
			filename=new String(filename.getBytes("utf-8"), "8859_1");
			response.setHeader("Content-Disposition", "attachment;filename="+filename);
			
			//서버에서 클라이언트로 출력
			ServletOutputStream out=response.getOutputStream();
			int numRead;
			while(true) {
				numRead=fis.read(b,0,b.length);//데이터 읽음
				if(numRead == -1) break;//더 이상 내용이 없으면 빠져나감
				out.write(b, 0, numRead);//데이터 출력
			}
			out.flush();
			out.close();
			fis.close();

		//답글작성 창
		}else if(uri.indexOf("reply.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			NoticeDTO dto=dao.view(num);
			dto.setContent("\n-----Original Contents-----\n"+dto.getContent());
			request.setAttribute("dto", dto);
			page="/notice/reply.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);

		//답글 등록
		}else if(uri.indexOf("insertReply.do") != -1) {
			int num=Integer.parseInt(request.getParameter("num"));
			NoticeDTO dto=dao.view(num);
			int ref=dto.getRef(); //답변 그룹 번호
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
			//목록으로 이동
			page=path+"/notice_servlet/list.do";
			response.sendRedirect(page);
			
		//검색
		}else if(uri.indexOf("search.do") != -1) {
			String search_option=request.getParameter("search_option");
			String keyword=request.getParameter("keyword");
			List<NoticeDTO> list=dao.searchList(search_option, keyword);
			request.setAttribute("list", list);
			request.setAttribute("search_option", search_option);
			request.setAttribute("keyword", keyword);
			page="/notice/search.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		
		//최신 공지사항 목록
		}else if(uri.indexOf("newList.do") != -1) {
			List<NoticeDTO> list=dao.newListNotice();
			request.setAttribute("list", list);
			page="/notice/list_new.jsp";
			RequestDispatcher rd=request.getRequestDispatcher(page);
			rd.forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
