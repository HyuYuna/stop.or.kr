package egovframework.plani.template.cmm.utils;

import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

/**
 * 교차접속 스크립트 공격 취약성 방지(파라미터 문자열 교체)
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자           수정내용
 *  -------    	--------    ---------------------------
 *   2011.10.10  한성곤          최초 생성
 *
 * </pre>
 */

public class EgovWebUtil {
  public static String clearXSSMinimum(String value) {
    if (value == null || value.trim().equals("")) {
      return "";
    }

    String returnValue = value;

    returnValue = returnValue.replaceAll("&", "&amp;");
    returnValue = returnValue.replaceAll("<", "&lt;");
    returnValue = returnValue.replaceAll(">", "&gt;");
    returnValue = returnValue.replaceAll("\"", "&#34;");
    returnValue = returnValue.replaceAll("\'", "&#39;");
    return returnValue;
  }

  public static String clearXSSMaximum(String value) {
    String returnValue = value;
    returnValue = clearXSSMinimum(returnValue);

    returnValue = returnValue.replaceAll("%00", null);

    returnValue = returnValue.replaceAll("%", "&#37;");

    // \\. => .

    returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
    returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\
    returnValue = returnValue.replaceAll("\\./", ""); // ./
    returnValue = returnValue.replaceAll("%2F", "");

    return returnValue;
  }

  public static String filePathBlackList(String value) {
    String returnValue = value;
    if (returnValue == null || returnValue.trim().equals("")) {
      return "";
    }

    returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
    returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

    return returnValue;
  }

  /**
   * 행안부 보안취약점 점검 조치 방안.
   *
   * @param value
   * @return
   */
  public static String filePathReplaceAll(String value) {
    String returnValue = value;
    if (returnValue == null || returnValue.trim().equals("")) {
      return "";
    }

    returnValue = returnValue.replaceAll("/", "");
    returnValue = returnValue.replaceAll("\\", "");
    returnValue = returnValue.replaceAll("\\.\\.", ""); // ..
    returnValue = returnValue.replaceAll("&", "");

    return returnValue;
  }

  public static String filePathWhiteList(String value) {
    return value; // TODO
  }

  public static boolean isIPAddress(String str) {
    Pattern ipPattern = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");

    return ipPattern.matcher(str).matches();
  }

  public static String nl2br(String value) {
    String retval = value;
    retval = retval.replaceAll("&", "&amp;");
    retval = retval.replaceAll("<", "&lt;");
    retval = retval.replaceAll(">", "&gt;");
    retval = retval.replaceAll("\"", "&#34;");
    retval = retval.replaceAll("\'", "&#39;");

    retval = retval.replaceAll("\r\n", "<br/>");
    return retval;
  }


  /**********************************************************
   * 지정한 자리수의 난수로 ID문자열을 생성한다. 추가/삭제가 빈번하게 일어나지 않는 경우에 한해 ID값으로 사용한다.
   **********************************************************/
  public static String generateIDString(String prefix, int length) {
    String ret_ = "";

    for (int i = 0; i < length; i++) {
      int rd = (int) (Math.random() * 10);

      switch (rd % 3) {
        case 0:
          ret_ += (char) ((Math.random() * 10) + 48);
          break;
        case 1:
          ret_ += (char) ((Math.random() * 26) + 65);
          break;
        case 2:
          ret_ += (char) ((Math.random() * 26) + 97);
          break;

      }
    }

    return prefix + ret_;
  }


