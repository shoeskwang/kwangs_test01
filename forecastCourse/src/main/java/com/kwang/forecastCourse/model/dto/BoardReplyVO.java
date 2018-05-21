package com.kwang.forecastCourse.model.dto;

import java.util.Date;

public class BoardReplyVO {
	private Integer rno;        // 댓글 번호
    private Integer bno;        // 게시글 번호
    private String replytext;    // 댓글 내용
    private String replyer;        // 댓글 작성자
    private Date regdate;        // 댓글 작성일자
    private String writer;		// +게시글의 작성자 추가
	public Integer getRno() {
		return rno;
	}
	public void setRno(Integer rno) {
		this.rno = rno;
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
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
		return "BoardReplyVO [rno=" + rno + ", bno=" + bno + ", replytext=" + replytext + ", replyer=" + replyer
				+ ", regdate=" + regdate + ", writer=" + writer + "]";
	}
    
    
}
