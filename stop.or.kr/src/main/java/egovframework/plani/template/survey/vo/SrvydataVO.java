package egovframework.plani.template.survey.vo;

public class SrvydataVO extends SrvybaseVO {

  private static final long serialVersionUID = 1L;

  /** 데이터 번호 (설문조사 응답자 일련번호;시퀀스) */
  private int data_idx = 0;

  /** 질문 번호 */
  private int ques_idx = 0;
  /** 서브질문 번호 (서브질문 번호 (만족도 평가 / 선호도선택 의 하위 항목에 사용)) */
  private int quessub_idx = 0;

  /** 답변 저장 값 */
  private String data_cont;

  /** 답변 저장값의 텍스트 값 */
  private String ref_cont;

  /** 답변 저장 보충 값 */
  private String data_spl;

  /** 답변자 식별값 (IP주소 등) */
  private String data_addr;

  /** 설문값 저장 배열 */
  private int[] arr_ques_idx;
  private String[] arr_ques_type;
  private String[] arr_answer;

  /** 응답자 성명 */
  private String srvy_appl_nm;

  /** 응답자 전화번호 */
  private String srvy_appl_cp;

  /** 시퀀스 명 */
  private String srvy_seq_name;

  /** 시퀀스 순번 */
  private int srvy_out_seq;

  public String getSrvy_seq_name() {
    return srvy_seq_name;
  }

  public void setSrvy_seq_name(String srvy_seq_name) {
    this.srvy_seq_name = srvy_seq_name;
  }

  public int getSrvy_out_seq() {
    return srvy_out_seq;
  }

  public void setSrvy_out_seq(int srvy_out_seq) {
    this.srvy_out_seq = srvy_out_seq;
  }

  public int getData_idx() {
    return data_idx;
  }

  public void setData_idx(int data_idx) {
    this.data_idx = data_idx;
  }

  public int getQues_idx() {
    return ques_idx;
  }

  public void setQues_idx(int ques_idx) {
    this.ques_idx = ques_idx;
  }

  public int getQuessub_idx() {
    return quessub_idx;
  }

  public void setQuessub_idx(int quessub_idx) {
    this.quessub_idx = quessub_idx;
  }

  public String getData_cont() {
    return data_cont;
  }

  public void setData_cont(String data_cont) {
    this.data_cont = data_cont;
  }

  public String getData_spl() {
    return data_spl;
  }

  public void setData_spl(String data_spl) {
    this.data_spl = data_spl;
  }

  public String getData_addr() {
    return data_addr;
  }

  public void setData_addr(String data_addr) {
    this.data_addr = data_addr;
  }

  public int[] getArr_ques_idx() {
    return arr_ques_idx;
  }

  public void setArr_ques_idx(int[] arr_ques_idx) {
    this.arr_ques_idx = arr_ques_idx;
  }

  public String[] getArr_ques_type() {
    return arr_ques_type;
  }

  public void setArr_ques_type(String[] arr_ques_type) {
    this.arr_ques_type = arr_ques_type;
  }

  public String[] getArr_answer() {
    return arr_answer;
  }

  public void setArr_answer(String[] arr_answer) {
    this.arr_answer = arr_answer;
  }

  public String getSrvy_appl_nm() {
    return srvy_appl_nm;
  }

  public void setSrvy_appl_nm(String srvy_appl_nm) {
    this.srvy_appl_nm = srvy_appl_nm;
  }

  public String getSrvy_appl_cp() {
    return srvy_appl_cp;
  }

  public void setSrvy_appl_cp(String srvy_appl_cp) {
    this.srvy_appl_cp = srvy_appl_cp;
  }

  public String getRef_cont() {
    return ref_cont;
  }

  public void setRef_cont(String ref_cont) {
    this.ref_cont = ref_cont;
  }

}
