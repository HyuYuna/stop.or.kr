package egovframework.plani.template.brdartcl.vo;

/**
 * @author yjlee
 *
 */
public class BoarddryVO extends BoarddefaultVO {

  private static final long serialVersionUID = 1L;

  /** 시작일시 */
  private String startdt;

  /** 종료일시 */
  private String enddt;

  /** 반복 여부 */
  private String repeat_yn;

  /** 종일스케줄 여부 */
  private String allday_yn;

  /** 국경일 여부 */
  private String holiday_yn;

  private String modeV;
  private String srchcalYr;
  private String srchcalMon;
  private String srchcalDay;

  private String startdd;
  private String enddd;

  /** 참조 URL */
  private String ref_url;

  private String writer_nm;

  private String ref_target;
  private String dry_place;

  /** 참조 키 */
  private String reference_key;

  public String getStartdt() {
    return startdt;
  }

  public void setStartdt(String startdt) {
    this.startdt = startdt;
  }

  public String getEnddt() {
    return enddt;
  }

  public void setEnddt(String enddt) {
    this.enddt = enddt;
  }

  public String getRepeat_yn() {
    return repeat_yn;
  }

  public void setRepeat_yn(String repeat_yn) {
    this.repeat_yn = repeat_yn;
  }

  public String getAllday_yn() {
    return allday_yn;
  }

  public void setAllday_yn(String allday_yn) {
    this.allday_yn = allday_yn;
  }

  public String getHoliday_yn() {
    return holiday_yn;
  }

  public void setHoliday_yn(String holiday_yn) {
    this.holiday_yn = holiday_yn;
  }

  public String getRef_url() {
    return ref_url;
  }

  public void setRef_url(String ref_url) {
    this.ref_url = ref_url;
  }

  public String getWriter_nm() {
    return writer_nm;
  }

  public void setWriter_nm(String writer_nm) {
    this.writer_nm = writer_nm;
  }

  public String getReference_key() {
    return reference_key;
  }

  public void setReference_key(String reference_key) {
    this.reference_key = reference_key;
  }

  public String getModeV() {
    return modeV;
  }

  public void setModeV(String modeV) {
    this.modeV = modeV;
  }

  public String getSrchcalYr() {
    return srchcalYr;
  }

  public void setSrchcalYr(String srchcalYr) {
    this.srchcalYr = srchcalYr;
  }

  public String getSrchcalMon() {
    return srchcalMon;
  }

  public void setSrchcalMon(String srchcalMon) {
    this.srchcalMon = srchcalMon;
  }

  public String getStartdd() {
    return startdd;
  }

  public void setStartdd(String startdd) {
    this.startdd = startdd;
  }

  public String getRef_target() {
    return ref_target;
  }

  public void setRef_target(String ref_target) {
    this.ref_target = ref_target;
  }

  public String getDry_place() {
    return dry_place;
  }

  public void setDry_place(String dry_place) {
    this.dry_place = dry_place;
  }

  public String getEnddd() {
    return enddd;
  }

  public void setEnddd(String enddd) {
    this.enddd = enddd;
  }

  public String getSrchcalDay() {
    return srchcalDay;
  }

  public void setSrchcalDay(String srchcalDay) {
    this.srchcalDay = srchcalDay;
  }



}

