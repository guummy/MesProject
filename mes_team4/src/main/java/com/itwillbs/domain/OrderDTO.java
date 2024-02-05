package com.itwillbs.domain;

public class OrderDTO {
	
	private String order_cd;
	private String order_date;
	private String deliver_date;
	private int order_count;
	private String con;
	
	private String business_cd;
	private int emp_no;
	private String product_cd_name;

	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getDeliver_date() {
		return deliver_date;
	}
	public void setDeliver_date(String deliver_date) {
		this.deliver_date = deliver_date;
	}
	public int getOrder_count() {
		return order_count;
	}
	public void setOrder_count(int order_count) {
		this.order_count = order_count;
	}
	public String getCon() {
		return con;
	}
	public void setCon(String con) {
		this.con = con;
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
	public String getProduct_cd_name() {
		return product_cd_name;
	}
	public void setProduct_cd_name(String product_cd_name) {
		this.product_cd_name = product_cd_name;
	}


	
}
