package com.jafa.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jafa.domain.Criteria;
import com.jafa.domain.MemberVO;
import com.jafa.domain.Pagination;
import com.jafa.repository.MemberRepository;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberRepository memberRepository;
	
	@GetMapping("/join")
	public String memJoin() {
		return "member/join";	// join.jsp
	}
	
	@GetMapping("/registerCheck")
	public @ResponseBody int memRegisterCheck(@RequestParam("id") String id) {
		MemberVO vo = memberRepository.registerCheck(id);
		if(vo != null || id.equals("")) {
			return 0;	// 이미 존재하는 회원 or 입력 불가
		}
		return 1;		// 사용가능한 아이디
	}
	
	// 회원가입 처리
	@PostMapping("/register")
	public String memRegister(MemberVO vo, String password1, String password2, 
								RedirectAttributes rttr, HttpSession session) {
		if(vo.getId() == null || vo.getId().equals("") || //id가 없다면 
		   password1 == null || password1.equals("") ||
		   password2 == null || password2.equals("") ||
		   vo.getName() == null || vo.getName().equals("") ||
		   vo.getAge() == 0 ||
		   vo.getGender() == null || vo.getGender().equals("") ||
		   vo.getEmail() == null || vo.getEmail().equals("") ) {
		   // 누락메세지를 가지고 가기 -> 객체바인딩(Model, HttpServletRequest, HttpSession)
		   rttr.addFlashAttribute("msgType", "실패 메세지");
		   rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
		   return "redirect:/member/join";	//${msgType}, ${msg}
		}
		if(!password1.equals(password2)) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 일치하지 않습니다.");
			return "redirect:/member/join";	//${msgType}, ${msg}
		}
		vo.setProfile("");	// 사진이미지는 없다는 의미 ""
		// 회원을 테이블에 저장
		int result = memberRepository.register(vo);
		if(result == 1) {	// 회원가입 성공 메세지
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
			// 회원가입이 성공하면 -> 로그인 처리
			session.setAttribute("mvo", vo);	// ${!empty mvo}
			return "redirect:/main";
		} else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다.");
			return "redirect:/member/join";
		}
	}
	
	// 로그아웃 처리
	@GetMapping("/logout")
	public String memLogout (HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
	
	// 로그인 화면으로 이동
	@GetMapping("/loginForm")
	public String memLoginForm() {
		return "member/memLoginForm";	//memLoginForm.jsp
	}
	
	// 로그인 기능
	@PostMapping("login")
	public String memLogin(MemberVO vo, RedirectAttributes rttr, HttpSession session) {
		if(vo.getId() == null || vo.getId().equals("") ||
		   vo.getPwd() == null || vo.getPwd().equals("")) {
		   rttr.addFlashAttribute("msgType", "실패 메세지");
		   rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
		   return "redirect:/member/loginForm";
		}
		MemberVO mvo = memberRepository.login(vo);
		if(mvo != null) {	// 로그인 성공
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "로그인 되었습니다.");
			session.setAttribute("mvo", mvo); 	// ${!empty mvo}
			return "redirect:/main";	// 메인
		} else {			// 로그인 실패
			rttr.addFlashAttribute("msgType", "로그인 실패");
			rttr.addFlashAttribute("msg", "아이디 혹은 비밀번호가 일치하지 않거나 없습니다.");
			return "redirect:/member/loginForm";
		}
	}
	
	// 회원정보수정 화면
	@GetMapping("/updateForm")
	public String memUpdateForm() {
		return "member/memUpdateForm";
	}
	
	// 회원정보 수정
	@PostMapping("/update")
	public String memUpdate(MemberVO vo, RedirectAttributes rttr, 
							String password1, String password2, HttpSession session) {
		if(vo.getId() == null || vo.getId().equals("") ||
		   password1 == null || password1.equals("") ||
		   password2 == null || password2.equals("") ||
		   vo.getName() == null || vo.getName().equals("") ||
		   vo.getAge() == 0 ||
		   vo.getGender() == null || vo.getGender().equals("") ||
		   vo.getEmail() == null || vo.getEmail().equals("") ) {
		   // 누락메세지를 가지고 가기 -> 객체바인딩(Model, HttpServletRequest, HttpSession)
		   rttr.addFlashAttribute("msgType", "실패 메세지");
		   rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
		   return "redirect:/member/updateForm";	//${msgType}, ${msg}
		 }
		 if(!password1.equals(password2)) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 서로 일치하지 않습니다.");
			return "redirect:/member/updateForm";	//${msgType}, ${msg}
		 }
		 // 수정된 회원정보 저장
		 int result = memberRepository.update(vo);
		 if(result == 1) {	// 수정 성공 메세지
			 rttr.addFlashAttribute("msgType", "성공 메세지");
			 rttr.addFlashAttribute("msg", "정보가 수정되었습니다.");
			 // 회원정보수정이 성공하면 -> 로그인 처리
			 session.setAttribute("mvo", vo);	// ${!empty mvo}
			 return "redirect:/main";
		 } else {
			 rttr.addFlashAttribute("msgType", "실패 메세지");
			 rttr.addFlashAttribute("msg", "정보수정에 실패했습니다.");
			 return "redirect:/member/updateForm";
		}
	}
	
	// 회원 사진등록 화면
	@GetMapping("/imageForm")
	public String memImageForm() {
		return "member/memImageForm";	// memImageForm.jsp
	}
	
	// 회원 사진 업로드(upload폴더, DB저장) 
