package egovframework.plani.custom.memsvc.vo;

import org.hibernate.validator.constraints.NotEmpty;

public class LoginVO {

  /** 아이디 */
  @NotEmpty
  private String user_id;

  /** 패스워드 */
  @NotEmpty
  private String user_scrt;

  public String getUser_id() {
    return user_id;
  }

  public void setUser_id(String user_id) {
    this.user_id = user_id;
  }

  public String getUser_scrt() {
    return user_scrt;
  }

  public void setUser_scrt(String user_scrt) {
    this.user_scrt = user_scrt;
  }
}
