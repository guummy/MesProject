package com.itwillbs.domain;

import java.sql.Date;

public class ReleaseDTO {
	// 출고코드, 출고일자, 적요, 진행상태, 출고수량
	private String rel_schedule_cd;
	private Date rel_date;
	private String remarks;
	private int rel_count;
	
	private String wh_cd;
	private String product_cd_name;
	private String pchor_cd;
	private String rec_schedule_cd;
	private String released;
	
	public String getReleased() {
		return released;
	}
	public void setReleased(String released) {
		this.released = released;
	}
	public String getRec_schedule_cd() {
		return rec_schedule_cd;
	}
	public void setRec_schedule_cd(String rec_schedule_cd) {
		this.rec_schedule_cd = rec_schedule_cd;
	}
	public String getWh_cd() {
		return wh_cd;
	}
	public void setWh_cd(String wh_cd) {
		this.wh_cd = wh_cd;
	}
	
	
	public String getProduct_cd_name() {
		return product_cd_name;
	}
	public void setProduct_cd_name(String product_cd_name) {
		this.product_cd_name = product_cd_name;
	}
	public String getPchor_cd() {
		return pchor_cd;
	}
	public void setPchor_cd(String pchor_cd) {
		this.pchor_cd = pchor_cd;
	}
	public String getRel_schedule_cd() {
		return rel_schedule_cd;
	}
	public void setRel_schedule_cd(String rel_schedule_cd) {
		this.rel_schedule_cd = rel_schedule_cd;
	}
	public Date getRel_date() {
		return rel_date;
	}
	public void setRel_date(Date rel_date) {
		this.rel_date = rel_date;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getRel_count() {
		return rel_count;
	}
	public void setRel_count(int rel_count) {
		this.rel_count = rel_count;
	}
	

}
	
	