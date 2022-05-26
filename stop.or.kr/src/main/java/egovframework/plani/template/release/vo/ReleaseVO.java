package egovframework.plani.template.release.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class ReleaseVO extends DefaultSearchVO {



  /** 순번 */
  private int rel_seq;

  /** 제목(공개항목) */
  @NotEmpty
  private String rel_title;

  /** 내용 - 텍스트(공표항목) */
  private String rel_content;

  /** 공지 */
  private String is_notice = "N";

  /** 등록일시 */
  private String wdt;

  /** 공개주기 */
  private String rel_pblntf_cycle;

  /** 공개시기 */
  private String rel_era;
  
  /** 공개방법(URL) **/
  private String rel_url;
  
  /** 분류 **/
  private String division;
  
  /** 담당부서 **/
  private String rel_dept;
  
  /** 담당자 **/
  private String rel_charger;
  
  /** 연락처 **/
  private String rel_cttpc;
  
  /** 공표방법 **/
  private String rel_mth;
  
  /** 2020년 이전자료 구분 **/
  private String releaseBefore;

  public String getReleaseBefore() {
	return releaseBefore;
}

public void setReleaseBefore(String releaseBefore) {
	this.releaseBefore = releaseBefore;
}

public String getRel_mth() {
	return rel_mth;
}

public void setRel_mth(String rel_mth) {
	this.rel_mth = rel_mth;
}

public String getRel_pblntf_cycle() {
	return rel_pblntf_cycle;
}

public void setRel_pblntf_cycle(String rel_pblntf_cycle) {
	this.rel_pblntf_cycle = rel_pblntf_cycle;
}

public String getRel_era() {
	return rel_era;
}

public void setRel_era(String rel_era) {
	this.rel_era = rel_era;
}

public String getRel_url() {
	return rel_url;
}

public void setRel_url(String rel_url) {
	this.rel_url = rel_url;
}

public String getDivision() {
	return division;
}

public void setDivision(String division) {
	this.division = division;
}

public String getRel_dept() {
	return rel_dept;
}

public void setRel_dept(String rel_dept) {
	this.rel_dept = rel_dept;
}

public String getRel_charger() {
	return rel_charger;
}

public void setRel_charger(String rel_charger) {
	this.rel_charger = rel_charger;
}

public String getRel_cttpc() {
	return rel_cttpc;
}

public void setRel_cttpc(String rel_cttpc) {
	this.rel_cttpc = rel_cttpc;
}

public int getRel_seq() {
    return rel_seq;
  }

  public void setRel_seq(int rel_seq) {
    this.rel_seq = rel_seq;
  }

  public String getRel_title() {
    return rel_title;
  }

  public void setRel_title(String rel_title) {
    this.rel_title = rel_title;
  }

  public String getRel_content() {
    return rel_content;
  }

  public void setRel_content(String rel_content) {
    this.rel_content = rel_content;
  }


  public String getIs_notice() {
    return is_notice;
  }

  public void setIs_notice(String is_notice) {
    this.is_notice = is_notice;
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

