package egovframework.plani.template.survey.vo;

public class SrvymainVO extends SrvybaseVO {

  private static final long serialVersionUID = 1L;

  /** 설문조사 내용 */
  private String srvy_cont;

  /** 현재시점 설문실시 여부[Y/N] */
  private String srvy_open_yn;

  /** 설문조사 시작일 */
  private String srvy_start;

  /** 설문조사 종료일 */
  private String srvy_end;

  /** 중복응답 허용여부 [Y/N] */
  private String srvy_allow_dup;

  /** 선착순 설정 (0 : 제한없음) */
  private int srvy_max_ans = 0;

  /** 안내 팝업 크기 / 위치 */
  private String srvy_x = "50";
  private String srvy_y = "50";
  private String srvy_w = "400";
  private String srvy_h = "500";

  /** 팝업 타입 */
  private String srvy_pop_type = "W";

  public String getSrvy_cont() {
    return srvy_cont;
  }

  public void setSrvy_cont(String srvy_cont) {
    this.srvy_cont = srvy_cont;
  }

  public String getSrvy_open_yn() {
    return srvy_open_yn;
  }

  public void setSrvy_open_yn(String srvy_open_yn) {
    this.srvy_open_yn = srvy_open_yn;
  }

  public String getSrvy_start() {
    return srvy_start;
  }

  public void setSrvy_start(String srvy_start) {
    this.srvy_start = srvy_start;
  }

  public String getSrvy_end() {
    return srvy_end;
  }

  public void setSrvy_end(String srvy_end) {
    this.srvy_end = srvy_end;
  }

  public String getSrvy_allow_dup() {
    return srvy_allow_dup;
  }

  public void setSrvy_allow_dup(String srvy_allow_dup) {
    this.srvy_allow_dup = srvy_allow_dup;
  }

  public int getSrvy_max_ans() {
    return srvy_max_ans;
  }

  public void setSrvy_max_ans(int srvy_max_ans) {
    this.srvy_max_ans = srvy_max_ans;
  }

  public String getSrvy_x() {
    return srvy_x;
  }

  public void setSrvy_x(String srvy_x) {
    this.srvy_x = srvy_x;
  }

  public String getSrvy_y() {
    return srvy_y;
  }

  public void setSrvy_y(String srvy_y) {
    this.srvy_y = srvy_y;
  }

  public String getSrvy_w() {
    return srvy_w;
  }

  public void setSrvy_w(String srvy_w) {
    this.srvy_w = srvy_w;
  }

  public String getSrvy_h() {
    return srvy_h;
  }

  public void setSrvy_h(String srvy_h) {
    this.srvy_h = srvy_h;
  }

  public String getSrvy_pop_type() {
    return srvy_pop_type;
  }

  public void setSrvy_pop_type(String srvy_pop_type) {
    this.srvy_pop_type = srvy_pop_type;
  }



}

