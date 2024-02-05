package com.itwillbs.domain;

public class InstructionDTO {

	private String order_cd;  // 수주코드
	private String product_cd_name;   // 품목코드
	private int instruction_qt;  // 지시수량
	private String rpname1; // 원재료1 이름
	private int consumption1; // 원재료1 소요량
	private String rpname2; // 원재료 2 이름
	private int consumption2; // 원재료2 소요량
	private String line_cd;  // 라인코드
	private String instruction_date;  // 작업지시일자
	private String instruction_state;  // 작업지시상태
	private String instruction_code;  // 작업지시코드
	
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}

	public int getInstruction_qt() {
		return instruction_qt;
	}
	public void setInstruction_qt(int instruction_qt) {
		this.instruction_qt = instruction_qt;
	}
	public String getRpname1() {
		return rpname1;
	}
	public void setRpname1(String rpname1) {
		this.rpname1 = rpname1;
	}
	public int getConsumption1() {
		return consumption1;
	}
	public void setConsumption1(int consumption1) {
		this.consumption1 = consumption1;
	}
	public String getRpname2() {
		return rpname2;
	}
	public void setRpname2(String rpname2) {
		this.rpname2 = rpname2;
	}
	public int getConsumption2() {
		return consumption2;
	}
	public void setConsumption2(int consumption2) {
		this.consumption2 = consumption2;
	}
	public String getLine_cd() {
		return line_cd;
	}
	public void setLine_cd(String line_cd) {
		this.line_cd = line_cd;
	}
	public String getInstruction_date() {
		return instruction_date;
	}
	public void setInstruction_date(String instruction_date) {
		this.instruction_date = instruction_date;
	}
	public String getInstruction_state() {
		return instruction_state;
	}
	public void setInstruction_state(String instruction_state) {
		this.instruction_state = instruction_state;
	}
	public String getInstruction_code() {
		return instruction_code;
	}
	public void setInstruction_code(String instruction_code) {
		this.instruction_code = instruction_code;
	}
	public String getProduct_cd_name() {
		return product_cd_name;
	}
	public void setProduct_cd_name(String product_cd_name) {
		this.product_cd_name = product_cd_name;
	}
	

	
	
}