  /**********************************************************
   * 지정한 자리수의 난수로 ID문자열을 생성한다. 추가/삭제가 빈번하게 일어나지 않는 경우에 한해 ID값으로 사용한다.
   **********************************************************/
  public static String getImgicoByExt(String ext) {
    String lext = ext.toLowerCase();

    String ret_ = "dft";

    if ("hwp".equals(lext) || "xls".equals(lext) || "doc".equals(lext) || "ppt".equals(lext)
        || "zip".equals(lext) || "pdf".equals(lext) || "txt".equals(lext))
      ret_ = ext;

    else if ("jpg".equals(lext) || "png".equals(lext) || "gif".equals(lext))
      ret_ = "img";

    else if ("docx".equals(lext))
      ret_ = "doc";
    else if ("pptx".equals(lext))
      ret_ = "ppt";
    else if ("xlsx".equals(lext))
      ret_ = "xls";

    return ret_;
  }


  /************************************************************
   * 문자열을 지정한 길이로 자르고 줄임표시(지정 가능)를 붙임
   * 
   * @param value : 문자열
   * @param limit : 자를 자리수
   * @param addval : 줄임표시 지정
   ************************************************************/
  public static String cutString(String value, int limit, String addval) {

    String retval = value;
    if (retval.length() > limit) {
      retval = value.substring(0, limit);
      retval += addval;
    }

    return retval;
  }

