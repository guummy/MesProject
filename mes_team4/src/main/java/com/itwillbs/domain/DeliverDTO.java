package com.itwillbs.domain;

import java.sql.Date;

import com.google.protobuf.Timestamp;

public class DeliverDTO {
	private String deliver_cd;  //출하코드
	private String business_cd; //거래처코드
	private String order_cd;	//수주코드
	private String product_cd_name;  //품목코드
	private Date deliver_date; //출하일자
	private int deliver_count;     //출하량
	private int emp_no;   //출하담당자갖고오는것?
	
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public String getDeliver_cd() {
		return deliver_cd;
	}
	public void setDeliver_cd(String deliver_cd) {
		this.deliver_cd = deliver_cd;
	}
	public String getBusiness_cd() {
		return business_cd;
	}
	public void setBusiness_cd(String business_cd) {
		this.business_cd = business_cd;
	}
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public String getProduct_cd_name() {
		return product_cd_name;
	}
	public void setProduct_cd_name(String product_cd_name) {
		this.product_cd_name = product_cd_name;
	}

	public Date getDeliver_date() {
		return deliver_date;
	}
	public void setDeliver_date(Date deliver_date) {
		this.deliver_date = deliver_date;
	}
	public int getDeliver_count() {
		return deliver_count;
	}
	public void setDeliver_count(int deliver_count) {
		this.deliver_count = deliver_count;
	}
	
	
	
	


}
