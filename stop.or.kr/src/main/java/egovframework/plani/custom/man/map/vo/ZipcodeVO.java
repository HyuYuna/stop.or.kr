package egovframework.plani.custom.man.map.vo;

import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class ZipcodeVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  private int map_idx;

  private String sido;

  private String gugun;

  /* 시/도/군/구 검색 */

  public int getMap_idx() {
    return map_idx;
  }

  public void setMap_idx(int map_idx) {
    this.map_idx = map_idx;
  }

  public String getSido() {
    return sido;
  }

  public void setSido(String sido) {
    this.sido = sido;
  }

  public String getGugun() {
    return gugun;
  }

  public void setGugun(String gugun) {
    this.gugun = gugun;
  }


}
