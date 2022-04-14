package egovframework.plani.template.man.metsys.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.custom.form.validator.NotEmptyFile;
import egovframework.plani.custom.form.validator.UploadCheck;
import egovframework.plani.custom.form.validator.groups.ValidationAdminCreate;
import egovframework.plani.custom.form.validator.groups.ValidationAdminModify;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

public class AwardsDataVO extends SysmenuVO {

  private static final long serialVersionUID = 1L;

  /** 수상작 그룹 아이디 */
  @NotEmpty(message = "수상작그룹 정보가 없습니다.",
      groups = {ValidationAdminCreate.class, ValidationAdminModify.class})
  private String group_id;

  /** 수상작 아이디 */
  private int data_id;

  @NotEmpty(message = "수상내역을 선택해주세요.",
      groups = {ValidationAdminCreate.class, ValidationAdminModify.class})
  private String awards;

  @NotEmpty(message = "작가를 입력해주세요.",
      groups = {ValidationAdminCreate.class, ValidationAdminModify.class})
  private String author;

  /** 수상작 공지 여부 */
  private String is_notice = "N";

  /** 수상작 시작일 */
  private String date_start;

  /** 수상작 종료일 */
  private String date_end;

  /** 수상작 제목 */
  @NotEmpty(message = "제목을 입력해주세요.",
      groups = {ValidationAdminCreate.class, ValidationAdminModify.class})
  private String subject;

  /** 수상작 내용 */
  @NotEmpty(message = "내용을 입력해주세요.",
      groups = {ValidationAdminCreate.class, ValidationAdminModify.class})
  private String content;

  private String youtube;

  @NotEmptyFile(message = "리스트 이미지를 선택해주세요.", field = "thumbnail",
      groups = {ValidationAdminCreate.class})
  @UploadCheck(dependency = true, field = "thumbnail", extensions = "gif, jpg, jpeg",
      groups = {ValidationAdminCreate.class, ValidationAdminModify.class})
  private String thumbnail_check;

  private AtchfileVO atchfileVO;



  public AtchfileVO getAtchfileVO() {
    return atchfileVO;
  }

  public void setAtchfileVO(AtchfileVO atchfileVO) {
    this.atchfileVO = atchfileVO;
  }

  public String getThumbnail_check() {
    return thumbnail_check;
  }

  public void setThumbnail_check(String thumbnail_check) {
    this.thumbnail_check = thumbnail_check;
  }

  /** 작성자 */
  private String writer;

  /** 작성일 */
  private String wdt;

  /** 수정자 */
  private String modifier;

  /** 수정일 */
  private String mdt;



  public String getYoutube() {
    return youtube;
  }

  public void setYoutube(String youtube) {
    this.youtube = youtube;
  }

  public String getAwards() {
    return awards;
  }

  public void setAwards(String awards) {
    this.awards = awards;
  }

  public String getAuthor() {
    return author;
  }

  public void setAuthor(String author) {
    this.author = author;
  }

  public String getGroup_id() {
    return group_id;
  }

  public void setGroup_id(String group_id) {
    this.group_id = group_id;
  }

  public int getData_id() {
    return data_id;
  }

  public void setData_id(int data_id) {
    this.data_id = data_id;
  }

  public String getSubject() {
    return subject;
  }

  public void setSubject(String subject) {
    this.subject = subject;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
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



  public String getIs_notice() {
    return is_notice;
  }

  public void setIs_notice(String is_notice) {
    this.is_notice = is_notice;
  }

  public String getDate_start() {
    return date_start;
  }

  public void setDate_start(String date_start) {
    this.date_start = date_start;
  }

  public String getDate_end() {
    return date_end;
  }

  public void setDate_end(String date_end) {
    this.date_end = date_end;
  }



}
