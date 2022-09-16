package notice.dto;

import java.util.Date;

public class NoticeCommentDTO {
	private int comment_num; //댓글 일련번호
	private int notice_num; //게시물 번호
	private String writer;
	private String content;
	private Date reg_date;
	//getter, setter, toString()
	public int getComment_num() {
		return comment_num;
	}
	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "NoticeCommentDTO [comment_num=" + comment_num + ", notice_num=" + notice_num + ", writer=" + writer
				+ ", content=" + content + ", reg_date=" + reg_date + "]";
	}
}
