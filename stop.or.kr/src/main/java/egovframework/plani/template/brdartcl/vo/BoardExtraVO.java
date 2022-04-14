package egovframework.plani.template.brdartcl.vo;

import org.apache.commons.lang.builder.ToStringBuilder;


public class BoardExtraVO {

  /** 여분 필드 상세 항목 */
  private String extra1_name;
  private String extra1_use;
  private String extra1_require;

  private String extra2_name;
  private String extra2_use;
  private String extra2_require;

  public String getExtra1_name() {
    return extra1_name;
  }

  public void setExtra1_name(String extra1_name) {
    this.extra1_name = extra1_name;
  }

  public String getExtra1_use() {
    return extra1_use;
  }

  public void setExtra1_use(String extra1_use) {
    this.extra1_use = extra1_use;
  }

  public String getExtra1_require() {
    return extra1_require;
  }

  public void setExtra1_require(String extra1_require) {
    this.extra1_require = extra1_require;
  }

  public String getExtra2_name() {
    return extra2_name;
  }

  public void setExtra2_name(String extra2_name) {
    this.extra2_name = extra2_name;
  }

  public String getExtra2_use() {
    return extra2_use;
  }

  public void setExtra2_use(String extra2_use) {
    this.extra2_use = extra2_use;
  }

  public String getExtra2_require() {
    return extra2_require;
  }

  public void setExtra2_require(String extra2_require) {
    this.extra2_require = extra2_require;
  }

  @Override
  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }


}
