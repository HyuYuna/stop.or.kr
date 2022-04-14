package egovframework.plani.template.survey.vo;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class SrvybaseVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;


  /** 설문조사 번호 */
  private int srvy_idx = 0;

  /** 파트 번호 */
  private int part_idx = 0;

  /** 설문 참여 인원 수 */
  private int srvy_appl_cnt = 0;

  /** 설문 파트 수 */
  private int srvy_part_cnt = 0;

  /** 현재시점 설문 진행 여부 */
  private String srvy_act_yn;
  private String srch_srvy_act_yn;

  /** 설문조사 명 */
  private String srvy_nm;

  /** 파트 명 */
  private String part_nm;

  /** 응답자 성명 저장 인덱스 (고정) */
  private final int srvy_nm_idx = 2001;
  /** 응답자 전화번호 저장 인덱스 (고정) */
  private final int srvy_cp_idx = 2002;

  /** 파트 구분 (개인정보 / 일반파트) */
  private String part_type = "CDIDX00063";

  public int getSrvy_idx() {
    return srvy_idx;
  }

  public void setSrvy_idx(int srvy_idx) {
    this.srvy_idx = srvy_idx;
  }

  public int getPart_idx() {
    return part_idx;
  }

  public void setPart_idx(int part_idx) {
    this.part_idx = part_idx;
  }

  public int getSrvy_appl_cnt() {
    return srvy_appl_cnt;
  }

  public void setSrvy_appl_cnt(int srvy_appl_cnt) {
    this.srvy_appl_cnt = srvy_appl_cnt;
  }

  public int getSrvy_part_cnt() {
    return srvy_part_cnt;
  }

  public void setSrvy_part_cnt(int srvy_part_cnt) {
    this.srvy_part_cnt = srvy_part_cnt;
  }

  public String getSrvy_act_yn() {
    return srvy_act_yn;
  }

  public void setSrvy_act_yn(String srvy_act_yn) {
    this.srvy_act_yn = srvy_act_yn;
  }

  public String getSrvy_nm() {
    return srvy_nm;
  }

  public void setSrvy_nm(String srvy_nm) {
    this.srvy_nm = srvy_nm;
  }

  public String getPart_nm() {
    return part_nm;
  }

  public void setPart_nm(String part_nm) {
    this.part_nm = part_nm;
  }

  public int getSrvy_nm_idx() {
    return srvy_nm_idx;
  }

  public int getSrvy_cp_idx() {
    return srvy_cp_idx;
  }

  public String getPart_type() {
    return part_type;
  }

  public void setPart_type(String part_type) {
    this.part_type = part_type;
  }

  public String getSrch_srvy_act_yn() {
    return srch_srvy_act_yn;
  }

  public void setSrch_srvy_act_yn(String srch_srvy_act_yn) {
    this.srch_srvy_act_yn = srch_srvy_act_yn;
  }


}

