package egovframework.plani.template.cmm.utils;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map.Entry;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import com.google.common.base.Joiner;
import egovframework.plani.template.cmm.utils.tagfree.URLDecoder;

/**
 * Common Util
 * 
 * @author pigcos
 *
 */
public class CommonUtil {

  public static String url(String url) {
    HttpServletRequest request =
        ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

    String requestUri = (String) request.getAttribute("javax.servlet.forward.request_uri");
    String queryString = (String) request.getAttribute("javax.servlet.forward.query_string");
    String contextPath = request.getContextPath();

    if (requestUri == null) {
      requestUri = request.getRequestURI();
    }

    // url 파라미터가 없는 경우 현재 url 셋팅 url파라미터가 있는경우에는 앞에 컨텍스트 패스 추가
    return StringUtils.isEmpty(url) ? requestUri : contextPath + url;
  }

  /**
   * url 만들기 : pigcos(2018-05-24)
   * 
   * @param request
   * @param url
   * @param param
   * @param override
   * @return
   */
  public static String getUrl(String url, String queryStringOverwrite, Boolean overwrite) {

    HttpServletRequest request =
        ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

    String requestUri = (String) request.getAttribute("javax.servlet.forward.request_uri");
    String queryString = (String) request.getAttribute("javax.servlet.forward.query_string");
    String contextPath = request.getContextPath();

    if (requestUri == null) {
      requestUri = request.getRequestURI();
      queryString = request.getQueryString();
    }

    if (queryString == null) {
      queryString = "";
    }

    // System.out.println("requestUri : " + request.getRequestURI());
    // System.out.println("queryString : " + request.getQueryString());
    // System.out.println("requestUri : " + requestUri);
    // System.out.println("queryString : " + queryString);
    // System.out.println("contextPath : " + contextPath);

    // url 파라미터가 없는 경우 현재 url 셋팅 url파라미터가 있는경우에는 앞에 컨텍스트 패스 추가
    url = StringUtils.isEmpty(url) ? requestUri : contextPath + url;
    // System.out.println("requestUri : " + url);

    String strQueryString = "";
    HashMap<String, String> resultQueryString = new HashMap<>();

    // System.out.println("getUrl : " + url + " : " + queryStringOverwrite);
    if (overwrite == true) { // url 파라미터 + queryStringOverwrite 추가
      // request query string
      resultQueryString = parseQueryString(queryString);
      // overwrite
      HashMap<String, String> parseQueryStringOverwrite = parseQueryString(queryStringOverwrite);
      for (Entry<String, String> entry : parseQueryStringOverwrite.entrySet()) {
        resultQueryString.put(entry.getKey(), entry.getValue());
      }

      // 기본으로 유지 되어야하는 기본 파라미터 값 정의
      // if (StringUtils.isEmpty(request.getParameter("srch_menu_nix")) == false) {
      // resultQueryString.put("srch_menu_nix", request.getParameter("srch_menu_nix"));
      // }
      // if (StringUtils.isEmpty(request.getParameter("srch_mu_lang")) == false) {
      // resultQueryString.put("srch_mu_lang", request.getParameter("srch_mu_lang"));
      // }
      // if (StringUtils.isEmpty(request.getParameter("srch_mu_site")) == false) {
      // resultQueryString.put("srch_mu_site", request.getParameter("srch_mu_site"));
      // }

    } else { // queryStringOverwrite 만 리턴
      resultQueryString = parseQueryString(queryStringOverwrite);
    }

    // 기본으로 유지 되어야하는 기본 파라미터 값 정의
    if (queryStringOverwrite != null) {
      // if (queryStringOverwrite != null && StringUtils.isEmpty(queryStringOverwrite) == true) {
      HashMap<String, String> check = parseQueryString(queryStringOverwrite);

      if (url.equals("/modedg/contentsView.do")) {
        System.out.println(url + " : " + check);
      }
      String[] baseParam = {"srch_menu_nix", "srch_mu_lang", "srch_mu_site"};
      for (int i = 0; i < baseParam.length; i++) {
        if (check.containsKey(baseParam[i]) == false
            && StringUtils.isEmpty(request.getParameter(baseParam[i])) == false) {
          resultQueryString.put(baseParam[i], request.getParameter(baseParam[i]));
        }
      }
    }


    // // 기본으로 유지 되어야하는 기본 파라미터 값 정의
    // if (StringUtils.isEmpty(request.getParameter("srch_menu_nix")) == false) {
    // resultQueryString.put("srch_menu_nix", request.getParameter("srch_menu_nix"));
    // }
    // if (StringUtils.isEmpty(request.getParameter("srch_mu_lang")) == false) {
    // resultQueryString.put("srch_mu_lang", request.getParameter("srch_mu_lang"));
    // }
    // if (StringUtils.isEmpty(request.getParameter("srch_mu_site")) == false) {
    // resultQueryString.put("srch_mu_site", request.getParameter("srch_mu_site"));
    // }


    if (resultQueryString.size() > 0) {
      ArrayList<String> resultQueryStringArrayList = new ArrayList<>();
      for (Entry<String, String> entry : resultQueryString.entrySet()) {
        if (!entry.getValue().equals("")) {// 값이 없는 파라미터는 제거
          resultQueryStringArrayList.add(entry.getKey() + "=" + entry.getValue());
        }
      }
      if (resultQueryStringArrayList.size() > 0) {
        strQueryString = "?" + Joiner.on("&").join(resultQueryStringArrayList);
      }
    }
    return url + strQueryString;
  }

