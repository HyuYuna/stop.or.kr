package egovframework.plani.template.man.metsys.vo;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class VisitLogVO extends DefaultSearchVO {
  private String vst_key; // 방문자 고유키
  private String vst_dt; // 방문 일자
  private String vst_tm; // 방문 시간
  private String vst_y; // 방문 년
  private String vst_m; // 방문 월
  private String vst_d; // 방문 일
  private String vst_h; // 방문 시
  private String vst_ip; // 방문자 IP
  private String vst_agent; // 방문자 브라우저
  private String vst_nation; // 방문자 국가
  private String vst_refer_site; // 검색 site
  private String vst_keyword; // 검색어
  private String vst_refer_url; // 리퍼러 full url
  private String vst_page; // 방문페이지
  private String vst_content_key;// 방문페이지의 콘텐트 종류
  private String vst_city; // 방문자의 도시
  private String col; // 검색 항목
  private long cnt;
  private double rate; // 비율
  private String chartType; // 차트 종
  private String searchFrom;
  private String searchTo;
  private String searchContentKey;

  public String getVst_key() {
    return vst_key;
  }

  public void setVst_key(String vst_key) {
    this.vst_key = vst_key;
  }

  public String getVst_dt() {
    return vst_dt;
  }

  public void setVst_dt(String vst_dt) {
    this.vst_dt = vst_dt;
  }

  public String getVst_tm() {
    return vst_tm;
  }

  public void setVst_tm(String vst_tm) {
    this.vst_tm = vst_tm;
  }

  public String getVst_y() {
    return vst_y;
  }

  public void setVst_y(String vst_y) {
    this.vst_y = vst_y;
  }

  public String getVst_m() {
    return vst_m;
  }

  public void setVst_m(String vst_m) {
    this.vst_m = vst_m;
  }

  public String getVst_d() {
    return vst_d;
  }

  public void setVst_d(String vst_d) {
    this.vst_d = vst_d;
  }

  public String getVst_h() {
    return vst_h;
  }

  public void setVst_h(String vst_h) {
    this.vst_h = vst_h;
  }

  public String getVst_ip() {
    return vst_ip;
  }

  public void setVst_ip(String vst_ip) {
    this.vst_ip = vst_ip;
  }

  public String getVst_agent() {
    return vst_agent;
  }

  public void setVst_agent(String vst_agent) {
    this.vst_agent = vst_agent;
  }

  public String getVst_nation() {
    return vst_nation;
  }

  public void setVst_nation(String vst_nation) {
    this.vst_nation = vst_nation;
  }

  public String getVst_refer_site() {
    return vst_refer_site;
  }

  public void setVst_refer_site(String vst_refer_site) {
    this.vst_refer_site = vst_refer_site;
  }

  public String getVst_keyword() {
    return vst_keyword;
  }

  public void setVst_keyword(String vst_keyword) {
    this.vst_keyword = vst_keyword;
  }

  public String getVst_refer_url() {
    return vst_refer_url;
  }

  public void setVst_refer_url(String vst_refer_url) {
    this.vst_refer_url = vst_refer_url;
  }

  public String getVst_page() {
    return vst_page;
  }

  public void setVst_page(String vst_page) {
    this.vst_page = vst_page;
  }

  public String getSearchFrom() {
    return searchFrom;
  }

  public void setSearchFrom(String searchFrom) {
    this.searchFrom = searchFrom;
  }

  public String getSearchTo() {
    return searchTo;
  }

  public void setSearchTo(String searchTo) {
    this.searchTo = searchTo;
  }

  public String getCol() {
    return col;
  }

  public void setCol(String col) {
    this.col = col;
  }

  public long getCnt() {
    return cnt;
  }

  public void setCnt(long cnt) {
    this.cnt = cnt;
  }

  public double getRate() {
    return rate;
  }

  public void setRate(double rate) {
    this.rate = rate;
  }

  public String getVst_content_key() {
    return vst_content_key;
  }

  public void setVst_content_key(String vst_content_key) {
    this.vst_content_key = vst_content_key;
  }

  public String getVst_city() {
    return vst_city;
  }

  public void setVst_city(String vst_city) {
    this.vst_city = vst_city;
  }

  public String getChartType() {
    return chartType;
  }

  public void setChartType(String chartType) {
    this.chartType = chartType;
  }

  public String getSearchContentKey() {
    return searchContentKey;
  }

  public void setSearchContentKey(String searchContentKey) {
    this.searchContentKey = searchContentKey;
  }
}
