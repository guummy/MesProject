package com.itwillbs.domain;

import java.sql.Timestamp;

public class ConsumptionDTO {
	// 완제품 
	private String cproduct_cd_name;
	private String cproduct_name;
	
	// 원자재 배열 저장
	private String[] rproduct_cd_name_arr;
	private String[] rproduct_name_arr;
	private int[] consumption_arr;
	private String[] consumption_unit_arr;
	
	// 원자재 단일 저장
	private String rproduct_cd_name;
	private String rproduct_name;
	private int consumption;
	private String consumption_unit;
	
	// 날짜
	private Timestamp insert_date;
	private Timestamp update_date;
	
	
	public String getCproduct_cd_name() {
		return cproduct_cd_name;
	}
	public void setCproduct_cd_name(String cproduct_cd_name) {
		this.cproduct_cd_name = cproduct_cd_name;
	}
	public String getCproduct_name() {
		return cproduct_name;
	}
	public void setCproduct_name(String cproduct_name) {
		this.cproduct_name = cproduct_name;
	}
	public String[] getRproduct_cd_name_arr() {
		return rproduct_cd_name_arr;
	}
	public void setRproduct_cd_name_arr(String[] rproduct_cd_name_arr) {
		this.rproduct_cd_name_arr = rproduct_cd_name_arr;
	}
	public String[] getRproduct_name_arr() {
		return rproduct_name_arr;
	}
	public void setRproduct_name_arr(String[] rproduct_name_arr) {
		this.rproduct_name_arr = rproduct_name_arr;
	}
	public int[] getConsumption_arr() {
		return consumption_arr; 
	} 
	public void setConsumption_arr(int[] consumption_arr) { 
		this.consumption_arr = consumption_arr; 
	}
	public String[] getConsumption_unit_arr() {
		return consumption_unit_arr;
	}
	public void setConsumption_unit_arr(String[] consumption_unit_arr) {
		this.consumption_unit_arr = consumption_unit_arr;
	}
	public String getRproduct_cd_name() {
		return rproduct_cd_name;
	}
	public void setRproduct_cd_name(String rproduct_cd_name) {
		this.rproduct_cd_name = rproduct_cd_name;
	}
	public String getRproduct_name() {
		return rproduct_name;
	}
	public void setRproduct_name(String rproduct_name) {
		this.rproduct_name = rproduct_name;
	}
	public int getConsumption() {
		return consumption;
	}
	public void setConsumption(int consumption) {
		this.consumption = consumption;
	}
	public String getConsumption_unit() {
		return consumption_unit;
	}
	public void setConsumption_unit(String consumption_unit) {
		this.consumption_unit = consumption_unit;
	}
	public Timestamp getInsert_date() {
		return insert_date;
	}
	public void setInsert_date(Timestamp insert_date) {
		this.insert_date = insert_date;
	}
	public Timestamp getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Timestamp update_date) {
		this.update_date = update_date;
	}
	

	
	
	
}// class
