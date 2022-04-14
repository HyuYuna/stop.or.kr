package egovframework.plani.template.brdartcl.vo;

import egovframework.plani.custom.form.validator.NotAnmEmpty;
import egovframework.plani.custom.form.validator.groups.ValidationBoardAdd;
import egovframework.plani.custom.form.validator.groups.ValidationBoardModify;

/**
 * 개별 게시판 정보 VO
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.vo] [BoardarticleVO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:58:08
 * @version : 1.0
 */
public class BoardarticleVO extends BoarddefaultVO {

  private static final long serialVersionUID = 1L;

  /** 그룹번호 */
  private int grp_no = 0;

  /** 그룹레벨 */
  private int grp_lv = 1;

  /** 그룹순번 */
  private int grp_ord = 1;

  /** 공공누리 저작권 코드 */
  private String kogl;

  /** 추가정보 */
  @NotAnmEmpty(groups = {ValidationBoardAdd.class, ValidationBoardModify.class})
  private String add_info_01;

  private String add_info_02;
  private String add_info_03;
  @NotAnmEmpty(groups = {ValidationBoardAdd.class})
  private String add_info_04;
  private String add_info_05;

  private String brd_pass;

  private String rname;

  /** 게시글 노출 여부 */
  private String active;

  public int getGrp_no() {
    return grp_no;
  }

  public void setGrp_no(int grp_no) {
    this.grp_no = grp_no;
  }

  public int getGrp_lv() {
    return grp_lv;
  }

  public void setGrp_lv(int grp_lv) {
    this.grp_lv = grp_lv;
  }

  public int getGrp_ord() {
    return grp_ord;
  }

  public void setGrp_ord(int grp_ord) {
    this.grp_ord = grp_ord;
  }


  @Override
  public String getKogl() {
    return kogl;
  }

  @Override
  public void setKogl(String kogl) {
    this.kogl = kogl;
  }

  public String getAdd_info_01() {
    return add_info_01;
  }

  public void setAdd_info_01(String add_info_01) {
    this.add_info_01 = add_info_01;
  }

  public String getAdd_info_02() {
    return add_info_02;
  }

  public void setAdd_info_02(String add_info_02) {
    this.add_info_02 = add_info_02;
  }

  public String getAdd_info_03() {
    return add_info_03;
  }

  public void setAdd_info_03(String add_info_03) {
    this.add_info_03 = add_info_03;
  }

  public String getAdd_info_04() {
    return add_info_04;
  }

  public void setAdd_info_04(String add_info_04) {
    this.add_info_04 = add_info_04;
  }

  public String getAdd_info_05() {
    return add_info_05;
  }

  public void setAdd_info_05(String add_info_05) {
    this.add_info_05 = add_info_05;
  }

  public String getBrd_pass() {
    return brd_pass;
  }

  public void setBrd_pass(String brd_pass) {
    this.brd_pass = brd_pass;
  }

  public String getRname() {
    return rname;
  }

  public void setRname(String rname) {
    this.rname = rname;
  }

  public String getActive() {
    return active;
  }

  public void setActive(String active) {
    this.active = active;
  }



}
