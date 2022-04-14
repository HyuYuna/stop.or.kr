package egovframework.plani.template.man.metsys.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class ComplicityItemVO extends DefaultSearchVO {
  private String data_id;
  private int group_id;
  private String item_division;
  private String item_target;
  private String item_name;
  private String item_explain;
  private String item_file_check;// item_file validation check

  private int item_state;
  private String item_awards;

  private ComplicityVO complicityVO;

  private AtchfileVO atchfileVO;


  private String modifier;
  private String mdt;

  private String sdate;
  private String edate;


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

  public String getSdate() {
    return sdate;
  }

  public void setSdate(String sdate) {
    this.sdate = sdate;
  }

  public String getEdate() {
    return edate;
  }

  public void setEdate(String edate) {
    this.edate = edate;
  }

  public String getItem_division() {
    return item_division;
  }

  public void setItem_division(String item_division) {
    this.item_division = item_division;
  }

  public String getItem_target() {
    return item_target;
  }

  public void setItem_target(String item_target) {
    this.item_target = item_target;
  }

  public String getItem_name() {
    return item_name;
  }

  public void setItem_name(String item_name) {
    this.item_name = item_name;
  }

  public String getItem_explain() {
    return item_explain;
  }

  public void setItem_explain(String item_explain) {
    this.item_explain = item_explain;
  }



  public String getItem_file_check() {
    return item_file_check;
  }

  public void setItem_file_check(String item_file_check) {
    this.item_file_check = item_file_check;
  }

  public String getData_id() {
    return data_id;
  }

  public void setData_id(String data_id) {
    this.data_id = data_id;
  }

  public int getGroup_id() {
    return group_id;
  }

  public void setGroup_id(int group_id) {
    this.group_id = group_id;
  }



  public ComplicityVO getComplicityVO() {
    return complicityVO;
  }

  public void setComplicityVO(ComplicityVO complicityVO) {
    this.complicityVO = complicityVO;
  }


  public AtchfileVO getAtchfileVO() {
    return atchfileVO;
  }

  public void setAtchfileVO(AtchfileVO atchfileVO) {
    this.atchfileVO = atchfileVO;
  }



  public int getItem_state() {
    return item_state;
  }

  public void setItem_state(int item_state) {
    this.item_state = item_state;
  }

  public String getItem_awards() {
    return item_awards;
  }

  public void setItem_awards(String item_awards) {
    this.item_awards = item_awards;
  }

  @Override
  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }

}
