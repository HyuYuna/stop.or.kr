package egovframework.plani.custom.man.company.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class CompanyVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  private int com_idx;

  private String div;

  private int seq;

  private String vchkcode;

  private String subject;

  @NotEmpty(message = "기관명을 입력해주세요.")
  private String name;

  private String wdt;

  public int getCom_idx() {
    return com_idx;
  }

  public void setCom_idx(int com_idx) {
    this.com_idx = com_idx;
  }

  public String getDiv() {
    return div;
  }

  public void setDiv(String div) {
    this.div = div;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  @Override
  public String getWdt() {
    return wdt;
  }

  @Override
  public void setWdt(String wdt) {
    this.wdt = wdt;
  }

  public int getSeq() {
    return seq;
  }

  public void setSeq(int seq) {
    this.seq = seq;
  }

  @Override
  public String getVchkcode() {
    return vchkcode;
  }

  @Override
  public void setVchkcode(String vchkcode) {
    this.vchkcode = vchkcode;
  }

  public String getSubject() {
    return subject;
  }

  public void setSubject(String subject) {
    this.subject = subject;
  }



}
