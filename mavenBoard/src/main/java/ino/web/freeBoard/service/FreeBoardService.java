package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ino.web.freeBoard.dto.FreeBoardDto;


@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<FreeBoardDto> freeBoardList(Map<String, Object> map){
			
		return sqlSessionTemplate.selectList("freeBoardGetList", map);
	}
	
	public List<HashMap<String, Object>> freeBoardCommon(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("freeBoardGetCommonList", map);
	}
	
	public int freeBoardCount(Map<String, Object> map) {
		int count;
		count = sqlSessionTemplate.selectOne("freeBoardCount", map);
		return count;
	}
	
	public int freeBoardInsertPro(FreeBoardDto dto) throws Exception {
		int judge;
		judge = sqlSessionTemplate.insert("freeBoardInsertPro",dto);
		return judge;
	}
	
	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}
	
	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}
	
	public int freeBoardModify(FreeBoardDto dto) throws Exception {
		int judge;
		judge = sqlSessionTemplate.update("freeBoardModify", dto);
		return judge;
	}

	public int freeBoardDelete (int num) throws Exception {
		int judge;
		judge = sqlSessionTemplate.delete("freeBoardDelete", num ); //오류 테스트용 주석처리 위치 num
		return judge;
		
	}
	
}
