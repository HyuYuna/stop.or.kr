package egovframework.plani.template.man.stat.vo;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class CommstatVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 통계 KEY */
  private String stat_key;

  /** 세션 ID */
  private String stat_sessid;

  /** 통계 KEY 설명 */
  private String stat_key_nm;

  /** 행위 상세 설명 */
  private String stat_key_dest;

  /** 도시 */
  private String stat_city;

  /** 국가 */
  private String stat_nat;

  /** 국가코드 */
  private String stat_nat_cd;

  /** 운영체제 종류 */
  private String stat_os;

  /** 브라우저 종류 */
  private String stat_bw;

  /** 이전페이지 링크 */
  private String stat_referer;

  /** 기록일 */
  private String stat_dt;

  /** 주소 */
  private String stat_raddr;

  /** UID */
  private String stat_uid;

  /** UNM */
  private String stat_unm;

  /** 차트 시리즈 구분명 */
  private String chartdata_srz;

  /** 차트 항목명 */
  private String chartdata_key;

  /** 차트 수치 */
  private int chartdata_val;

  /** 단위 선택 */
  private String date_choice = "DD";

  /** 총 접속 횟수 */
  private int tot_cnt;

  /** 총 접속 횟수 (중복 접속 허용) */
  private int tot_cnt_ignore_dup;


  public String getStat_key() {
    return stat_key;
  }

  public void setStat_key(String stat_key) {
    this.stat_key = stat_key;
  }

  public String getStat_sessid() {
    return stat_sessid;
  }

  public void setStat_sessid(String stat_sessid) {
    this.stat_sessid = stat_sessid;
  }

  public String getStat_city() {
    return stat_city;
  }

  public void setStat_city(String stat_city) {
    this.stat_city = stat_city;
  }

  public String getStat_nat() {
    return stat_nat;
  }

  public void setStat_nat(String stat_nat) {
    this.stat_nat = stat_nat;
  }

  public String getStat_nat_cd() {
    return stat_nat_cd;
  }

  public void setStat_nat_cd(String stat_nat_cd) {
    this.stat_nat_cd = stat_nat_cd;
  }

  public String getStat_bw() {
    return stat_bw;
  }

  public void setStat_bw(String stat_bw) {
    this.stat_bw = stat_bw;
  }

  public String getStat_referer() {
    return stat_referer;
  }

  public void setStat_referer(String stat_referer) {
    this.stat_referer = stat_referer;
  }

  public String getStat_dt() {
    return stat_dt;
  }

  public void setStat_dt(String stat_dt) {
    this.stat_dt = stat_dt;
  }

  public String getStat_key_nm() {
    return stat_key_nm;
  }

  public void setStat_key_nm(String stat_key_nm) {
    this.stat_key_nm = stat_key_nm;
  }

  public String getStat_os() {
    return stat_os;
  }

  public void setStat_os(String stat_os) {
    this.stat_os = stat_os;
  }

  public String getChartdata_key() {
    return chartdata_key;
  }

  public void setChartdata_key(String chartdata_key) {
    this.chartdata_key = chartdata_key;
  }

  public int getChartdata_val() {
    return chartdata_val;
  }

  public void setChartdata_val(int chartdata_val) {
    this.chartdata_val = chartdata_val;
  }

  public String getChartdata_srz() {
    return chartdata_srz;
  }

  public void setChartdata_srz(String chartdata_srz) {
    this.chartdata_srz = chartdata_srz;
  }

  public String getDate_choice() {
    return date_choice;
  }

  public void setDate_choice(String date_choice) {
    this.date_choice = date_choice;
  }

  public String getStat_raddr() {
    return stat_raddr;
  }

  public void setStat_raddr(String stat_raddr) {
    this.stat_raddr = stat_raddr;
  }

  public String getStat_uid() {
    return stat_uid;
  }

  public void setStat_uid(String stat_uid) {
    this.stat_uid = stat_uid;
  }

  public String getStat_unm() {
    return stat_unm;
  }

  public void setStat_unm(String stat_unm) {
    this.stat_unm = stat_unm;
  }

  public int getTot_cnt() {
    return tot_cnt;
  }

  public void setTot_cnt(int tot_cnt) {
    this.tot_cnt = tot_cnt;
  }

  public int getTot_cnt_ignore_dup() {
    return tot_cnt_ignore_dup;
  }

  public void setTot_cnt_ignore_dup(int tot_cnt_ignore_dup) {
    this.tot_cnt_ignore_dup = tot_cnt_ignore_dup;
  }

  public String getStat_key_dest() {
    return stat_key_dest;
  }

  public void setStat_key_dest(String stat_key_dest) {
    this.stat_key_dest = stat_key_dest;
  }


}