//	@RequestMapping("/imageUpdate")
//	public String memImageUpdate (HttpServletRequest request, HttpSession session, RedirectAttributes rttr) throws IOException {
//		// 파일업로드 API(cos.jar 3가지)
//		MultipartRequest multi = null;	// 객체 생성
//		int fileMaxSize = 40*1024*1024;	// 10MB
//		String savePath = request.getRealPath("resources/upload");
//		try {
//			// 사진 업로드
//			multi=new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
//		} catch (Exception e) {
//			e.printStackTrace();
//			rttr.addFlashAttribute("msgType", "실패 메세지");
//			rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");
//			return "redirect:/imageForm";
//		}
//		// db 테이블에 회원이미지 업데이트
//		String id = multi.getParameter("id");
//		String newProfile = "";
//		File file = multi.getFile("profile");
//		if(file != null) {	// 업로드가 된 상태(.png .jpg .gif)
//			// 이미지파일인지 체크 -> 이미지 파일이 아니면 삭제
//			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1);
//			ext = ext.toUpperCase();	// PNG, JPG, GIF, JPEG
//			if(ext.equals("PNG") || ext.equals("JPG") || ext.equals("GIF") || ext.equals("JPEG")){
//				// 새로 업로드 된 이미지(new), 현재 DB에 있는 이미지(old)
//				String oldProfile = memberRepository.getMember(id).getProfile();
//				File oldFile  = new File(savePath + "/" + oldProfile);
//				if(oldFile.exists()) {
//					oldFile.delete();
//				}
//				newProfile = file.getName();
//			} else {	// 이미지 파일이 아니면
//				if(file.exists()) {
//					file.delete();	// 삭제
//				}
//				rttr.addFlashAttribute("msgType", "실패 메세지");
//				rttr.addFlashAttribute("msg", "이미지파일만 업로드가능합니다.");
//				return "redirect:/imageForm";
//			}
//		}
//		// 새로운 이미지를 테이블에 업데이트
//		MemberVO mvo = new MemberVO();
//		mvo.setId(id);
//		mvo.setProfile(newProfile);
//		memberRepository.profileUpdate(mvo);	// 이미지 업데이트 성공
//		MemberVO m = memberRepository.getMember(id);
//		// 세션을 새롭게 생성
//		session.setAttribute("mvo", m);
//		rttr.addFlashAttribute("msgType", "성공 메세지");
//		rttr.addFlashAttribute("msg", "이미지가 변경되었습니다.");
//		return "redirect:/";
//	}
	
	// 회원 사진 업로드(upload폴더, DB저장) 
	@PostMapping("/imageUpdate")
	public String memImageUpdate (MemberVO vo, @RequestParam("attachFile") MultipartFile multipartFile,
			RedirectAttributes rttr) throws IOException {
		
		if(!multipartFile.isEmpty()) { //첨부파일이 있을대
			String fileName = multipartFile.getOriginalFilename();
			vo.setProfile(fileName);
			//파일타입결정 : img파일, other
			if(multipartFile.getContentType().startsWith("image")) { //이미지 파일 일때
				vo.setFileType(com.jafa.domain.MemberVO.FileType.IMAGE);
			}else {//아닐때
				vo.setFileType(com.jafa.domain.MemberVO.FileType.OTHER);
			}
			memberRepository.profileUpdate(vo);//데이터베이스에 저장
			//업로드
			// ex) /file01_repo/1/벵갈호랑이.png
			File uploadPath = new File("c:/file01_spring/"+vo.getId());
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
			memberRepository.profileUpdate(vo);//데이터베이스에 저장
		}
		return "redirect:/main";
	}
	
	@GetMapping("/memInfo")
	public String memInfo(@ModelAttribute("cri") Criteria criteria,
			Model model) {
		model.addAttribute("memInfo", memberRepository.getMemberInfo(criteria))
		.addAttribute("p", new Pagination(criteria, memberRepository.getTotalCount(criteria)));
		return "member/memInfo";
	}

}
