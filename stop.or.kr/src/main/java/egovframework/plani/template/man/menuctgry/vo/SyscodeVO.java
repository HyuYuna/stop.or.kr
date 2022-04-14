package egovframework.plani.template.man.menuctgry.vo;

import egovframework.plani.template.man.menuctgry.vo.base.SyscodeBaseVO;

public class SyscodeVO extends SyscodeBaseVO {

  private static final long serialVersionUID = 1L;

  /** 코드 ID */
  private String code_idx;

  /** 상위코드 ID */
  private String up_code_idx;

  /** 코드 명 */
  private String code_nm;

  /** 코드 순서 */
  private int code_ord;

  /** 조회 제외시킬 코드 목록 */
  private String except_codes;

  public String getCode_idx() {
    return code_idx;
  }

  public void setCode_idx(String code_idx) {
    this.code_idx = code_idx;
  }

  public String getUp_code_idx() {
    return up_code_idx;
  }

  public void setUp_code_idx(String up_code_idx) {
    this.up_code_idx = up_code_idx;
  }

  public String getCode_nm() {
    return code_nm;
  }

  public void setCode_nm(String code_nm) {
    this.code_nm = code_nm;
  }

  public int getCode_ord() {
    return code_ord;
  }

  public void setCode_ord(int code_ord) {
    this.code_ord = code_ord;
  }

  public String getExcept_codes() {
    return except_codes;
  }

  public void setExcept_codes(String except_codes) {
    this.except_codes = except_codes;
  }



}

