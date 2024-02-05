package com.itwillbs.domain;

public class ProductDTO {
//	품목코드, 품목타입코드, 품목명, 제품코드, 제품구분, 거래처코드, 규격, 단위, 적요
	private String product_cd;
	private int product_type_cd;
	private String product_dv;
	private String product_name;
	private String product_cd_name;
	private String business_cd;
	private String product_size;
	private String product_unit;
	private String remarks;
	
	public String getProduct_cd() {
		return product_cd;
	}
	public void setProduct_cd(String product_cd) {
		this.product_cd = product_cd;
	}
	public int getProduct_type_cd() {
		return product_type_cd;
	}
	public void setProduct_type_cd(int product_type_cd) {
		this.product_type_cd = product_type_cd;
	}
	public String getProduct_dv() {
		return product_dv;
	}
	public void setProduct_dv(String product_dv) {
		this.product_dv = product_dv;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_cd_name() {
		return product_cd_name;
	}
	public void setProduct_cd_name(String product_cd_name) {
		this.product_cd_name = product_cd_name;
	}
	public String getBusiness_cd() {
		return business_cd;
	}
	public void setBusiness_cd(String business_cd) {
		this.business_cd = business_cd;
	}
	public String getProduct_size() {
		return product_size;
	}
	public void setProduct_size(String product_size) {
		this.product_size = product_size;
	}
	public String getProduct_unit() {
		return product_unit;
	}
	public void setProduct_unit(String product_unit) {
		this.product_unit = product_unit;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}
