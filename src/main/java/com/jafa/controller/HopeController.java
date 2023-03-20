package com.jafa.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.jafa.domain.Criteria;
import com.jafa.domain.HopeVO;
import com.jafa.domain.Pagination;
import com.jafa.repository.BookRepository;
import com.jafa.repository.HopeRepository;

//책 대여 및 신청 
@Controller
@RequestMapping("/hope")
public class HopeController {

	@Autowired
	private HopeRepository hopeRepository;
	@Autowired
	private	BookRepository bookRepository;
	
	//비치희망도서 신청현황
	@GetMapping(value = {"/requestList"})
	public String requestList(@ModelAttribute("cri") Criteria criteria,
			Model model) {
		model.addAttribute("requestList", hopeRepository.getRequestList(criteria))
		.addAttribute("p", new Pagination(criteria, hopeRepository.getTotalCount(criteria)));
		return "hope/requestList";
	}
	//신청 폼
	@GetMapping("/requestForm")
	public String requestForm(Model model,@ModelAttribute("cri") Criteria criteria) {
		//새신청번호
		model.addAttribute("rno", hopeRepository.getNewRno())
		.addAttribute("r",hopeRepository.getRequestList(criteria));
		return"hope/requestForm";
	}
	//신청처리
	@PostMapping("/request")
	public String addRequest(HopeVO vo) {
		hopeRepository.addRequest(vo);
		//return을 현황페이지로 했으나 신청이 처리되었을ㄸㅐ 데이터는 추가 되고 페이지이동이 안됨
		return "hope/requestList";
	}
	
	//결과전송폼(관리자페이지)
	@GetMapping("/requestMaster") 
	public String master(@ModelAttribute("cri") Criteria criteria, Model model) {
		//희망도서신청관리
		model.addAttribute("requestMaster", hopeRepository.getRequestMaster(criteria))
		.addAttribute("p", new Pagination(criteria, hopeRepository.getTotalCount(criteria)));
		return "hope/requestMaster";
	}
	
	//결과전송처리(관리자페이지)
	@PostMapping("/requestResult")
	public String sendResult(Model model,HopeVO vo,
				@RequestParam(value = "goResult_ck", required=false) String[] goValue,
				@RequestParam(value = "noResult_ck", required=false) String[] noValue,
				@RequestParam(value = "etc", required=false) String[] etc ) {
	//기존 거절 코드 
	//거절값과 거절사유를 각각 List나 Map 형태로 받아 거절List와 거절사유List를 반복문을 통해 짝을 지어 전송하여 처리하려 했으나 
	//코드를 축약하는 과정에서 배열로 받아 반복문을 통해 두 파라미터를 동시에 전송하여 처리해도 이상이 없는것을 확인
	
		if(noValue==null || goValue==null) {// 거절값이 null 혹은 승인값이 null인 경우
			if(noValue==null) { //거절값이 null이면
				for(String g : goValue) {//승인을 실행하고
					int Grno = Integer.parseInt(g);
					hopeRepository.updateGo(Grno);
				}
			}
			if(goValue==null) {//승인값이 null이면
				for(int i=0; i<noValue.length;i++) { //거절을 실행하고
					int Xrno = Integer.parseInt(noValue[i]);
					hopeRepository.updateNo(Xrno,etc[i]);
				}
			}
		}//거절값과 승인값 둘다 null이 아니면 둘다 실행
		if(goValue!=null && noValue!=null) {
			for(int i=0; i<noValue.length;i++) { //거절실행
				int Xrno = Integer.parseInt(noValue[i]);
				hopeRepository.updateNo(Xrno,etc[i]);
			}
			for(String g : goValue) { //승인실행
				int Grno = Integer.parseInt(g);
				hopeRepository.updateGo(Grno);
			}
		}
		return "hope/requestList";	
	}
	
	
	
}
/*
  -컨트롤러 

 -. 책을 승인하면 보유하고있는 도서에 insert??
 3. 처리해야하는 목록중 하나만 처리하면 반대쪽값이 널
  - ex)승인이나 널만 하면 다른 한쪽이 널이표기됨
    둘다 하나라도 같이 처리하면 진행됨 진행이 되면 2번과 같은 상황이 발생
*/