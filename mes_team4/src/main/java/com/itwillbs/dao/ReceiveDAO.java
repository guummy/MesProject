package com.itwillbs.dao;

import java.util.List;

import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.PerformDTO;
import com.itwillbs.domain.PurchaseDTO;
import com.itwillbs.domain.ReceiveDTO;
import com.itwillbs.domain.StockDTO;

public interface ReceiveDAO {

	public void insertReceive(ReceiveDTO receiveDTO);

	public List<ReceiveDTO> getReciveList(PageDTO pageDTO);
	
	public ReceiveDTO getPch_cd(String pch);

	public int getReceiveCount(PageDTO pageDTO);

	public Integer getRECNum(String today);

	public ReceiveDTO getReceive(String rec_schedule_cd);

	public void updateReceive(ReceiveDTO receiveDTO);

	public void deleteReceive(String rec_schedule_cd);

	public void updateStockcount(StockDTO stockDTO);

	public int getStock_count(String product_cd_name);

	public ReceiveDTO getbfRec_count(ReceiveDTO eceiveDTO);

	public String getProduct_cd_name2(String rec_schedule_cd);

	public String getPchor_cd(String rec_schedule_cd);

	public int getSumRelCount(String pchor_cd);

	public int getRel_count(String pchor_cd);

	public int getpurcheck(String purchase_cd);

	public int getperformcheck(String order_cd);

	public String dvcheck(String product_cd_name);

	public PerformDTO getPerform_date(String inst);

	public String getInst(String pchor_cd);

	public PurchaseDTO getPurchase_date(String pchor_cd);

}
