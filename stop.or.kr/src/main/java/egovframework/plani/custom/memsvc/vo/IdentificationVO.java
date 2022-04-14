package egovframework.plani.custom.memsvc.vo;

public class IdentificationVO {

  /** 이름 */
  private String user_nm;

  /** 주민번호 앞자리 */
  private String rrn1;

  /** 주민번호 뒷자리 */
  private String rrn2;

  /** 핸드폰 번호 */
  private String cpno;

  /** 인증 방법 : 구분할 수 있도록만..[1 : IPIN, 2: 핸드폰] */
  private String confirm_way;

  /** 공공아이핀 CI */
  private String gpin_ci;

  /** ID KEY : 인증후에 받은 결과값중 인증을 구분할 수 있는 키값 */
  private String idkey;


  public String getUser_nm() {
    return user_nm;
  }

  public void setUser_nm(String user_nm) {
    this.user_nm = user_nm;
  }

  public String getConfirm_way() {
    return confirm_way;
  }

  public void setConfirm_way(String confirm_way) {
    this.confirm_way = confirm_way;
  }

  public String getGpin_ci() {
    return gpin_ci;
  }

  public void setGpin_ci(String gpin_ci) {
    this.gpin_ci = gpin_ci;
  }

  public String getRrn1() {
    return rrn1;
  }

  public void setRrn1(String rrn1) {
    this.rrn1 = rrn1;
  }

  public String getIdkey() {
    return idkey;
  }

  public void setIdkey(String idkey) {
    this.idkey = idkey;
  }

  public String getRrn2() {
    return rrn2;
  }

  public void setRrn2(String rrn2) {
    this.rrn2 = rrn2;
  }

  public String getCpno() {
    return cpno;
  }

  public void setCpno(String cpno) {
    this.cpno = cpno;
  }



}
