package egovframework.plani.template.man.metsys.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

public class AwardsGroupVO extends SysmenuVO {

  private static final long serialVersionUID = 1L;

  /** 아이디 */
  private String group_id;

  /** 이름 */
  @NotEmpty(message = "공고 이름을 입력해주세요.")
  private String name;

  /** 작성자 */
  private String writer;

  /** 작성일 */
  private String wdt;

  /** 수정자 */
  private String modifier;

  /** 수정일 */
  private String mdt;

  public String getGroup_id() {
    return group_id;
  }

  public void setGroup_id(String group_id) {
    this.group_id = group_id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
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


}
