package com.itwillbs.dao;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.DeliverDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ReleaseDTO;

public interface DeliverDAO {
	
	//추상메소드
		public void insertDeliver(DeliverDTO deliverDTO);
		
		
		public List<DeliverDTO> getDeliverList(PageDTO pageDTO);
		
		public DeliverDTO getDeliver(DeliverDTO deliverDTO);
		
		public void updateDeliver(DeliverDTO deliverDTO);
		
		public int getDeliverCount(PageDTO pageDTO);
		
		
		public void deleteDeliver(String deliver_cd);
		
		
		public List<Map<String, Object>> getInstMap();
		
		
		public List<Map<String, Object>> getInstMap2();
		
		
		public List<Map<String, Object>> getInstMap3();


		public String getDeliver_cd();


		public List<Map<String, Object>> getRelList2(PageDTO pageDTO);


		public int getRelCount(PageDTO pageDTO);

		
		public int getinstcheck(String order_cd);


		public ReleaseDTO getreldat(String order_cd);





}
