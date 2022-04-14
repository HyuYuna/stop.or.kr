package egovframework.plani.template.cardnews.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class CardNewsVO extends DefaultSearchVO {



  /** 순번 */
  private int cn_seq;

  /** 제목 */
  @NotEmpty
  private String cn_title;

  /** 내용 - 텍스트 */
  private String cn_content;

  /** 공지 */
  private String is_notice = "N";

  /** 등록일시 */
  private String wdt;

  /** 조회수 */
  private int hits;
  
  private String cn_alt;


  public int getCn_seq() {
    return cn_seq;
  }

  public void setCn_seq(int cn_seq) {
    this.cn_seq = cn_seq;
  }

  public String getCn_title() {
    return cn_title;
  }

  public void setCn_title(String cn_title) {
    this.cn_title = cn_title;
  }

  public String getCn_content() {
    return cn_content;
  }

  public void setCn_content(String cn_content) {
    this.cn_content = cn_content;
  }


  public String getIs_notice() {
    return is_notice;
  }

  public void setIs_notice(String is_notice) {
    this.is_notice = is_notice;
  }


  public void setHits(int hits) {
    this.hits = hits;
  }

  public int getHits() {
    return hits;
  }


  public String getCn_alt() {
	return cn_alt;
  }

  public void setCn_alt(String cn_alt) {
	this.cn_alt = cn_alt;
  }

@Override
  public String getWdt() {
    return wdt;
  }

  @Override
  public void setWdt(String wdt) {
    this.wdt = wdt;
  }

}

