package egovframework.plani.template.brdartcl.vo;

public class BoardrcmndVO extends BoarddefaultVO {

  private static final long serialVersionUID = 1L;

  /** 순번 */
  private int rcmnd_idx;

  /** 추천인/ 반대인 ID */
  private String rcmnd_id;

  /** 추천:R/반대:J 구분 */
  private String rcmnd_gb;

  /** 추천/반대 일시 */
  private String rdt;


  public int getRcmnd_idx() {
    return rcmnd_idx;
  }

  public void setRcmnd_idx(int rcmnd_idx) {
    this.rcmnd_idx = rcmnd_idx;
  }

  public String getRcmnd_id() {
    return rcmnd_id;
  }

  public void setRcmnd_id(String rcmnd_id) {
    this.rcmnd_id = rcmnd_id;
  }

  public String getRcmnd_gb() {
    return rcmnd_gb;
  }

  public void setRcmnd_gb(String rcmnd_gb) {
    this.rcmnd_gb = rcmnd_gb;
  }

  public String getRdt() {
    return rdt;
  }

  public void setRdt(String rdt) {
    this.rdt = rdt;
  }



}

