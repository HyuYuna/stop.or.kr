package egovframework.plani.template.man.menuctgry.vo;

import egovframework.plani.template.man.menuctgry.vo.base.SyscodeBaseVO;

public class SysauthVO extends SyscodeBaseVO {

  private static final long serialVersionUID = 1L;

  /** 권한코드 */
  private String auth_cd;

  /** 권한코드 */
  private String up_auth_cd;

  /** 권한명 */
  private String auth_nm;

  /** 권한 레벨 */
  private int auth_lv;

  /** 권한 순서 */
  private int auth_ord;

  public String getAuth_cd() {
    return auth_cd;
  }

  public void setAuth_cd(String auth_cd) {
    this.auth_cd = auth_cd;
  }

  public String getAuth_nm() {
    return auth_nm;
  }

  public void setAuth_nm(String auth_nm) {
    this.auth_nm = auth_nm;
  }

  public int getAuth_lv() {
    return auth_lv;
  }

  public void setAuth_lv(int auth_lv) {
    this.auth_lv = auth_lv;
  }

  public int getAuth_ord() {
    return auth_ord;
  }

  public void setAuth_ord(int auth_ord) {
    this.auth_ord = auth_ord;
  }

  public String getUp_auth_cd() {
    return up_auth_cd;
  }

  public void setUp_auth_cd(String up_auth_cd) {
    this.up_auth_cd = up_auth_cd;
  }


}