  /************************************************************
   * UTF-8 Decoding : 한글을 사용하는 속성의 Getter 메소드에서 사용
   * 
   * @param str : 디코딩할 한글 String
   * @return : 디코딩된 한글 String
   ************************************************************/
  public static String UTF8Decode(String str) {
    String ret = str;
    try {
      if (str != null && !"".equals(str))
        ret = URLDecoder.decode(str, "UTF-8");
    } catch (UnsupportedEncodingException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    return ret;

  }


  /************************************************************
   * UTF-8 Encoding : 한글을 사용하는 속성의 Getter 메소드에서 사용
   * 
   * @param str : 인코딩할 한글 String
   * @return : 인코딩된 한글 String
   ************************************************************/
  public static String UTF8Encode(String str) {
    String ret = str;
    try {
      if (str != null && !"".equals(str))
        ret = URLEncoder.encode(str, "UTF-8");
    } catch (UnsupportedEncodingException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    return ret;

  }

  /************************************************************
   * javascript 로 링크된 스트링을 실제 링크가능한 텍스트로 변형시킴
   * 
   * @param str : 변환할 String
   * @return : 변환된 String
   ************************************************************/
  public static String getJavascriptLinkStr(String str, String srch_menu_nix) {
    // ex) str = JS##fn_egov_change_menu(&apos;00&apos;)
    String ret = str;
    ret = ret.replace("JS##", "javascript:");
    ret = ret.replace("##srch_menu_nix", "('" + srch_menu_nix + "')");
    return ret;

  }

  /************************************************************
   * 문자열이 특정 문자열로 시작하는지 여부를 리턴한다.
   * 
   * @param org : 원본 String
   * @param comp : 비교할 String
   * @return : 문자열 시작 여부
   ************************************************************/
  public Boolean startsWith(String org, String comp) {
    System.out.println(org.startsWith(comp));
    return org.startsWith(comp);

  }


  /************************************************************
   * 원하는 자릿수만큼 0으로 채운 String을 반환한다.
   * 
   * @param str : 원래 숫자
   * @param len : 자리수
   * @return : 변환된 String
   ************************************************************/
  public static String getZerofillStr(int str, int len) {
    // ex) str = JS##fn_egov_change_menu(&apos;00&apos;)

    String ret = new Integer(str).toString();
    for (int i = ret.length(); i < len; i++) {
      ret = "0" + ret;
    }
    return ret;

  }

  /************************************************************
   * int value를 1000단위 NumberFormat으로.. 1000000 => 1,000,000
   * 
   * @param : int value
   * @return : 변환된 String
   ************************************************************/
  public static String getNumberFormat(int value) {
    NumberFormat nf = NumberFormat.getInstance();
    return nf.format(value);
  }


  /************************************************************
   * 클라이언트의 브라우저 종류
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static String getRemoteBrowser(HttpServletRequest request) {
    String ret_ = null;

    String userAgent = request.getHeader("User-Agent");
    userAgent = userAgent.toUpperCase();

    if (userAgent.indexOf("TRIDENT/7.0; RV:11.0") >= 0)
      ret_ = "IE 11";
    else if (userAgent.indexOf("COMPATIBLE; MSIE 10.0;") >= 0)
      ret_ = "IE 10";
    else if (userAgent.indexOf("COMPATIBLE; MSIE 9.0;") >= 0)
      ret_ = "IE 9";
    else if (userAgent.indexOf("COMPATIBLE; MSIE 8.0;") >= 0)
      ret_ = "IE 8";
    else if (userAgent.indexOf("COMPATIBLE; MSIE 7.0;") >= 0)
      ret_ = "IE 7";
    else if (userAgent.indexOf("COMPATIBLE; MSIE 6.0;") >= 0)
      ret_ = "IE 6";
    else if (userAgent.indexOf("CHROME") >= 0)
      ret_ = "Chrome";
    else if (userAgent.indexOf("SAFARI") >= 0)
      ret_ = "Safari";
    else if (userAgent.indexOf("FIREFOX") >= 0)
      ret_ = "Firefox";
    else if (userAgent.indexOf("OPERA") >= 0)
      ret_ = "Opera";
    else
      ret_ = "ETC";
    return ret_;
  }


  /************************************************************
   * 클라이언트의 브라우저 종류
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static String getRemoteOS(HttpServletRequest request) {
    String ret_ = null;

    String userAgent = request.getHeader("User-Agent");

    if (userAgent != null)
    	userAgent = userAgent.toUpperCase();



    if (userAgent == null)

      return "Windows";



    if (userAgent.indexOf("WINDOWS") >= 0)

      ret_ = "Windows";

    else if (userAgent.indexOf("ANDROID") >= 0)

      ret_ = "Android";

    else if (userAgent.indexOf("IPHONE") >= 0)

      ret_ = "IOS";

    else if (userAgent.indexOf("LINUX") >= 0)

      ret_ = "Linux";

    else

      ret_ = "ETC";

    return ret_;
  }


  /************************************************************
   * 클라이언트의 IP
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static String getRemoteAddr(HttpServletRequest request) {
    String ret_ = null;

    ret_ = request.getHeader("WL-Proxy-Client-IP");
    if (ret_ == null || "".equals(ret_)) {
      ret_ = request.getHeader("Proxy-Client-IP");
    }
    if (ret_ == null || "".equals(ret_)) {
      ret_ = request.getHeader("X-Forwarded-For");;
    }
    if (ret_ == null || "".equals(ret_)) {
      ret_ = request.getRemoteAddr();
    }

    return ret_;
  }


  /************************************************************
   * 이전페이지의 링크정보
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static String getReferer(HttpServletRequest request) {
    String ret_ = request.getHeader("Referer");
    return ret_;
  }


  /************************************************************
   * 현재 연도 구하기
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static int getCalYear() {
    Calendar cal = Calendar.getInstance();
    return cal.get(Calendar.YEAR);
  }

  /************************************************************
   * 현재 월 구하기
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static int getCalMonth() {
    Calendar cal = Calendar.getInstance();
    return cal.get(Calendar.MONTH) + 1;
  }

  /************************************************************
   * 현재 날짜 구하기
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static int getCalDay() {
    Calendar cal = Calendar.getInstance();
    return cal.get(Calendar.DATE);
  }

  /************************************************************
   * 특정 날짜의 시작 요일 구하기
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static int getDayofWeek(int year, int month, int date) {
    Calendar cal = Calendar.getInstance();
    cal.set(year, month - 1, date);

    return cal.get(Calendar.DAY_OF_WEEK);
  }


  /************************************************************
   * 특정 날짜의 시작 요일 구하기
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static String getDayofWeekKor(int year, int month, int date) {
    String ret = "";
    int dofw = getDayofWeek(year, month, date);

    if (dofw == 1)
      ret = "일";
    else if (dofw == 2)
      ret = "월";
    else if (dofw == 3)
      ret = "화";
    else if (dofw == 4)
      ret = "수";
    else if (dofw == 5)
      ret = "목";
    else if (dofw == 6)
      ret = "금";
    else if (dofw == 7)
      ret = "토";

    return ret;
  }



  /************************************************************
   * 특정 문자열로 시작하는지 여부
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static boolean isStartsWith(String str, String prefix) {
    return str.startsWith(prefix);
  }


  /************************************************************
   * 특정 문자열로 끝나는지 여부
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static boolean isEndsWith(String str, String suffix) {
    return str.endsWith(suffix);
  }


  /************************************************************
   * 허용되지 않은 태그를 제외한 태그를 원래대로 보여준다.
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static String removeScrtag(String str) {
    // Pattern pattern =
    // Pattern.compile("<(/*)(\b(?!p|a|b|span|div|strong|br|img|font|table|tbody|tfoot|th|tr|td|h1|h2|h3|h4|ul|li|em|ol|hr|input|object|dd|dl|dt|iframe|caption|section|col|label))([^>]*)>");
    str = str.replace("&amp;", "&");
    str = str.replace("&quot;", "\"");
    str = str.replace("&apos;", "'");
    str = str.replace("&lt;", "<");
    str = str.replace("&gt;", ">");
    str = str.replace("<BR>", "");
    str = str.replace("<BR/>", "");
    // System.out.println(str);


    // String retstr =
    // str.replaceAll("<(/*)(\b(?!p|a|b|span|div|strong|br|img|font|table|tbody|tfoot|th|tr|td|h1|h2|h3|h4|ul|li|em|ol|hr|input|object|dd|dl|dt|iframe|caption|section|col|label))([^>]*)>",
    // "&lt;$1$2$3&gt;");
    // String retstr =
    // str.replaceAll("<(/*)((?!p|a|b|span|div|strong|br|img|font|table|tbody|tfoot|th|tr|td|h1|h2|h3|h4|ul|li|em|ol|hr|input|object|dd|dl|dt|iframe|caption|section|col|label))([^>]*)>",
    // "&lt;$1$2$3&gt;");
    String retstr = str.replaceAll("(?i)<(/*)(script)([^>]*)>", "&lt;$1$2$3&gt;");
    return retstr;
  }


  /************************************************************
   * 태그를 제거한다.
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static String removeTag(String str) {
    str = str.replace("&amp;", "&");
    str = str.replace("&quot;", "\"");
    str = str.replace("&apos;", "'");
    str = str.replace("&lt;", "<");
    str = str.replace("&gt;", ">");

    String retstr = str.replaceAll("<(/)?([a-zA-Z0-9]*)(\\s[a-zA-Z0-9]*=[^>]*)?(\\s)*(/)?>", "");
    return retstr;
  }



  /************************************************************
   * 파일 확장자를 구함
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static String getExtension(String strPath) {
    String ext = null;
    if (strPath != null && strPath.lastIndexOf(".") >= 0)
      ext = strPath.substring(strPath.lastIndexOf(".") + 1, strPath.length());
    else
      ext = "";

    return ext;
  }


  /************************************************************
   * 해당 연도/ 달의 날짜 수
   * 
   * @param request : ServletRequest
   ************************************************************/
  public static int getDaycntofmonth(int year, int month) {
    int monthday = 0;
    switch (month) {
      case 1:
        monthday = 31;
        break;
      case 2:
        monthday = (isLeapyear(year) ? 29 : 28);
        break;
      case 3:
        monthday = 31;
        break;
      case 4:
        monthday = 30;
        break;
      case 5:
        monthday = 31;
        break;
      case 6:
        monthday = 30;
        break;
      case 7:
        monthday = 31;
        break;
      case 8:
        monthday = 31;
        break;
      case 9:
        monthday = 30;
        break;
      case 10:
        monthday = 31;
        break;
      case 11:
        monthday = 30;
        break;
      case 12:
        monthday = 31;
        break;
      default:
        monthday = 0;
    }

    return monthday;
  }

  public static boolean isLeapyear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0)
          return true;

        return false;
      }
      return true;
    }
    return false;
  }

  public static int parseInt(String strnum) {
    return strnum == null ? 0 : Integer.parseInt(strnum);
  }

  public static String getYoutubeThumbUrl(String src) {
    String tok_1 = "/embed/";

    int idx = src.indexOf(tok_1);
    if (idx < 0) {
      tok_1 = "watch?v=";
      idx = src.indexOf(tok_1);
    }

    if (idx < 0)
      return "";

    idx += tok_1.length();
    String utbkey = src.substring(idx, idx + 11);
    String url = "http://img.youtube.com/vi/##utbkey##/1.jpg";
    url = url.replaceAll("##utbkey##", utbkey);

    return url;
  }

  public static void printRequestInfomation(HttpServletRequest request) {
    try {
      InetAddress ip = InetAddress.getLocalHost();
      // System.out.println("SERVER_NAME :" + request.getServerName());
      // System.out.println("SERVER_SOFTWARE :" + request.getScheme());
      // System.out.println("SERVER_PROTOCOL :" + request.getProtocol());
      // System.out.println("SERVER_PORT :" + request.getServerPort());
      // System.out.println("SERVER_ADDRESS :" + ip.getHostAddress());//현재 서버 IP구하기
      // System.out.println("REQUEST_METHOD :" + request.getMethod());
      // System.out.println("PATH_INFO :" + request.getPathInfo());
      // System.out.println("PATH_TRANSLATED :" + request.getPathTranslated());
      // System.out.println("SCRIPT_NAME :" + request.getServletPath());
      // System.out.println("QUERY_STRING :" + request.getQueryString());
      // System.out.println("REMOTE_HOST :" + request.getRemoteHost());
      // System.out.println("REMOTE_ADDR :" + request.getRemoteAddr());
      // result : REMOTE_ADDR :fe80:0:0:0:5883:b16c:ab03:97af
      // IPv6형식 이클립스 > Run > Run Configuration > Arguments > -Djava.net.preferIPv4Stack=true
      // localhost 대신에 다른 경로를 잡아주면 정상적으로 출력된다.
      // System.out.println("AUTH_TYPE :" + request.getAuthType());
      // System.out.println("REMOTE_USER :" + request.getRemoteUser());
      // System.out.println("CONTENT_TYPE :" + request.getContentType());
      // System.out.println("CONTENT_LENGTH :" + request.getContentLength());
      // System.out.println("HTTP_ACCEPT :" + request.getHeader("Accept"));
      // System.out.println("HTTP_USER_AGENT :" + request.getHeader("User-Agent"));
      // System.out.println("HTTP_REFERER :" + request.getHeader("Referer")); // 이전페이지의 링크정보
      // System.out.println("WL-PROXY-CLIENT-IP :" + request.getHeader("WL-Proxy-Client-IP"));
      // System.out.println("PROXY-CLIENT-IP :" + request.getHeader("Proxy-Client-IP"));
      // System.out.println("X-FORWARED-FOR :" + request.getHeader("X-Forwarded-For"));
    } catch (UnknownHostException e) {
      e.printStackTrace();
    }

  }

  /**
   * StringBuffer가 replaceall 메소드를 지원하지 않기때문에 만듬.
   * 
   * @param sb_
   * @param replaceFrom
   * @param replaceTo
   */
  public static void replaceallSB(StringBuffer sb_, String replaceFrom, String replaceTo) {
    int idx = 0;
    while ((idx = sb_.indexOf(replaceFrom)) >= 0) {
      sb_.replace(idx, idx + replaceFrom.length(), replaceTo);
    }
  }

  /**
   * String concat...
   * 
   * @param src
   * @param dest
   */
  public static String concat(String src, String dest) {
    StringBuffer sb_ = new StringBuffer(src);
    sb_.append(dest);

    return sb_.toString();
  }

  /**
   * Mysql에서 지원하지 않는 Connect By 절을 구현.. 호출은 반드시 다음과 같이 한다. getLeveldList(list, null, 1, new
   * Integer(1)); 2014.08.26 bhhan
   * 
   * @param rowlist : connect by가 적용되지 않은 (적용해야 할) 결과 리스트
   * @param parentVal : start with 에 들어가야 할 조건 (최상위 노드)
   * @param nowlevel : 현재 Level
   * @param startOrd : 정렬 시작값
   */
  public static Integer getLeveldList(List<SysmenuVO> rowlist, String parentVal, int nowlevel,
      Integer startOrd) {
    List<SysmenuVO> list = new ArrayList<SysmenuVO>();

    // //////////////////////////////////////////////////////
    // Step 1 ..
    // parentVal 를 부모로 갖는 녀석들을 먼저 골라낸다..
    // 레벨값을 셋팅한다.
    for (int i = 0; i < rowlist.size(); i++) {
      SysmenuVO menuVO = rowlist.get(i);

      if (parentVal == null || "".equals(parentVal)) {
        if (menuVO.getUp_menu_idx() == null || "".equals(menuVO.getUp_menu_idx())) {
          menuVO.setMenu_lv(nowlevel);
          list.add(menuVO);
        }
      } else {
        if (parentVal.equals(menuVO.getUp_menu_idx())) {
          menuVO.setMenu_lv(nowlevel);
          list.add(menuVO);
        }
      }
    }

    {
      // 같은 부모의 자식들을 정해진정렬 기준으로 정렬함
      // 여기서는 menu_ord 의 값으로 정렬함.
      // 이부분이 Order Siblings By 가 됨..
      Comparator<SysmenuVO> sort = new Comparator<SysmenuVO>() {
        @Override
        public int compare(SysmenuVO o1, SysmenuVO o2) {
          return EgovWebUtil.getZerofillStr(o1.getMenu_ord(), 6)
              .compareTo(EgovWebUtil.getZerofillStr(o2.getMenu_ord(), 6));
        }
      };
      Collections.sort(list, sort); // 위에 설정한 내용대로 정렬(sort!)
    }
    //
    // ///////////////////////////////////////////////////////


    // /////////////////////////////////////////////////////
    // 이부분은 디버깅시 진행상황을 한눈에 확인하도록
    // 값을 출력하는 부분이다.
    // 아래 Step 3 내부에 포인트 찍고 한단계씩 진행하면서
    // 값을 확인하면 오류를 쉽게 찾을 수 있다.
    /*
     * System.out.println("\n############################"); for(int i = 0; i < rowlist.size(); i++)
     * { SysmenuVO menuVO = (SysmenuVO)rowlist.get(i); System.out.println(menuVO.getMenu_idx() + " "
     * + menuVO.getUp_menu_idx() + " " + menuVO.getMenu_lv() + " " + menuVO.getConnectOrder()); }
     */
    //
    // //////////////////////////////////////////////////////

    // ////////////////////////////////////////////////////////
    // Step 2 ..
    // 위에서 뽑아낸 같은 부모의 자식들을 재귀 탐색하여
    // 레벨과 정렬 번호를 붙인다..
    for (int j = 0; j < list.size(); j++) {
      SysmenuVO menuVO = list.get(j);
      menuVO.setConnectOrder(startOrd++);
      startOrd = getLeveldList(rowlist, menuVO.getMenu_idx(), nowlevel + 1, startOrd);
    }
    //
    // /////////////////////////////////////////////////////////


    // /////////////////////////////////////////////////////////
    // Step 3 ..
    // 재귀호출이 종료될때
    // 최종적으로 connectOrd 값으로 정렬을 시켜
    // connect by 기능을 완성한다.
    if (parentVal == null) {

      Comparator<SysmenuVO> sort = new Comparator<SysmenuVO>() {
        @Override
        public int compare(SysmenuVO o1, SysmenuVO o2) {
          return EgovWebUtil.getZerofillStr(o1.getConnectOrder(), 6)
              .compareTo(EgovWebUtil.getZerofillStr(o2.getConnectOrder(), 6));
        }
      };
      Collections.sort(rowlist, sort); // 위에 설정한 내용대로 정렬(sort!)

    }
    //
    // /////////////////////////////////////////////////////////

    return startOrd;
  }

  /**
   * 한 메뉴의 상위메뉴를 재귀탐색하여 메뉴를 구성한다
   * 
   * @param orgList : 원본 메뉴목록
   * @param findIdx : 찾는 메뉴
   * @param srchList : 결과 메뉴목록
   * @return
   */
  public static boolean getParentList(String[][] orgList, String findIdx, List srchList) {
    for (int i = 0; i < orgList.length; i++) {
      // 찾는 노드인 경우
      if (orgList[i][0].equals(findIdx)) {
        // 상위 노드가 있으면 다시 탐색
        if (orgList[i][1] != null && "".equals(orgList[i][1]) == false) {
          srchList.add(orgList[i][0]);
          getParentList(orgList, orgList[i][1], srchList);
        }

        // 없으면 리턴
        else {
          srchList.add(orgList[i][0]);
          return false;
        }
      }
    }

    return true;
  }

  public static boolean getChildList(String[][] orgList, String findIdx, List srchList) {
    for (int i = 0; i < orgList.length; i++) {
      // 찾는 노드의 하위노드인 경우
      if (orgList[i][1] != null && orgList[i][1].equals(findIdx)) {
        srchList.add(orgList[i][0]);
        getChildList(orgList, orgList[i][0], srchList);
      }
    }

    return true;
  }

  public static void main(String[] args) {
    /*
     * System.out.println(EgovWebUtil.getCalYear()); System.out.println(EgovWebUtil.getCalMonth());
     * System.out.println(EgovWebUtil.getCalDay());
     * System.out.println(EgovWebUtil.getStartDayofWeek(2013, 10, 1));
     */
    // System.out.println(EgovWebUtil.generateIDString("", 8));
    // System.out.println(EgovWebUtil.isStartsWith("", ""));

    // String str = "<section src='aa'>agheio<div>age</div></section>";
    // String retstr = str.replaceAll("<(\\/*)(\b(?!section))([^>]*)>", "&lt;$1$2$3&gt;");

    // String str = "<section><span id='aa'>agheio</span><script
    // type='text/javascript'>alert('aa');</script></section><div>test</div>";
    /*
     * String str =
     * "<span>aoge</span><DIV id='age'>test</DIV><aa>eg</aa><script type='text/javascript'>alert('aa');</script>"
     * ; String retstr = str.replaceAll("(?i)<(/*)(script)([^>]*)>", "&lt;$1$2$3&gt;");
     * System.out.println(retstr);
     */

    /*
     * String tag = "<p class=\"linemenu\">홈페이지가이드  &gt;  <span class=\"current\">안녕하세요</span></p>";
     * System.out.println(EgovWebUtil.removeTag(tag)); for(int i = 0; i < 43; i++) {
     * System.out.println(EgovWebUtil.generateIDString("", 8)); } try{
     * System.out.println(EgovFileScrty.encryptPassword("pwdadmin")); }catch(Exception e){
     * 
     * }
     */

    // System.out.println(EgovWebUtil.getUtubeThumbUrl("a"));
    try {
      System.out.println(EgovFileScrty.encode("322-44-54821"));
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }
}
