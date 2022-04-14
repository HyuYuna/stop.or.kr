package egovframework.plani.template.cmm.vo;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;
import egovframework.plani.template.cmm.utils.EgovWebUtil;

/**
 * XPAY 결제 요청 변수로 들어가는 값을 정의
 * 
 * @class : [KTSTA] [egovframework.plani.cmm.utils] [XpayDefUtil.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 10. 10. 오후 8:13:23
 * @version : 1.0
 */
public class XpayDefVO extends DefaultSearchVO {

  private static final long serialVersionUID = 3498087468556129525L;

  /** LG유플러스 결제서비스 선택(test:테스트, service:서비스) */
  private String PLATFORM = "test";

  /** LG유플러스으로 부터 발급받으신 상점아이디 */
  // private String CST_MID = "ssd4114";
  private String CST_MID = "lgdacomxpay";

  /** 상점아이디(cst_mid에 의해 자동생성) */
  private String LGD_MID;


  /** 주문번호(상점정의 유니크한 주문번호) */
  private String LGD_OID;

  /** LG유플러스 거래번호 */
  private String LGD_TID;

  /** 결제금액("," 를 제외한 결제금액) */
  private int LGD_AMOUNT;

  /** 상점MertKey(mertkey는 상점관리자 -> 계약정보 -> 상점정보관리에서 확인) */
  private String LGD_MERTKEY = "ae0cd88570363cf35f08025bab71a7b0";

  /** 구매자명 */
  private String LGD_BUYER;

  /** 상품명 */
  private String LGD_PRODUCTINFO;

  /** 구매자 이메일 */
  private String LGD_BUYEREMAIL;

  /** 타임스탬프 */
  private String LGD_TIMESTAMP;

  /** 결제창 SKIN (red, blue, cyan, green, yellow) */
  private String LGD_CUSTOM_SKIN = "blue";

  /** 상점결제결과 처리(DB) 페이지 URL */
  private String LGD_NOTEURL = "/xpayctrl/xpaynoteProc.do";

  /** 가상계좌(무통장) 결제 연동을 하시는 경우 설정 */
  private String LGD_CASNOTEURL = "/xpayctrl/xpaycasnoteProc.do";

  /** hashdata 암호화 적용( LGD_MID + LGD_OID + LGD_AMOUNT + LGD_TIMESTAMP + LGD_MERTKEY ) */
  private String LGD_HASHDATA;

  /** 상점정의 결제가능수단 */
  private String LGD_CUSTOM_USABLEPAY;

  /** 사용한 결제수단 */
  private String LGD_PAYTYPE;

  /** 응답코드, '0000' 이면 성공 이외는 실패 */
  private String LGD_RESPCODE;

  /** 응답메세지 */
  private String LGD_RESPMSG;

  /** 신용카드번호 */
  private String LGD_CARDNUM;

  /** 거래종류(R:할당,I:입금,C:취소) */
  private String LGD_CASFLAG;

  /** 입금할 계좌번호 (가상계좌) */
  private String LGD_ACCOUNTNUM;

  /** 결제기관코드 */
  private String LGD_FINANCECODE;

  /** 결제기관 명 */
  private String LGD_FINANCENAME;

  public String getLGD_MID() {
    LGD_MID = ("test".equals(PLATFORM) ? "t" : "") + CST_MID;
    return LGD_MID;
  }

  public void setLGD_MID(String LGD_MID) {
    this.LGD_MID = LGD_MID;
  }


  public String getLGD_TIMESTAMP() {
    LGD_TIMESTAMP = genTimestamp();
    return LGD_TIMESTAMP;
  }


  public void setLGD_TIMESTAMP(String LGD_TIMESTAMP) {
    this.LGD_TIMESTAMP = LGD_TIMESTAMP;
  }

  public String genTimestamp() {
    Calendar cal = Calendar.getInstance();
    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
    return sf.format(cal.getTime());
  }

  public String genHashData() throws NoSuchAlgorithmException {
    StringBuffer sb = new StringBuffer();
    sb.append(LGD_MID);
    sb.append(LGD_OID);
    sb.append(LGD_AMOUNT);
    sb.append(LGD_TIMESTAMP);
    sb.append(LGD_MERTKEY);

    byte[] bNoti = sb.toString().getBytes();
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] digest = md.digest(bNoti);

    StringBuffer strBuf = new StringBuffer();
    for (int i = 0; i < digest.length; i++) {
      int c = digest[i] & 0xff;
      if (c <= 15) {
        strBuf.append("0");
      }
      strBuf.append(Integer.toHexString(c));
    }

