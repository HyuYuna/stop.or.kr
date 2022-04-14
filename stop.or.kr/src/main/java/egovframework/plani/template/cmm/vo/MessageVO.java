package egovframework.plani.template.cmm.vo;

import java.util.Date;

public class MessageVO {

  /** 발송 시간 */
  private Date send_date;

  /** SMS 발송 상태 0 : 발송대기, 1 : 전송완료, 2 : 결과수신완료 */
  /** MMS 발송 상태 0 : 발송대기, 2 : 송신완료, 3 : 결과수신 */
  private String send_stat;

  /** SMS 문자 전송 형태 0 : 일반메시지, 1 : 콜백 URL 메시지 */
  /** MMS 문자 전송 형태 0 : MMS, 1 : MMSURL, 7 : HTML */
  private String msg_type;

  /** 수신자 전화번호 */
  private String phone;

  /** 송신자 전화번호 */
  private String callback;

  /** 전송할 메세지 */
  private String msg;

  /*
   * MMS
   */

  /** 제목 */
  private String subject;

  /** 파일 갯수 */
  private int file_cnt;

  /** 파일 위치 */
  private String file_path;

  /** 파일 사이즈 */
  private int file_path_size;


  /**
   * 생성자 SMS용
   * 
   * @param phone
   * @param msg
   */
  public MessageVO(String phone, String msg) {
    this.phone = phone;
    this.msg = msg;
    this.callback = "0419505300";
    this.send_stat = "0";
    this.msg_type = "0";
  }

  /**
   * 생성자 MMS용
   * 
   * @param phone
   * @param msg
   */
  public MessageVO(String phone, String msg, String subject) {
    this.phone = phone;
    this.msg = msg;
    this.subject = subject;
    this.callback = "0419505300";
    this.send_stat = "0";
    this.msg_type = "0";
    this.file_cnt = 0;
    this.file_path = "";
    this.file_path_size = 0;
  }

  public Date getSend_date() {
    return send_date;
  }

  public void setSend_date(Date send_date) {
    this.send_date = send_date;
  }

  public String getSend_stat() {
    return send_stat;
  }

  public void setSend_stat(String send_stat) {
    this.send_stat = send_stat;
  }

  public String getMsg_type() {
    return msg_type;
  }

  public void setMsg_type(String msg_type) {
    this.msg_type = msg_type;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getCallback() {
    return callback;
  }

  public void setCallback(String callback) {
    this.callback = callback;
  }

  public String getMsg() {
    return msg;
  }

  public void setMsg(String msg) {
    this.msg = msg;
  }

  public String getSubject() {
    return subject;
  }

  public void setSubject(String subject) {
    this.subject = subject;
  }

  public int getFile_cnt() {
    return file_cnt;
  }

  public void setFile_cnt(int file_cnt) {
    this.file_cnt = file_cnt;
  }

  public String getFile_path() {
    return file_path;
  }

  public void setFile_path(String file_path) {
    this.file_path = file_path;
  }

  public int getFile_path_size() {
    return file_path_size;
  }

  public void setFile_path_size(int file_path_size) {
    this.file_path_size = file_path_size;
  }
}
