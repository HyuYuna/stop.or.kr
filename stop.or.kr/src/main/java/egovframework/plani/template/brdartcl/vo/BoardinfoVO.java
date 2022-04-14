/*
 * Copyright 2008-2009 the original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
package egovframework.plani.template.brdartcl.vo;

import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

/**
 * 게시판정보 VO
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.metsys.vo] [BoardinfoVO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 13. 오전 11:29:03
 * @version : 1.0
 */
public class BoardinfoVO extends SysmenuVO {

  private static final long serialVersionUID = 1L;

  /** 테이블 명 */
  private String tbl_nm = "";

  /** 게시판 명 */
  private String brd_nm = "";

  /** 게시판 설명 */
  private String brd_dft = "";

  /** 게시판 기본 스킨 */
  private String brd_dft_skin = "A";

  /** 게시판 사용자 정의 스킨 */
  private String brd_cust_skin = "";

  /** 게시판 종류 */
  private String brd_gb = "CDIDX00042";
  private String brd_gb_nm = "일반 게시판 / 자료실";

  /** 게시판 종류 서브 */
  private String brd_gb_sub = "A";

  /** 에디터 구분 */
  private String editor_gb = "G";

  /** 카테고리 사용 여부 */
  private String use_ctgry = "N";

  /** 카테고리 사용 ID */
  private String ctgry_idx;

  /** 카테고리 ID */
  private String srch_ctgry_idx;

  /** 카테고리 명 */
  private String ctgry_nm;


  /** 공지사항포함 여부 */
  private String use_notice = "N";

  /** 비밀글 사용 여부 */
  private String use_scrt = "N";

  /** 게시물 추천 사용 여부 */
  private String use_rcmnd = "N";

  /** 게시물 반대 사용 여부 */
  private String use_rjct = "N";

  /** 첨부파일 사용 여부 */
  private String use_atch = "Y";

  /** UPLOADIFY 사용 여부 */
  private String use_uploadify = "Y";

  /** 공공누리 적용 여부 */
  private String use_kogl = "N";

  /** 답글 구분 [A|R|N] A : 계단식 답글, R : 댓글, B : 답글 + 댓글, N : 댓글 없음 */
  private String reply_gb;

  /** 파일첨부 허용개수 [0 : 제한없음] */
  private int attach_cnt_limit = 5;

  /** 파일첨부 허용크기 [0 : 제한없음] */
  private int attach_size_limit = 20;

  /** 페이지당 게시물 개수 [default : 15] */
  private int atcl_per_pg = 15;

  /** 한 화면에 표시할 페이지 네비 개수 [default : 10] */
  private int pg_per_navi = 10;

  /** 게시판 공개 방식 (로그인 사용자) */
  private String on_viewmode = "2";

  /** 게시판 공개 방식 (로그인하지 않은 사용자) */
  private String off_viewmode = "1";

  /** 현재 게시판 전용 테이블을 생성할지 여부 */
  private String create_new_table = "N";

  /** 연결된 메뉴의 IDX */
  private String ref_menu_nix = null;
  private String ref_menu_nm = null;

  /** 게시판 안내 컨텐츠 */
  private String info_cont;

  private int searchCount = 0;

  /** 게시판 관리자 목록 -> [ , ] 로 구분된 ID 문자열 */
  private String brd_auth_usr = null;

  /** 게시판 메뉴계층 보여주기를 위한 메뉴정보 추가 */
  // private String menu_idx;
  // private String up_menu_idx;
  // private String menu_nm;
  // private String menu_lv;
  // private String use_yn;
  // private String is_leaf;

  private Object extra1;
  private Object extra2;
  private BoardExtraVO brd_extra;

  public String getTbl_nm() {
    return tbl_nm;
  }

  public void setTbl_nm(String tbl_nm) {
    this.tbl_nm = tbl_nm;
  }

  public String getBrd_nm() {
    return brd_nm;
  }

  public void setBrd_nm(String brd_nm) {
    this.brd_nm = brd_nm;
  }

  public String getBrd_dft() {
    return brd_dft;
  }

  public void setBrd_dft(String brd_dft) {
    this.brd_dft = brd_dft;
  }

  public String getUse_notice() {
    return use_notice;
  }

  public void setUse_notice(String use_notice) {
    this.use_notice = use_notice;
  }

  public String getUse_rcmnd() {
    return use_rcmnd;
  }

  public void setUse_rcmnd(String use_rcmnd) {
    this.use_rcmnd = use_rcmnd;
  }

  public String getUse_rjct() {
    return use_rjct;
  }

  public void setUse_rjct(String use_rjct) {
    this.use_rjct = use_rjct;
  }

  public String getReply_gb() {
    return reply_gb;
  }

  public void setReply_gb(String reply_gb) {
    this.reply_gb = reply_gb;
  }

  public int getAttach_cnt_limit() {
    return attach_cnt_limit;
  }

