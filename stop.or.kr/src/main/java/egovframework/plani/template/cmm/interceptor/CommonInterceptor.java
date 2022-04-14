package egovframework.plani.template.cmm.interceptor;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.exceptions.XSSException;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.RequestParameterHelper;
import egovframework.plani.template.cmm.utils.UserInfoHelper;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

/**
 * Validation 에서 참조할 post 값 처리 (2018-05-30)
 * 
 * @author pigcos
 *
 */
public class CommonInterceptor extends HandlerInterceptorAdapter {

  /** XSS 화이트 리스트 */
  private List<String> urlWhiteList = new ArrayList<String>();
  {
    urlWhiteList.add("/svcmem/siteLogin.do");
  };

  private String[] pattern = {"<script>(.*?)</script>", "src[\r\n]*=[\r\n]*\\\'(.*?)\\\'",
      "src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", "</script>", "<script(.*?)>", "eval\\((.*?)\\)",
      "expression\\((.*?)\\)", "javascript:", "vbscript:", "onload(.*?)="};

  private List<String> pattern2 = new ArrayList<String>();
  {
    pattern2.add("(?i)<.*?script.*?>.*?</.*?>");
    pattern2.add("(?i)<.*?script.*?\\s+.*?/script.*?>");
    pattern2.add("(?i)<.*?javascript:.*?>.*?</.*?>");
    pattern2.add("(?i)<.*?\\s+on.*?>.*?</.*?>");
    pattern2.add("(?i)<object.*?>.*?</object.*?>");
    pattern2.add("(?i)<.*?object:.*?>.*?</.*?>");
    pattern2.add("(?i)<applet.*?>.*?</applet.*?>");
    pattern2.add("(?i)<.*?applet:.*?>.*?</.*?>");
    pattern2.add("(?i)<embed.*?>.*?</embed.*?>");
    pattern2.add("(?i)<.*?embed:.*?>.*?</.*?>");
    pattern2.add("(?i)<form.*?>.*?</form.*?>");
    pattern2.add("(?i)<.*?form:.*?>.*?</.*?>");
    pattern2.add("(?i)<.*?\\f+on.*?>.*?</.*?>");

    pattern2.add("(?i)onabort");
    pattern2.add("(?i)onactivate");
    pattern2.add("(?i)onafterprint");
    pattern2.add("(?i)onafterupdate");
    pattern2.add("(?i)onbeforeactivate");
    pattern2.add("(?i)onbeforecopy");
    pattern2.add("(?i)onbeforecut");
    pattern2.add("(?i)onbeforedeactivate");
    pattern2.add("(?i)onbeforeeditfocus");
    pattern2.add("(?i)onbeforepaste");
    pattern2.add("(?i)onbeforeprint");
    pattern2.add("(?i)onbeforeunload");
    pattern2.add("(?i)onbeforeupdate");
    pattern2.add("(?i)onblur");
    pattern2.add("(?i)onbounce");
    pattern2.add("(?i)oncellchange");
    pattern2.add("(?i)onchange");
    pattern2.add("(?i)onclick");
    pattern2.add("(?i)oncontextmenu");
    pattern2.add("(?i)oncontrolselect");
    pattern2.add("(?i)oncopy");
    pattern2.add("(?i)oncut");
    pattern2.add("(?i)ondataavailable");
    pattern2.add("(?i)ondatasetchanged");
    pattern2.add("(?i)ondatasetcomplete");
    pattern2.add("(?i)ondblclick");
    pattern2.add("(?i)ondeactivate");
    pattern2.add("(?i)ondrag");
    pattern2.add("(?i)ondragend");
    pattern2.add("(?i)ondragenter");
    pattern2.add("(?i)ondragleave");
    pattern2.add("(?i)ondragover");
    pattern2.add("(?i)ondragstart");
    pattern2.add("(?i)ondrop");
    pattern2.add("(?i)onerror");
    pattern2.add("(?i)onerrorupdate");
    pattern2.add("(?i)onfilterchange");
    pattern2.add("(?i)onfinish");
    pattern2.add("(?i)onfocus");
    pattern2.add("(?i)onfocusin");
    pattern2.add("(?i)onfocusout");
    pattern2.add("(?i)onhelp");
    pattern2.add("(?i)onkeydown");
    pattern2.add("(?i)onkeypress");
    pattern2.add("(?i)onkeyup");
    pattern2.add("(?i)onlayoutcomplete");
    pattern2.add("(?i)onload");
    pattern2.add("(?i)onlosecapture");
    pattern2.add("(?i)onmousedown");
    pattern2.add("(?i)onmouseenter");
    pattern2.add("(?i)onmouseleave");
    pattern2.add("(?i)onmousemove");
    pattern2.add("(?i)onmouseout");
    pattern2.add("(?i)onmouseover");
    pattern2.add("(?i)onmouseup");
    pattern2.add("(?i)onmousewheel");
    pattern2.add("(?i)onmove");
    pattern2.add("(?i)onmoveend");
    pattern2.add("(?i)onmovestart");
    pattern2.add("(?i)onpaste");
    pattern2.add("(?i)onpropertychange");
    pattern2.add("(?i)onreadystatechange");
    pattern2.add("(?i)onreset");
    pattern2.add("(?i)onresize");
    pattern2.add("(?i)onresizeend");
    pattern2.add("(?i)onresizestart");
    pattern2.add("(?i)onrowenter");
    pattern2.add("(?i)onrowexit");
    pattern2.add("(?i)onrowsdelete");
    pattern2.add("(?i)onrowsinserted");
    pattern2.add("(?i)onscroll");
    pattern2.add("(?i)onselect");
    pattern2.add("(?i)onselectionchange");
    pattern2.add("(?i)onselectstart");
    pattern2.add("(?i)onstart");
    pattern2.add("(?i)onstop");
    pattern2.add("(?i)onsubmit");
    pattern2.add("(?i)onunload");

    // xss 추가 pigcos : 2018-08-29
    pattern2.add("(?i)alert");
    pattern2.add("(?i)href");
    pattern2.add("(?i)iframe");
    pattern2.add("(?i)src");

  };

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws Exception {



    String url = request.getRequestURI().toString();
    String contextPath = request.getContextPath();

    // 파일 확장자 구하기
    String file_ext = url.substring(url.lastIndexOf(".") + 1, url.length());
    file_ext = file_ext.toLowerCase();

    // url중 .do 인 경우에만 체크?
    if (file_ext.equals("do") == false) {
      return super.preHandle(request, response, handler);
    }

    // System.out.println("url : " + url);
    // System.out.println("contextpath : " + contextPath);

    // 화이트 리스트 URL인 경우 검사하지 않음.
    boolean checkWhiteList = false;

    if (UserInfoHelper.isAdmin() == true) {
      checkWhiteList = true;
    } else {
      for (String whiteList : urlWhiteList) {
        if (url.equals(contextPath + whiteList) == true) {
          checkWhiteList = true;
          break;
        }
      }
    }

    if (checkWhiteList == false) {
      // XSS 체크
      Enumeration<String> names = request.getParameterNames();
      while (names.hasMoreElements()) {
        String a = names.nextElement();
        String value = request.getParameter(a);
        // avoid encoded attacks.
        // value = ESAPI.encoder().canonicalize(value);
        if (isXSSValidInput(value) == false) {
          String message = MessageHelper.getMessage("IT-CONTAINS-AN-UNACCEPTABLE-STRING");
          System.out.println("XSS(CommonInterceptor.java) : " + a + " -> " + value);
          String requestedWithHeader = request.getHeader("X-Requested-With");
          if ("XMLHttpRequest".equals(requestedWithHeader)) {
            throw new XSSException(message, a);
          } else {
            throw new CmmnException(message);
          }
        }
      }
    }

    // Validation 참조용
    if (request.getMethod() == "POST") {
      String uri = request.getRequestURI();
      // System.out.println(" Request URI \t: " + uri);
      Map<String, Object> data = new HashMap<>();
      // System.out.println(request.getMethod());
      Enumeration<String> paramNames = request.getParameterNames();
      while (paramNames.hasMoreElements()) {
        String key = paramNames.nextElement();
        String value = request.getParameter(key);
        // System.out.println(" RequestParameter Data ==> " + key + " : " + value + "");
        String[] values = request.getParameterValues(key);
        if (values.length > 0) {
          // for (int i = 0; i < values.length; i++) {
          // System.out.println(" RequestParameter Data ==> " + key + " : " + values[i] + "");
          // }
          data.put(key, values);
        }
      }
      // 업로드 파일이 있는 경우 실제 업로드 파일명 저장
      boolean isMultipart = ServletFileUpload.isMultipartContent(request);
      if (isMultipart == true) {
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; //
        // 다중파일
        Iterator<String> multipartParamNames = multipartRequest.getFileNames();

        while (multipartParamNames.hasNext()) {
          String key = multipartParamNames.next();
          List<MultipartFile> files = multipartRequest.getFiles(key);

          // System.out.println("key : " + key);
          // System.out.println("files : " + files.size());

          data.put(key, files);
          // String[] values = new String[files.size()];
          // for (int i = 0; i < files.size(); i++) {
          // values[i] = files.get(i).getOriginalFilename();
          // // System.out.println("multi : " + files.get(i).getOriginalFilename());
          // }
          // data.put(key, values);
          // // System.out.println("multi : " + files.get(0).getOriginalFilename());
        }
      }

      RequestParameterHelper.setParamter(request, uri, data);
    }
    return super.preHandle(request, response, handler);
  }

