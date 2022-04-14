package egovframework.plani.template.cmm.interceptor;

import java.util.Iterator;
import java.util.Set;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;

/**
 * 인증여부 체크 인터셉터
 * 
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성 
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 * </pre>
 */


public class AuthenticInterceptor extends HandlerInterceptorAdapter {

  private Set<String> permittedURL;

  public void setPermittedURL(Set<String> permittedURL) {
    this.permittedURL = permittedURL;
  }

  private Set<String> managedURL;

  public void setManagedURL(Set<String> managedURL) {
    this.managedURL = managedURL;
  }

  /**
   * 요청 URL 가져오기. "//" 처럼 url의 경로 구분 문자값이 두번 쓰여질 때 정상 작동하지 않음 해결
   * 
   * @param request
   * @return
   */
  public String getRequestURI(HttpServletRequest request) {
    return request.getRequestURI().replaceAll("[/]{2,}", "/");
  }

  /**
   * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다. 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
   */
  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws Exception {

    String requestURI = this.getRequestURI(request);
    boolean isPermittedURL = false;
    boolean isManagedURL = false;


    if (requestURI.indexOf("JsonList.") >= 0 || requestURI.indexOf("mainmenuList.") >= 0
        || requestURI.indexOf("managemenuList.") >= 0 || requestURI.indexOf("leftmenuList.") >= 0
        || requestURI.indexOf("bannerList.") >= 0 || requestURI.indexOf("jcaptcha") >= 0
        || requestURI.indexOf("atchDirectImage.") >= 0 || requestURI.indexOf("siteLogin.") >= 0
        || requestURI.indexOf("metsysLogin.") >= 0 || requestURI.indexOf("metsysLoginProc.") >= 0
        || requestURI.indexOf("metsysLogout.") >= 0 || requestURI.indexOf("preCheckMember.") >= 0
        || requestURI.indexOf("contentsView.") >= 0) {
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_PRJTNM",
          EgovProperties.getProperty("Globals.prjtnm"));
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_COPYRIGHT",
          EgovProperties.getProperty("Globals.copyright"));

