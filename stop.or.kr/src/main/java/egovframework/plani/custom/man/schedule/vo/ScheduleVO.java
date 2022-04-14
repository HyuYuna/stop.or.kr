package egovframework.plani.custom.man.schedule.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class ScheduleVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  private int sch_idx;

  @NotEmpty
  private String subject;

  @NotEmpty
  private String s_date;

  @NotEmpty
  private String e_date;

  private String wdt;
  private String mdt;

  private String SrchcalYr;
  private String SrchcalMon;


  public int getSch_idx() {
    return sch_idx;
  }

  public void setSch_idx(int sch_idx) {
    this.sch_idx = sch_idx;
  }

  public String getSubject() {
    return subject;
  }

  public void setSubject(String subject) {
    this.subject = subject;
  }

  public String getS_date() {
    return s_date;
  }

  public void setS_date(String s_date) {
    this.s_date = s_date;
  }

  public String getE_date() {
    return e_date;
  }

  public void setE_date(String e_date) {
    this.e_date = e_date;
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

  public String getSrchcalYr() {
    return SrchcalYr;
  }

  public void setSrchcalYr(String srchcalYr) {
    SrchcalYr = srchcalYr;
  }

  public String getSrchcalMon() {
    return SrchcalMon;
  }

  public void setSrchcalMon(String srchcalMon) {
    SrchcalMon = srchcalMon;
  }



}
