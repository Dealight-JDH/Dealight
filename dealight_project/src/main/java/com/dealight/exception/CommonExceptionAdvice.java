package com.dealight.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	   
//		@ExceptionHandler(Exception.class)
//		public String exception(Exception ex) {
//			log.error("Exception....."+ex.getMessage());
//			return "error_page";
//		}
	
		@ExceptionHandler(NoHandlerFoundException.class)
		@ResponseStatus(HttpStatus.NOT_FOUND)
		public String handler404(NoHandlerFoundException ex) {
			return "custom404";
		}
}
