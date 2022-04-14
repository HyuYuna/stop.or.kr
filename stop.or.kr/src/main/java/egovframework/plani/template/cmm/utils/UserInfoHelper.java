package egovframework.plani.template.cmm.utils;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;

public class UserInfoHelper {

  /**
   * 로그인 회원정보
   * 
   * @return
   */
  public static MemberVO getLoginData() {
    HttpServletRequest request =
        ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    MemberVO memberVO = new MemberVO();
    try {
      if (EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO") != null) {
        memberVO = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return memberVO;
  }

  /**
   * 로그인 체크
   */
  public static boolean isLogin() {
    MemberVO memberVO = getLoginData();
    // 로그아웃후 세션 정보가 없는 경우 체크
    if (memberVO.getUser_id() != null && memberVO.getUser_auth_lv() <= 10000) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 관리자 로그인 체크
   * 
   * @return
   */
  public static boolean isAdmin() {
    MemberVO memberVO = getLoginData();
    // 로그아웃후 세션 정보가 없는 경우 체크
    if (memberVO.getUser_id() != null && memberVO.getUser_auth_lv() <= 100) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 관리자 체크
   * 
   * @throws Exception
   */
  public static void adminCheck() throws Exception {
    if (isAdmin() == false) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES"));
    }
  }

  /**
   * 로그인 세션 처리
   * 
   * @param request
   * @param memberVO
   * @throws Exception
   */
  public static void setSessionValues(HttpServletRequest request, MemberVO memberVO)
      throws Exception {
    EgovSessionCookieUtil.setSessionInvalidate(request);

    // ///////////////////////////////////////////////////////
    // 로그인 당시의 환경을 저장한다.
    // 현재의 환경이 로그인 당시의 환경과 비교하여 다를경우
    // 세션ID 변조에 의한 로그인권한 획득시도로 보고 처리한다.
    // (세션아이디, IP주소, OS, 브라우저 중 하나라도 다르면 안됨)
    // 2015.11.23 bhhan
    String loginsess_id = EgovSessionCookieUtil.getSessionID(request);
    // 세션을 invalidate 한 뒤에는 세션아이디가 새로 발급되므로 세션으로부터 아이디를 직접 받아서 저장해야한다.
    String loginsess_ip = request.getRemoteAddr();
    String loginsess_os = EgovWebUtil.getRemoteOS(request);
    String loginsess_bw = EgovWebUtil.getRemoteBrowser(request);
    memberVO.setLoginsess_id(loginsess_id);
    memberVO.setLoginsess_ip(loginsess_ip);
    memberVO.setLoginsess_os(loginsess_os);
    memberVO.setLoginsess_bw(loginsess_bw);
    // 로그인 당시의 환경을 저장한다.
    // ///////////////////////////////////////////////////////

    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_INFO", memberVO);
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_ID", memberVO.getUser_id());
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_NM", memberVO.getUser_nm());
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_LAST_LOGIN",
        memberVO.getLast_login());
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_LAST_LOGOUT",
        memberVO.getLast_logout());
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_AUTH", memberVO.getUser_auth_cd());
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_LV", memberVO.getUser_auth_lv());

    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_PRJTNM",
        EgovProperties.getProperty("Globals.prjtnm"));
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_JAVAPRJT",
        EgovProperties.getProperty("Globals.javaprjt"));
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_WORKSPACE",
        EgovProperties.getProperty("Globals.workspacePath"));
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_COPYRIGHT",
        EgovProperties.getProperty("Globals.copyright"));
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_PROP_UPLOADDIR",
        EgovProperties.GLOBALS_FILEUPLOAD_PATH);
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_STAT_KEY",
        EgovWebUtil.generateIDString("", 64));
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_MANMENU_AUTH", new HashMap());
    EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_MAIN_MENU");
    EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_WOMEN_MENU");
    EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_MBL_MENU");
  }

  /**
   * 로그아웃 처리
   * 
   * @param request
   * @throws Exception
   */
  public static void removeSessionValues(HttpServletRequest request) throws Exception {
    EgovSessionCookieUtil.setSessionInvalidate(request);
  }
}
