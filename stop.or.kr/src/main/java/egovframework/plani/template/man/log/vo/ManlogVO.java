package egovframework.plani.template.man.log.vo;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class ManlogVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 일련번호 */
  private int log_idx;

  /** 로그 KEY */
  private String log_key;

  /** 로그 KEY 설명 */
  private String log_key_nm;

  /** 로그 상세 */
  private String log_key_dest;

  /** 작업 구분 */
  private String log_job_gb;

  /** IP 주소 */
  private String log_raddr;

  /** 행위자 ID */
  private String log_uid;
  private String log_unm;

  /** 기록일 */
  private String log_dt;

  public int getLog_idx() {
    return log_idx;
  }

  public void setLog_idx(int log_idx) {
    this.log_idx = log_idx;
  }

  public String getLog_key() {
    return log_key;
  }

  public void setLog_key(String log_key) {
    this.log_key = log_key;
  }

  public String getLog_key_nm() {
    return log_key_nm;
  }

  public void setLog_key_nm(String log_key_nm) {
    this.log_key_nm = log_key_nm;
  }

  public String getLog_key_dest() {
    return log_key_dest;
  }

  public void setLog_key_dest(String log_key_dest) {
    this.log_key_dest = log_key_dest;
  }

  public String getLog_raddr() {
    return log_raddr;
  }

  public void setLog_raddr(String log_raddr) {
    this.log_raddr = log_raddr;
  }

  public String getLog_uid() {
    return log_uid;
  }

  public void setLog_uid(String log_uid) {
    this.log_uid = log_uid;
  }

  public String getLog_dt() {
    return log_dt;
  }

  public void setLog_dt(String log_dt) {
    this.log_dt = log_dt;
  }

  public String getLog_unm() {
    return log_unm;
  }

  public void setLog_unm(String log_unm) {
    this.log_unm = log_unm;
  }

  public String getLog_job_gb() {
    return log_job_gb;
  }

  public void setLog_job_gb(String log_job_gb) {
    this.log_job_gb = log_job_gb;
  }


}

