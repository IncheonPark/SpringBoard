package ino.web.freeBoard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;
import ino.web.freeBoard.util.FreeBoardPagination;

@Controller
public class FreeBoardController {
	
	@Autowired
	private FreeBoardService freeBoardService;
	
	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request, @RequestParam(defaultValue ="") String select
													   , @RequestParam(defaultValue ="") String search
													   , @RequestParam(defaultValue ="1") int curPageNum
													   , @RequestParam(defaultValue ="") String startDate
													   , @RequestParam(defaultValue ="") String endDate
													   ){
		System.out.println("select:" + select + " search: " + search + " curPageNum : " + curPageNum 
				+ " startDate : " + startDate + " endDate : " + endDate);
		
		ModelAndView mav = new ModelAndView();
		Map<String,Object> map = new HashMap<String,Object>();
		
		String startD = startDate;
		String endD = endDate;
		
		//builder쓸 필요 없이 임시 변수 하나 만들어서 map에 먼저 넣은 다음 나중에 덮어 씌우면 된다. GG
		//startDate = startDate.replaceAll("-", "");
		//endDate = endDate.replaceAll("-", "");
		
		map.put("select", select);//DCODE_PK1
		map.put("search", search);
		map.put("startDate", startD.replaceAll("-", ""));
		map.put("endDate", endD.replaceAll("-", ""));
		int totalList = freeBoardService.freeBoardCount(map);
		
		FreeBoardPagination pagination = new FreeBoardPagination(curPageNum, totalList);
		map.put("startIndex", pagination.getStartIndexNum());
		map.put("PAGE_SIZE", FreeBoardPagination.PAGE_SIZE);
		map.put("curPageNum", curPageNum);
		
		List<FreeBoardDto> list = freeBoardService.freeBoardList(map);

		map.put("mcode_pk", "CODE_PK1");
		List<HashMap<String,Object>> commonList1 = freeBoardService.freeBoardCommon(map);
		
		map.put("mcode_pk", "CODE_PK2");
		List<HashMap<String,Object>> commonList2 = freeBoardService.freeBoardCommon(map);
		System.out.println("commonList2 : "+commonList2);
		
		/*StringBuilder buildStartDate = new StringBuilder(startDate);
		StringBuilder buildEndDate = new StringBuilder(endDate);
		
		if (!startDate.equals("") && !endDate.equals("")) {
			buildStartDate.insert(4, "-");	buildStartDate.insert(7, "-");
			buildEndDate.insert(4, "-");	buildEndDate.insert(7, "-");
		}*/
		
		// 주석을 하나 추가함 
		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		mav.addObject("search",search);
		mav.addObject("select", select);
		mav.addObject("startDate", startDate);
		mav.addObject("endDate", endDate);
		mav.addObject("freeBoardPagination", pagination);
		mav.addObject("PAGE_SIZE", FreeBoardPagination.PAGE_SIZE);
		mav.addObject("commonList1",commonList1);
		mav.addObject("commonList2",commonList2);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/mainAjax.ino")
	public Map<String, Object> mainAjax(HttpServletRequest request, 
							@RequestParam(defaultValue = "", required = false) String select, 
							@RequestParam(defaultValue = "", required = false) String search,
							@RequestParam(defaultValue = "1", required = false) int curPageNum,
							@RequestParam(defaultValue ="", required = false) String startDate,
							@RequestParam(defaultValue ="", required = false) String endDate ) {

		System.out.println("select:" + select + " search: " + search + " curPageNum : " + curPageNum 
				+ " startDate : " + startDate + " endDate : " + endDate);
		//int iCurPageNum = Integer.parseInt(curPageNum);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String startDateD = startDate.replaceAll("-", "");
		String endDateD = endDate.replaceAll("-", "");
		
		map.put("select", select);
		map.put("search", search);
		map.put("startDate", startDateD);
		map.put("endDate", endDateD);
		int totalList = freeBoardService.freeBoardCount(map);
		
		FreeBoardPagination pagination = new FreeBoardPagination(curPageNum, totalList);
		map.put("startIndex", pagination.getStartIndexNum());
		map.put("PAGE_SIZE", FreeBoardPagination.PAGE_SIZE);
		map.put("curPageNum", curPageNum);
		
		List<FreeBoardDto> list = freeBoardService.freeBoardList(map);
		map.put("freeBoardPagination", pagination); 
		map.put("freeBoardList", list); 
		
		//map안에 select, search, list, startIndex, PAGE_SIZE, pagination 여섯 객체가 들어있다.
		
		/*StringBuilder buildStartDate = new StringBuilder(startDate);
		StringBuilder buildEndDate = new StringBuilder(endDate);
		
		if (!startDate.equals("") && !endDate.equals("")) {
			buildStartDate.insert(4, "-");	buildStartDate.insert(7, "-");
			buildEndDate.insert(4, "-");	buildEndDate.insert(7, "-");
		}*/
		
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		return map;
	}
	
	@RequestMapping("/freeBoardInsert.ino")
	/*public String freeBoardInsert(){
		return "freeBoardInsert";
	}*/
	public ModelAndView freeBoardInsert() {
		ModelAndView mav = new ModelAndView();
		FreeBoardDto dto = new FreeBoardDto();
		mav.setViewName("freeBoardInsert");
		mav.addObject("freeBoardDto",dto);
		return mav;
	}
	
	@RequestMapping("/freeBoardInsertPro.ino")
	public String freeBoardInsertPro(HttpServletRequest request, 
			FreeBoardDto dto) throws Exception {
		
		freeBoardService.freeBoardInsertPro(dto);
		
		 //insertPro 실행 후 Detail에 ?쿼리값 리다이렉트.
		return "redirect:freeBoardDetail.ino?num="+freeBoardService.getNewNum();
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardInsertAjax.ino")
	public Map<String, Object> freeBoardInsertAjax(HttpServletRequest request, 
			@RequestParam(required = false) String name,
			@RequestParam(required = false) String title,
			@RequestParam(required = false) String content) throws Exception {
		
		System.out.println("tests: "+name+"tests: "+title+"tests: "+content);
		FreeBoardDto dto = new FreeBoardDto();
		dto.setName(name); dto.setTitle(title); dto.setContent(content); //오류 테스트용 주석처리 위치
		
		Map<String, Object> map = new HashMap<String, Object>();
		int judge =0;
		try {
			judge = freeBoardService.freeBoardInsertPro(dto);
			
			if(judge > 0) {
				map.put("judge", true);
			}
			else {
				map.put("judge", false);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("judge", false);
			return map;
		}
		
		return map;
		
	}
	
	@RequestMapping("/freeBoardDetail.ino") //select 기능
	public ModelAndView freeBoardDetail(HttpServletRequest request){
		 //freeBoardDetailByNum구현
		ModelAndView mav = new ModelAndView();
		FreeBoardDto dto = freeBoardService.getDetailByNum(Integer.parseInt(request.getParameter("num")));
		mav.setViewName("freeBoardDetail");
		mav.addObject("freeBoardDto", dto);
		return mav;
	}
	
	@RequestMapping("/freeBoardModify.ino")
	public ModelAndView freeBoardModify(
			HttpServletRequest request, FreeBoardDto dto, Errors errors) throws Exception {
		ModelAndView mav = new ModelAndView();

		//service Modify 구현
		freeBoardService.freeBoardModify(dto);
		Map<String, Object> map = new HashMap<String, Object>();
		//map 객체가 비어있다.
		List<FreeBoardDto> list = freeBoardService.freeBoardList(map);
		
		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardModifyAjax.ino")
	public Map<String, Object> freeBoardModifyAjax(HttpServletRequest request, 
					@RequestParam(required = false) String num,
					@RequestParam(required = false) String title,
					@RequestParam(required = false) String content) throws Exception {
		System.out.println("tests: "+title+"tests: "+content);
		//service Modify 구현
		FreeBoardDto dto = new FreeBoardDto();
		Map<String, Object> map = new HashMap<String, Object>();
		dto.setNum(Integer.parseInt(num)); dto.setTitle(title); dto.setContent(content); //오류 테스트용 주석처리 위치
		int judgement;
		try {
			judgement = freeBoardService.freeBoardModify(dto);
			if (judgement > 0) {
				map.put("judgement", true);
			} else {
				map.put("judgement", false);
			}
		} catch(Exception e) {
			e.printStackTrace();
			map.put("judgement", false);
			return map;
		}
		
		return map;

	}
	
	@RequestMapping("/freeBoardDelete.ino")
	public String freeBoardDelete(int num) throws Exception {
		// service freeBoardDelete 구현
		freeBoardService.freeBoardDelete(num);
		return "redirect:/main.ino";
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardDeleteAjax.ino")
	public Map<String, Object> freeBoardDeleteAjax(
			@RequestParam(required = false) int num) throws Exception { //파라미터 수정필요
		// service freeBoardDelete 구현
		System.out.println("tests :"+num);
		Map<String, Object> map = new HashMap<String, Object>();
		int judgement;
		try {
			judgement = freeBoardService.freeBoardDelete(num);
			if (judgement > 0) {
				map.put("judgement", true);
			} else {
				map.put("judgement", false);
			}
		} catch(Exception e) {
			map.put("judgement", false);
			return map;
		}
		
		return map;
	}
}