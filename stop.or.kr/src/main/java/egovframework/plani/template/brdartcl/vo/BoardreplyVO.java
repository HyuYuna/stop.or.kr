package egovframework.plani.template.brdartcl.vo;


public class BoardreplyVO extends BoarddefaultVO {

  private static final long serialVersionUID = 1L;

  /** 댓글 순번 */
  private int reply_idx;

  /** 내용 */
  private String reply_cont;

  /** 추천수 */
  private int rcmnd_cnt = 0;

  private String brd_pwd;
  private String brd_pwd_chk;

  public int getReply_idx() {
    return reply_idx;
  }

  public void setReply_idx(int reply_idx) {
    this.reply_idx = reply_idx;
  }

  public String getReply_cont() {
    return reply_cont;
  }

  public void setReply_cont(String reply_cont) {
    this.reply_cont = reply_cont;
  }

  public int getRcmnd_cnt() {
    return rcmnd_cnt;
  }

  public void setRcmnd_cnt(int rcmnd_cnt) {
    this.rcmnd_cnt = rcmnd_cnt;
  }

  public String getBrd_pwd() {
    return brd_pwd;
  }

  public void setBrd_pwd(String brd_pwd) {
    this.brd_pwd = brd_pwd;
  }

  public String getBrd_pwd_chk() {
    return brd_pwd_chk;
  }

  public void setBrd_pwd_chk(String brd_pwd_chk) {
    this.brd_pwd_chk = brd_pwd_chk;
  }


}

