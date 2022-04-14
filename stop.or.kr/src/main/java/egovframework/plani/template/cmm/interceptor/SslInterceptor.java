package egovframework.plani.template.cmm.interceptor;

import java.util.Iterator;
import java.util.Set;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 인증여부 체크 인터셉터
 * 
 * @author PLANI bhhan
 * @since 2013.04.22
 * @version 1.0
 * @see
 * 
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2013.04.22  bhhan      최초 생성
 * </pre>
 */


public class SslInterceptor extends HandlerInterceptorAdapter {

  private Set<String> sslURL;

  public void setSslURL(Set<String> sslURL) {
    this.sslURL = sslURL;
  }

  /**
   * SSL인증 여부를 체크한다. 보안접속이 필요한 URL의 경우 요청을 https:// 로 보낸다.
   */
  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws Exception {

    String requestURI = request.getRequestURI(); // 요청 URI
    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");
    boolean isSslURL = false;

    String serverName = request.getServerName();
    int port = request.getServerPort();
    StringBuffer reqURL = request.getRequestURL();

    // 로컬 테스트인경우 SSL인증 처리를 하지 않는다.
    if ("done.jdep.plani.co.kr".equals(serverName) || "localhost".equals(serverName.toLowerCase())
        || "192.168.0.140".equals(serverName) || "127.0.0.1".equals(serverName)) {
      return true;
    }

    // 페이지 내에서 ajax 처리되는 action은
    // 여기에 추가되어 있어야 한다.
    // https 에서 http 호출 => 에러; 실행안됨
    else if (requestURI.indexOf("mainmenuList") >= 0 || requestURI.indexOf("managemenuList") >= 0
        || requestURI.indexOf("leftmenuList") >= 0 || requestURI.indexOf("bannerList") >= 0
        || requestURI.indexOf("JsonList") >= 0 || requestURI.indexOf("imageAtchfile") >= 0
        || requestURI.indexOf("rmvAtchOnefile") >= 0
        || requestURI.indexOf("boardarticleListXML") >= 0 || requestURI.indexOf("chkBoardPwd") >= 0) {
      return true;
    }

    else {

      for (Iterator<String> it = this.sslURL.iterator(); it.hasNext();) {
        String urlPattern = request.getContextPath() + it.next();

        if (Pattern.matches(urlPattern, requestURI)) {// SSL URI 체크
          isSslURL = true;
          break;
        }
      }



      /****************************************************
       * 예외상황 적용 Start dispatch-servlet에 추가되어있지 않지만 특정 메뉴에서만 적용해야 하는 경우 또는 특정 메뉴에서만 적용하지 않아야 하는 경우를
       * 처리
       ****************************************************/
      /*
       * if(requestURI.indexOf("/menuctgry/mainmenuList") >= 0) {
       * if(srch_menu_nix.equals("5hp0jViS") || srch_menu_nix.equals("7b2667cg")) { String url =
       * "https://" + serverName + ((port == 80 || port == 443) ? "" : ":" + port) + requestURI; url
       * += (request.getQueryString() == null ? "" : "?" + request.getQueryString()); ModelAndView
       * modelAndView = new ModelAndView("redirect:" + url); throw new
       * ModelAndViewDefiningException(modelAndView); } }
       * 
       * // 관리자페이지 권한목록 조회 : 사용자정보 관리에서만 ssl처리 되어야 한다. else
       * if(requestURI.indexOf("/menuctgry/sysauthJsonList") >= 0 ||
       * requestURI.indexOf("/menuctgry/managemenuList") >= 0) { if(srch_menu_nix.equals("zumNR6AM")
       * || srch_menu_nix.equals("zumNR6AM_01")) { String url = "https://" + serverName + ((port ==
       * 80 || port == 443) ? "" : ":" + port) + requestURI; url += (request.getQueryString() ==
       * null ? "" : "?" + request.getQueryString()); ModelAndView modelAndView = new
       * ModelAndView("redirect:" + url); throw new ModelAndViewDefiningException(modelAndView); } }
       */

      /****************************************************
       * 예외상황 적용 End
       ****************************************************/

      // 현재 요청 URL이 https:// 가 아닌 경우
      if (reqURL.indexOf("https://") < 0) {
        // 보안접속이 필요한 URL
        if (isSslURL) {
          // String url = "https://" + serverName + ((port == 80 || port == 443) ? "" : ":" + port)
          // + requestURI;
          // String url = "https://" + serverName + (":444") + requestURI;
          // pigcos 2018-09-03 : www.stop.or.kr:444로 강제 redirection
          String url = "https://www.stop.or.kr" + requestURI;
          // ych 2018-09-05 : ssl 적용 안되게 변경해달라고 하셔서 http로 리다이렉트
          // String url = "http://www.stop.or.kr" + requestURI;
          url += (request.getQueryString() == null ? "" : "?" + request.getQueryString());
          ModelAndView modelAndView = new ModelAndView("redirect:" + url);
          throw new ModelAndViewDefiningException(modelAndView);
        }

        // 보안접속이 필요하지 않은 URL
        else
          return true;
      }

      // 현재 요청 URL이 https:// 인 경우
      else {
        // 보안접속이 필요한 URL
        if (isSslURL) {
          return true;
        }
        // 보안접속이 필요하지 않은 URL
        else {

          String url =
              "http://" + serverName + ((port == 80 || port == 443) ? "" : ":" + port) + requestURI;
          // String url = "http://" + serverName + (":") + requestURI;

          url += (request.getQueryString() == null ? "" : "?" + request.getQueryString());
          ModelAndView modelAndView = new ModelAndView("redirect:" + url);
          throw new ModelAndViewDefiningException(modelAndView);
        }
      }
    }

  }


}
