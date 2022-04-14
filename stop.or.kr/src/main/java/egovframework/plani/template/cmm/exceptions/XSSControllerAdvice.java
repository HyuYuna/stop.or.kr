package egovframework.plani.template.cmm.exceptions;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;

@ControllerAdvice
public class XSSControllerAdvice {

  @ExceptionHandler(XSSException.class)
  @ResponseBody
  public Object handleXSSException(XSSException se) {
    ResponseResultHelper responseResultHelper = new ResponseResultHelper();
    return responseResultHelper.setAjaxResultVO(true,
        responseResultHelper.getMessages(se.getField(), se.getMessage()), null, null);
  }
}
