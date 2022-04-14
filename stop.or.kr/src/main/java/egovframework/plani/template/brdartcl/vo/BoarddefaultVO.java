package egovframework.plani.template.brdartcl.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.custom.form.validator.Captcha;
import egovframework.plani.custom.form.validator.NotCategoryEmpty;
import egovframework.plani.custom.form.validator.NotEditorEmpty;
import egovframework.plani.custom.form.validator.NotExtraEmpty;
import egovframework.plani.custom.form.validator.groups.ValidationBoardAdd;
import egovframework.plani.custom.form.validator.groups.ValidationBoardModify;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

/**
 * 게시판 정보 기본 VO
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.vo] [BoardarticleVO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:58:08
 * @version : 1.0
 */
public class BoarddefaultVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 테이블 명 */
  private String tbl_nm;

  /** 댓글 테이블 명 */
  private String reply_tbl_nm;

  /** 게시판 번호 */
  private String brd_id;
  private String brd_id_list;
  private String brd_nm;
  private String brd_gb;
  private String brd_gb_sub;

  /** 게시물 순번 */
  private int cont_idx;

  /** 카테고리 ID */
  @NotCategoryEmpty(dependency = false, groups = {ValidationBoardAdd.class,
      ValidationBoardModify.class})
  private String ctgry_idx;

  private String srch_ctgry_idx;

  /** 카테고리 명 */
  private String ctgry_nm;

  /** 에디터 종류 */
  private String editor_gb;

  /** 제목 */
  @NotEmpty(groups = {ValidationBoardAdd.class, ValidationBoardModify.class})
  private String subject;

  /** 내용 */
  @NotEditorEmpty(dependency = false, groups = {ValidationBoardAdd.class,
      ValidationBoardModify.class})
  private String brd_cont;

  /** 조회수 */
  private int hits = 0;

  /** 추천수 */
  private int rcmnd_cnt = 0;

  /** 반대수 */
  private int rjct_cnt = 0;

  /** 댓글수 */
  private int reply_cnt = 0;

  /** 첨부파일수 */
  private int atach_cnt = 0;

  /** 공지여부 */
  private String is_notice = "N";

  /** 비밀글 여부 */
  private String is_scrt = "N";

  /** 댓글 구분 */
  private String reply_gb = "N";

  /** 작성 경과 일 */
  private String dfr_wdt;

  /** 추천 사용 여부 */
  private String use_rcmnd = "N";

  /** 반대 사용 여부 */
  private String use_rjct = "N";

  /** 공공누리 저작권 코드 */
  private String kogl;

  /** 이미지 첨부시 내용 자동 추가 여부 */
  private String chk_imgintocont;


  @Captcha(dependency = false, groups = {ValidationBoardAdd.class}, field = "captcha_val")
  private String captcha_val;

  /** 여분필드 */
  @NotExtraEmpty(dependency = false, groups = {ValidationBoardAdd.class,
      ValidationBoardModify.class}, field = "extra1")
  private String extra1;
  @NotExtraEmpty(dependency = false, groups = {ValidationBoardAdd.class,
      ValidationBoardModify.class}, field = "extra2")
  private String extra2;

  public String getTbl_nm() {
    return tbl_nm;
  }

  public void setTbl_nm(String tbl_nm) {
    this.tbl_nm = tbl_nm;
  }

  public String getBrd_id() {
    return brd_id;
  }

  public void setBrd_id(String brd_id) {
    this.brd_id = brd_id;
  }

  public int getCont_idx() {
    return cont_idx;
  }

  public void setCont_idx(int cont_idx) {
    this.cont_idx = cont_idx;
  }

  public String getSubject() {
    return subject;
  }

  public void setSubject(String subject) {
    this.subject = subject;
  }

  public String getBrd_cont() {
    return brd_cont;
  }

  public void setBrd_cont(String brd_cont) {
    this.brd_cont = brd_cont;
  }

  public int getHits() {
    return hits;
  }

  public void setHits(int hits) {
    this.hits = hits;
  }

  public int getRcmnd_cnt() {
    return rcmnd_cnt;
  }

  public void setRcmnd_cnt(int rcmnd_cnt) {
    this.rcmnd_cnt = rcmnd_cnt;
  }

  public int getRjct_cnt() {
    return rjct_cnt;
  }

  public void setRjct_cnt(int rjct_cnt) {
    this.rjct_cnt = rjct_cnt;
  }

  public String getIs_notice() {
    return is_notice;
  }

  public void setIs_notice(String is_notice) {
    this.is_notice = is_notice;
  }

  public String getEditor_gb() {
    return editor_gb;
  }

  public void setEditor_gb(String editor_gb) {
    this.editor_gb = editor_gb;
  }

  public String getCtgry_idx() {
    return ctgry_idx;
  }

  public void setCtgry_idx(String ctgry_idx) {
    this.ctgry_idx = ctgry_idx;
  }

  public String getCtgry_nm() {
    return ctgry_nm;
  }

  public void setCtgry_nm(String ctgry_nm) {
    this.ctgry_nm = ctgry_nm;
  }

  public String getDfr_wdt() {
    return dfr_wdt;
  }

  public void setDfr_wdt(String dfr_wdt) {
    this.dfr_wdt = dfr_wdt;
  }

  public String getReply_tbl_nm() {

    return reply_tbl_nm;
  }

  public void setReply_tbl_nm(String reply_tbl_nm) {

    this.reply_tbl_nm = reply_tbl_nm;
  }

  public int getReply_cnt() {
    return reply_cnt;
  }

  public void setReply_cnt(int reply_cnt) {
    this.reply_cnt = reply_cnt;
  }

  public int getAtach_cnt() {
    return atach_cnt;
  }

  public void setAtach_cnt(int atach_cnt) {
    this.atach_cnt = atach_cnt;
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

  public String getIs_scrt() {
    return is_scrt;
  }

  public void setIs_scrt(String is_scrt) {
    this.is_scrt = is_scrt;
  }


  public String getReply_gb() {
    return reply_gb;
  }

  public void setReply_gb(String reply_gb) {
    this.reply_gb = reply_gb;
  }

  public String getKogl() {
    return kogl;
  }

  public void setKogl(String kogl) {
    this.kogl = kogl;
  }

  public String getSrch_ctgry_idx() {
    return srch_ctgry_idx;
  }

  public void setSrch_ctgry_idx(String srch_ctgry_idx) {
    this.srch_ctgry_idx = srch_ctgry_idx;
  }

  public String getBrd_nm() {
    return brd_nm;
  }

  public void setBrd_nm(String brd_nm) {
    this.brd_nm = brd_nm;
  }

  public String getBrd_gb() {
    return brd_gb;
  }

  public void setBrd_gb(String brd_gb) {
    this.brd_gb = brd_gb;
  }

  public String getBrd_gb_sub() {
    return brd_gb_sub;
  }

  public void setBrd_gb_sub(String brd_gb_sub) {
    this.brd_gb_sub = brd_gb_sub;
  }

  public String getBrd_id_list() {
    return brd_id_list;
  }

  public void setBrd_id_list(String brd_id_list) {
    this.brd_id_list = brd_id_list;
  }

  public String getChk_imgintocont() {
    return chk_imgintocont;
  }

  public void setChk_imgintocont(String chk_imgintocont) {
    this.chk_imgintocont = chk_imgintocont;
  }

  public String getCaptcha_val() {
    return captcha_val;
  }

  public void setCaptcha_val(String captcha_val) {
    this.captcha_val = captcha_val;
  }

  public String getExtra1() {
    return extra1;
  }

  public void setExtra1(String extra1) {
    this.extra1 = extra1;
  }

  public String getExtra2() {
    return extra2;
  }

  public void setExtra2(String extra2) {
    this.extra2 = extra2;
  }



}
