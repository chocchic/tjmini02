package com.shop.mapper;

import java.util.List;

public interface SchedulerMapper {
	// `		SchedulerMapper
	public List<Long> getneedSale();
	
	public void updateSale(Long pnum);

	public List<String> getneedSub();
	
}
