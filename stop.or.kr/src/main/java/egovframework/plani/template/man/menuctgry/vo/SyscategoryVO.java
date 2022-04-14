package egovframework.plani.template.man.menuctgry.vo;

import egovframework.plani.template.man.menuctgry.vo.base.SyscodeBaseVO;

public class SyscategoryVO extends SyscodeBaseVO {

  private static final long serialVersionUID = 1L;

  /** 카테고리 ID */
  private String ctgry_idx = "";

  /** 상위카테고리 ID */
  private String up_ctgry_idx = "";

  /** 카테고리 명 */
  private String ctgry_nm = "";

  /** 카테고리 순서 */
  private int ctgry_ord = 1;

  public String getCtgry_idx() {
    return ctgry_idx;
  }

  public void setCtgry_idx(String ctgry_idx) {
    this.ctgry_idx = ctgry_idx;
  }

  public String getUp_ctgry_idx() {
    return up_ctgry_idx;
  }

  public void setUp_ctgry_idx(String up_ctgry_idx) {
    this.up_ctgry_idx = up_ctgry_idx;
  }

  public String getCtgry_nm() {
    return ctgry_nm;
  }

  public void setCtgry_nm(String ctgry_nm) {
    this.ctgry_nm = ctgry_nm;
  }

  public int getCtgry_ord() {
    return ctgry_ord;
  }

  public void setCtgry_ord(int ctgry_ord) {
    this.ctgry_ord = ctgry_ord;
  }


}

