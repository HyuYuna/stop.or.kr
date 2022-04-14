package egovframework.plani.template.cmm.utils;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;

public class SendmessageUtil {
  /*
   * private String smtp_host = EgovProperties.GLOBALS_SMTP_HOST; private int smtp_port =
   * EgovProperties.GLOBALS_SMTP_PORT; private String smtp_id = EgovProperties.GLOBALS_SMTP_ID;
   * private String smtp_pw = EgovProperties.GLOBALS_SMTP_PWD;
   */

  private class PlaniAuthenticator extends Authenticator {

    private String sm_id;
    private String sm_pw;

    public PlaniAuthenticator(String id, String pw) {
      this.sm_id = id;
      this.sm_pw = pw;
    }

    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
      return new javax.mail.PasswordAuthentication(sm_id, sm_pw);
    }

  }


  private String smtp_host = null;
  private int smtp_port = 25;
  private String smtp_id = null;
  private String smtp_pw = null;
  private boolean use_svrauth = false;

  public SendmessageUtil() {}

  public SendmessageUtil(String host, int port) {
    smtp_host = host;
    smtp_port = port;
    use_svrauth = false;
  }

  public SendmessageUtil(String host, int port, String id, String pw) {
    smtp_host = host;
    smtp_port = port;
    smtp_id = id;
    smtp_pw = pw;
    use_svrauth = true;
  }

  public String getSmtp_host() {
    return smtp_host;
  }

  public void setSmtp_host(String smtp_host) {
    this.smtp_host = smtp_host;
  }

  public String getSmtp_id() {
    return smtp_id;
  }

  public void setSmtp_id(String smtp_id) {
    this.smtp_id = smtp_id;
  }

  public String getSmtp_pw() {
    return smtp_pw;
  }

  public void setSmtp_pw(String smtp_pw) {
    this.smtp_pw = smtp_pw;
  }

  public int getSmtp_port() {
    return smtp_port;
  }

  public void setSmtp_port(int smtp_port) {
    this.smtp_port = smtp_port;
  }

  public boolean isUse_svrauth() {
    return use_svrauth;
  }

  public void setUse_svrauth(boolean use_svrauth) {
    this.use_svrauth = use_svrauth;
  }

  public void SendMail(String mail_from, String mail_fromnm, String mail_to, String subject,
      String content) {
    try {
      System.out.println("###### 메일 전송 테스트 ##### ");

      // 프로퍼티 값 인스턴스 생성과 기본세션(SMTP 서버 호스트 지정)
      Properties props = new Properties();
      props.put("mail.smtp.host", smtp_host);
      props.put("mail.smtp.port", smtp_port);
      props.put("mail.smtp.starttls.enable", "false");
      props.put("mail.smtp.auth", "false");
      props.put("mail.smtp.ssl.socketFactory.port", 25);
      // props.put("mail.smtp.ssl.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

      PlaniAuthenticator auth = use_svrauth ? new PlaniAuthenticator(smtp_id, smtp_pw) : null;
      Session mailSession = Session.getDefaultInstance(props, auth);

      // sess.getPasswordAuthentication(host);
      Message msg = new MimeMessage(mailSession);
      msg.setFrom(
          new InternetAddress(mail_from, MimeUtility.encodeText(mail_fromnm, "EUC-KR", "B")));// 보내는
                                                                                              // 사람
                                                                                              // 설정
      InternetAddress[] address = {new InternetAddress(mail_to)};

      msg.setRecipients(Message.RecipientType.TO, address);// 받는 사람설정
      msg.setSubject(MimeUtility.encodeText(subject, "EUC-KR", "B"));// 제목 설정
      msg.setSentDate(new java.util.Date());// 보내는 날짜 설정
      msg.setContent(content, "text/html;charset=euc-kr"); // 내용 설정 (HTML 형식)

      Transport.send(msg); // 메일 보내기
    } catch (MessagingException ex) {
      ex.printStackTrace();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  /**
   * 파일첨부 메일 예제..
   * 
   * @param mail_from
   * @param mail_fromnm
   * @param mail_to
   * @param subject
   * @param content
   * @param filelist
   */
  public void SendMailAtchfile(String mail_from, String mail_fromnm, String mail_to, String subject,
      String content, List<AtchfileVO> filelist) {
    try {

      content = EgovWebUtil.removeScrtag(content);

      String txtMail = "<div style='text-align:center; margin:0 auto; width:500px;'>";
      txtMail +=
          "<div style='border:5px solid #DDDFD0; background:url(http://kiom.rauinfo.com/images/mail.gif) no-repeat 0 0; width:500px; padding-bottom:20px; margin:20px; '>";
      txtMail +=
          "	<div style='text-valign:top;border-top:1px solid #E1E1E1; border-bottom:1px solid #E1E1E1; padding:6px 0 3px 0; margin:90px 23px 0  23px; width:440px;'><span style='color:#404D07; font-size:12px; font-weight:bold;'>"
              + subject + "</span></div>";
      txtMail +=
          "	<div style='border:1px solid #CED4AD; background-color:#F2F5E1; padding:10px; margin:20px 23px 0 23px; width:440px; height:200px; line-height:18px; '>"
              + content + "<br></div>";
      txtMail += "</div>";
      txtMail += "</div>";

      PlaniAuthenticator auth = new PlaniAuthenticator(smtp_id, smtp_pw);

      Properties props = System.getProperties();
      props.put("mail.smtp.host", "mail.kiom.re.kr");
      props.put("mail.smtp.auth", "true");
      Session msgSession = Session.getInstance(props, auth);
      // Session msgSession = Session.getDefaultInstance(props, null);

      Message msg = new MimeMessage(msgSession);

      // sess.getPasswordAuthentication(host);
      msg.setFrom(
          new InternetAddress(mail_from, MimeUtility.encodeText(mail_fromnm, "EUC-KR", "B")));// 보내는
                                                                                              // 사람
                                                                                              // 설정
      InternetAddress[] address = {new InternetAddress(mail_to)};

      msg.setRecipients(Message.RecipientType.TO, address);// 받는 사람설정
      msg.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));// 제목 설정
      msg.setSentDate(new java.util.Date());// 보내는 날짜 설정
      // msg.setContent(txtMail,"text/html;charset=UTF-8"); // 내용 설정 (HTML 형식)

      Multipart mp = new MimeMultipart();

      MimeBodyPart mbpCont = new MimeBodyPart();
      mbpCont.setContent(txtMail, "text/html;charset=UTF-8");
      mp.addBodyPart(mbpCont);

      MimeBodyPart mbpFile = null;
      if (filelist != null) {
        for (int i = 0; i < filelist.size(); i++) {
          AtchfileVO fileVO = filelist.get(i);
          mbpFile = new MimeBodyPart();
          String filename = EgovProperties.GLOBALS_FILEUPLOAD_PATH + "/" + fileVO.getFpath() + "/"
              + fileVO.getFname();
          FileDataSource fds = new FileDataSource(new File(filename));
          mbpFile.setDataHandler(new DataHandler(fds));
          mbpFile.setFileName(MimeUtility.encodeText(fileVO.getRname(), "UTF-8", "B"));
          mp.addBodyPart(mbpFile);
        }
        msg.setContent(mp);
      }
      Transport.send(msg);

    } catch (MessagingException ex) {
      ex.printStackTrace();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }


  public void SendSMS(String dest_cp, String content) {
    Connection conn = null;
    PreparedStatement ps = null;
    String url = "jdbc:oracle:thin:@210.219.32.232:1521:sci01";
    String userid = "novitas";
    String password = "novitas2008";

    try {
      conn = DriverManager.getConnection(url, userid, password);
      if ("".equals(dest_cp) || "".equals(content))


        ///////////////////////////////////////
        // SMS 메세지 전송 처리 Start
        ///////////////////////////////////////
        try {
          if (content.getBytes().length > 80)
            throw new CmmnException("80바이트 이상은 전송할 수 없습니다.");

          StringBuffer sb = new StringBuffer();
          sb.append("INSERT INTO EM_TRAN ");
          sb.append(
              "(TRAN_PR, TRAN_PHONE, TRAN_CALLBACK, TRAN_STATUS, TRAN_DATE, TRAN_MSG , TRAN_TYPE) VALUES ");
          sb.append("(EM_TRAN_PR.NEXTVAL, ?, ?, '1', SYSDATE, ?, 4)");
          ps = conn.prepareStatement(sb.toString());
          int idx = 1;
          ps.setString(idx++, dest_cp);
          ps.setString(idx++, "");
          ps.setString(idx++, content);
          ps.executeUpdate();


        } catch (Exception e) {
          e.printStackTrace();
        } finally {
          if (ps != null)
            ps.close();
        }
      ///////////////////////////////////////
      // SMS 메세지 전송 처리 End
      ///////////////////////////////////////


    } catch (Exception e) {
      e.printStackTrace();
    } finally {

      if (conn != null)
        try {
          conn.close();
        } catch (SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
    }

  }


}
