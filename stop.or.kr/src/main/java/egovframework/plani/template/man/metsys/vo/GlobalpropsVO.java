package egovframework.plani.template.man.metsys.vo;

import java.io.Serializable;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class GlobalpropsVO extends DefaultSearchVO implements Serializable {

  private static final long serialVersionUID = 1L;

  /** 프로젝트 명칭 */
  private String prjt_nm;

  /** Java 프로젝트 명 */
  private String javaprjt;

  /** workspace */
  private String workspace;

  /** copyright */
  private String copyright;

  /** 첨부파일 저장 위치 */
  private String uploaddir;

  public String getPrjt_nm() {
    return prjt_nm;
  }

  public void setPrjt_nm(String prjt_nm) {
    this.prjt_nm = prjt_nm;
  }

  public String getJavaprjt() {
    return javaprjt;
  }

  public void setJavaprjt(String javaprjt) {
    this.javaprjt = javaprjt;
  }

  public String getWorkspace() {
    return workspace;
  }

  public void setWorkspace(String workspace) {
    this.workspace = workspace;
  }

  public String getCopyright() {
    return copyright;
  }

  public void setCopyright(String copyright) {
    this.copyright = copyright;
  }

  public String getUploaddir() {
    return uploaddir;
  }

  public void setUploaddir(String uploaddir) {
    this.uploaddir = uploaddir;
  }



}
