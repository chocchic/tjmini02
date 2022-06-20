package com.mydiary.persistence;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;

import com.mydiary.model.Diary;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class QuerydslRepositoryImpl extends QuerydslRepositorySupport implements SearchBoardRepository {

	public QuerydslRepositoryImpl() {
		super(Diary.class);
		// TODO Auto-generated constructor stub
	}

	@Override
	public Diary search() {
		log.info("search...");
		
		// 결과를 Tuple로 받기
		QDiary diary = QDiary.diary;
		
		JPQLQuery<Diary> jpqlquery = from(diary);
		
		JPQLQuery<Tuple> tuple = jpqlquery.select(board, member.email,reply.count());
		tuple.groupBy(board);
		
		// 결과 가져오기
		List<Tuple> result = tuple.fetch();
		
		System.out.println(result);
		
		return null;
	}

	@Override
	public Page<Object[]> searchPage(String type, String keyword, Pageable pageable) {
		QBoard board = QBoard.board;
		QReply reply = QReply.reply;
		QMember member = QMember.member;
		
		JPQLQuery<Board> jpqlquery = from(board);
		jpqlquery.leftJoin(member).on(board.member.eq(member)); 
		jpqlquery.leftJoin(reply).on(reply.board.eq(board));
		
		// 검색 결과를 만들어주는 부분
		JPQLQuery<Tuple> tuple = jpqlquery.select(board, member,reply.count());

		// 동적인ㅇ 쿼리 수행을 위한 객체 생성
		BooleanBuilder booleanBuilder = new BooleanBuilder();
		// bno가 0보다 큰 데이터를 추출
		BooleanExpression expression = board.bno.gt(0L);
		
		// type이 검색 항목
		if(type !=null) {
			String[] typeArr = type.split("");
			BooleanBuilder conditionBuilder = new BooleanBuilder();
			for(String t : typeArr) {
				switch(t) {
					case "t":
						conditionBuilder.or(board.title.contains(keyword));
						break;
					case "c":
						conditionBuilder.or(board.content.contains(keyword));
						break;
					case "w":
						conditionBuilder.or(board.member.name.contains(keyword));
						break;
				}
			}
			booleanBuilder.and(conditionBuilder);
		}
		// 조건 적용
		tuple.where(booleanBuilder);
		
		// 데이터 정렬 - 하나의 조건으로만 정렬
		// tuple.orderBy(board.bno.desc());
		// 정렬 조건 가져오기
		Sort sort = pageable.getSort();
		sort.stream().forEach(order ->{
			Order direction = order.isAscending()?Order.ASC:Order.DESC;
			String prop = order.getProperty();
			
			PathBuilder orderByExpression = new PathBuilder(Board.class, "board");
			tuple.orderBy(new OrderSpecifier(direction, orderByExpression.get(prop)));
		});
		
		// 그룹화
		tuple.groupBy(board);
		
		// 페이징 처리
		tuple.offset(pageable.getOffset());
		tuple.limit(pageable.getPageSize());
		
		// 결과를 가져오기
		List<Tuple> result = tuple.fetch();
		
		// 결과를 리턴
		return new PageImpl<Object[]>(result.stream().map(t->t.toArray()).collect(Collectors.toList()), pageable, tuple.fetchCount());
	}

}