package egovframework.plani.template.brdartcl.vo;

public class BoardthmVO extends BoarddefaultVO {

  private static final long serialVersionUID = 1L;

  /** 유튜브 영상 */
  private String brd_utb;

  /** 이미지 파일 번호 */
  private int img_idx;
  private int img_cnt;

  /** 썸네일 이미지 파일 번호 */
  private int thm_img_idx;

  /** 첨부이미지 width */
  private int img_width;

  /** 첨부이미지 height */
  private int img_height;

  public int getImg_idx() {
    return img_idx;
  }

  public void setImg_idx(int img_idx) {
    this.img_idx = img_idx;
  }

  public int getThm_img_idx() {
    return thm_img_idx;
  }

  public void setThm_img_idx(int thm_img_idx) {
    this.thm_img_idx = thm_img_idx;
  }

  public int getImg_width() {
    return img_width;
  }

  public void setImg_width(int img_width) {
    this.img_width = img_width;
  }

  public int getImg_height() {
    return img_height;
  }

  public void setImg_height(int img_height) {
    this.img_height = img_height;
  }

  public String getBrd_utb() {
    return brd_utb;
  }

  public void setBrd_utb(String brd_utb) {
    this.brd_utb = brd_utb;
  }

  public int getImg_cnt() {
    return img_cnt;
  }

  public void setImg_cnt(int img_cnt) {
    this.img_cnt = img_cnt;
  }


}

