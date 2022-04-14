package egovframework.plani.template.cmm.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.vo.AjaxResultVO;

/**
 * Response 요청시 응답 처리(2018-05-18)
 * 
 * @author pigcos
 *
 */
public class ResponseResultHelper {

  private HttpServletRequest request;
  private String view;

  /**
   * Construct
   * 
   * @param request
   * @param view
   */
  public ResponseResultHelper(HttpServletRequest request, String view) {
    this.request = request;
    this.view = view;
  }

  public ResponseResultHelper() {}

  /**
   * 뷰 경로변경
   * 
   * @param view
   */
  public void setView(String view) {
    this.view = view;
  }

  /**
   * Ajax Check
   * 
   * @return
   */
  private boolean isAjax() {
    String requestedWithHeader = request.getHeader("X-Requested-With");
    return "XMLHttpRequest".equals(requestedWithHeader);
  }

  /**
   * AjaxResult 공통 값 셋팅
   * 
   * @param isError
   * @param messages
   * @param url
   * @param data
   * @return
   */
  public AjaxResultVO setAjaxResultVO(boolean isError, Object messages, String url, Object data) {
    AjaxResultVO ajaxResultVO = new AjaxResultVO();
    ajaxResultVO.setError(isError);
    if (url != null) {
      ServletRequestAttributes attr =
          (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
      String contextPath = attr.getRequest().getContextPath();
      url = url.replaceAll("^" + contextPath, ""); // contextPath 제거
      url = contextPath + url;
    }
    if (messages != null)
      ajaxResultVO.setMessages(messages);
    if (url != null)
      ajaxResultVO.setUrl(url);
    if (data != null)
      ajaxResultVO.setData(data);
    return ajaxResultVO;
  }

  /**
   * Validiation 에러처리 : ajax요청인경우 AjaxResultVO, 일반요청인경우 ModelAndView
   * 
   * @param result
   * @return
   */
  public Object validation(BindingResult result) {
    validateSessionReset();
    if (isAjax() == true) {
      List<ObjectError> errors = result.getAllErrors();
      Map<String, ArrayList<String>> messages = new HashMap<>();
      for (int i = 0; i < errors.size(); i++) {
        FieldError error = (FieldError) errors.get(i);
        String key = error.getField();
        if (messages.containsKey(key) == true) {
          messages.get(key).add(getErrorMessage(error));
        } else {
          ArrayList<String> data = new ArrayList<>();
          data.add(getErrorMessage(error));
          messages.put(key, data);
        }
      }
      // System.out.println("error : " + messages);
      // FieldError error = (FieldError) errors.get(0);
      // return setAjaxResultVO(true, error.getField(), getErrorMessage(error), null, null);
      return setAjaxResultVO(true, messages, null, null);
    } else {
      ModelAndView modelAndView = new ModelAndView(view);
      return modelAndView;
    }
  }

  /**
   * 에러 코드별 메세지 가져오기
   * 
   * @param error
   * @return
   */
  private String getErrorMessage(FieldError error) {
    String[] codes = error.getCodes();
    for (int i = 0; i < codes.length; i++) {
      String message = MessageHelper.getMessage(codes[i]);
      if (message != null && message.equals("") == false
          && message.equals(MessageHelper.getLocale()) == false) {
        return MessageHelper.getMessage(codes[i]);
      }
    }
    return error.getDefaultMessage();
  }

  /**
   * 에러메세지 만들기
   * 
   * @param field
   * @param message
   * @return
   */
  public Object getMessages(String field, String message) {
    if (field != null && field.equals("") == false) {
      Map<String, ArrayList<String>> messages = new HashMap<>();
      ArrayList<String> data = new ArrayList<>();
      data.add(message);
      messages.put(field, data);
      return messages;
    } else {
      String messages = message;
      return messages;
    }
  }

  /**
   * error
   * 
   * @param isError
   * @param field
   * @param message
   * @param url
   * @return
   */
  public Object error(String field, String message, String url, Object data) throws Exception {
    validateSessionReset();
    if (isAjax() == true) {
      return setAjaxResultVO(true, getMessages(field, message), url, data);
    } else {
      throw new CmmnException(message);
      // throw new AjaxException(message);
    }
  }

  /**
   * error method override
   * 
   * @param field
   * @param message
   * @param url
   * @return
   * @throws Exception
   */
  public Object error(String field, String message, String url) throws Exception {
    return error(field, message, url, null);
  }

  /**
   * error method override
   * 
   * @param field
   * @param message
   * @return
   * @throws Exception
   */
  public Object error(String field, String message) throws Exception {
    return error(field, message, null, null);
  }


  /**
   * success
   * 
   * @param field
   * @param message
   * @param url
   * @return
   */
  public Object success(String field, String message, String url, Object data) {
    validateSessionReset();
    if (isAjax() == true) {
      return setAjaxResultVO(false, getMessages(field, message), url, data);
    } else {
      url = (url == null) ? "/" : url;
      // System.out.println("url : " + url);
      if (url != null) { // contextPath 제거
        ServletRequestAttributes attr =
            (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        String contextPath = attr.getRequest().getContextPath();
        url = url.replaceAll("^" + contextPath, ""); // contextPath 제거
        // url = contextPath + url;
      }
      System.out.println("url : " + url);
      ModelAndView modelAndView = new ModelAndView("redirect:" + url);
      return modelAndView;
    }
  }

  /**
   * success method override
   * 
   * @param field
   * @param message
   * @param url
   * @return
   */
  public Object success(String field, String message, String url) {
    return success(field, message, url, null);
  }

  /**
   * success method override
   * 
   * @param field
   * @param message
   * @return
   */
  public Object success(String field, String message) {
    return success(field, message, null, null);
  }

  /**
   * success method override
   * 
   * @return
   */
  public Object success() {
    return success(null, null, null, null);
  }

  /**
   * validation session data reset
   */
  private void validateSessionReset() {
    try {
      String url = request.getRequestURI().toString();
      HttpServletRequest request =
          ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
      Map<String, Map<String, String[]>> session =
          (Map<String, Map<String, String[]>>) EgovSessionCookieUtil.getSessionAttribute(request,
              "SESS_VALIDATE_DATA");
      if (session != null) {
        session.remove(url);
        EgovSessionCookieUtil.setSessionAttribute(request, "SESS_VALIDATE_DATA", session);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}
