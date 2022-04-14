package egovframework.plani.template.survey.vo;

public class SrvyquesansVO extends SrvybaseVO {

  private static final long serialVersionUID = 1L;

  /** 질문 번호 */
  private int ques_idx = 0;

  /** 질문내 질문 답변 번호 (설문결과 저장시에는 이값을 참조하지 않는다.. 답변값이 중간에 삭제될 수 있기 때문) */
  private int quesans_idx = 0;

  /** 설문조사 번호 */
  private int srvy_idx = 0;

  /** 파트 번호 */
  private int part_idx = 0;

  /** 질문 / 답변 구분 */
  private String quesans_type;

  /** 질문 / 답변 내용 */
  private String quesans_cont;

  /** 질문 타입 */
  private String ques_type;
  private String ques_type_nm;

  /** 보충답변 (Ex: 기타) 필요여부 */
  private String ans_need_spl;

  /** 답변 번호 (중요! - 답변의 순서는 이 값에 의해 정해지며, 설문 결과 저장시 이 값을 참조한다..) */
  private int ans_ord = 0;

  /** 답변 개수 */
  private int ans_cnt = 0;

  /** 답변 통계 */
  private String ans_pct;

  /** 응닶 없음 답변 통계 */
  private String no_ans_pct;

  /** 질문 답변 NULL 허용 여부 */
  private String quesans_null;

  private int[] arr_ques_idx;
  private int[] arr_quesans_idx;
  private String[] arr_quesans_cont;
  private String[] arr_quesans_type;
  private int[] arr_ans_ord;
  private String[] arr_ans_need_spl;

  public int getQues_idx() {
    return ques_idx;
  }

  public void setQues_idx(int ques_idx) {
    this.ques_idx = ques_idx;
  }

  public int getQuesans_idx() {
    return quesans_idx;
  }

  public void setQuesans_idx(int quesans_idx) {
    this.quesans_idx = quesans_idx;
  }

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

  public String getQuesans_type() {
    return quesans_type;
  }

  public void setQuesans_type(String quesans_type) {
    this.quesans_type = quesans_type;
  }

  public String getQuesans_cont() {
    return quesans_cont;
  }

  public void setQuesans_cont(String quesans_cont) {
    this.quesans_cont = quesans_cont;
  }

  public String getQues_type() {
    return ques_type;
  }

  public void setQues_type(String ques_type) {
    this.ques_type = ques_type;
  }

  public String getQues_type_nm() {
    return ques_type_nm;
  }

  public void setQues_type_nm(String ques_type_nm) {
    this.ques_type_nm = ques_type_nm;
  }

  public String getAns_need_spl() {
    return ans_need_spl;
  }

  public void setAns_need_spl(String ans_need_spl) {
    this.ans_need_spl = ans_need_spl;
  }

  public int getAns_ord() {
    return ans_ord;
  }

  public void setAns_ord(int ans_ord) {
    this.ans_ord = ans_ord;
  }

  public int[] getArr_ques_idx() {
    return arr_ques_idx;
  }

  public void setArr_ques_idx(int[] arr_ques_idx) {
    this.arr_ques_idx = arr_ques_idx;
  }

  public int[] getArr_quesans_idx() {
    return arr_quesans_idx;
  }

  public void setArr_quesans_idx(int[] arr_quesans_idx) {
    this.arr_quesans_idx = arr_quesans_idx;
  }

  public String[] getArr_quesans_cont() {
    return arr_quesans_cont;
  }

  public void setArr_quesans_cont(String[] arr_quesans_cont) {
    this.arr_quesans_cont = arr_quesans_cont;
  }

  public String[] getArr_quesans_type() {
    return arr_quesans_type;
  }

  public void setArr_quesans_type(String[] arr_quesans_type) {
    this.arr_quesans_type = arr_quesans_type;
  }

  public int[] getArr_ans_ord() {
    return arr_ans_ord;
  }

  public void setArr_ans_ord(int[] arr_ans_ord) {
    this.arr_ans_ord = arr_ans_ord;
  }

  public String[] getArr_ans_need_spl() {
    return arr_ans_need_spl;
  }

  public void setArr_ans_need_spl(String[] arr_ans_need_spl) {
    this.arr_ans_need_spl = arr_ans_need_spl;
  }

  public int getAns_cnt() {
    return ans_cnt;
  }

  public void setAns_cnt(int ans_cnt) {
    this.ans_cnt = ans_cnt;
  }

  public String getAns_pct() {
    return ans_pct;
  }

  public void setAns_pct(String ans_pct) {
    this.ans_pct = ans_pct;
  }

  public String getNo_ans_pct() {
    return no_ans_pct;
  }

  public void setNo_ans_pct(String no_ans_pct) {
    this.no_ans_pct = no_ans_pct;
  }

  public String getQuesans_null() {
    return quesans_null;
  }

  public void setQuesans_null(String quesans_null) {
    this.quesans_null = quesans_null;
  }
}

