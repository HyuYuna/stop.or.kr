package egovframework.plani.template.brdartcl.vo;

/**
 * 개별 게시판 정보 VO
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.vo] [BoardarticleVO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:58:08
 * @version : 1.0
 */
public class BoardfaqVO extends BoarddefaultVO {

  private static final long serialVersionUID = 1L;

  /** 그룹레벨 */
  private int grp_lv = 1;

  public int getGrp_lv() {
    return grp_lv;
  }

  public void setGrp_lv(int grp_lv) {
    this.grp_lv = grp_lv;
  }

}

