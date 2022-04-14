package egovframework.plani.template.cmm.utils;

import java.util.Calendar;
import java.util.HashMap;
import NiceID.Check.CPClient;
import egovframework.plani.template.cmm.vo.UserAuthVO;

public class CheckPlusSafe {

  /** 에러 코드 */
  private String ErrorCode = "0000";

  public String getErrorCode() {
    return ErrorCode;
  }

  public void setErrorCode(String errorCode) {
    ErrorCode = errorCode;
  }

  // (관련문의 : (02-2122-4873 / 02-2122-4541)
  // DI값이 넘어오지 않으면 전화해서 요청해야하지만
  // 핸드폰인증만 단독으로 신청되어있을 경우에는 받을 수 없다.. (아이핀과 같이 인증할 경우에 받을 수 있음)
  // 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
  // 없으면 기본 웹페이지 / Mobile : 모바일페이지
  // 서버가 IBM -AIX일 경우 IBM용 클라이언트 모듈을 넣어야 함 (NiceID.jar)
  public String getEncPlanData(String authType, String customize, String type) {

    // CPClient niceCheck = new CPClient();
    NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

    String sSiteCode = "G7897"; // NICE로부터 부여받은 사이트 코드
    String sSitePassword = "C4IC5FMAA1RA"; // NICE로부터 부여받은 사이트 패스워드

    String sRequestNumber = "REQ0000000001"; // 요청 번호, 이는 성공/실패후에 같은 값으로
                                             // 되돌려주게 되므로
                                             // 업체에서 적절하게 변경하여 쓰거나, 아래와
                                             // 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSiteCode);

    String popgubun = "N"; // Y : 취소버튼 있음 / N : 취소버튼 없음

    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    String sReturnUrl = "";
    String sErrorUrl = "";
    if ("parent".equals(type)) {
      /*
       * sReturnUrl = "http://www.nie.re.kr/memuser/successHpAndCertByParent.do"; sErrorUrl =
       * "http://www.nie.re.kr/memuser/failHpAndCertByParent.do"; if ("Mobile".equals(customize)) {
       * sReturnUrl = "http://www.nie.re.kr/msvcmem/successHpAndCertByParent.mdo"; sErrorUrl =
       * "http://www.nie.re.kr/msvcmem/failHpAndCertByParent.mdo"; }
       */
    } else {
      sReturnUrl = "http://archive.nypi.re.kr/memuser/successHpAndCert.do";
      sErrorUrl = "http://archive.nypi.re.kr/memuser/failHpAndCert.do";

      // sReturnUrl = "http://www.nypi.re.kr/ARCHIVE/memuser/successHpAndCert.do";
      // sErrorUrl = "http://www.nypi.re.kr/ARCHIVE/memuser/failHpAndCert.do";

      // 로컬
      // sReturnUrl = "http://localhost:8082/memuser/successHpAndCert.do";
      // sErrorUrl = "http://localhost:8082/memuser/failHpAndCert.do";

      if ("Mobile".equals(customize)) {
        // sReturnUrl = "http://www.nie.re.kr/msvcmem/successHpAndCert.mdo";
        // sErrorUrl = "http://www.nie.re.kr/msvcmem/failHpAndCert.mdo";
      }
    }

    // if("parent".equals(type)){
    // sReturnUrl = "http://localhost/memuser/successHpAndCertByParent.do";
    // sErrorUrl = "http://localhost/memuser/failHpAndCertByParent.do";
    // if ("Mobile".equals(customize)) {
    // sReturnUrl = "http://localhost/msvcmem/successHpAndCertByParent.mdo";
    // sErrorUrl = "http://localhost/msvcmem/failHpAndCertByParent.mdo";
    // }
    // }else{
    // sReturnUrl = "http://localhost/memuser/successHpAndCert.do";
    // sErrorUrl = "http://localhost/memuser/failHpAndCert.do";
    // if ("Mobile".equals(customize)) {
    // sReturnUrl = "http://localhost/msvcmem/successHpAndCert.mdo";
    // sErrorUrl = "http://localhost/msvcmem/failHpAndCert.mdo";
    // }
    // }

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber
        + "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode + "9:AUTH_TYPE"
        + authType.getBytes().length + ":" + authType + "7:RTN_URL" + sReturnUrl.getBytes().length
        + ":" + sReturnUrl + "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl
        + "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun + "9:CUSTOMIZE"
        + customize.getBytes().length + ":" + customize;

    String sMessage = "";
    String sEncData = "";

    int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
    if (iReturn == 0) {
      sEncData = niceCheck.getCipherData();
    } else if (iReturn == -1) {
      sMessage = "암호화 시스템 에러입니다.";
    } else if (iReturn == -2) {
      sMessage = "암호화 처리오류입니다.";
    } else if (iReturn == -3) {
      sMessage = "암호화 데이터 오류입니다.";
    } else if (iReturn == -9) {
      sMessage = "입력 데이터 오류입니다.";
    } else {
      sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
    // System.out.println("sMessage : " + sMessage);

    return sEncData;
  }

  public UserAuthVO getUserAuth(String EncodeData, String param_r1) {
    CPClient niceCheck = new CPClient();

    String sEncodeData = requestReplace(EncodeData, "encodeData");
    String sReserved1 = requestReplace(param_r1, "");

    String sSiteCode = "G7897"; // NICE로부터 부여받은 사이트 코드
    String sSitePassword = "C4IC5FMAA1RA"; // NICE로부터 부여받은 사이트 패스워드

    String sCipherTime = ""; // 복호화한 시간
    String sRequestNumber = ""; // 요청 번호
    String sResponseNumber = ""; // 인증 고유번호
    String sAuthType = ""; // 인증 수단
    String sName = ""; // 성명
    String sDupInfo = ""; // 중복가입 확인값 (DI_64 byte)
    String sConnInfo = ""; // 연계정보 확인값 (CI_88 byte)
    String sBirthDate = ""; // 생일
    String sGender = ""; // 성별
    String sNationalInfo = ""; // 내/외국인정보 (개발가이드 참조)
    String sMessage = "";
    String sPlainData = "";
    String sErrorCode = "";

    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

    if (iReturn == 0) {
      sPlainData = niceCheck.getPlainData();
      sCipherTime = niceCheck.getCipherDateTime();

      // 데이타를 추출합니다.
      HashMap mapresult = niceCheck.fnParse(sPlainData);

      sRequestNumber = (String) mapresult.get("REQ_SEQ");
      sResponseNumber = (String) mapresult.get("RES_SEQ");
      sAuthType = (String) mapresult.get("AUTH_TYPE");
      sName = (String) mapresult.get("NAME");
      sBirthDate = (String) mapresult.get("BIRTHDATE");
      sGender = (String) mapresult.get("GENDER");
      sNationalInfo = (String) mapresult.get("NATIONALINFO");
      sDupInfo = (String) mapresult.get("DI");
      sConnInfo = (String) mapresult.get("CI");
      sErrorCode = (String) mapresult.get("ERR_CODE");
      setErrorCode(sErrorCode);

    } else if (iReturn == -1) {
      sMessage = "복호화 시스템 에러입니다.";
    } else if (iReturn == -4) {
      sMessage = "복호화 처리오류입니다.";
    } else if (iReturn == -5) {
      sMessage = "복호화 해쉬 오류입니다.";
    } else if (iReturn == -6) {
      sMessage = "복호화 데이터 오류입니다.";
    } else if (iReturn == -9) {
      sMessage = "입력 데이터 오류입니다.";
    } else if (iReturn == -12) {
      sMessage = "사이트 패스워드 오류입니다.";
    } else {
      sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }

    UserAuthVO userAuth = new UserAuthVO();
    userAuth.setName(sName);
    userAuth.setDupInfo(sDupInfo);
    userAuth.setAuthType("HP");
    userAuth.setBirthDate(sBirthDate);
    userAuth.setAge(this.getAge(sBirthDate));

    return userAuth;
  }

  public static String requestReplace(String paramValue, String gubun) {
    String result = "";

    if (paramValue != null) {

      paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

      paramValue = paramValue.replaceAll("\\*", "");
      paramValue = paramValue.replaceAll("\\?", "");
      paramValue = paramValue.replaceAll("\\[", "");
      paramValue = paramValue.replaceAll("\\{", "");
      paramValue = paramValue.replaceAll("\\(", "");
      paramValue = paramValue.replaceAll("\\)", "");
      paramValue = paramValue.replaceAll("\\^", "");
      paramValue = paramValue.replaceAll("\\$", "");
      paramValue = paramValue.replaceAll("'", "");
      paramValue = paramValue.replaceAll("@", "");
      paramValue = paramValue.replaceAll("%", "");
      paramValue = paramValue.replaceAll(";", "");
      paramValue = paramValue.replaceAll(":", "");
      paramValue = paramValue.replaceAll("-", "");
      paramValue = paramValue.replaceAll("#", "");
      paramValue = paramValue.replaceAll("--", "");
      paramValue = paramValue.replaceAll("-", "");
      paramValue = paramValue.replaceAll(",", "");

      if (gubun != "encodeData") {
        paramValue = paramValue.replaceAll("\\+", "");
        paramValue = paramValue.replaceAll("/", "");
        paramValue = paramValue.replaceAll("=", "");
      }

      result = paramValue;

    }
    return result;
  }

  public int getAge(String birthDate) {
    if (birthDate == null || birthDate.length() == 0) {
      return 0;
    }
    int year = Integer.parseInt(birthDate.substring(0, 4));
    int month = Integer.parseInt(birthDate.substring(4, 6));
    int day = Integer.parseInt(birthDate.substring(6, 8));

    Calendar cal = Calendar.getInstance();
    cal.set(Calendar.YEAR, year);
    cal.set(Calendar.MONTH, month - 1);
    cal.set(Calendar.DATE, day);

    Calendar now = Calendar.getInstance();

    int age = now.get(Calendar.YEAR) - cal.get(Calendar.YEAR);
    if ((cal.get(Calendar.MONTH) > now.get(Calendar.MONTH))
        || (cal.get(Calendar.MONTH) == now.get(Calendar.MONTH)
            && cal.get(Calendar.DAY_OF_MONTH) > now.get(Calendar.DAY_OF_MONTH))) {
      age--;
    }
    return age;
  }
}
