package com.jafa.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.BoardVO;
import com.jafa.domain.BoardVO.FileType;
import com.jafa.domain.Criteria;
import com.jafa.domain.Pagination;
import com.jafa.repository.BoardRepository;


@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardRepository boardRepository;
	
	//전체게시판 목록(페이징, 카테고리, 검색기능)
	@GetMapping(value = {"/list","/list/{tid}"})
	public String list(@ModelAttribute("cri") Criteria criteria, 
			Model model,
			@PathVariable(required = false) String tid) { 
		criteria.setTid(tid);
		model.addAttribute("list", boardRepository.list(criteria))
		.addAttribute("p", new Pagination(criteria, boardRepository.getTotalCount(criteria)));
		return "board/list";
	}
	
	//글쓰기 폼 이동
	@GetMapping("/writeForm")
	public String writeForm() {
		return "board/writeForm";
	}
	
	//글쓰기 처리
	@PostMapping("/write")
	public String write(BoardVO vo,
			@RequestParam("attachFile") MultipartFile multipartFile,
			RedirectAttributes rttr) {

		if(!multipartFile.isEmpty()) { //첨부파일이 있을대
			String fileName = multipartFile.getOriginalFilename();
			vo.setImageFileName(fileName);
			//파일타입결정 : img파일, other
			if(multipartFile.getContentType().startsWith("image")) { //이미지 파일 일때
				vo.setFileType(FileType.IMAGE);
			}else {//아닐때
				vo.setFileType(FileType.OTHER);
			}
			boardRepository.insertBoard(vo);//데이터베이스에 저장
			//업로드
			// ex) /file01_repo/1/벵갈호랑이.png
			File uploadPath = new File("c:/file01_spring/"+vo.getBno());
			if(!uploadPath.exists()) {//업로드패스 생성
				uploadPath.mkdirs();
			}
			//파일경로 지정
			File uploadFile = new File(uploadPath,fileName);
			try {
				multipartFile.transferTo(uploadFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}else {//없을때
			boardRepository.insertBoard(vo);
		}
	    return "/board/list";
	}
	//글상세보기
	@GetMapping("/detail")
	public String detail(Model model,Long bno) {
		model.addAttribute("b",boardRepository.detail(bno));
		return "board/detail";
	}
	//글삭제하기
	@PostMapping("/remove")
	public String remove(Long bno) {
		BoardVO vo = boardRepository.detail(bno); // 게시물정보조회 
		if(vo.getImageFileName()!=null) {
			// 파일 삭제 
			File file = new File("c:/file01_spring/"+bno,vo.getImageFileName());
			File folder = new File("c:/file01_spring/"+bno);
			file.delete(); // 파일삭제
			folder.delete(); // 폴더삭제
		}
		boardRepository.remove(bno); // 게시물삭제 
		return "redirect:/board/list";
	}
	//수정폼
	@GetMapping("/modify")
	public void modForm(Long bno, Model model) {
		BoardVO vo = boardRepository.detail(bno);
		model.addAttribute("b", vo);
	}
	//수정처리
	@PostMapping("/modify")
	public String modify(BoardVO vo,RedirectAttributes rttr,
			@RequestParam(defaultValue = "false") Boolean delChk,
			@RequestParam("attachFile") MultipartFile multipartFile) {

		if(delChk) { //이미지 삭제 및 내용변경
			
			//파일삭제
			BoardVO detail = boardRepository.detail(vo.getBno());
			File file = new File("c:/file01_repo/"+detail.getBno()+"/"+detail.getImageFileName());
			File folder = new File("c:/file01_repo/"+detail.getBno());
			file.delete();
			folder.delete();
			//modify호출
			boardRepository.modify(vo);
		}else {
			
			if(!multipartFile.isEmpty()) { //이미지 내용 둘다 변경
				
				//삭제
				BoardVO detail = boardRepository.detail(vo.getBno());
				File file = new File("c:/file01_spring/"+detail.getBno()+"/"+detail.getImageFileName());
				file.delete();
				
				//새로운 파일 업로드
				String fileName = multipartFile.getOriginalFilename();
				vo.setImageFileName(fileName);
				//파일타입결정 : img파일, other
				if(multipartFile.getContentType().startsWith("image")) { //이미지 파일 일때
					vo.setFileType(FileType.IMAGE);
				}else {//아닐때
					vo.setFileType(FileType.OTHER);
				}
				
				//수정 후 업로드
				File uploadPath = new File("c:/file01_repo/"+vo.getBno());
				if(!uploadPath.exists()) {//업로드패스 생성
					uploadPath.mkdirs();
				}
				//파일경로 지정
				File uploadFile = new File(uploadPath,fileName);
				try {
					multipartFile.transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				//modify 호출
				boardRepository.modify(vo);
				
			}else { // 내용만변경
				boardRepository.modifyOnlyContent(vo);
			}
		}
		System.out.println(delChk);
		return "redirect:/board/list";
	}
	
}