  /**
   * redirect:url
   * 
   * @param url
   * @param queryStringOverwrite
   * @param overwrite
   * @return
   */
  public static String getRedirectUrl(String url, String queryStringOverwrite, Boolean overwrite) {
    String getUrl = getUrl(url, queryStringOverwrite, overwrite);
    HttpServletRequest request =
        ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    String contextPath = request.getContextPath();
    return "redirect:" + getUrl.replaceAll("^" + contextPath, ""); // contextPath 제거
  }

  /**
   * 문자열 query string을 HashMap 형태로 리턴 : pigcos(2018-05-24)
   * 
   * @param queryString
   * @return
   */
  public static HashMap<String, String> parseQueryString(String queryString) {
    String[] queryStringArg = queryString.split("&");
    HashMap<String, String> resultQueryStringHashMap = new LinkedHashMap<>();
    if (queryString != null && !queryString.equals("") && queryStringArg.length > 0) {
      for (int i = 0; i < queryStringArg.length; i++) {
        int idx = queryStringArg[i].indexOf("=");
        String key = queryStringArg[i].substring(0, idx);
        String value = queryStringArg[i].substring(idx + 1);
        // if (key != null && value != null) {
        try {
          resultQueryStringHashMap.put(key, URLDecoder.decode(value, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
          e.printStackTrace();
        }
        // }
      }
    }
    return resultQueryStringHashMap;
  }

  /**
   * htmlspecialchars
   * 
   * @param source
   * @return
   */
  public static String htmlspecialchars(String source) {
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < source.length(); i++) {
      char c = source.charAt(i);
      switch (c) {
        case '<':
          sb.append("&lt;");
          break;
        case '>':
          sb.append("&gt;");
          break;
        case '&':
          sb.append("&amp;");
          break;
        case '"':
          sb.append("&quot;");
          break;
        case '\'':
          sb.append("&apos;");
          break;
        default:
          sb.append(c);
      }
    }
    return sb.toString();
  }

  /**
   * String date to form date
   * 
   * @param date
   * @param format
   * @return
   */
  public static String dateFormat(String date, String format) {
    SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat transFormat2 = new SimpleDateFormat(format);
    try {
      Date from = transFormat.parse(date);
      return transFormat2.format(from);
    } catch (ParseException e) {
      return date;
    }
  }

  /**
   * 날짜 체크
   * 
   * @param start
   * @param end
   * @param s1
   * @param s2
   * @param s3
   * @return
   */
  public static String dateCheck(String start, String end, String s1, String s2, String s3) {
    if (StringUtils.isEmpty(start) == true || StringUtils.isEmpty(end) == true) {
      return "";
    }

    SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    try {
      Date startDate = transFormat.parse(start);
      Date endDate = transFormat.parse(end);
      Date nowDate = new Date();

      // 진행전
      if (startDate.getTime() > nowDate.getTime()) {
        return s1;
      }
      // 진행중
      if (startDate.getTime() <= nowDate.getTime() && endDate.getTime() >= nowDate.getTime()) {
        return s2;
      }
      if (endDate.getTime() < nowDate.getTime()) {
        return s3;
      }
    } catch (ParseException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }


    return "";
  }

  /**
   * srch_mu_site, srch_mu_lang에 따른 레이아웃 경로 리턴
   * 
   * @param returnUrl
   * @return
   */
  public static String getViewPageUrl(String returnUrl) {
    HttpServletRequest request =
        ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

    String srch_mu_site = request.getParameter("srch_mu_site");
    
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가
    
    // 2018-07-20 : pigcos 공모전
    if ("CDIDX00004".equals(srch_mu_site) == true) {
      returnUrl = "/complicity" + returnUrl;
    } else if ("CDIDX00005".equals(srch_mu_site) == true) {
      returnUrl = "/women" + returnUrl;
    }

    return returnUrl;

  }

  /**
   * 공모전 접수 상태
   * 
   * @param state
   * @return
   */
  public static String complicityState(int state) {
    switch (state) {
      case 1:
        return "접수완료";
      case 9:
        return "접수반려";
      default:
        return "접수대기";
    }
  }

  /**
   * 공모전 접수 상태 html
   * 
   * @param state
   * @return
   */
  public static String complicityStateHtml(int state) {
    switch (state) {
      case 1:
        return "<span class=\"icon1 type1\">" + complicityState(state) + "</span>";
      case 9:
        return "<span class=\"icon1 type7\">" + complicityState(state) + "</span>";
      default:
        return "<span class=\"icon1 type6\">" + complicityState(state) + "</span>";
    }
  }

  /**
   * 공모전 개인/팀 구분
   * 
   * @param division
   * @return
   */
  public static String complicityDivision(String division) {
    switch (division) {
      case "1":
        return "개인";
      case "2":
        return "팀";
      default:
        return "";
    }
  }

  public static String getDate2String(Date dt, String format) {
    SimpleDateFormat smp = new SimpleDateFormat(format);
    return smp.format(dt);
  }

  public static String complicityFromText(String key) {
    String result = "";
    switch (key) {
      case "off1":
        result = "교내 광고/게시판, 포스터";
        break;
      case "off2":
        result = "씽굿 공모전 잡지 및 광고";
        break;
      case "off3":
        result = "친구, 교수 등 지인소개";
        break;
      case "off4":
        result = "기타";
        break;
      case "on1":
        result = "온라인 카페, 블로그, 게시판";
        break;
      case "on2":
        result = "인터넷 뉴스 기사";
        break;
      case "on3":
        result = "씽굿 공모전 홈페이지";
        break;
      case "on4":
        result = "페이스북";
        break;
      case "on5":
        result = "이메일";
        break;
      case "on6":
        result = "기타";
        break;
    }
    return result;
  }

  public static String complicityFromString(String[] from, String exp, String separator) {
    if (from == null) {
      return "";
    }
    ArrayList<String> str = new ArrayList<String>();
    for (int i = 0; i < from.length; i++) {
      if (Pattern.matches(exp, from[i])) {
        // System.out.println("str ok : " + from[i]);
        str.add(complicityFromText(from[i]));
      }
    }
    // System.out.println("str : " + str);
    return Joiner.on(separator).join(str);
  }


  public static String awardsText(String key) {
    String result = "";

    switch (key) {
      case "10":
        result = "대상";
        break;
      case "20":
        result = "금상";
        break;
      case "30":
        result = "은상";
        break;
      case "40":
        result = "동상";
        break;
      case "999":
        result = "수상작";

    }
    return result;
  }

}
