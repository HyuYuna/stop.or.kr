package egovframework.plani.template.man.metsys.vo;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class WithdrawalVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 순번 */
  private int wd_idx;

  /** 회원ID */
  private String user_id;

  /** 게시물 순번 */
  private String user_nm;

  /** 가입일 */
  private String jdt;

  /** 탈퇴일 */
  private String wdt;

  /** 탈퇴사유 */
  private String wreason;

  public int getWd_idx() {
    return wd_idx;
  }

  public void setWd_idx(int wd_idx) {
    this.wd_idx = wd_idx;
  }

  public String getUser_id() {
    return user_id;
  }

  public void setUser_id(String user_id) {
    this.user_id = user_id;
  }

  public String getUser_nm() {
    return user_nm;
  }

  public void setUser_nm(String user_nm) {
    this.user_nm = user_nm;
  }

  public String getJdt() {
    return jdt;
  }

  public void setJdt(String jdt) {
    this.jdt = jdt;
  }

  public String getWdt() {
    return wdt;
  }

  public void setWdt(String wdt) {
    this.wdt = wdt;
  }

  public String getWreason() {
    return wreason;
  }

  public void setWreason(String wreason) {
    this.wreason = wreason;
  }

}

