package com.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.common.security.domain.CustomUser;
import com.member.domain.MemberVO;
import com.project.domain.ReviewVO;
import com.project.service.ReviewService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/review/*")
@Log4j
public class ReviewController {
	@Autowired
	private ReviewService reviewS;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("write")
	public String write(@ModelAttribute("pnum") Integer pnum,Authentication auth, Model model, RedirectAttributes rttr) {
		System.out.println("write get 요청 ");
		
		System.out.println("pnum : " + pnum);
		CustomUser user = (CustomUser)auth.getPrincipal();
		MemberVO member = user.getMember();
		model.addAttribute("mnum", member.getMnum());
		List<Integer> mypnumList = reviewS.getMyP(member.getMnum());
		if(!mypnumList.contains(pnum)) {
			rttr.addFlashAttribute("result", "no");
			return "redirect:/vegekit/shop/content?pnum="+pnum;
		}
		return "vegekit/review/write";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("write")
	public String writePro(ReviewVO vo, MultipartHttpServletRequest request, Model model) {
		System.out.println("write pro 요청 ");
		log.info(vo); // vo 잘 들어왔는지 로그로 확인 
		
		//넘어온 이미지 파일 정보 꺼내기
		MultipartFile mf =  request.getFile("img"); 
		System.out.println("mf:" + mf.getSize());
		System.out.println("mf:" + mf.isEmpty());
		
		//넘어온 값이 null이면 substring 안하게 분기처리,.?
		if(!mf.isEmpty()) {
			String ct = mf.getContentType();
			String type = ct.substring(0, ct.indexOf("/")); //타입에 /plain 앞까지 잘려서 담김
			
						
			//서버에 파일 저장
			//파일 저장할 폴더 경로 찾기 (save)
			String savePath = request.getRealPath("resources/save"); //!!!!!!!!!윈도우는 \\이렇게 하지만 맥은 /은 이렇게 해야한다.. 나중에 파일 합칠때 꼭 기억하고 참
	
		
			//파일명에 밀리세컨드 추가 
			String orgName = mf.getOriginalFilename();
			String ext = orgName.substring(orgName.lastIndexOf(".")); //파일 업로드를 안하면 에러. 
			String imgName = orgName.substring(0, orgName.lastIndexOf(".")); //처음부터 . 전까지 잘라줌
			String newName = imgName + System.currentTimeMillis() + ext;
			
			
			//파일을 실제로 저장 처리 
			//: 내가 만든 파일명과 폴더 전체 경로를 연결해서 그쪽으로 파일을 이동해주는 개념
			String imgPath = savePath + "/" + newName; //파일합칠때 기억!!!!!!!!!!!!!!!!! 역슬래쉬 두개로 바꾸기!!!!!!!!!!
			System.out.println(savePath);
			File f =new File(imgPath); 
			try {
				mf.transferTo(f);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			//5. 디비에 파일 이름 저장 
			vo.setIname(newName);
			// 글 저장 
			reviewS.register(vo);
			
			//상품 해당 리뷰 평균가져오기
			float starAvg =  reviewS.getStarAvg(vo.getPnum());
			reviewS.saveStar(starAvg,vo.getPnum());
	
			return"redirect:/vegekit/review/myReviewList";
		
		}else {
		
			// 글 저장 
				reviewS.register(vo);
				//상품 해당 리뷰 평균가져오기
				float starAvg =  reviewS.getStarAvg(vo.getPnum());
				reviewS.saveStar(starAvg,vo.getPnum());
				return"redirect:/vegekit/review/myReviewList";
		}
	}

	
	//조회 폼
	@GetMapping({"content","modify","delete"})
	public void content(@RequestParam("rnum") Integer rnum, Model model, Authentication auth) {
		System.out.println(auth);
		System.out.println(auth.getAuthorities());
		model.addAttribute("review",reviewS.get(rnum));
		
	}
	
	//리뷰 수정
	@PreAuthorize("isAuthenticated()")
	@PostMapping("modify")
	public String modify(ReviewVO vo, MultipartHttpServletRequest request) {
		//reviewS.modify(vo);
		//넘어온 이미지 파일 정보 꺼내기
		MultipartFile mf =  request.getFile("img"); 
		System.out.println("mf:" + mf.getSize());
		System.out.println("mf:" + mf.isEmpty());				
		if(!mf.isEmpty()) {
			String ct = mf.getContentType();		
			String type = ct.substring(0, ct.indexOf("/")); //타입에 /plain 앞까지 잘려서 담김
							
			String savePath = request.getRealPath("resources/save"); //윈도우는 \\이렇게 하지만 맥은 /은 이렇게 해야한다.. 나중에 파일 합칠때 꼭 기억하고 참
			
				
			String orgName = mf.getOriginalFilename();
			String ext = orgName.substring(orgName.lastIndexOf(".")); //파일 업로드를 안하면 에러. 
			String imgName = orgName.substring(0, orgName.lastIndexOf(".")); //처음부터 . 전까지 잘라줌
			String newName = imgName + System.currentTimeMillis() + ext;
					
					
			String imgPath = savePath + "/" + newName; //파일합칠때 기억!!!!!!!!!!!!!!!!! 역슬래쉬 두개로 바꾸기!!!!!!!!!!
			System.out.println(savePath);
			File f =new File(imgPath); 
			try {
				mf.transferTo(f);
			} catch (IOException e) {
				e.printStackTrace();
			}
					
			//5. 디비에 파일 이름 저장 
			vo.setIname(newName);
			// 글 저장 
			reviewS.modify(vo);
			
			//상품 해당 리뷰 평균가져오기
			float starAvg =  reviewS.getStarAvg(vo.getPnum());
			reviewS.saveStar(starAvg,vo.getPnum());
			
			return"redirect:/vegekit/review/myReviewList";
				
			}
		else {
				
			// 글 저장 
			reviewS.modify(vo);
					
			//상품 해당 리뷰 평균가져오기
			float starAvg =  reviewS.getStarAvg(vo.getPnum());
			reviewS.saveStar(starAvg,vo.getPnum());
			
			return"redirect:/vegekit/review/myReviewList";
		}

	}
	
	//리뷰 삭제
	@PostMapping("delete")
	public String delete(@RequestParam("rnum") Integer rnum,RedirectAttributes rttr, ReviewVO vo,@RequestParam("pnum")Integer pnum)  {
		reviewS.remove(rnum);
		
		//프로덕트 테이블 스타 다시 업데이트 
		float starAvg =  reviewS.getStarAvg(pnum);
		reviewS.saveStar(starAvg,pnum);
		
		rttr.addFlashAttribute("result", "success");
		return"redirect:/vegekit/review/myReviewList";
	}
	
	//사용자 리뷰 목록
	@GetMapping("myReviewList")
	public void myReviewList(ReviewVO vo, Model model,MemberVO mvo, Authentication auth)  { 
		CustomUser user = (CustomUser)auth.getPrincipal();
		MemberVO member = user.getMember();
		model.addAttribute("list",reviewS.myReviewList(member.getMnum()));
	}
	
	//관리자 리뷰 목록 (pnum이 가지고 있는 모든 리뷰 가져오기)
	@GetMapping("adminReviewList")
	public void adminReviewList(ReviewVO vo, Model model,@RequestParam("pnum") Integer pnum) {
		model.addAttribute("list",reviewS.getAdminList(pnum));
	}
	

}
