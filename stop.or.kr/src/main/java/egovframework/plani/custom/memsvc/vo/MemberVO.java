package egovframework.plani.custom.memsvc.vo;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

import egovframework.plani.custom.form.validator.AdminUserEmailCheck;
import egovframework.plani.custom.form.validator.ConfirmPassword;
import egovframework.plani.custom.form.validator.EmailCheck;
import egovframework.plani.custom.form.validator.IdCheck;
import egovframework.plani.custom.form.validator.UploadCheck;
import egovframework.plani.custom.form.validator.UserEmailCheck;
import egovframework.plani.custom.form.validator.UserIdCheck;
import egovframework.plani.custom.form.validator.groups.ValidationAdminJoin;
import egovframework.plani.custom.form.validator.groups.ValidationAdminModify;
import egovframework.plani.custom.form.validator.groups.ValidationUserJoin;
import egovframework.plani.custom.form.validator.groups.ValidationUserModify;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class MemberVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  /** 아이디 */
  @NotEmpty(groups = {ValidationUserJoin.class, ValidationAdminJoin.class})
  @IdCheck(dependency = true, groups = {ValidationUserJoin.class, ValidationAdminJoin.class})
  @UserIdCheck(dependency = true, groups = {ValidationUserJoin.class, ValidationAdminJoin.class})
  private String user_id;

  /** 비밀번호 : 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내의 암호 정규식 */
  @NotEmpty(groups = {ValidationUserJoin.class, ValidationAdminJoin.class})
  @Pattern(regexp = "{0}|^.*(?=^.{8,15}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$", groups = {
      ValidationUserJoin.class, ValidationAdminJoin.class, ValidationAdminModify.class})
  private String user_scrt;

  /** 비밀번호 확인 */
  @NotEmpty(groups = {ValidationUserJoin.class, ValidationAdminJoin.class})
  @ConfirmPassword(field = "user_scrt", dependency = true, groups = {ValidationUserJoin.class,
      ValidationAdminJoin.class, ValidationAdminModify.class})
  private String user_scrt_confirm;

  /** 이름 */
  @NotEmpty(groups = {ValidationUserJoin.class, ValidationAdminJoin.class})
  private String user_nm;

  /** EMAIL */
  @NotEmpty(groups = {ValidationUserJoin.class, ValidationUserModify.class,
      ValidationAdminJoin.class})
  @EmailCheck(dependency = true, groups = {ValidationUserJoin.class, ValidationUserModify.class,
      ValidationAdminJoin.class})
  @UserEmailCheck(dependency = true,
      groups = {ValidationUserJoin.class, ValidationUserModify.class})
  @AdminUserEmailCheck(dependency = true, field = "id", groups = {ValidationAdminJoin.class,
      ValidationAdminModify.class})
  private String user_email;

  /** 핸드폰 앞자리 */
  @Pattern(regexp = "[0-9]{3}", groups = {ValidationUserJoin.class, ValidationUserModify.class,
      ValidationAdminJoin.class, ValidationAdminModify.class})
  private String user_cp_1;

  /** 핸드폰 중간 */
  @Pattern(regexp = "[0-9]{4}", groups = {ValidationUserJoin.class, ValidationUserModify.class,
      ValidationAdminJoin.class, ValidationAdminModify.class})
  private String user_cp_2;

  /** 핸드폰 마지막 */
  @Pattern(regexp = "[0-9]{4}", groups = {ValidationUserJoin.class, ValidationUserModify.class,
      ValidationAdminJoin.class, ValidationAdminModify.class})
  private String user_cp_3;

  /** 주소1 */
  private String user_addr_1;

  /** 파일 업로드 체크 */
  @UploadCheck(field = "file_upload", extensions = "jpg, jpeg", groups = {ValidationUserJoin.class,
      ValidationUserModify.class})
  private String file_upload_check;

  private String chk_flag;

  /** 패스워드 */
  private String user_scrt_org;

  /** 생년월일 */
  private String user_birth;


  /** 전화 앞자리 */
  private String user_tel_1;
  private String user_tel_2;
  private String user_tel_3;


  /** 우편번호 */
  private String user_zip;


  /** 주소2 */
  private String user_addr_2;


  private String mailing_yn = "N";


  /** 사용자부서 / 직위/직급 정보 */
  private String user_dept;
  private String user_grade;

  /** 사용자 권한 상위 코드 */
  private String up_auth_cd;

  /** 사용자 권한코드 */
  private String user_auth_cd;

  /** 사용자 권한레벨 */
  private int user_auth_lv;

  /** 사용자 권한명 */
  private String user_auth_nm;

  /** 로그인 타입 : 회원로그인 / 비회원 로그인 */
  private String user_login_type;

  /** 비밀번호/아이디 찾기 타입 */
  private String user_recover_type;

  private String user_ipincode;

  private String user_dupinfo;

  private String user_name_chk;

  private String pinCode;

  private String allow_ip = "*";

  /** 로그인 시의 정보가 현재세션의 정보와 일치하는지 확인하기 위한 값 */
  private String loginsess_id = "";
  private String loginsess_ip = "";
  private String loginsess_bw = "";
  private String loginsess_os = "";

  /** 중복가입 정보 */
  private String user_dup_info;

  /** 대표자 */
  private String president;
  /** 사업자 등록번호 */
  private String bizreg_no;
  /** 사업범위 */
  private String biz_scope;
  /** 주요제품 */
  private String maj_product;
  /** 마지막 로그인 시간 */
  private String last_login;
  /** 마지막 로그아웃 시간 */
  private String last_logout;

	/** 비밀번호 오류초과 잠금 */
	private String is_lock;

	private int lock_count;

	/** 비밀번호 수정일 */
	protected String pass_mdt;

	/** 비밀번호 수정기간 */
	protected int pass_mdt_d;

  public String getUser_id() {
    return user_id;
  }

  public void setUser_id(String user_id) {
    this.user_id = user_id;
  }

  public String getUser_scrt() {
    return user_scrt;
  }

  public void setUser_scrt(String user_scrt) {
    this.user_scrt = user_scrt;
  }

  public String getUser_nm() {
    return user_nm;
  }

  public void setUser_nm(String user_nm) {
    this.user_nm = user_nm;
  }

  public String getUser_email() {
    return user_email;
  }

  public void setUser_email(String user_email) {
    this.user_email = user_email;
  }

  public String getUser_birth() {
    return user_birth;
  }

  public void setUser_birth(String user_birth) {
    this.user_birth = user_birth;
  }

  public String getUser_cp_1() {
    return user_cp_1;
  }

  public void setUser_cp_1(String user_cp_1) {
    this.user_cp_1 = user_cp_1;
  }

  public String getUser_cp_2() {
    return user_cp_2;
  }

  public void setUser_cp_2(String user_cp_2) {
    this.user_cp_2 = user_cp_2;
  }

  public String getUser_cp_3() {
    return user_cp_3;
  }

  public void setUser_cp_3(String user_cp_3) {
    this.user_cp_3 = user_cp_3;
  }

  public String getUser_zip() {
    return user_zip;
  }

  public void setUser_zip(String user_zip) {
    this.user_zip = user_zip;
  }

  public String getUser_addr_1() {
    return user_addr_1;
  }

  public void setUser_addr_1(String user_addr_1) {
    this.user_addr_1 = user_addr_1;
  }

  public String getUser_addr_2() {
    return user_addr_2;
  }

  public void setUser_addr_2(String user_addr_2) {
    this.user_addr_2 = user_addr_2;
  }

  public String getUser_auth_cd() {
    return user_auth_cd;
  }

  public void setUser_auth_cd(String user_auth_cd) {
    this.user_auth_cd = user_auth_cd;
  }


  public String getUser_auth_nm() {
    return user_auth_nm;
  }

  public void setUser_auth_nm(String user_auth_nm) {
    this.user_auth_nm = user_auth_nm;
  }

  public String getUser_login_type() {
    return user_login_type;
  }

  public void setUser_login_type(String user_login_type) {
    this.user_login_type = user_login_type;
  }

  public int getUser_auth_lv() {
    return user_auth_lv;
  }

  public void setUser_auth_lv(int user_auth_lv) {
    this.user_auth_lv = user_auth_lv;
  }

  public String getUp_auth_cd() {
    return up_auth_cd;
  }

  public void setUp_auth_cd(String up_auth_cd) {
    this.up_auth_cd = up_auth_cd;
  }


  public String getUser_scrt_org() {
    return user_scrt_org;
  }

  public void setUser_scrt_org(String user_scrt_org) {
    this.user_scrt_org = user_scrt_org;
  }

  public String getUser_ipincode() {
    return user_ipincode;
  }

  public void setUser_ipincode(String user_ipincode) {
    this.user_ipincode = user_ipincode;
  }

  public String getUser_recover_type() {
    return user_recover_type;
  }

  public void setUser_recover_type(String user_recover_type) {
    this.user_recover_type = user_recover_type;
  }

  public String getUser_dupinfo() {
    return user_dupinfo;
  }

  public void setUser_dupinfo(String user_dupinfo) {
    this.user_dupinfo = user_dupinfo;
  }

  public String getMailing_yn() {
    return mailing_yn;
  }

  public void setMailing_yn(String mailing_yn) {
    if (mailing_yn == null) {
      mailing_yn = "N";
    }
    this.mailing_yn = mailing_yn;
  }

  public String getUser_tel_1() {
    return user_tel_1;
  }

  public void setUser_tel_1(String user_tel_1) {
    this.user_tel_1 = user_tel_1;
  }

  public String getUser_tel_2() {
    return user_tel_2;
  }

  public void setUser_tel_2(String user_tel_2) {
    this.user_tel_2 = user_tel_2;
  }

  public String getUser_tel_3() {
    return user_tel_3;
  }

  public void setUser_tel_3(String user_tel_3) {
    this.user_tel_3 = user_tel_3;
  }

  public String getUser_dept() {
    return user_dept;
  }

  public void setUser_dept(String user_dept) {
    this.user_dept = user_dept;
  }

  public String getUser_grade() {
    return user_grade;
  }

  public void setUser_grade(String user_grade) {
    this.user_grade = user_grade;
  }

  public String getPinCode() {
    return pinCode;
  }

  public void setPinCode(String pinCode) {
    this.pinCode = pinCode;
  }

  public String getAllow_ip() {
    return allow_ip;
  }

  public void setAllow_ip(String allow_ip) {
    this.allow_ip = allow_ip;
  }

  public String getChk_flag() {
    return chk_flag;
  }

  public void setChk_flag(String chk_flag) {
    this.chk_flag = chk_flag;
  }

  public String getUser_name_chk() {
    return user_name_chk;
  }

  public void setUser_name_chk(String user_name_chk) {
    this.user_name_chk = user_name_chk;
  }

  public String getPresident() {
    return president;
  }

  public void setPresident(String president) {
    this.president = president;
  }

  public String getBizreg_no() {
    return bizreg_no;
  }

  public void setBizreg_no(String bizreg_no) {
    this.bizreg_no = bizreg_no;
  }

  public String getBiz_scope() {
    return biz_scope;
  }

  public void setBiz_scope(String biz_scope) {
    this.biz_scope = biz_scope;
  }

  public String getMaj_product() {
    return maj_product;
  }

  public void setMaj_product(String maj_product) {
    this.maj_product = maj_product;
  }

  public String getLoginsess_id() {
    return loginsess_id;
  }

  public void setLoginsess_id(String loginsess_id) {
    this.loginsess_id = loginsess_id;
  }

  public String getLoginsess_ip() {
    return loginsess_ip;
  }

  public void setLoginsess_ip(String loginsess_ip) {
    this.loginsess_ip = loginsess_ip;
  }

  public String getLoginsess_bw() {
    return loginsess_bw;
  }

  public void setLoginsess_bw(String loginsess_bw) {
    this.loginsess_bw = loginsess_bw;
  }

  public String getLoginsess_os() {
    return loginsess_os;
  }

  public void setLoginsess_os(String loginsess_os) {
    this.loginsess_os = loginsess_os;
  }

  public String getUser_dup_info() {
    return user_dup_info;
  }

  public void setUser_dup_info(String user_dup_info) {
    this.user_dup_info = user_dup_info;
  }

  public String getUser_scrt_confirm() {
    return user_scrt_confirm;
  }

  public void setUser_scrt_confirm(String user_scrt_confirm) {
    this.user_scrt_confirm = user_scrt_confirm;
  }

  public String getFile_upload_check() {
    return file_upload_check;
  }

  public void setFile_upload_check(String file_upload_check) {
    this.file_upload_check = file_upload_check;
  }

  public String getLast_login() {
    return last_login;
  }

  public void setLast_login(String last_login) {
    this.last_login = last_login;
  }

  public String getLast_logout() {
    return last_logout;
  }

  public void setLast_logout(String last_logout) {
    this.last_logout = last_logout;
  }

	public String getIs_lock() {
		return is_lock;
	}

	public void setIs_lock(String is_lock) {
		this.is_lock = is_lock;
	}

	public int getLock_count() {
		return lock_count;
	}

	public void setLock_count(int lock_count) {
		this.lock_count = lock_count;
	}

	public String getPass_mdt() {
		return pass_mdt;
	}

	public void setPass_mdt(String pass_mdt) {
		this.pass_mdt = pass_mdt;
	}

	public int getPass_mdt_d() {
		return pass_mdt_d;
	}

	public void setPass_mdt_d(int pass_mdt_d) {
		this.pass_mdt_d = pass_mdt_d;
	}
}
