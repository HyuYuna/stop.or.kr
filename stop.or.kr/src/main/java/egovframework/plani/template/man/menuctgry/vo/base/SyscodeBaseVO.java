package egovframework.plani.template.man.menuctgry.vo.base;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class SyscodeBaseVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;


  /** 사용여부 */
  private String use_yn;

  /** 상위/하위 구분 */
  private String child_gb;

  /** job 구분 */
  private String job_gb;

  /** 순서조회 From */
  private int from_ord = 0;

  /** 순서조회 To */
  private int to_ord = 0;

  /** 순서조회에 필요 */
  private int add_ord = 1;

  public String getChild_gb() {
    return child_gb;
  }

  public void setChild_gb(String child_gb) {
    this.child_gb = child_gb;
  }

  public String getJob_gb() {
    return job_gb;
  }

  public void setJob_gb(String job_gb) {
    this.job_gb = job_gb;
  }

  public String getUse_yn() {
    return use_yn;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }

  public int getFrom_ord() {
    return from_ord;
  }

  public void setFrom_ord(int from_ord) {
    this.from_ord = from_ord;
  }

  public int getTo_ord() {
    return to_ord;
  }

  public void setTo_ord(int to_ord) {
    this.to_ord = to_ord;
  }

  public int getAdd_ord() {
    return add_ord;
  }

  public void setAdd_ord(int add_ord) {
    this.add_ord = add_ord;
  }

}

