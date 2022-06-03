package com.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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

import com.admin.domain.Criteria;
import com.admin.domain.PageDTO;
import com.admin.domain.ProductVO;
import com.admin.service.ProductService;

import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/vegekit/admin/product/*")
@Log4j
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	//상품등록폼
	@GetMapping("writeForm")
	public void writeForm() {
		System.out.println("write get 방식 요청!!");
	}
	
	//상품등록!
	@PreAuthorize("isAuthenticated()")
	@PostMapping("write")
	public String write(ProductVO product, MultipartHttpServletRequest request) {
		System.out.println("write post 방식 요청!!");
		
		// 썸네일 이미지 저장 함수
		saveThumImg(product, request);
		// 디테일 이미지 저장 함수
		saveDetailImg(product, request);
		log.info(product);
		productService.register(product);
		
		return "redirect:/vegekit/admin/product/list";
	}
	
	
	//상품 리스트 출력
	@GetMapping("list") // list 요청시 pageNum, listQty 가 들어와야함.
	public void list(Criteria cri, Model model) {
		//model.addAttribute("list", productService.getList());

		// 페이징처리 버전!! 
		// 현재 페이지 번호에 따른, 보여줄 글 목록 가져와 view에 전달 
		model.addAttribute("list", productService.getList(cri));
		
		// 전체 글의 개수 가져오고 
		int total = productService.getTotal(cri); 
		// 화면에 띄워줄 페이지번호등 계산완료된 PageDTO 객체도 view전달 
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
	}
	
	// 수정폼 이동
	@GetMapping({"detail","modifyForm", "deleteForm"})
	public void content(@RequestParam("pnum") Long pnum, @ModelAttribute("cri")Criteria cri, Model model) {
		model.addAttribute("product", productService.get(pnum)); 
	}
	
	@PostMapping("delete")
	public String delete(@RequestParam("pnum") Long pnum, Criteria cri,
			RedirectAttributes rttr) {
		if(productService.delete(pnum)) {
			rttr.addFlashAttribute("result", "success"); 
		}
		return "redirect:/vegekit/admin/product/list" + cri.getParameterLink();
	}

	
	

	@PreAuthorize("isAuthenticated()")
	@PostMapping("modify")
	public String modify(ProductVO product, Criteria cri, RedirectAttributes rttr
			,MultipartHttpServletRequest request) {
		// 썸네일 이미지 변경시 처리
		/*if(request.getFile("thumbImg").equals(null)) {
			is_thModifyImg = 1;
			saveThumImg(product, request);
		}*/
		if(product.getThumb() == null) {
			product.setThumb(request.getParameter("orThumbImg"));	// 그전 풀네임 그대로 저장
		}
		saveThumImg(product, request);
		// 썸네일이미지 수정이 안되었을시 처리
		
		
		// 디테일 이미지 변경시 처리
		/*if(request.getFile("detailImg").equals(null)) {
			saveDetailImg(product, request);
		}*/
		
		if(product.getDetail() == null) {
			product.setDetail(request.getParameter("orDetailImg"));	// 그전 풀네임 그대로 저장
		}
		saveDetailImg(product, request);
		// 디테일이미지 수정이 안되었을시 처리
		//product.setDetail(request.getParameter("detailImg"));// 그전 풀네임 그대로 저장
		
		
		boolean res = productService.modify(product);
		if(res) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/vegekit/admin/product/list" + cri.getParameterLink(); 
	}
	
	
	
	
	
	
	
	//썸네일 이미지 저장  함수
	public void saveThumImg(ProductVO product, MultipartHttpServletRequest request) {
		MultipartFile thumbImg = request.getFile("thumbImg");
		String ct = thumbImg.getContentType();
		String type = ct.substring(0, ct.indexOf("/")); 
		if(!type.equals("image")) { // 이미지가 아니면 저장 하지말자.
			System.out.println("이미지파일 아닙니다."); // 저장하지말고 폼페이지로 강제 이동 
		}else {
			// 서버에 파일 저장
			String savePath = request.getRealPath("resources\\save");
			
			// 파일명 중복 안되게
			String orgThumbName = thumbImg.getOriginalFilename(); 	
			UUID uuid = UUID.randomUUID(); 
			String newThumbName = uuid+orgThumbName;
			
			// #4. 파일을 실제로 저장 처리 
			String ThumImgPath = savePath + "\\" + newThumbName; 
			System.out.println("너자나 경로~~~~!!!!!!!!!!!!!!!!!!!!!"+ThumImgPath);
			File ThumF = new File(ThumImgPath); 
			try {
				thumbImg.transferTo(ThumF);
			}catch(IOException e) {
				e.printStackTrace();
			}
			if(newThumbName != null) {
				product.setThumb(newThumbName);
			}
			
		}
	}
	
	
	//디테일 이미지 저장 함수
	public void saveDetailImg(ProductVO product, MultipartHttpServletRequest request) {
		MultipartFile detailImg = request.getFile("detailImg");
		String ct = detailImg.getContentType();
		String type = ct.substring(0, ct.indexOf("/")); 
		if(!type.equals("image")) { // 이미지가 아니면 저장 하지말자.
			System.out.println("이미지파일 아닙니다."); // 저장하지말고 폼페이지로 강제 이동 
		}else {
			// 서버에 파일 저장
			String savePath = request.getRealPath("resources\\save");
			
			// 파일명 중복 안되게
			String orgDetailName = detailImg.getOriginalFilename(); 		
			UUID uuid = UUID.randomUUID(); 
			String newDetailName = uuid+orgDetailName;
			
			// #4. 파일을 실제로 저장 처리 
			String DetailImgPath = savePath + "\\" + newDetailName; 
			File DetailF = new File(DetailImgPath); 
			try {
				detailImg.transferTo(DetailF);
			}catch(IOException e) {
				e.printStackTrace();
			}
			if(newDetailName != null) {
				product.setDetail(newDetailName);
			}
		}
	}
	
}












