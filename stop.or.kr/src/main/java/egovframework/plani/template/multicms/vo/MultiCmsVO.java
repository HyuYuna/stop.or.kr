package egovframework.plani.template.multicms.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class MultiCmsVO extends DefaultSearchVO {



  /** 순번 */
  private int mc_seq;

  /** 제목 */
  @NotEmpty
  private String mc_title;

  /** 카테고리 */
  private String mc_category;

  /** 내용 - 텍스트 */
  private String mc_content;

  /** 등록일시 */
  private String wdt;

  /** 이미지 VCHKCODE */
  private String img_code;

  /** 파일 VCHKCODE */
  private String file_code;
  
  private String mc_alt;

  public int getMc_seq() {
    return mc_seq;
  }

  public void setMc_seq(int mc_seq) {
    this.mc_seq = mc_seq;
  }

  public String getMc_title() {
    return mc_title;
  }

  public void setMc_title(String mc_title) {
    this.mc_title = mc_title;
  }

  public String getMc_content() {
    return mc_content;
  }

  public void setMc_content(String mc_content) {
    this.mc_content = mc_content;
  }

  public String getImg_code() {
    return img_code;
  }

  public String getMc_category() {
    return mc_category;
  }

  public void setMc_category(String mc_category) {
    this.mc_category = mc_category;
  }


  public void setImg_code(String img_code) {
    this.img_code = img_code;
  }

  public String getFile_code() {
    return file_code;
  }

  public void setFile_code(String file_code) {
    this.file_code = file_code;
  }

  public String getMc_alt() {
	return mc_alt;
  }

  public void setMc_alt(String mc_alt) {
	this.mc_alt = mc_alt;
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

