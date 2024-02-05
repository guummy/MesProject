package com.itwillbs.domain;

public class SystemDTO {
	
	
	private int emp_no;
	private String emp_name;
	private String emp_pass;
	private String dept_cd;
	private String grade_cd;
	private String emp_priv;

	
	public int getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(int emp_no) {
		this.emp_no = emp_no;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_pass() {
		return emp_pass;
	}
	public void setEmp_pass(String emp_pass) {
		this.emp_pass = emp_pass;
	}

	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getGrade_cd() {
		return grade_cd;
	}
	public void setGrade_cd(String grade_cd) {
		this.grade_cd = grade_cd;
	}
	public String getEmp_priv() {
		return emp_priv;
	}
	public void setEmp_priv(String emp_priv) {
		this.emp_priv = emp_priv;
	}

	

}
