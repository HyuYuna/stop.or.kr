package egovframework.plani.template.man.metsys.vo;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class AccessipVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 권한코드 */
  private String auth_cd;
  private String auth_nm;

  /** 접근 IP */
  private String access_ip;

  /** 설명 */
  private String description;

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

  public String getAccess_ip() {
    return access_ip;
  }

  public void setAccess_ip(String access_ip) {
    this.access_ip = access_ip;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

}

