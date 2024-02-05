package com.itwillbs.domain;

public class LineDTO {
	//생산설비
	private String line_cd;
	private String line_name;
	private String line_process;
	private String line_status;
	private String remarks;
	
	
	public String getLine_cd() {
		return line_cd;
	}
	public void setLine_cd(String line_cd) {
		this.line_cd = line_cd;
	}
	public String getLine_name() {
		return line_name;
	}
	public void setLine_name(String line_name) {
		this.line_name = line_name;
	}
	public String getLine_process() {
		return line_process;
	}
	public void setLine_process(String line_process) {
		this.line_process = line_process;
	}
	public String getLine_status() {
		return line_status;
	}
	public void setLine_status(String line_status) {
		this.line_status = line_status;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}
