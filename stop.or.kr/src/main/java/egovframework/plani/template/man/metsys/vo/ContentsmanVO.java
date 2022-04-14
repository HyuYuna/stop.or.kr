package egovframework.plani.template.man.metsys.vo;

import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

public class ContentsmanVO extends SysmenuVO {

  private static final long serialVersionUID = 1L;

  /** 컨텐츠 ID */
  private String ucont_id;

  /** 컨텐츠 버전 */
  private int ucont_version;

  /** 컨텐츠 제목 */
  private String ucont_subject;
  private String ucont_dft;

  /** CSS 정의 [CSS파일 또는 CSS코드] */
  private String ucont_css;

  /** 내용 */
  private String ucont_cont;

  /** [Y/N] 컨텐츠 내의 이미지를 (이름이 같은)첨부파일로 대체 */
  private String alter_img_atch;

  /** 작성자 */
  private String writer;

  /** 작성일 */
  private String wdt;

  /** 수정자 */
  private String modifier;

  /** 수정일 */
  private String mdt;

  /** 연결된 메뉴의 IDX */
  private String ref_menu_nix = null;
  private String ref_menu_nm = null;

  /** 컨텐츠 메뉴계층 보여주기를 위한 메뉴정보 추가 */
  // private String menu_idx;
  // private String up_menu_idx;
  // private String menu_nm;
  // private String menu_lv;
  // private String use_yn;
  // private String is_leaf;


  @Override
  public String getUcont_id() {
    return ucont_id;
  }

  @Override
  public void setUcont_id(String ucont_id) {
    this.ucont_id = ucont_id;
  }

  public int getUcont_version() {
    return ucont_version;
  }

  public void setUcont_version(int ucont_version) {
    this.ucont_version = ucont_version;
  }

  public String getUcont_subject() {
    return ucont_subject;
  }

  public void setUcont_subject(String ucont_subject) {
    this.ucont_subject = ucont_subject;
  }

  public String getUcont_dft() {
    return ucont_dft;
  }

  public void setUcont_dft(String ucont_dft) {
    this.ucont_dft = ucont_dft;
  }

  public String getUcont_css() {
    return ucont_css;
  }

  public void setUcont_css(String ucont_css) {
    this.ucont_css = ucont_css;
  }

  public String getUcont_cont() {
    return ucont_cont;
  }

  public void setUcont_cont(String ucont_cont) {
    this.ucont_cont = ucont_cont;
  }

  @Override
  public String getWriter() {
    return writer;
  }

  @Override
  public void setWriter(String writer) {
    this.writer = writer;
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
  public String getModifier() {
    return modifier;
  }

  @Override
  public void setModifier(String modifier) {
    this.modifier = modifier;
  }

  @Override
  public String getMdt() {
    return mdt;
  }

  @Override
  public void setMdt(String mdt) {
    this.mdt = mdt;
  }

  public String getAlter_img_atch() {
    return alter_img_atch;
  }

  public void setAlter_img_atch(String alter_img_atch) {
    this.alter_img_atch = alter_img_atch;
  }

  public String getRef_menu_nix() {
    return ref_menu_nix;
  }

  public void setRef_menu_nix(String ref_menu_nix) {
    this.ref_menu_nix = ref_menu_nix;
  }

  public String getRef_menu_nm() {
    return ref_menu_nm;
  }

  public void setRef_menu_nm(String ref_menu_nm) {
    this.ref_menu_nm = ref_menu_nm;
  }

  // @Override
  // public String getMenu_idx() {
  // return menu_idx;
  // }
  //
  // @Override
  // public void setMenu_idx(String menu_idx) {
  // this.menu_idx = menu_idx;
  // }
  //
  // @Override
  // public String getUp_menu_idx() {
  // return up_menu_idx;
  // }
  //
  // @Override
  // public void setUp_menu_idx(String up_menu_idx) {
  // this.up_menu_idx = up_menu_idx;
  // }
  //
  // @Override
  // public String getMenu_nm() {
  // return menu_nm;
  // }
  //
  // @Override
  // public void setMenu_nm(String menu_nm) {
  // this.menu_nm = menu_nm;
  // }
  //
  // public String getMenu_lv() {
  // return menu_lv;
  // }
  //
  // public void setMenu_lv(String menu_lv) {
  // this.menu_lv = menu_lv;
  // }
  //
  // @Override
  // public String getUse_yn() {
  // return use_yn;
  // }
  //
  // @Override
  // public void setUse_yn(String use_yn) {
  // this.use_yn = use_yn;
  // }
  //
  // @Override
  // public String getIs_leaf() {
  // return is_leaf;
  // }
  //
  // @Override
  // public void setIs_leaf(String is_leaf) {
  // this.is_leaf = is_leaf;
  // }



}
