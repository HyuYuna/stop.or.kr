package egovframework.plani.template.webtoon.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.custom.form.validator.UploadCheck;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class WebtoonCategoryVO extends DefaultSearchVO {

  /** 순번 */
  private int cn_seq;

  /** 제목 */
  @NotEmpty
  private String cn_title;

  /** 등록일시 */
  private String wdt;

  private int max_seq;


  /** 수정일시 */
  private String mdt;

  @UploadCheck(dependency = true, field = "thumbnail", extensions = "gif, jpg, jpeg")
  private String thumbnail_check;

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

  @Override
  public String getWdt() {
    return wdt;
  }

  @Override
  public void setWdt(String wdt) {
    this.wdt = wdt;
  }

  @Override
  public String getMdt() {
    return mdt;
  }

  @Override
  public void setMdt(String mdt) {
    this.mdt = mdt;
  }

  public String getThumbnail_check() {
    return thumbnail_check;
  }

  public void setThumbnail_check(String thumbnail_check) {
    this.thumbnail_check = thumbnail_check;
  }

  public int getMax_seq() {
    return max_seq;
  }

  public void setMax_seq(int max_seq) {
    this.max_seq = max_seq;
  }



}
