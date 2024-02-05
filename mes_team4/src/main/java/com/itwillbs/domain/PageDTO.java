package com.itwillbs.domain;

import java.util.List;

public class PageDTO {
	// DB 쿼리문 입력 멤버변수
	private int pageSize; // 화면에 보여줄 글의 개수
	private int startRow; // 테이블에서 가져올 시작 글번호
	private int endRow; // 끝 글번호
	private String search; // 페이지 검색어
	private String search_option; // 검색어 옵션
	private String search_com; // 완료 구분
	private String select; // 검색어 옵션
	private String product_dv; // 품목 구분
	private String start_date; // 시작일
	private String end_date; // 마감일
	private String start_due_date; // 시작일
	private String end_due_date; // 마감일
	
	// 테이블 병합처리 멤버변수
	private List<Integer> rowcolsTd; // td의 rowcols 수 
	private List<Integer> showTd; // td를 나타낼 위치
	
	// 페이징처리 계산 멤버변수
	private String pageNum; // 현재 화면의 페이지번호 String
	private int CurrentPage; // 현재 화면의 페이지번호 int(형변환)
	private int pageBlock; // 한 화면에 나타낼 페이징 개수
	private int pageCount; // 글 개수에 따른 총 페이징 개수
	private int startPage; // 페이징 시작 번호
	private int endPage; // 페이징 끝 번호
	private int count; // 게시판의 모든 행 개수
	
	// 생산상태 카운트 멤버변수 
	private int pcount; // 생산전 개수
	private int wcount; // 생산대기 개수
	private int icount; // 생산중 개수
	private int fcount; // 생산완료 개수
	private String cd;
	
	public int getWcount() {
		return wcount;
	}
	public void setWcount(int wcount) {
		this.wcount = wcount;
	}
	public int getIcount() {
		return icount;
	}
	public void setIcount(int icount) {
		this.icount = icount;
	}
	
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getSearch_com() {
		return search_com;
	}
	public void setSearch_com(String search_com) {
		this.search_com = search_com;
	}
	public String getStart_due_date() {
		return start_due_date;
	}
	public void setStart_due_date(String start_due_date) {
		this.start_due_date = start_due_date;
	}
	public String getEnd_due_date() {
		return end_due_date;
	}
	public void setEnd_due_date(String end_due_date) {
		this.end_due_date = end_due_date;
	}
	public String getSearch_option() {
		return search_option;
	}
	public void setSearch_option(String search_option) {
		this.search_option = search_option;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public int getFcount() {
		return fcount;
	}
	public void setFcount(int fcount) {
		this.fcount = fcount;
	}		
	public List<Integer> getRowcolsTd() {
		return rowcolsTd;
	}
	public void setRowcolsTd(List<Integer> rowcolsTd) {
		this.rowcolsTd = rowcolsTd;
	}
	public List<Integer> getShowTd() {
		return showTd;
	}
	public void setShowTd(List<Integer> showTd) {
		this.showTd = showTd;
	}
	public String getProduct_dv() {
		return product_dv;
	}
	public void setProduct_dv(String product_dv) {
		this.product_dv = product_dv;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getPageNum() {
		return pageNum;
	}
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}
	public int getCurrentPage() {
		return CurrentPage;
	}
	public void setCurrentPage(int currentPage) {
		CurrentPage = currentPage;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public int getPageBlock() {
		return pageBlock;
	}
	public void setPageBlock(int pageBlock) {
		this.pageBlock = pageBlock;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public String getSelect() {
		return select;
	}
	public void setSelect(String select) {
		this.select = select;
	}

}//class
