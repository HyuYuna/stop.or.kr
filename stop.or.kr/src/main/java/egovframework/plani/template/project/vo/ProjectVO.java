package egovframework.plani.template.project.vo;

import org.hibernate.validator.constraints.NotEmpty;
import egovframework.plani.custom.form.validator.EmailCheck;
import egovframework.plani.template.cmm.vo.DefaultSearchVO;

public class ProjectVO extends DefaultSearchVO {

  private static final long serialVersionUID = 1L;

  private int new_idx;

  @NotEmpty
  @EmailCheck(dependency = true)
  private String email;

  private String wdt;

  private String mdt;

  private String deldt;

  public int getNew_idx() {
    return new_idx;
  }

  public void setNew_idx(int new_idx) {
    this.new_idx = new_idx;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
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
  public String getMdt() {
    return mdt;
  }

  @Override
  public void setMdt(String mdt) {
    this.mdt = mdt;
  }

  public String getDeldt() {
    return deldt;
  }

  public void setDeldt(String deldt) {
    this.deldt = deldt;
  }
/*20190527 PMS용 추가*/
  private int pbd_seq;
  private String pid_cd;
  private String pbd_no;
  private String pbd_no_sub;
  private String pbd_year;
  private String pbd_category;
  private String pbd_req_type;
  private String pbd_req_title;
  private String pbd_req_content;
  private String pbd_req_mem_seq;
  private String pbd_req_mem_nm;
  private String pbd_req_dt;
  private String pbd_due_dt;
  private String pbd_res_type;
  private String pbd_res_title;
  private String pbd_res_content;
  private String pbd_res_mem_seq;
  private String pbd_res_mem_nm;
  private String pbd_res_dt;
  private String pbd_ref_mem_array;
  private String mem_team_nm;
	
	public int getPbd_seq() {
		return pbd_seq;
	}
	
	public void setPbd_seq(int pbd_seq) {
		this.pbd_seq = pbd_seq;
	}
	
	public String getPid_cd() {
		return pid_cd;
	}
	
	public void setPid_cd(String pid_cd) {
		this.pid_cd = pid_cd;
	}
	
	public String getPbd_no() {
		return pbd_no;
	}
	
	public void setPbd_no(String pbd_no) {
		this.pbd_no = pbd_no;
	}
	
	public String getPbd_no_sub() {
		return pbd_no_sub;
	}
	
	public void setPbd_no_sub(String pbd_no_sub) {
		this.pbd_no_sub = pbd_no_sub;
	}
	
	public String getPbd_year() {
		return pbd_year;
	}
	
	public void setPbd_year(String pbd_year) {
		this.pbd_year = pbd_year;
	}
	
	public String getPbd_category() {
		return pbd_category;
	}
	
	public void setPbd_category(String pbd_category) {
		this.pbd_category = pbd_category;
	}
	
	public String getPbd_req_type() {
		return pbd_req_type;
	}
	
	public void setPbd_req_type(String pbd_req_type) {
		this.pbd_req_type = pbd_req_type;
	}
	
	public String getPbd_req_title() {
		return pbd_req_title;
	}
	
	public void setPbd_req_title(String pbd_req_title) {
		this.pbd_req_title = pbd_req_title;
	}
	
	public String getPbd_req_content() {
		return pbd_req_content;
	}
	
	public void setPbd_req_content(String pbd_req_content) {
		this.pbd_req_content = pbd_req_content;
	}
	
	public String getPbd_req_mem_seq() {
		return pbd_req_mem_seq;
	}
	
	public void setPbd_req_mem_seq(String pbd_req_mem_seq) {
		this.pbd_req_mem_seq = pbd_req_mem_seq;
	}
	
	public String getPbd_req_mem_nm() {
		return pbd_req_mem_nm;
	}
	
	public void setPbd_req_mem_nm(String pbd_req_mem_nm) {
		this.pbd_req_mem_nm = pbd_req_mem_nm;
	}
	
	public String getPbd_req_dt() {
		return pbd_req_dt;
	}
	
	public void setPbd_req_dt(String pbd_req_dt) {
		this.pbd_req_dt = pbd_req_dt;
	}
	
	public String getPbd_due_dt() {
		return pbd_due_dt;
	}
	
	public void setPbd_due_dt(String pbd_due_dt) {
		this.pbd_due_dt = pbd_due_dt;
	}
	
	public String getPbd_res_type() {
		return pbd_res_type;
	}
	
	public void setPbd_res_type(String pbd_res_type) {
		this.pbd_res_type = pbd_res_type;
	}
	
	public String getPbd_res_title() {
		return pbd_res_title;
	}
	
	public void setPbd_res_title(String pbd_res_title) {
		this.pbd_res_title = pbd_res_title;
	}
	
	public String getPbd_res_content() {
		return pbd_res_content;
	}
	
	public void setPbd_res_content(String pbd_res_content) {
		this.pbd_res_content = pbd_res_content;
	}
	
	public String getPbd_res_mem_seq() {
		return pbd_res_mem_seq;
	}
	
	public void setPbd_res_mem_seq(String pbd_res_mem_seq) {
		this.pbd_res_mem_seq = pbd_res_mem_seq;
	}
	
	public String getPbd_res_mem_nm() {
		return pbd_res_mem_nm;
	}
	
	public void setPbd_res_mem_nm(String pbd_res_mem_nm) {
		this.pbd_res_mem_nm = pbd_res_mem_nm;
	}
	
	public String getPbd_res_dt() {
		return pbd_res_dt;
	}
	
	public void setPbd_res_dt(String pbd_res_dt) {
		this.pbd_res_dt = pbd_res_dt;
	}
	
	public String getPbd_ref_mem_array() {
		return pbd_ref_mem_array;
	}
	
	public void setPbd_ref_mem_array(String pbd_ref_mem_array) {
		this.pbd_ref_mem_array = pbd_ref_mem_array;
	}

	public String getMem_team_nm() {
		return mem_team_nm;
	}

	public void setMem_team_nm(String mem_team_nm) {
		this.mem_team_nm = mem_team_nm;
	}

}