      return true;
    }


    EgovSessionCookieUtil.setSessionAttribute(request, "REFERER", request.getHeader("referer"));
    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");
    if ("".equals(srch_menu_nix) == false) {
      String mpatt = "^[a-zA-Z0-9]{8}$";
      if (Pattern.matches(mpatt, srch_menu_nix) == false)
        throw new CmmnException("필수 파라미터가 정상적인 값의 범위를 벗어납니다.");

      EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_MENU_NIX");
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_MENU_NIX", srch_menu_nix);
      EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_SNS_URL");
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_SNS_URL",
          request.getAttribute("javax.servlet.forward.request_uri") + "?"
              + request.getQueryString().replace("&", "&amp;"));
    }



    // 요청한 페이지가 관리자 메뉴인지 확인한다...
    for (Iterator<String> it = this.managedURL.iterator(); it.hasNext();) {
      String urlPattern = request.getContextPath() + it.next();

      if (Pattern.matches(urlPattern, requestURI)) {// 정규표현식을 이용해서 요청 URI가 허용된 URL에 맞는지 점검함.
        isManagedURL = true;
        break;
      }
    }


    MemberVO memberVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    // 로그인한 사용자인 경우
    if (memberVO != null && memberVO.getUser_auth_lv() < 9999) {
      // ///////////////////////////////////////////////////////
      // 현재의 환경을 가져와서 로그인 당시의 환경과 비교한다.
      String loginsess_id = request.getRequestedSessionId();
      String loginsess_ip = request.getRemoteAddr();
      String loginsess_os = EgovWebUtil.getRemoteOS(request);
      String loginsess_bw = EgovWebUtil.getRemoteBrowser(request);

      // 현재의 환경이 로그인 당시의 환경과 비교하여 다를경우
      // (세션아이디, IP주소, OS, 브라우저 중 하나라도 다르면 안됨)
      // 세션ID 변조에 의한 로그인 권한 획득시도로 보고 처리한다.
      // 2015.11.23 bhhan
      if ((loginsess_id.equals(memberVO.getLoginsess_id())
          && loginsess_ip.equals(memberVO.getLoginsess_ip())
          && loginsess_os.equals(memberVO.getLoginsess_os()) && loginsess_bw.equals(memberVO
          .getLoginsess_bw())) == false) {
        // 세션 변조에 의한 권한획득 시도이므로 (또는 비정상적인 요청)
        // 해당 세션을 강제 종료시킨다.
        EgovSessionCookieUtil.setSessionInvalidate(request);
        ModelAndView modelAndView = new ModelAndView("redirect:/svcmem/siteLogin.do");
        throw new ModelAndViewDefiningException(modelAndView);
      }

      // 현재의 환경을 가져와서 로그인 당시의 환경과 비교한다.
      // ///////////////////////////////////////////////////////

      // 관리자가 아닌경우 관리자 페이지를 들어갈 수 없다.
      if (isManagedURL) {
        // 관리자가 아닌경우 관리자페이지 에서 쫓아낸다.
        if (memberVO.getUser_auth_lv() > 100) {
          if (requestURI.indexOf("modeurScrtcheck.") >= 0)
            return true;

          ModelAndView modelAndView = new ModelAndView("redirect:/contents/siteMain.do");
          throw new ModelAndViewDefiningException(modelAndView);
        }

        // 관리자인 경우
        else {

          // 2018-07-17 pigcos : 주석처리..

          // HashMap menumap =
          // (HashMap) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MANMENU_AUTH");
          // if (menumap != null) {
          // if (requestURI.indexOf("metsysMain.") >= 0 || requestURI.indexOf("modeurList.") >= 0
          // || requestURI.indexOf("sysauthList.") >= 0
          // || requestURI.indexOf("modeurScrtcheck.") >= 0)
          // return true;
          //
          // if (srch_menu_nix.length() >= 8)
          // srch_menu_nix = srch_menu_nix.substring(0, 8);
          //
          // // 관리자라 하더라도 해당 메뉴의 사용권한이 세션에 등록되어 있지 않은 경우 쫓아낸다.
          // if (menumap.get(srch_menu_nix) == null) {
          // ModelAndView modelAndView = new ModelAndView("redirect:/contents/siteMain.do");
          // throw new ModelAndViewDefiningException(modelAndView);
          // }
          // }

        }
      }

      return true;

    }

    // 로그인하지 않은 사용자인 경우
    else {
      ModelAndView modelAndView = null;

      if (
      // 추가 / 삭제 / 수정은 비로그인 상태에서 허용하지 않는다.
      (requestURI.indexOf("add") >= 0 || requestURI.indexOf("rmv") >= 0 || requestURI
          .indexOf("mdf") >= 0) &&

      // 다음 액션들은 추가 / 수정 / 삭제 (add / rmv / mdf) 를 포함하고 있으나,
      // 비로그인 상태에서도 허용되어야 하므로 여기에 걸리지 않도록 처리한다.
          (requestURI.indexOf("addSrvydata") < 0 && requestURI.indexOf("addMember") < 0
              && requestURI.indexOf("Boardanonim") < 0 && requestURI.indexOf("Boardreply") < 0 && requestURI
              .indexOf("Mailuser") < 0)) {
        // 모바일 페이지인 경우
        if (requestURI.indexOf(".mdo") >= 0) {
          modelAndView = new ModelAndView("redirect:/contents/siteMain.mdo");
        }
        // 일반 페이지인 경우
        else {
          // 관리자 페이지 요청인 경우 관리자 로그인페이지로
          if (isManagedURL == true) {
            modelAndView = new ModelAndView("redirect:/metsys/metsysLogin.do");
          }
          // 관리자 페이지 요청이 아닌경우 사용자 로그인
          else {
            setReturnUrl(request);
            modelAndView = new ModelAndView("redirect:/svcmem/siteLogin.do");
          }
        }

        throw new ModelAndViewDefiningException(modelAndView);
      }

      // 추가 / 삭제 / 수정등의 기능이 아닌 페이지
      else {

        String sess_uid =
            (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
        if (sess_uid == null || "".equals(sess_uid)) {
          MemberVO tmpVO = new MemberVO();
          tmpVO.setUser_id("GUEST_" + EgovWebUtil.generateIDString("", 8));
          tmpVO.setUser_nm("GUEST");
          tmpVO.setUser_auth_cd("G0001");
          tmpVO.setUser_auth_lv(10002);

          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_ID", tmpVO.getUser_id());
          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_NM", tmpVO.getUser_nm());
          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_AUTH",
              tmpVO.getUser_auth_cd());
          EgovSessionCookieUtil
              .setSessionAttribute(request, "SESS_USR_LV", tmpVO.getUser_auth_lv());
          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_INFO", tmpVO);
          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_PRJTNM",
              EgovProperties.getProperty("Globals.prjtnm"));
          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_COPYRIGHT",
              EgovProperties.getProperty("Globals.copyright"));
          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_UPLOADDIR",
              EgovProperties.GLOBALS_FILEUPLOAD_PATH);
        }


        for (Iterator<String> it = this.permittedURL.iterator(); it.hasNext();) {
          String urlPattern = request.getContextPath() + it.next();

          if (Pattern.matches(urlPattern, requestURI)) {// 정규표현식을 이용해서 요청 URI가 허용된 URL에 맞는지 점검함.
            isPermittedURL = true;
            break;
          }
        }
        // 허용된 URL인 경우 통과
        if (isPermittedURL) {
          return true;
        } else {
          if (requestURI.indexOf(".mdo") >= 0) {
            modelAndView = new ModelAndView("redirect:/contents/siteLogin.mdo");
          } else {
            // 관리자 페이지 요청인 경우 관리자 로그인페이지로
            if (isManagedURL == true)
              modelAndView = new ModelAndView("redirect:/metsys/metsysLogin.do");
            // 관리자 페이지 요청이 아닌경우 사용자 로그인
            else {
              // 2018-06-29 pigcos : 정상 url이 아닌 경우 404 처리위해 return 처리
              return true;
              // setReturnUrl(request);
              // modelAndView = new ModelAndView("redirect:/svcmem/siteLogin.do?tgtact=01");
            }
          }

          throw new ModelAndViewDefiningException(modelAndView);
        }
      }
    }
  }

  /*******************************************************
   * 로그인 후 돌아올 페이지 설정 (원래 가려고 했던 페이지
   * 
   * @param request
   * @throws Exception
   *******************************************************/
  private void setReturnUrl(HttpServletRequest request) throws Exception {
    String return_url = this.getRequestURI(request) + "?" + request.getQueryString();
    EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_RETURN_URL");
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_RETURN_URL", return_url);
  }

}
