package egovframework.plani.template.man.metsys.vo;

import java.util.List;
import javax.validation.constraints.Pattern;
import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.custom.form.validator.ComplicityItemCheck;
import egovframework.plani.custom.form.validator.groups.ValidationUserComplicity;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class ComplicityVO extends DefaultSearchVO {

  /** 그룹 아이디 */
  private int group_id;

  /** 성명 */
  @NotEmpty(message = "성명을 입력해주세요.", groups = {ValidationUserComplicity.class})
  private String name;

  /** 연락처 1 */
  @Pattern(regexp = "[0-9]{2,3}", message = "연락처 중 첫번째자리를 입력해주세요.",
      groups = {ValidationUserComplicity.class})
  private String tel_1;

  /** 연락처 2 */
  @Pattern(regexp = "[0-9]{4}", message = "연락처 중 두번째자리를 입력해주세요.",
      groups = {ValidationUserComplicity.class})
  private String tel_2;

  /** 연락처 3 */
  @Pattern(regexp = "[0-9]{4}", message = "연락처 중 세번째자리를 입력해주세요.",
      groups = {ValidationUserComplicity.class})
  private String tel_3;

  /** 연락처 */
  private String tel;

  /** 이메일 아이디 */
  @Pattern(regexp = "[_a-z0-9-]+(.[_a-z0-9-]+)*", message = "이메일 아이디를 입력해주세요.",
      groups = {ValidationUserComplicity.class})
  private String email_id;

  /** 이메일 호스트 */
  @Pattern(regexp = "(?:\\w+\\.)+\\w+$", message = "이메일 호스트를 입력해주세요.",
      groups = {ValidationUserComplicity.class})
  private String email_host;

  /** 이메일 선택 */
  private String email_select;

  /** 이메일 */
  private String email;

  /** 나이 */
  @Pattern(regexp = "[0-9]{1,3}", message = "나이를 입력해주세요.",
      groups = {ValidationUserComplicity.class})
  private String age;

  /** 소속 */
  @NotEmpty(message = "소속을 입력해주세요.", groups = {ValidationUserComplicity.class})
  private String belong;

  @ComplicityItemCheck(message = "출품작 정보를 확인해주세요.", extensions = "gif, png, jpg, bmp", mb = 5,
      groups = {ValidationUserComplicity.class})
  private List<ComplicityItemVO> items;

  /** 설문조사 성별 */
  @NotEmpty(message = "성별을 선택해주세요.", groups = {ValidationUserComplicity.class})
  private String survey_gender;

  /** 설문조사 연령 */
  @NotEmpty(message = "연령대를 선택해주세요.", groups = {ValidationUserComplicity.class})
  private String survey_age;

  /** 설문조사 거주지 */
  @NotEmpty(message = "거주지를 선택해주세요.", groups = {ValidationUserComplicity.class})
  private String survey_city;

  /** 설문조사 경로 */
  @NotEmpty(message = "공모전을 알게된 경로를 선택해주세요.", groups = {ValidationUserComplicity.class})
  private String[] survey_from;

  private String survey_from_string;
  private String survey_etc;

  private String writer;
  private String wdt;
  private String modifier;
  private String mdt;

  private String sdate;
  private String edate;


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

  public String getSurvey_age() {
    return survey_age;
  }

  public void setSurvey_age(String survey_age) {
    this.survey_age = survey_age;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getTel_1() {
    return tel_1;
  }

  public void setTel_1(String tel_1) {
    this.tel_1 = tel_1;
  }

  public String getTel_2() {
    return tel_2;
  }

  public void setTel_2(String tel_2) {
    this.tel_2 = tel_2;
  }

  public String getTel_3() {
    return tel_3;
  }

  public void setTel_3(String tel_3) {
    this.tel_3 = tel_3;
  }

  public String getEmail_id() {
    return email_id;
  }

  public void setEmail_id(String email_id) {
    this.email_id = email_id;
  }

  public String getEmail_host() {
    return email_host;
  }

  public void setEmail_host(String email_host) {
    this.email_host = email_host;
  }

  public String getAge() {
    return age;
  }

  public void setAge(String age) {
    this.age = age;
  }

  public String getBelong() {
    return belong;
  }

  public void setBelong(String belong) {
    this.belong = belong;
  }

  public String getSurvey_gender() {
    return survey_gender;
  }

  public void setSurvey_gender(String survey_gender) {
    this.survey_gender = survey_gender;
  }

  public String[] getSurvey_from() {
    return survey_from;
  }

  public void setSurvey_from(String[] survey_from) {
    this.survey_from = survey_from;
  }

  public String getSurvey_etc() {
    return survey_etc;
  }

  public void setSurvey_etc(String survey_etc) {
    this.survey_etc = survey_etc;
  }

  public List<ComplicityItemVO> getItems() {
    return items;
  }

  public void setItems(List<ComplicityItemVO> items) {
    this.items = items;
  }

  public String getEmail_select() {
    return email_select;
  }

  public void setEmail_select(String email_select) {
    this.email_select = email_select;
  }

  public String getSurvey_city() {
    return survey_city;
  }

  public void setSurvey_city(String survey_city) {
    this.survey_city = survey_city;
  }

  public String getSurvey_from_string() {
    return survey_from_string;
  }

  public void setSurvey_from_string(String survey_from_string) {
    this.survey_from_string = survey_from_string;
  }

  public int getGroup_id() {
    return group_id;
  }

  public void setGroup_id(int group_id) {
    this.group_id = group_id;
  }

  public String getTel() {
    return tel;
  }

  public void setTel(String tel) {
    this.tel = tel;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
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

