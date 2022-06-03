package com.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.mapper.SchedulerMapper;

@Service("SchedulerService")
public class SchedulerServiceImpl implements SchedulerService{

	@Autowired
	SchedulerMapper s;
	
	@Autowired
	KakaoPayService service;
	int n = 0;
	int n2= 0;
	@Override
	public void SetSale() {
		// 마감기한이 오늘로 부터 3일 이하인 상품 pnum 저장
		List<Long> pnumList = s.getneedSale();
		System.out.println("setSale 발동 : " + pnumList);
		System.out.println(n++ +"번 실행");
		// pnumlist에 포함된 상품만 update 
		for(Long pnum : pnumList) {
			s.updateSale(pnum);
		}
		
	}

	@Override
	public void DoSubPay() {
		// 구독이 일어나야 할 sid에 대해서 모음
		List<String> sidList  = s.getneedSub();
		System.out.println("do sub pay 발동 : " + sidList);
		System.out.println(n2++ +"번 실행");
		// sidList에 포함된 경우만 kakaoSub
		
		for(String sid : sidList) {
			service.kakaoPaySub(sid);
		}
		
		
	}

	@Override
	public void DoSubAlarm() {
		// admin쪽에서 결제일 1일 전임을 알람 자동 날리기
		// 사용자에게 insert
		
	}

}
