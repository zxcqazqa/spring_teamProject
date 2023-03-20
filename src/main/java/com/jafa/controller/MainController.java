package com.jafa.controller;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jafa.repository.BoardRepository;
import com.jafa.repository.BookRepository;
import com.jafa.repository.CategoryRepository;

@Controller
@RequestMapping("/")
public class MainController {

	@Autowired
	BoardRepository boardRepository;
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	@Autowired
	private BookRepository bookRepository;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("threeNotice",boardRepository.mainNotice());
		model.addAttribute("threeReview", boardRepository.mainReview());
		model.addAttribute("threeEtc", boardRepository.mainEtc());
		application.setAttribute("cateList", categoryRepository.getCateList());
		application.setAttribute("subCateList", categoryRepository.getSubCateList());
		application.setAttribute("cate", bookRepository.bookOfCate()); // 카테고리별 게시물 수 포함된 거
		application.setAttribute("subCate", bookRepository.bookOfSubCate()); // 서브카테고리별 게시물 수 포함된 거
		return "/main/main";
	}
	
	@GetMapping("/test")
	public String test() {
		return"main/test";
	}


}
