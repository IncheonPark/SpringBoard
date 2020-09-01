package ino.web.freeBoard.util;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import ino.web.freeBoard.dto.FreeBoardDto;

public class FreeBoardDtoValidator implements Validator {
	
	@Override
    public boolean supports(Class<?> dtoClass) {
        return FreeBoardDto.class.isAssignableFrom(dtoClass);
    }
	
	@Override
    public void validate(Object target, Errors errors) {
        FreeBoardDto dto = (FreeBoardDto) target;
        
        if(dto.getName() == null || dto.getName().trim().isEmpty()) {
            errors.rejectValue("name", "required", "이름을 입력해 주세요.");
            	
        } else if(dto.getName().length() < 2 || dto.getName().length() > 10) {
        	errors.rejectValue("name", "wronglength", "이름이 너무 짧거나 깁니다.");
        }
        
        if(dto.getTitle() == null || dto.getTitle().trim().isEmpty()) {
            errors.rejectValue("title", "required", "제목을 입력해 주세요.");
            
        } else if(dto.getTitle().length() < 2 || dto.getTitle().length() > 20) {
        	errors.rejectValue("title", "wronglength", "제목이 너무 짧거나 깁니다.");
        }
        
        if(dto.getContent() == null || dto.getContent().trim().isEmpty()) {
            errors.rejectValue("content", "required", "콘텐츠를 입력해 주세요.");
            
        } else if(dto.getContent().length() < 1 || dto.getContent().length() > 500) {
        	errors.rejectValue("content", "wronglength", "내용이 너무 짧거나 깁니다.");
        }
        
        
        
	}
}
