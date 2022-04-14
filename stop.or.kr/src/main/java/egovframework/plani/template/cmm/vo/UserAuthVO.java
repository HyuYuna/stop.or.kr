package egovframework.plani.template.cmm.vo;

public class UserAuthVO {

  /** 이름 */
  private String name;

  /** G-PIN에서 주민등록번호를 대신하는 키 */
  private String virtualNo;

  /** G-PIN에서 중복 가입을 확인하는 키 */
  private String dupInfo;

  /** 인증 방법 */
  private String AuthType;

  /** 생년 월일 */
  private String birthDate;

  /** 나이 */
  private int age;

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getVirtualNo() {
    return virtualNo;
  }

  public void setVirtualNo(String virtualNo) {
    this.virtualNo = virtualNo;
  }

  public String getDupInfo() {
    return dupInfo;
  }

  public void setDupInfo(String dupInfo) {
    this.dupInfo = dupInfo;
  }

  public String getAuthType() {
    return AuthType;
  }

  public void setAuthType(String authType) {
    AuthType = authType;
  }

  public String getBirthDate() {
    return birthDate;
  }

  public void setBirthDate(String birthDate) {
    this.birthDate = birthDate;
  }

  public int getAge() {
    return age;
  }

  public void setAge(int age) {
    this.age = age;
  }
}