  public void setAttach_cnt_limit(int attach_cnt_limit) {
    this.attach_cnt_limit = attach_cnt_limit;
  }

  public int getAttach_size_limit() {
    return attach_size_limit;
  }

  public void setAttach_size_limit(int attach_size_limit) {
    this.attach_size_limit = attach_size_limit;
  }

  public int getAtcl_per_pg() {
    return atcl_per_pg;
  }

  public void setAtcl_per_pg(int atcl_per_pg) {
    this.atcl_per_pg = atcl_per_pg;
  }

  public int getPg_per_navi() {
    return pg_per_navi;
  }

  public void setPg_per_navi(int pg_per_navi) {
    this.pg_per_navi = pg_per_navi;
  }

  public String getOn_viewmode() {
    return on_viewmode;
  }

  public void setOn_viewmode(String on_viewmode) {
    this.on_viewmode = on_viewmode;
  }

  public String getOff_viewmode() {
    return off_viewmode;
  }

  public void setOff_viewmode(String off_viewmode) {
    this.off_viewmode = off_viewmode;
  }

  public String getEditor_gb() {
    return editor_gb;
  }

  public void setEditor_gb(String editor_gb) {
    this.editor_gb = editor_gb;
  }

  public String getBrd_dft_skin() {
    return brd_dft_skin;
  }

  public void setBrd_dft_skin(String brd_dft_skin) {
    this.brd_dft_skin = brd_dft_skin;
  }

  public String getBrd_cust_skin() {
    return brd_cust_skin;
  }

  public void setBrd_cust_skin(String brd_cust_skin) {
    this.brd_cust_skin = brd_cust_skin;
  }

  public String getUse_ctgry() {
    return use_ctgry;
  }

  public void setUse_ctgry(String use_ctgry) {
    this.use_ctgry = use_ctgry;
  }

  public String getCtgry_idx() {
    return ctgry_idx;
  }

  public void setCtgry_idx(String ctgry_idx) {
    this.ctgry_idx = ctgry_idx;
  }

  public String getUse_atch() {
    return use_atch;
  }

  public void setUse_atch(String use_atch) {
    this.use_atch = use_atch;
  }

  public String getBrd_gb() {
    return brd_gb;
  }

  public void setBrd_gb(String brd_gb) {
    this.brd_gb = brd_gb;
  }

  public String getBrd_gb_nm() {
    return brd_gb_nm;
  }

  public void setBrd_gb_nm(String brd_gb_nm) {
    this.brd_gb_nm = brd_gb_nm;
  }

  public String getUse_scrt() {
    return use_scrt;
  }

  public void setUse_scrt(String use_scrt) {
    this.use_scrt = use_scrt;
  }

  public String getCreate_new_table() {
    return create_new_table;
  }

  public void setCreate_new_table(String create_new_table) {
    this.create_new_table = create_new_table;
  }

  public String getUse_uploadify() {
    return use_uploadify;
  }

  public void setUse_uploadify(String use_uploadify) {
    this.use_uploadify = use_uploadify;
  }

  public String getUse_kogl() {
    return use_kogl;
  }

  public void setUse_kogl(String use_kogl) {
    this.use_kogl = use_kogl;
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

  public String getBrd_gb_sub() {
    return brd_gb_sub;
  }

  public void setBrd_gb_sub(String brd_gb_sub) {
    this.brd_gb_sub = brd_gb_sub;
  }

  public int getSearchCount() {
    return searchCount;
  }

  public void setSearchCount(int searchCount) {
    this.searchCount = searchCount;
  }

  public String getSrch_ctgry_idx() {
    return srch_ctgry_idx;
  }

  public void setSrch_ctgry_idx(String srch_ctgry_idx) {
    this.srch_ctgry_idx = srch_ctgry_idx;
  }

  public String getCtgry_nm() {
    return ctgry_nm;
  }

  public void setCtgry_nm(String ctgry_nm) {
    this.ctgry_nm = ctgry_nm;
  }

  public String getBrd_auth_usr() {
    return brd_auth_usr;
  }

  public void setBrd_auth_usr(String brd_auth_usr) {
    this.brd_auth_usr = brd_auth_usr;
  }

  public String getInfo_cont() {
    return info_cont;
  }

  public void setInfo_cont(String info_cont) {
    this.info_cont = info_cont;
  }

  public Object getExtra1() {
    return extra1;
  }

  public void setExtra1(Object extra1) {
    this.extra1 = extra1;
  }

  public Object getExtra2() {
    return extra2;
  }

  public void setExtra2(Object extra2) {
    this.extra2 = extra2;
  }

  public BoardExtraVO getBrd_extra() {
    return brd_extra;
  }

  public void setBrd_extra(BoardExtraVO brd_extra) {
    this.brd_extra = brd_extra;
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

  // @Override
  // public String getMenu_lv() {
  // return menu_lv;
  // }
  //
  // public void setMenu_lv(String menu_lv) {
  // this.menu_lv = menu_lv;
  // }

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
