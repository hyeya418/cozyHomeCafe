package member.dto;

import java.sql.Date;

public class MemberDTO {
	private String userid;
	private String pw1;
	private String name; 
	private String tel;
	private String email;
	private Date join_date;
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPw1() {
		return pw1;
	}
	public void setPw1(String pw1) {
		this.pw1 = pw1;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}

	@Override
	public String toString() {
		return "MemberDTO [userid=" + userid + ", pw1=" + pw1 + ", name=" + name + ", tel=" + tel + ", email=" + email
				+ ", join_date=" + join_date + "]";
	}
	public MemberDTO() {
	}
	public MemberDTO(String userid, String pw1, String name, String tel, String email,Date join_date) {
		super();
		this.userid = userid;
		this.pw1 = pw1;
		this.name = name;
		this.tel = tel;
		this.email = email;
		this.join_date = join_date;
	}
}
