package egovframework.plani.custom.man.map.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class MapVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  private int map_idx;

  @NotEmpty(message = "카테고리를 필수로 입력해주세요.")
  private String category;

  @NotEmpty(message = "시도를 필수로 입력해주세요.")
  private String sido;

  @NotEmpty(message = "구군을 필수로 입력해주세요.")
  private String gugun;

  @NotEmpty(message = "기관명을 필수로 입력해주세요.")
  private String name;

  @NotEmpty(message = "주소를 필수로 입력해주세요.")
  private String addr;

  @NotEmpty(message = "전화번호를 필수로 입력해주세요.")
  private String tel;

  @NotEmpty(message = "위도를 필수로 입력해주세요.")
  private String urlx;

  @NotEmpty(message = "경도를 필수로 입력해주세요.")
  private String urly;

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

  public String getCategory() {
    return category;
  }

  public void setCategory(String category) {
    this.category = category;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getAddr() {
    return addr;
  }

  public void setAddr(String addr) {
    this.addr = addr;
  }

  public String getTel() {
    return tel;
  }

  public void setTel(String tel) {
    this.tel = tel;
  }

  public String getUrlx() {
    return urlx;
  }

  public void setUrlx(String urlx) {
    this.urlx = urlx;
  }

  public String getUrly() {
    return urly;
  }

  public void setUrly(String urly) {
    this.urly = urly;
  }


}
