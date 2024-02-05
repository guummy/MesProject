package com.itwillbs.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.OrderDAO;
import com.itwillbs.domain.OrderDTO;
import com.itwillbs.domain.PageDTO;

@Service
public class OrderServiceImpl implements OrderService{

	@Inject
	private OrderDAO orderDAO;
	
	@Override
	public void insertOrder(OrderDTO orderDTO) {
		System.out.println("OrderServiceImpl insertORder()");
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
		String today = now.format(formatter);
		
		System.out.println("오늘날짜:"+today);
		
		if(orderDAO.getMaxNum(today)==null) {
			
			orderDTO.setOrder_cd("OR"+today+"01");
		}else {
			
			int num = orderDAO.getMaxNum(today)+1;
			String new_num = String.valueOf(num).format("%02d", num);
			String str = "OR" + today + new_num;
			orderDTO.setOrder_cd(str);
		}
		orderDAO.insertOrder(orderDTO);
	}

	@Override
	public List<OrderDTO> getOrderList(PageDTO pageDTO) {
		System.out.println("OrderServiceImpl getOrderList()");
		//시작하는 행번호 구하기
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow = startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
				
		return orderDAO.getOrderList(pageDTO);
	}

	@Override
	public int getOrderCount() {
		System.out.println("OrderServiceImpl getOrderCount()");
		
		return orderDAO.getOrderCount();
	}

	@Override
	public void deleteOrder(String cd) {
		System.out.println("OrderServiceImpl deleteOrder()");
		
		orderDAO.deteleOrder(cd);
		
	}

	@Override
	public OrderDTO getOrder(String cd) {
		System.out.println("OrderServiceImpl getOrder()");
		return orderDAO.getOrder(cd);
	}

	@Override
	public void updateOrder(OrderDTO orderDTO) {
		System.out.println("OrderServiceImpl updateOrder()");	
		orderDAO.updateOrder(orderDTO);
	}

	@Override
	public int getPCount() {
		System.out.println("OrderServiceImpl getPCount()");
		return orderDAO.getPCount();
	}

	@Override
	public int getFCount() {
		System.out.println("OrderServiceImpl getFCount()");
		return orderDAO.getFCount();
	}

	@Override
	public int getPCount(PageDTO pageDTO) {
		System.out.println("orderService search있는 p갯수구함");
		return orderDAO.getPCount(pageDTO);
	}

	@Override
	public int getFCount(PageDTO pageDTO) {
		System.out.println("orderService search있는 f갯수구함");
		return orderDAO.getFCount(pageDTO);
	}

	@Override
	public String getProduct_cd_name(String order_cd) {
		System.out.println("OrderServiceImpl getProduct_cd_name()");
		
		return orderDAO.getProduct_cd_name(order_cd);
	}

	@Override
	public int getSumRelCount(String order_cd) {
		System.out.println("OrderServiceImpl getSumRelCount()");
		
		return orderDAO.getSumRelCount(order_cd);
	}

	@Override
	public int getbfOr_count(String order_cd) {
		System.out.println("OrderServiceImpl getbfOr_count()");
		
		return orderDAO.getbfOr_count(order_cd);
	}

	@Override
	public void updateCon(String cd) {
		System.out.println("OrderServiceImpl updateCon()");	
	
		orderDAO.updateCon(cd);
		
		
	}

	@Override
	public int getICount() {
		System.out.println("OrderServiceImpl getICount()");
		return orderDAO.getICount();
	}

	@Override
	public int getWCount() {
		System.out.println("OrderServiceImpl getWCount()");
		return orderDAO.getWCount();
	}

	@Override
	public int getICount(PageDTO pageDTO) {
		System.out.println("orderService search있는 i갯수구함");
		return orderDAO.getICount(pageDTO);
	}

	@Override
	public int getWCount(PageDTO pageDTO) {
		System.out.println("orderService search있는 w갯수구함");
		return orderDAO.getWCount(pageDTO);
	}

	@Override
	public List<OrderDTO> getOrderList2(PageDTO pageDTO) {
		System.out.println("OrderServiceImpl getOrderList2()");
		//시작하는 행번호 구하기
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1;
		int endRow = startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow);
		pageDTO.setEndRow(endRow);
				
		return orderDAO.getOrderList2(pageDTO);
	}

	@Override
	public int getOrderCount2() {
		System.out.println("OrderServiceImpl getOrderCount2()");
		
		return orderDAO.getOrderCount2();
	}



}
