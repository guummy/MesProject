package com.itwillbs.domain;

import java.sql.Date;

public class PurchaseDTO {
	private String purchase_cd;
	private String business_cd;
	private int emp_no;
	private String rproduct_cd_name;
	
	private String purchase_date_st;
	private String purchase_due_st;
	private Date purchase_date;
	private Date purchase_due;
	
	private int purchase_count;
	private String purchase_com;
	
	public String getPurchase_date_st() {
		return purchase_date_st;
	}
	public void setPurchase_date_st(String purchase_date_st) {
		this.purchase_date_st = purchase_date_st;
	}
	public String getPurchase_due_st() {
		return purchase_due_st;
	}
	public void setPurchase_due_st(String purchase_due_st) {
		this.purchase_due_st = purchase_due_st;
	}
	public String getPurchase_cd() {
		return purchase_cd;
	}
	public void setPurchase_cd(String purchase_cd) {
		this.purchase_cd = purchase_cd;
	}
	public String getBusiness_cd() {
		return business_cd;
	}
	public void setBusiness_cd(String business_cd) {
		this.business_cd = business_cd;
	}
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public String getRproduct_cd_name() {
		return rproduct_cd_name;
	}
	public void setRproduct_cd_name(String rproduct_cd_name) {
		this.rproduct_cd_name = rproduct_cd_name;
	}
	public Date getPurchase_date() {
		return purchase_date;
	}
	public void setPurchase_date(Date purchase_date) {
		this.purchase_date = purchase_date;
	}
	public Date getPurchase_due() {
		return purchase_due;
	}
	public void setPurchase_due(Date purchase_due) {
		this.purchase_due = purchase_due;
	}
	public int getPurchase_count() {
		return purchase_count;
	}
	public void setPurchase_count(int purchase_count) {
		this.purchase_count = purchase_count;
	}
	public String getPurchase_com() {
		return purchase_com;
	}
	public void setPurchase_com(String purchase_com) {
		this.purchase_com = purchase_com;
	}
	
	

	
}// class
