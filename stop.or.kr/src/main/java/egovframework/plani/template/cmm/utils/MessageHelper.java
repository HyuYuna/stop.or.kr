package egovframework.plani.template.cmm.utils;

import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

/**
 * spring:message 사용을 위한 helper 클래스 2018-05-02
 * 
 * @author pigcos
 *
 */
public class MessageHelper {
  /**
   * getMessage를 사용하기위한 MessageSourceAccessor
   */
  private static MessageSourceAccessor messageSourceAccessr = null;

  /**
   * 기본 언어 설정값
   */
  private static String locale;

  /**
   * bean에서 MessageSourceAccessor를 주입 받기위한 메서드
   * 
   * @param msAcc
   */
  public void setMessageSourceAccessor(MessageSourceAccessor msAcc) {
    // globals.properties 에 설정된 Globals.locale 설정
    locale = EgovProperties.getProperty("Globals.locale");
    // 파라미터로 전달 받은 MessageSourceAccessor 설정
    MessageHelper.messageSourceAccessr = msAcc;
  }

  /**
   * spring:message를 사용하기위한 메서드
   * 
   * @param key
   * @return 현재 언어설정 코드에 맞는 메세지
   */
  public static String getMessage(String key) {
    return messageSourceAccessr.getMessage(key, "");
  }

  /**
   * spring:message를 사용하기위한 메서드
   * 
   * @param key
   * @param objs
   * @return 현재 언어설정 코드에 맞는 메세지
   */
  public static String getMessage(String key, Object[] objs) {
    return messageSourceAccessr.getMessage(key, objs, locale);
  }

  /**
   * 기본 언어 설정값
   * 
   * @return 기본 언어 설정값
   */
  public static String getDefaultLocale() {
    return locale;
  }

  /**
   * 현재 언어 설정값
   * 
   * @return 현재 언어 설정값
   */
  public static String getLocale() {
    return LocaleContextHolder.getLocale().toString().toUpperCase();
  }

  /**
   * 언어설정
   * 
   * @param language
   */
  public static void setLocale(String language) {

    HttpServletRequest request =
        ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

    RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
    HttpServletResponse response = ((ServletRequestAttributes) requestAttributes).getResponse();

    SessionLocaleResolver sessionLocaleResolver = new SessionLocaleResolver();

    Locale changeLocale = new Locale(language);
    // LocaleContextHolder.setLocale(changeLocale);
    sessionLocaleResolver.setLocale(request, response, changeLocale);

  }

  /**
   * 기본 언어가 아닌경우 디폴트로 설정
   */
  public static void checkDefaultLocale() {

    HttpServletRequest request =
        ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

    String language = request.getParameter(EgovProperties.getProperty("Globals.locale.paramName"));
    // System.out.println("param name : " + EgovProperties.getProperty("Globals.locale.paramName"));
    // System.out.println("language : " + language);
    if (language == null || language.equals(MessageHelper.getDefaultLocale())
        || language.equals("")) {

      // sessionLocaleResolver.setLocale(request, response,
      // new Locale(MessageHelper.getDefaultLocale()));
      MessageHelper.setLocale(MessageHelper.getDefaultLocale());
      // System.out.println("setLocale : " + MessageHelper.getDefaultLocale());
    }


  }

}
