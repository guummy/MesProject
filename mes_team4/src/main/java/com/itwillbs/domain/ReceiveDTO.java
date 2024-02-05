package com.itwillbs.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class ReceiveDTO {
	private String rec_schedule_cd;
	private Date rec_date;
	private String remarks;
	private int rec_count;
	private String pchor_cd;
	private String wh_cd;
	private String product_cd_name;
	
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
	public String getRec_schedule_cd() {
		return rec_schedule_cd;
	}
	public void setRec_schedule_cd(String rec_schedule_cd) {
		this.rec_schedule_cd = rec_schedule_cd;
	}

	public Date getRec_date() {
		return rec_date;
	}
	public void setRec_date(Date rec_date) {
		this.rec_date = rec_date;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getRec_count() {
		return rec_count;
	}
	public void setRec_count(int rec_count) {
		this.rec_count = rec_count;
	}
	

}
