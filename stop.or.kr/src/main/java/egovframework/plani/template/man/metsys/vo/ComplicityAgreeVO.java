package egovframework.plani.template.man.metsys.vo;

import javax.validation.constraints.Pattern;
import org.hibernate.validator.constraints.NotEmpty;

public class ComplicityAgreeVO {

  @NotEmpty(message = "개인정보보호를 위한 이용자 동의사항에 동의하여 주십시오.")
  @Pattern(regexp = "1", message = "개인정보보호를 위한 이용자 동의사항에 동의하여 주십시오.")
  private String agree1;

  @NotEmpty(message = "제3자 제공에 관한 사항에 동의하여 주십시오.")
  @Pattern(regexp = "1", message = "제3자 제공에 관한 사항에 동의하여 주십시오.")
  private String agree2;

  @NotEmpty(message = "저작권 확인 및 동의사항에 동의하여 주십시오.")
  @Pattern(regexp = "1", message = "저작권 확인 및 동의사항에 동의하여 주십시오.")
  private String agree3;

  public String getAgree1() {
    return agree1;
  }

  public void setAgree1(String agree1) {
    this.agree1 = agree1;
  }

  public String getAgree2() {
    return agree2;
  }

  public void setAgree2(String agree2) {
    this.agree2 = agree2;
  }

  public String getAgree3() {
    return agree3;
  }

  public void setAgree3(String agree3) {
    this.agree3 = agree3;
  }

}
