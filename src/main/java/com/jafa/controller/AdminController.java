package com.jafa.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.Criteria;
import com.jafa.domain.Bookshop.BookCategory;
import com.jafa.domain.Bookshop.BookDTO;
import com.jafa.domain.Bookshop.BookSubCategory;
import com.jafa.domain.Bookshop.BookVO;
import com.jafa.repository.BookRepository;
import com.jafa.repository.CategoryRepository;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final String REPO_PATH = "c:/file01_spring/";
	private static final String bookServicePathName = "book/";

	@Autowired
	private CategoryRepository categoryRepository;

	@Autowired
	private BookRepository bookRepository;

	@Autowired
	private ServletContext application;

	// 관리자 홈
	@GetMapping("/home")
	public String home() {
		return "/admin/home";
	}
	
	// 도서관리페이지로 이동
	@GetMapping("/book")
	public String book(@ModelAttribute("cri") Criteria criteria, Model model) {
		application.setAttribute("cateList", categoryRepository.getCateList());
		application.setAttribute("subCateList", categoryRepository.getSubCateList());
		application.setAttribute("cate", bookRepository.bookOfCate()); // 카테고리별 게시물 수 포함된 거
		application.setAttribute("subCate", bookRepository.bookOfSubCate()); // 서브카테고리별 게시물 수 포함된 거
		model.addAttribute("latest", bookRepository.latestList()); // 최근에 등록한 상품 목록
		return "admin/book";
	}

	// 여러개 등록
	@PostMapping("/registerBook")
	public String registerBook(BookDTO dto, @RequestParam("attachFile") List<MultipartFile> multipartFile,
			RedirectAttributes rttr) {
		List<BookVO> bookList = dto.getBookList();

		if (!multipartFile.isEmpty()) { // 첨부파일이 있을 때
			int count = 0;
			for (MultipartFile f : multipartFile) {
				String fileName = f.getOriginalFilename(); // 데이터베이스에 저장될 이미지 파일 이름
				bookList.get(count).setBookImage(fileName);
				bookRepository.insertBook(bookList.get(count));

				// 경로: c:/file01_spring/book/cate_id/subCate_id/bookNo/이미지파일
				File uploadPath = new File(REPO_PATH + bookServicePathName + bookList.get(count).getCate_id() + "/"
						+ bookList.get(count).getSubCate_id() + "/" + bookList.get(count).getBookNo());

				if (!uploadPath.exists()) { // 디렉토리 존재하지 않으면
					uploadPath.mkdirs(); // 디렉토리 생성
				}

				File uploadFile = new File(uploadPath, fileName); // 업로드
				try {
					f.transferTo(uploadFile);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				count++;
			}

		} else { // 첨부파일이 없는 경우
			bookRepository.addBook(bookList);
		}
		return "redirect:/admin/book";
	}
	
	/*
	// 하나만 등록
	@PostMapping("/registerBook")
	public String registerBook(BookVO vo, @RequestParam("attachFile") MultipartFile multipartFile,
			RedirectAttributes rttr) {

		if (!multipartFile.isEmpty()) { // 첨부파일이 있을 때
			String fileName = multipartFile.getOriginalFilename(); // 데이터베이스에 저장될 이미지 파일 이름
			vo.setBookImage(fileName);
			bookRepository.insertBook(vo);

			// 경로: c:/file01_spring/book/cate_id/subCate_id/bookNo/이미지파일
			File uploadPath = new File(REPO_PATH + bookServicePathName + vo.getCate_id() + "/" + vo.getSubCate_id()
					+ "/" + vo.getBookNo());

			if (!uploadPath.exists()) { // 디렉토리 존재하지 않으면
				uploadPath.mkdirs(); // 디렉토리 생성
			}

			File uploadFile = new File(uploadPath, fileName); // 업로드
			try {
				multipartFile.transferTo(uploadFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		} else { // 첨부파일이 없는 경우
			bookRepository.insertBook(vo);
		}
		return "redirect:/admin/book";
	}
	*/
	
	// 도서 상품 수정
	@PostMapping("/modifyBook")
	public String modifyBook(BookVO vo, @RequestParam("attachFile") MultipartFile multipartFile,
			RedirectAttributes rttr) {
		
		if (!multipartFile.isEmpty()) { // 첨부파일이 있을 때
			BookVO detail = bookRepository.findByBookNo(vo.getBookNo());
			File file = new File(REPO_PATH + bookServicePathName + detail.getBookCategory().getCate_id()+"/"+ detail.getBookSubCategory().getSubCate_id() +"/"+ detail.getBookNo() +"/"+ detail.getBookImage());
			file.delete(); // 기존 파일 삭제
			File folder = new File(REPO_PATH + bookServicePathName + detail.getBookCategory().getCate_id()+"/"+ detail.getBookSubCategory().getSubCate_id() +"/"+ detail.getBookNo());
			folder.delete(); // 폴더 삭제
			
			String fileName = multipartFile.getOriginalFilename();
			vo.setBookImage(fileName);
			bookRepository.updateBook(vo); // 데이터베이스에 저장
			
			// 파일 업로드
			// 경로: c:/file01_spring/book/cate_id/subCate_id/bookNo/이미지파일
			File uploadPath = new File(REPO_PATH + bookServicePathName + vo.getCate_id() + "/" + vo.getSubCate_id() + "/" + vo.getBookNo());
			if(!uploadPath.exists()) {//업로드패스 생성
				uploadPath.mkdirs();
			}
			File uploadFile = new File(uploadPath,fileName);
			try {
				multipartFile.transferTo(uploadFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		} else { // 첨부파일이 있을 때
			bookRepository.updateBook(vo);
		}
		return "redirect:/admin/book";
	}

	// 도서상품 삭제
	@PostMapping("/removeBook")
	public String removeBook(int bookNo) {
		BookVO detail = bookRepository.findByBookNo(bookNo); // 게시물정보조회

		if (detail.getBookImage() != null) {
			File file = new File(REPO_PATH + bookServicePathName + detail.getBookCategory().getCate_id()+"/"+ detail.getBookSubCategory().getSubCate_id() +"/"+ detail.getBookNo() +"/"+ detail.getBookImage());
			file.delete(); // 기존 파일 삭제
			File folder = new File(REPO_PATH + bookServicePathName + detail.getBookCategory().getCate_id()+"/"+ detail.getBookSubCategory().getSubCate_id() +"/"+ detail.getBookNo());
			folder.delete(); // 폴더 삭제
		}
		bookRepository.deleteBook(bookNo);
		return "redirect:/admin/book";
	}

	// 카테고리 관리 페이지
	@GetMapping("/category")
	public String category() {
		application.setAttribute("cateList", categoryRepository.getCateList());
		application.setAttribute("subCateList", categoryRepository.getSubCateList());
		return "/admin/category";
	}

	// 카테고리 추가
	@PostMapping("/addCate")
	public String addCate(@Valid BookCategory bookCategory, Errors errors, RedirectAttributes rttr) {
		if(errors.hasErrors()) {
			return "/admin/category";
		}
		categoryRepository.saveCate(bookCategory);
		return "redirect:/admin/category";
	}

	// 서브카테고리 추가
	@PostMapping("/addSubCate") // org.apache.ibatis.binding.BindingException
	public String addSubCate(@Valid BookSubCategory bookSubCategory, Errors errors, RedirectAttributes rttr) {
		if(errors.hasErrors()) {
			return "/admin/category";
		}
		categoryRepository.saveSubCate(bookSubCategory);
		return "redirect:/admin/category";
	}

	// 카테고리 삭제
	@PostMapping("/delCate")
	public String delCate(String id) {
		categoryRepository.delCate(id);
		return "/admin/home";
	}

	// 서브 카테고리 삭제
	@PostMapping("/delSubCate")
	public String delSubCate(String id) {
		categoryRepository.delSubCate(id);
		return "redirect:/admin/category";
	}

}