    String LGD_HASHDATA = strBuf.toString();
    return LGD_HASHDATA;
  }

  public String genOid(String payprefix) {
    String oid = payprefix;
    oid += genTimestamp();
    oid += EgovWebUtil.generateIDString("", 10);
    return oid;
  }

  public String getPLATFORM() {
    return PLATFORM;
  }

  public void setPLATFORM(String PLATFORM) {
    this.PLATFORM = PLATFORM;
  }

  public String getCST_MID() {
    return CST_MID;
  }

  public void setCST_MID(String cST_MID) {
    CST_MID = cST_MID;
  }

  public String getLGD_OID() {
    return LGD_OID;
  }

  public void setLGD_OID(String lGD_OID) {
    LGD_OID = lGD_OID;
  }

  public int getLGD_AMOUNT() {
    return LGD_AMOUNT;
  }

  public void setLGD_AMOUNT(int lGD_AMOUNT) {
    LGD_AMOUNT = lGD_AMOUNT;
  }

  public String getLGD_MERTKEY() {
    return LGD_MERTKEY;
  }

  public void setLGD_MERTKEY(String lGD_MERTKEY) {
    LGD_MERTKEY = lGD_MERTKEY;
  }

  public String getLGD_BUYER() {
    return LGD_BUYER;
  }

  public void setLGD_BUYER(String lGD_BUYER) {
    LGD_BUYER = lGD_BUYER;
  }

  public String getLGD_PRODUCTINFO() {
    return LGD_PRODUCTINFO;
  }

  public void setLGD_PRODUCTINFO(String lGD_PRODUCTINFO) {
    LGD_PRODUCTINFO = lGD_PRODUCTINFO;
  }

  public String getLGD_BUYEREMAIL() {
    return LGD_BUYEREMAIL;
  }

  public void setLGD_BUYEREMAIL(String lGD_BUYEREMAIL) {
    LGD_BUYEREMAIL = lGD_BUYEREMAIL;
  }

  public String getLGD_CUSTOM_SKIN() {
    return LGD_CUSTOM_SKIN;
  }

  public void setLGD_CUSTOM_SKIN(String lGD_CUSTOM_SKIN) {
    LGD_CUSTOM_SKIN = lGD_CUSTOM_SKIN;
  }

  public String getLGD_NOTEURL() {
    return LGD_NOTEURL;
  }

  public void setLGD_NOTEURL(String lGD_NOTEURL) {
    LGD_NOTEURL = lGD_NOTEURL;
  }

  public String getLGD_CASNOTEURL() {
    return LGD_CASNOTEURL;
  }

  public void setLGD_CASNOTEURL(String lGD_CASNOTEURL) {
    LGD_CASNOTEURL = lGD_CASNOTEURL;
  }

  public String getLGD_HASHDATA() {
    return LGD_HASHDATA;
  }

  public void setLGD_HASHDATA(String lGD_HASHDATA) {
    LGD_HASHDATA = lGD_HASHDATA;
  }

  public String getLGD_CUSTOM_USABLEPAY() {
    return LGD_CUSTOM_USABLEPAY;
  }

  public void setLGD_CUSTOM_USABLEPAY(String lGD_CUSTOM_USABLEPAY) {
    LGD_CUSTOM_USABLEPAY = lGD_CUSTOM_USABLEPAY;
  }

  public String getLGD_RESPCODE() {
    return LGD_RESPCODE;
  }

  public void setLGD_RESPCODE(String lGD_RESPCODE) {
    LGD_RESPCODE = lGD_RESPCODE;
  }

  public String getLGD_RESPMSG() {
    return LGD_RESPMSG;
  }

  public void setLGD_RESPMSG(String lGD_RESPMSG) {
    LGD_RESPMSG = lGD_RESPMSG;
  }

  public String getLGD_CARDNUM() {
    return LGD_CARDNUM;
  }

  public void setLGD_CARDNUM(String lGD_CARDNUM) {
    LGD_CARDNUM = lGD_CARDNUM;
  }

  public String getLGD_CASFLAG() {
    return LGD_CASFLAG;
  }

  public void setLGD_CASFLAG(String lGD_CASFLAG) {
    LGD_CASFLAG = lGD_CASFLAG;
  }

  public String getLGD_ACCOUNTNUM() {
    return LGD_ACCOUNTNUM;
  }

  public void setLGD_ACCOUNTNUM(String lGD_ACCOUNTNUM) {
    LGD_ACCOUNTNUM = lGD_ACCOUNTNUM;
  }

  public String getLGD_TID() {
    return LGD_TID;
  }

  public void setLGD_TID(String lGD_TID) {
    LGD_TID = lGD_TID;
  }

  public String getLGD_PAYTYPE() {
    return LGD_PAYTYPE;
  }

  public void setLGD_PAYTYPE(String lGD_PAYTYPE) {
    LGD_PAYTYPE = lGD_PAYTYPE;
  }

  public String getLGD_FINANCECODE() {
    return LGD_FINANCECODE;
  }

  public void setLGD_FINANCECODE(String lGD_FINANCECODE) {
    LGD_FINANCECODE = lGD_FINANCECODE;
  }

  public String getLGD_FINANCENAME() {
    return LGD_FINANCENAME;
  }

  public void setLGD_FINANCENAME(String lGD_FINANCENAME) {
    LGD_FINANCENAME = lGD_FINANCENAME;
  }

  /**
   * @param args
   */
  public static void main(String[] args) {
    // TODO Auto-generated method stub

  }

}
