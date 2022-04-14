package egovframework.plani.template.man.metsys.vo;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class ComplicityConfirmVO {

  @NotEmpty(message = "이메일 주소를 입력해주세요.")
  @Email(message = "이메일 형식이 올바르지 않습니다.")
  private String email;

  @NotEmpty(message = "이름을  입력해주세요.")
  private String name;

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }


}
