package egovframework.plani.template.cmm.utils;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 * Validation 클래스에서 다른 필드의 값을 참조하기 위한 헬퍼 클래스(2018-05-30)
 * 
 * @author pigcos
 *
 */
public class RequestParameterHelper {

  // private static Map<String, Map<String, String[]>> datas = new HashMap<>();

  /**
   * parameter 정보 셋터
   * 
   * @param key
   * @param data
   */
  public static void setParamter(HttpServletRequest request, String key, Map<String, Object> data) {
    // datas.put(key, data);
    try {
      Map<String, Map<String, Object>> datas = new HashMap<>();
      Map<String, Map<String, Object>> session =
          (Map<String, Map<String, Object>>) EgovSessionCookieUtil.getSessionAttribute(request,
              "SESS_VALIDATE_DATA");
      if (session != null) {
        for (String key1 : session.keySet()) {
          datas.put(key1, session.get(key1));
          // System.out.println(String.format("키 : %s, 값 : %s", key1, session.get(key1)));
        }
      }
      // System.out.println("session : " + session);
      datas.put(key, data);
      // System.out.println("key : " + key);
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_VALIDATE_DATA", datas);
      // System.out.println("session : " + datas);
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }

  /**
   * parameter 정보
   * 
   * @param uri
   * @param field
   * @return
   */
  public static Object getParameter(HttpServletRequest request, String uri, String field) {
    Map<String, Map<String, Object>> datas = null;
    try {
      datas = (Map<String, Map<String, Object>>) EgovSessionCookieUtil.getSessionAttribute(request,
          "SESS_VALIDATE_DATA");
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    return datas.get(uri).get(field);
  }
}
