package com.mydiary.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
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
import com.mydiary.model.Question;
import com.mydiary.persistence.DiaryImgRepository;
import com.mydiary.persistence.DiaryRepository;
import com.mydiary.persistence.QuestionRepository;
import com.querydsl.core.Tuple;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
@RequiredArgsConstructor
public class DiaryServiceImpl implements DiaryService{
	private final DiaryRepository diaryRepository;
	private final DiaryImgRepository diaryimgRepo;
	private final QuestionRepository qRepository;
	
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
		Diary item = dtoToEntity(dto);
		// 먼저 다이어리 작성 후
		diaryRepository.save(item);
		Long dno = item.getDno();//diaryRepository.findIdByDiary(item);
		//파일 업로드 처리 -> 데이터베이스상에 등록
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
					int Idx = originalName.lastIndexOf(".");
					String name = originalName.substring(0,Idx);
					DiaryImgDTO imgdto = DiaryImgDTO.builder().dno(dno).name(name)
							.imageurl(realUploadPath + File.separator + uuid + fileName).build();
					diaryimgRepo.save(imgdtoToEntity(imgdto));
				}catch(Exception e) {
					System.out.println(e.getLocalizedMessage());
				}
			}
		}
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
			List<Diary_image> imgs = diaryimgRepo.findByDiary(current);
			List<DiaryImgDTO> imgdtolist = new ArrayList<DiaryImgDTO>();
			for(Diary_image img : imgs) {
				imgdtolist.add(imgentityToDto(img));
			}
			DiaryDTO result = entityToDto(optional.get());
			result.setImagelist(imgdtolist);
			return result;
		}
		return null;
	}

	@Override
	public Long updateDiary(DiaryDTO dto) {
		for(MultipartFile img : dto.getImage()) {
			if(img.isEmpty() == false) {
				MultipartFile uploadFile = img;
				
				String originalName = uploadFile.getOriginalFilename();
				String fileName = originalName.substring(originalName.lastIndexOf("\\")+1);
				
				String realUploadPath = makeFolder();
	
				String uuid = UUID.randomUUID().toString();
				String saveName = uploadPath + File.separator + realUploadPath + File.separator + uuid + fileName;
				Path savePath = Paths.get(saveName);
				
				try {
					uploadFile.transferTo(savePath);
				}catch(Exception e) {
					System.out.println(e.getLocalizedMessage());
					e.printStackTrace();
				}

				int Idx = originalName.lastIndexOf(".");
				String name = originalName.substring(0,Idx);
				DiaryImgDTO imgdto = DiaryImgDTO.builder().dno(dto.getDno()).name(name)
						.imageurl(realUploadPath + File.separator + uuid + fileName).build();
				diaryimgRepo.save(imgdtoToEntity(imgdto));
			}
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
	public Long deleteDiary(Long dno) {
		diaryRepository.deleteById(dno);
		updateDate();
		return dno;
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
	@Override
	public DiaryDTO getPrevDiary(DiaryDTO dto) {
		Diary d = diaryRepository.searchPrev(dto.getDno(), dto.getMember_mno(), dto.getRegdate());
		if(d != null) {
			return entityToDto(d);			
		}
		return DiaryDTO.builder().dno(-1L).build();
	}
	@Override
	public DiaryDTO getNextDiary(DiaryDTO dto) {
		Diary d = diaryRepository.searchNext(dto.getDno(), dto.getMember_mno(), dto.getRegdate());
		if(d != null) {
			return entityToDto(d);			
		}
		return DiaryDTO.builder().dno(-1L).build();
	}
	
	@Override
	public String deletepicture(Long ino) {
		String response = "fail";
		
		String path = uploadPath + File.pathSeparator + diaryimgRepo.findById(ino).get().getImageurl();
		Path filePath = Paths.get(path);
		
		diaryimgRepo.deleteById(ino);
		if(diaryimgRepo.findById(ino).isEmpty()) {
			try {
				Files.delete(filePath);
			} catch (IOException e) {
				e.printStackTrace();
				System.out.println("사진 없음!");
			}
			response = "success" ;
		}
		return response;
	}
	
	@Override
	public String getQ() {
		int qno = (int)(Math.random()*210 +1);
		return qRepository.getOne((long) qno).getContent();
	}
}
