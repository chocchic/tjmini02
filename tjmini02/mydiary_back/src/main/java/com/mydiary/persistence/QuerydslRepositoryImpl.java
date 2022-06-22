package com.mydiary.persistence;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;

import com.mydiary.model.Diary;
import com.mydiary.model.QDiary;
import com.mydiary.model.QMember;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.JPQLQuery;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class QuerydslRepositoryImpl extends QuerydslRepositorySupport implements QuerydslRepository {

	public QuerydslRepositoryImpl() {
		super(Diary.class);
	}

	@Override
	public Diary search() {
		log.info("search...");
		
		// 결과를 Tuple로 받기
		QDiary diary = QDiary.diary;
		QMember member = QMember.member;
		
		JPQLQuery<Diary> jpqlquery = from(diary);
		jpqlquery.leftJoin(member).on(diary.member.eq(member));
		JPQLQuery<Tuple> tuple = jpqlquery. select(diary, member.nickname);
		tuple.groupBy(diary);
		
		// 결과 가져오기
		List<Tuple> result = tuple.fetch();
		
		System.out.println(result);

		return null;
	}

	@Override
	public Page<Object[]> searchPage(String type, String keyword, Pageable pageable) {
		
		QDiary diary = QDiary.diary;
		QMember member = QMember.member;
		
		JPQLQuery<Diary> jpqlquery = from(diary);
		jpqlquery.leftJoin(member).on(diary.member.mno.eq(member.mno));
		
		// 검색 결과를 만들어주는 부분
		JPQLQuery<Tuple> tuple = jpqlquery.select(diary, member.nickname);

		// 동적인ㅇ 쿼리 수행을 위한 객체 생성
		BooleanBuilder booleanBuilder = new BooleanBuilder();
		// bno가 0보다 큰 데이터를 추출
		BooleanExpression expression = diary.dno.gt(0L);
		
		// type이 검색 항목
		if(type !=null) {
			String[] typeArr = type.split("");
			BooleanBuilder conditionBuilder = new BooleanBuilder();
			for(String t : typeArr) {
				switch(t) {
					case "t":
						conditionBuilder.or(diary.title.contains(keyword));
						break;
					case "c":
						conditionBuilder.or(diary.content.contains(keyword));
						break;
					case "w":
						conditionBuilder.or(diary.member.nickname.contains(keyword));
						break;
					case "n":
						conditionBuilder.or(diary.weather.contains(keyword));
						break;
				}
			}
			booleanBuilder.and(conditionBuilder);
		}
		// 조건 적용
		tuple.where(booleanBuilder);
		
		// 데이터 정렬 - 하나의 조건으로만 정렬
		// tuple.orderBy(diary.dno.desc());
		// 정렬 조건 가져오기
		Sort sort = pageable.getSort();
		sort.stream().forEach(order ->{
			Order direction = order.isAscending()?Order.ASC:Order.DESC;
			String prop = order.getProperty();
			
			PathBuilder orderByExpression = new PathBuilder(Diary.class, "diary");
			tuple.orderBy(new OrderSpecifier(direction, orderByExpression.get(prop)));
		});
		
		// 그룹화
		tuple.groupBy(diary);
		
		// 페이징 처리
		tuple.offset(pageable.getOffset());
		tuple.limit(pageable.getPageSize());
		
		// 결과를 가져오기
		List<Tuple> result = tuple.fetch();
		
		// 결과를 리턴
		return new PageImpl<Object[]>(result.stream().map(t->t.toArray()).collect(Collectors.toList()), pageable, tuple.fetchCount());
	}

}