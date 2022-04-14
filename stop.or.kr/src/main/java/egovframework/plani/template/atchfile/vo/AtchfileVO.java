package egovframework.plani.template.atchfile.vo;

import java.text.DecimalFormat;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

/**
 * 첨부파일 정보 VO
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.atchfile.vo] [AtchfileVO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 22. 오후 3:17:33
 * @version : 1.0
 */
public class AtchfileVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 첨부파일 구분 키(키값 대분류); */
  private String atckey_1st;

  /** 첨부파일 구분 키(키값 중분류); */
  private String atckey_2nd;

  /** 첨부파일 구분 키(키값 소분류; 소분류까지의 분류가 필요없이 2단계분류만으로 충분한 경우 1을 기본값으로 한다.); */
  private int atckey_3rd = 0;

  /** 첨부파일 구분 키(키값 소분류); */
  private int atckey_4th = 0;

  /** 파일 경로 */
  private String fpath;

  /** 변경된 파일 명 */
  private String fname;

  /** 실제 파일 명 */
  private String rname;

  /** 확장자 */
  private String fext;

  /** 파일크기 */
  private int size_kb;

  /** 파일크기 */
  private double size_mb;

  private int img_width;

  private int img_height;
  
  private String alt;
  
  private String add_tag;

  /** 썸네일 여부 */
  private String is_thumb = "N";

  public String getAtckey_1st() {
    return atckey_1st;
  }

  public void setAtckey_1st(String atckey_1st) {
    this.atckey_1st = atckey_1st;
  }

  public String getAtckey_2nd() {
    return atckey_2nd;
  }

  public void setAtckey_2nd(String atckey_2nd) {
    this.atckey_2nd = atckey_2nd;
  }

  public int getAtckey_3rd() {
    return atckey_3rd;
  }

  public void setAtckey_3rd(int atckey_3rd) {
    this.atckey_3rd = atckey_3rd;
  }

  public int getAtckey_4th() {
    return atckey_4th;
  }

  public void setAtckey_4th(int atckey_4th) {
    this.atckey_4th = atckey_4th;
  }

  public String getFpath() {
    return fpath;
  }

  public void setFpath(String fpath) {
    this.fpath = fpath;
  }

  public String getFname() {
    return fname;
  }

  public void setFname(String fname) {
    this.fname = fname;
  }

  public String getRname() {
    return rname;
  }

  public void setRname(String rname) {
    this.rname = rname;
  }

  public String getFext() {
    return fext;
  }

  public void setFext(String fext) {
    this.fext = fext;
  }

  public int getSize_kb() {
    return size_kb;
  }

  public void setSize_kb(int size_kb) {
    this.size_kb = size_kb;
  }

  public String getIs_thumb() {
    return is_thumb;
  }

  public void setIs_thumb(String is_thumb) {
    this.is_thumb = is_thumb;
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

  public double getSize_mb() {

    size_mb = (size_kb > 0) ? (double) size_kb / 1024 : 0.1;
    DecimalFormat df = new DecimalFormat("#.##");
    String sz = df.format(size_mb);
    size_mb = Double.parseDouble(sz);
    return size_mb;
  }

  public void setSize_mb(double size_mb) {
    this.size_mb = size_mb;
  }

  public String getAlt() {
	return alt;
  }

  public void setAlt(String alt) {
	this.alt = alt;
  }

  public String getAdd_tag() {
	return add_tag;
  }

  public void setAdd_tag(String add_tag) {
	this.add_tag = add_tag;
  }
  
}

