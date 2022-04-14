package egovframework.plani.custom.man.newsletter.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.custom.form.validator.EmailCheck;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class NewsletterVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  private int new_idx;

  @NotEmpty
  @EmailCheck(dependency = true)
  private String email;

  private String wdt;

  private String mdt;

  private String deldt;
  
  private String reason;//20200608 사유 추가
  
  private String agree;//20200727 재동의여부 추가

  public String getAgree() {
	return agree;
}

public void setAgree(String agree) {
	this.agree = agree;
}

public String getReason() {
	return reason;
}

public void setReason(String reason) {
	this.reason = reason;
}

public int getNew_idx() {
    return new_idx;
  }

  public void setNew_idx(int new_idx) {
    this.new_idx = new_idx;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  @Override
  public String getWdt() {
    return wdt;
  }

  @Override
  public void setWdt(String wdt) {
    this.wdt = wdt;
  }

  @Override
  public String getMdt() {
    return mdt;
  }

  @Override
  public void setMdt(String mdt) {
    this.mdt = mdt;
  }

  public String getDeldt() {
    return deldt;
  }

  public void setDeldt(String deldt) {
    this.deldt = deldt;
  }



}
