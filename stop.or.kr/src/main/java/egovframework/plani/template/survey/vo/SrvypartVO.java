package egovframework.plani.template.survey.vo;

public class SrvypartVO extends SrvybaseVO {

  private static final long serialVersionUID = 1L;

  /** 개인정보 수집 안내 */
  private String part_psn_info;

  /** 하위 질문 개수 */
  private String part_ques_cnt;


  public String getPart_psn_info() {
    return part_psn_info;
  }

  public void setPart_psn_info(String part_psn_info) {
    this.part_psn_info = part_psn_info;
  }

  public String getPart_ques_cnt() {
    return part_ques_cnt;
  }

  public void setPart_ques_cnt(String part_ques_cnt) {
    this.part_ques_cnt = part_ques_cnt;
  }


}


