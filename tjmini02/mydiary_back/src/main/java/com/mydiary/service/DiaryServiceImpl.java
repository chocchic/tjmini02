package com.mydiary.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mydiary.dto.DiaryDTO;
import com.mydiary.dto.DiaryImgDTO;
import com.mydiary.dto.PageRequestDTO;
import com.mydiary.dto.PageResponseDTO;
import com.mydiary.model.Diary;
import com.mydiary.model.Diary_image;
import com.mydiary.model.Member;
import com.mydiary.persistence.DiaryImgRepository;
import com.mydiary.persistence.DiaryRepository;
import com.querydsl.core.Tuple;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
@RequiredArgsConstructor
public class DiaryServiceImpl implements DiaryService{
	private final DiaryRepository diaryRepository;
	private final DiaryImgRepository diaryimgRepo;
	
	//application.properties 파일에 작성한 속성 가져오기
	@Value("${com.choc.upload.path}")
	private String uploadPath;
	
	//업로드한 날짜 별로 이미지를 저장하기 위해서 날짜별로 디렉토리를 만들어서 경로를 리턴하는 메서드
	private String makeFolder() {
		//오늘 날짜를 문자열로 생성
		String str = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
		//문자열을 치환 - /를 운영체제의 디렉토리 구분자로 치환
		String realUploadPath = str.replace("//", File.separator);
		//디렉토리 생성
		File uploadPathDir = new File(uploadPath, realUploadPath);
		if(uploadPathDir.exists() == false) {
			uploadPathDir.mkdirs();
		}
		return realUploadPath;
		
	}
	//삽입이나 수정 그리고 삭제시 작업 시간을 기록하는 메서드
	//이 시간을 읽어서 데이터가 변경되었는지 확인
	private void updateDate() {
		try(PrintWriter pw = new PrintWriter(
				new FileOutputStream("./updatedate.dat"))){
			//현재 날짜 및 시간 가져오기
			String str = LocalDateTime.now().format(
					DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
			pw.println(str);
			pw.flush();
		}catch(Exception e) {
			System.out.println(e.getLocalizedMessage());
		}
	}
	
	@Override
	public Long registerDiary(DiaryDTO dto) {
		//파일 업로드 처리
		//전송 받은 파일을 가져오기
		//image 파라미터의 값을 가져오기
		for(MultipartFile uploadFile : dto.getImage()) {
			//전송된 파일이 있다면
			if(uploadFile.isEmpty() == false) {
				//이미지 파일 만 업로드하기 위해서 이미지 파일이 아니면 작업 중단
				if(uploadFile.getContentType().startsWith("image") == false) {
					return null;
				}
				//원본 파일의 파일 이름 찾아오기
				String originalName = uploadFile.getOriginalFilename();
				String fileName = originalName.substring(
						originalName.lastIndexOf("\\") + 1);
				
				//파일을 업로드할 디렉토리 경로를 생성
				String realUploadPath = makeFolder();
				
				//업로드 할 파일의 경로를 생성
				String uuid = UUID.randomUUID().toString(); //파일 이름의 중복을 피하기 위해서 생성
				String saveName = uploadPath + File.separator + 
						realUploadPath + File.separator + uuid + fileName;
				Path savePath = Paths.get(saveName);
				try {
					//파일 업로드
					uploadFile.transferTo(savePath);
					//이미지 경로를 DTO에 설정
					//dto.setImageurl(realUploadPath + File.separator + uuid + fileName);
					DiaryImgDTO imgdto = DiaryImgDTO.builder().dno(dto.getDno()).name(originalName)
							.imageurl(realUploadPath + File.separator + uuid + fileName).build();
					diaryimgRepo.save(imgdtoToEntity(imgdto));
				}catch(Exception e) {
					System.out.println(e.getLocalizedMessage());
				}
			}
		}
		Diary item = dtoToEntity(dto);
		diaryRepository.save(item);
		//수정한 시간을 기록
		updateDate();
		return item.getDno();
	}

	@Override
	public DiaryDTO getDiary(DiaryDTO dto) {
		Long dno = dto.getDno();
		Optional<Diary> optional = diaryRepository.findById(dno);
		if(optional.isPresent()) {
			Diary current = optional.get();
			List<Diary_image> imgs = diaryimgRepo.findDiary_imageByDiary(current);
			for(Diary_image img : imgs) {
				
			}
			return entityToDto(optional.get());
		}
		return null;
	}

	@Override
	public Long updateDiary(DiaryDTO dto) {
		// 삽입할 때는 이미지가 없으면 이미지 업로드를 처리하지 않거나 기본 이미지로 설정
		// 수정을 할 때 이미지가 없다는 것은 수정할 이미지가 없다는 의미가 될 수 있음
		for(MultipartFile img : dto.getImage()) {
			if(img.isEmpty() == false) {
				// 업로드된 파일을 가져오기
				MultipartFile uploadFile = img;
				
				// 원본 파일 이름 찾아오기
				String originalName = uploadFile.getOriginalFilename();
				// IE나 Edge에서는 전체 파일 경로가 오기 때문에 마지막 \위치를 찾아서 뒷부부만 가져와야 합.
				String fileName = originalName.substring(originalName.lastIndexOf("\\")+1); // 모바일에서 이 작업은 안해도 됨
				
				// 업로드할 디렉터리 경로를 생성, 회원 정보 이미지와 아이템 이미지를 구별해서 ㅅ저장하고자 하면 makeFolder 메서드를 각ㄱ각 구현
				String realUploadPath = makeFolder();
	
				// 파일 이름 중복을 최소화하기 위한 UUID 생성
				String uuid = UUID.randomUUID().toString();
				// 파일 이름 중간에 _를 이용해서 구분
				// 교재나 검색한 소스가 보일 때 \나 /가 보이면 앞뒤 문맥을 읽어서 디렉터리 기호라면 File.separator로 변경하는 것을 고려
				// 고재를 볼 때는 어떤 운영체제에서 작성한 것인지 확인하고 교재를 읽어보는 것이 좋습니다. 
				String saveName = uploadPath + File.separator + realUploadPath + File.separator + uuid + fileName;
				// 실제 전송할 경로를 생성 - jdk 1.7 이상에서 지원
				Path savePath = Paths.get(saveName);
				
				try {
					// 파일 전송
					uploadFile.transferTo(savePath);
				}catch(Exception e) {
					System.out.println(e.getLocalizedMessage());
					e.printStackTrace();
				}
				// 파일의 경로를 저장
				//dto.setImageurl(realUploadPath + File.separator + uuid + fileName);
				DiaryImgDTO imgdto = DiaryImgDTO.builder().dno(dto.getDno()).name(originalName)
						.imageurl(realUploadPath + File.separator + uuid + fileName).build();
				diaryimgRepo.save(imgdtoToEntity(imgdto));
			}/*else {
				// 업로드할 파일이 없을 때 이전 내용을 그대로 적용
				//dto.setImageurl(getDiary(dto).getImageurl());
				// image에 대한 테이블이 따로 있으므로 파일 변경이 일어났을 때에 대해서만 처리  
			}
			*/
		}
		// 데이터베이스에서 수정
		Diary item = dtoToEntity(dto);
		Long dno = item.getDno();
		diaryRepository.save(item);
		// 수정한 날짜 업데이트
		updateDate();
		return dno;
	}

	@Override
	public Long deleteDiary(DiaryDTO dto) {
		Diary item = dtoToEntity(dto);
		Long itemid = item.getDno();
		diaryRepository.deleteById(itemid);
		updateDate();
		return itemid;
	}
	@Override
	public PageResponseDTO getList(PageRequestDTO dto) {
		log.info("getlist에서 받은 dto : "+dto);
		Sort sort = Sort.by("dno").descending();
		Pageable pageable = PageRequest.of(dto.getPage()-1, dto.getSize(), sort);
		Page<Object[]> pages = diaryRepository.searchPage(dto.getType(), dto.getKeyword(), pageable);
		PageResponseDTO result = new PageResponseDTO();
		result.setTotalPage(pages.getTotalPages());
		result.makePageList(pageable);
		List<DiaryDTO> list = new ArrayList<>();
		for(Object[] obj: pages.getContent()) {
			Diary diary = (Diary) obj[0];
			DiaryDTO diaryDTO = DiaryDTO.builder().dno(diary.getDno()).content(diary.getContent())
					.title(diary.getTitle()).weather(diary.getWeather()).nickname((String) obj[1])
					.regdate(diary.getRegDate()).build();
			list.add(diaryDTO);
		}
		result.setList(list);
		return result;
	}
}
