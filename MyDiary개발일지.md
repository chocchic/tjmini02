# MyDiary 개발일지
0602 ~ 0612 : 주제 구상, 개발 범위 및 필수 기능 설정  
0613 : 프로젝트 생성 및 Security관련 설정, 테이블 구상  
0614 : 테이블 구상  
0615 : 테이블 구상, 자료로 정리  
0616 : 테이블 create, 백엔드 기본 설정(model, dto, repo ... )  
0617 : 테이블 create, 백엔드 기본 설정(model, dto, repo ... )  
0618 : 푹 쉬었다  
0619 : react 템플릿 설정, 기본 설정(next.js)  
0620 : react 포기하기로 마음먹고 타임리프로 다시 만드는 중. 검색용 쿼리방식 고민 중  
0621 : 쿼리 dsl 사용 -> application.properties에 속성 추가하고, gradle에 추가
    service에 메서드가 하나도 없이 bean으로 등록되려고 하면 오류 나므로 @Autowired나 @R~로 되어 자동으로 주입되는 경우 다 주석해서 에러 막기
    gradle execution으로 build 했을 때 과정 중 오류가 나면 최 하단까지 내려가서 show failures하면 오류 목록이 다보이니까 그거 보고 고치기  
    고치고 빌드했더니 db에 이상하게 반영되서 다시 해서 db에 올림 : 왜 계속 diary 테이블에 두 boolean타입만 can_reply이런식으로 만들어지는지 모르겠어서 @Column해서 바꿔봄 -> Model db형이 맞지 않아서 생기는 것였음. boolean이 없으므로 varchar나 integer로 알아서 바꾸기  

    생각해보니까 thymeleaf를 dependecy로 추가 안해서 프로젝트 우클 > 스프링 > 스프링 스타터 ~ 로 하면 바로 추가 가능하다  
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'

    만들어놓았던 화면에 데이터를 뿌리려고 보니 null값 나와서 알 수 없으므로 testcase클래스에 테스트용 데이터 넣음  

    내일 할일  
    1. 테스트 케이스로 들어간 일기 날짜를 수정해주기  
    2. Home의 pagenation 사라진거 복구  
    3. register form 양식을 수정  
        1) 날짜/ 작성자 정보 보이기, 제목/날씨/내용/사진 등록 가능하도록, 날씨는 되도록 버튼이나 셀렉트박스를 통해  
        2) 회원 정보로 추천 질문  
        3) 10개 이상의 일기는 등록하지 못한다고 알림  

0622 : 
    basic.html 로고 깨진거 수정  
    querydsl을 이용한 type/keyword가 있는 검색 테스트 완료 -> 왜 뷰에는 안뜰까 -> 성공  
    이메일 SMTP 성공 / 쿼츠 됨 -> 쿼츠가 자동 삭제 시작되지 않으므로 서버 새로고침시 등록된 빈으로 나온다.. 그냥 코드 고치면 서버 껐다 키기 
    크론식 만들기 귀찮을 떄 : http://www.cronmaker.com/
    포트 번호 중복이라는 오류 뜰 때: netstat -ano로 그 포트 pid 찾아서 taskkill /f /pid '찾은pid'  
    pagenation 안 뜨는 이유 : totalPage 없이 계속 페이지 리스트만들려고 하니 totalPage가 초기화된값인 0으로 들어가 있어서 페이지가 항상 0으로 나옴 서비스 메서드의 setTotalPage와 makePageList 함수 위치를 바꿈  
    register폼에 있는 ajax diary_imgDTO에도 맞도록 수정하기 오늘은 너무 졸려서 이만  
0623 : 
    나중에 댓글 추가한다면 diary.html에 추가할 코드를 reply.html에 저장해두었다
    댓글 등록은 굳이 ajax처리를 하지 않아도 된다 -> 페이지 이동이 귀찮으므로 그냥 컨트롤러로
    대신 일기 읽을 때 다음 일기 / 이전 일기 기능을 넣어서 ajax처리하는게 좋아보임 -> 그냥 컨트롤러로함
    diary에 다음 일기와 이전 일기를 위한 메서드 추가 -> null이 들어가면 귀찮으니까 그런 일기 없을 경우 dno가 -1  
    사진은 로컬 파일로 접근해서 올리는건 불가능 -> 서버에 올리기로 경로, 사진 이미 올라간거 위치 바꿈

    내일 해야할 일 : 수정폼의 사진삭제 완벽히, 수정, 삭제 잇기  

0624 : 
    modify.html에서 수정버튼을 누르면 컨트롤러에 도달하지 않고 403에러 발생 -> post와 연관잇는듯
    -> form에 타임리프로 action추가해주니까 해결 ~> 타임리프가 post매핑해줄 때 자동으로 csrf를 만들어주는데 그냥 form으로 보내니깐 안 만들어져서 오류!! 
    -> th:action="@{url}"  안에 url을 잘 쓰도록 하자.. 경로가 틀리면 404나옴
    -> 수정시 Field error in object 'diaryDTO' on field 'image': rejected value [] 오류가 나옴 매핑이 안되서라는거같음
    ~> enctype="multipart/form-data"이걸 form에 안넣어줬다
    수정 / 삭제 완료

    사진의 삭제 성공
    ~> data가 잘 안넘어 와서 done으로 해서 성공했는지 넘어온 데이터를 확인  

    home, register에 추천 질문 올리기 끝 
    남은 것 : 
    질문 새로고침을 ajax로 구현  
    security를 통한 회원가입

    react로 프론트 바꾸기 ~> cors설정부터 하기  

    

