package egovframework.plani.template.man.popup.vo;

import java.net.URLEncoder;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class PopupVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 순번 */
  private int pop_seq;

  /** 제목 */
  private String pop_title;

  /** 구분(W:창팝업/Z:팝업) */
  private String pop_type = "W";
  private String searchPopType;

  /** 게시 시작일자 */
  private String pop_from;
  private String searchFrom;

  /** 게시 종료일자 */
  private String pop_to;
  private String searchTo;

  /** 팝업 너비 */
  private String pop_w = "0";

  /** 팝업 높이 */
  private String pop_h = "0";

  private String pop_x = "0";
  private String pop_y = "0";

  /** 팝업 내용 - 텍스트 */
  private String pop_content;

  /** 팝업 내용 - 이미지 */
  private String pop_image;

  /** 팝업 링크 URL */
  private String pop_link;

  /** 링크 target */
  private String pop_target;

  /** ALT 속성값 */
  private String pop_alt;

  /** 사용 여부 */
  private String use_yn;
  private String searchUseYn;

  /** 등록자ID */
  private String writer;

  /** 등록일시 */
  private String wdt;

  /** 정렬 번호 */
  private int pop_sort;
  private String sort_dir;

  /** 이미지 크기 구할때 사용 합니다. */
  private int atch_idx;
  private String fpath;
  private String fname;

  private String urlParams;

  public String getUrlParams() {
    if (this.urlParams == null || this.urlParams.equals("")) {
      StringBuffer sb = new StringBuffer();
      sb.append("pageIndex=" + new Integer(this.pageIndex).toString());
      if (this.searchCondition != null && !this.searchCondition.equals(""))
        sb.append("&amp;searchCondition=" + this.searchCondition);

      try {
        if (this.searchKeyword != null && !this.searchKeyword.equals(""))
          sb.append("&amp;searchKeyword=" + URLEncoder.encode(this.searchKeyword, "utf-8"));
      } catch (Exception e) {
      }
      if (this.searchPopType != null && !this.searchPopType.equals(""))
        sb.append("&amp;searchPopType=" + this.searchPopType);
      if (this.searchUseYn != null && !this.searchUseYn.equals(""))
        sb.append("&amp;searchUseYn=" + this.searchUseYn);
      if (this.searchFrom != null && !this.searchFrom.equals(""))
        sb.append("&amp;searchFrom=" + this.searchFrom);
      if (this.searchTo != null && !this.searchTo.equals(""))
        sb.append("&amp;searchTo=" + this.searchTo);

      return sb.toString();
    } else
      return urlParams;
  }

  public void setUrlParams(String urlParams) {
    this.urlParams = urlParams;
  }


  public int getPop_seq() {
    return pop_seq;
  }

  public void setPop_seq(int pop_seq) {
    this.pop_seq = pop_seq;
  }

  public String getPop_title() {
    return pop_title;
  }

  public void setPop_title(String pop_title) {
    this.pop_title = pop_title;
  }

  public String getPop_type() {
    return pop_type;
  }

  public void setPop_type(String pop_type) {
    this.pop_type = pop_type;
  }

  public String getPop_from() {
    return pop_from;
  }

  public void setPop_from(String pop_from) {
    this.pop_from = pop_from;
  }

  public String getPop_to() {
    return pop_to;
  }

  public void setPop_to(String pop_to) {
    this.pop_to = pop_to;
  }

  public String getPop_w() {
    return pop_w;
  }

  public void setPop_w(String pop_w) {
    this.pop_w = pop_w;
  }

  public String getPop_h() {
    return pop_h;
  }

  public void setPop_h(String pop_h) {
    this.pop_h = pop_h;
  }

  public String getPop_content() {
    return pop_content;
  }

  public void setPop_content(String pop_content) {
    this.pop_content = pop_content;
  }

  public String getPop_image() {
    return pop_image;
  }

  public void setPop_image(String pop_image) {
    this.pop_image = pop_image;
  }

  public String getPop_link() {
    return pop_link;
  }

  public void setPop_link(String pop_link) {
    this.pop_link = pop_link;
  }

  public String getPop_target() {
    return pop_target;
  }

  public void setPop_target(String pop_target) {
    this.pop_target = pop_target;
  }

  public String getUse_yn() {
    return use_yn;
  }

  public String getPop_x() {
    return pop_x;
  }

  public void setPop_x(String pop_x) {
    this.pop_x = pop_x;
  }

  public String getPop_y() {
    return pop_y;
  }

  public void setPop_y(String pop_y) {
    this.pop_y = pop_y;
  }

  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
  }

  public String getWriter() {
    return writer;
  }

  public void setWriter(String writer) {
    this.writer = writer;
  }

  public String getWdt() {
    return wdt;
  }

  public void setWdt(String wdt) {
    this.wdt = wdt;
  }

  public String getPop_alt() {
    return pop_alt;
  }

  public void setPop_alt(String pop_alt) {
    this.pop_alt = pop_alt;
  }

  public String getSearchPopType() {
    return searchPopType;
  }

  public void setSearchPopType(String searchPopType) {
    this.searchPopType = searchPopType;
  }

  public int getPop_sort() {
    return pop_sort;
  }

  public void setPop_sort(int pop_sort) {
    this.pop_sort = pop_sort;
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

  public String getSort_dir() {
    return sort_dir;
  }

  public void setSort_dir(String sort_dir) {
    this.sort_dir = sort_dir;
  }

  public String getSearchUseYn() {
    return searchUseYn;
  }

  public void setSearchUseYn(String searchUseYn) {
    this.searchUseYn = searchUseYn;
  }

  public String getFpath() {
    return fpath;
  }

  public void setFpath(String fpath) {
    this.fpath = fpath;
  }

  public int getAtch_idx() {
    return atch_idx;
  }

  public void setAtch_idx(int atch_idx) {
    this.atch_idx = atch_idx;
  }

  public String getFname() {
    return fname;
  }

  public void setFname(String fname) {
    this.fname = fname;
  }



}

