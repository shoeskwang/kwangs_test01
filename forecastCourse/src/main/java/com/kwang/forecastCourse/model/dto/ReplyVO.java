package com.kwang.forecastCourse.model.dto;

import java.util.Date;

public class ReplyVO {
	private Integer grno;        // 댓글 번호
    private Integer gno;        // 코스 번호
    private String replytext;    // 댓글 내용
    private String replyer;        // 댓글 작성자
    private Date regdate;        // 댓글 작성일자
    private String writer;		// +코스 작성자 추가
	public Integer getGrno() {
		return grno;
	}
	public void setGrno(Integer grno) {
		this.grno = grno;
	}
	public Integer getGno() {
		return gno;
	}
	public void setGno(Integer gno) {
		this.gno = gno;
	}
	public String getReplytext() {
		return replytext;
	}
	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [grno=" + grno + ", gno=" + gno + ", replytext=" + replytext + ", replyer=" + replyer
				+ ", regdate=" + regdate + ", writer=" + writer + "]";
	}
    
    
}