  /**
   * XSS Valid input
   * 
   * @param value
   * @return
   */
  private boolean isXSSValidInput(String value) {
    if (value != null) {
      value = value.replaceAll("", "");
      for (String ptn : pattern) {
        Pattern scriptPattern =
            Pattern.compile(ptn, Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
        if (scriptPattern.matcher(value).find()) {
          return false;
        }
      }
      for (String ptn : pattern2) {
        Pattern scriptPattern =
            Pattern.compile(ptn, Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
        if (scriptPattern.matcher(value).find()) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }

  /**
   * do 페이지 체크
   * 
   * @param request
   * @return
   */
  private boolean checkDoPage(HttpServletRequest request) {
    String url = request.getRequestURI().toString();
    // 파일 확장자 구하기
    String file_ext = url.substring(url.lastIndexOf(".") + 1, url.length());
    file_ext = file_ext.toLowerCase();
    // url중 .do 인 경우에만 체크?
    if (file_ext.equals("do") == false) {
      return true;
    } else {
      return false;
    }
  }

  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
      ModelAndView modelAndView) throws Exception {

    if (checkDoPage(request) == true) {
      return;
    }

    // TODO : sitePagestatWrite.do 페이지 통계 제외??
    // System.out.println("post handle url : " + request.getRequestURI());
    String srchMenuNix = request.getParameter("srch_menu_nix");
    if (StringUtils.isEmpty(srchMenuNix) == false) {
      SysmenuVO menuVO = new SysmenuVO();
      menuVO.setSrch_menu_nix(srchMenuNix);
      menuVO = sysmenuService.selectSysmenu(menuVO);
      // System.out.println(menuVO);
      if (modelAndView != null && StringUtils.isEmpty(menuVO.getMenu_idx()) == false) {
        modelAndView.addObject("nowMenuVO", menuVO);
      }
    }
  }

}
