package egovframework.plani.template.cmm.utils.tagfree;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.Vector;
import javax.mail.MessagingException;
import javax.mail.internet.MimeUtility;
import org.w3c.tidy.Configuration;
import org.w3c.tidy.Tidy;

/**
 * TAGFREE MIME Utility 클래스
 * 
 * @author Jonghyun, Yoon [yoonjh@tagfree.com]
 *
 */
public class MimeUtil {
  protected String m_strMimeValue;
  protected String m_strDecodedHtml;
  protected String m_strSaveUrl;
  protected String m_strSavePath;
  protected Vector m_vecFileList;
  protected String m_strBoundary;
  protected String m_strOutCharEncoding;
  protected String m_strInCharEncoding;
  protected boolean m_bRename;
  protected int m_iHtmlRange;
  protected String m_strSaveFilePattern;

  /**
   * 생성자
   * 
   * @see java.lang.Object#Object()
   * 
   */
  public MimeUtil() {
    m_bRename = true;
    m_strBoundary = "--TWE_MIME";
    m_strDecodedHtml = "";
    m_vecFileList = new Vector();
    m_strSaveUrl = "";
    m_strSavePath = "";
    m_strMimeValue = "";
    m_strOutCharEncoding = "";
    m_strInCharEncoding = "";
    m_iHtmlRange = Constant.HTML_ALL;
    m_strSaveFilePattern = "";
    // System.out.println("TAGFREE ActiveDesigner MimeUtil v7.1 002");
  }

  /**
   * 디코딩 결과 HTML 값을 반환한다.
   * 
   * @param bTidy Tidy를 사용하여 well-form xhtml을 반환한다.
   * @return String 디코딩된 HTML
   */
  public String getDecodedHtml(boolean bTidy) {
    if (bTidy)
      return getTidyHtml();
    else
      return m_strDecodedHtml;
  }

  /**
   * 디코딩시에 저장한 파일 리스트를 반환한다.
   * 
   * @return Enumeration 디코딩된 파일 이름에 대한 Enumeration
   */
  public Enumeration getDecodedFileList() {
    return m_vecFileList.elements();
  }

  /**
   * 저장될 파일이름의 패턴을 지정한다. SimpleDateFormat형식.<br>
   * 예)setSaveFilePattern("yyyyMMddHHmmss");
   * 
   * @param strSaveFilePattern
   */
  public void setSaveFilePattern(String strSaveFilePattern) {
    m_strSaveFilePattern = strSaveFilePattern;
  }

  /**
   * Active Designer에서 작성된 본문의 MIME 값을 설정한다.
   * 
   * @param strMimeValue MIME 값
   */
  public void setMimeValue(String strMimeValue) {
    m_strMimeValue = strMimeValue;
  }

  /**
   * 디코딩 후 저장된 파일들의 URL 경로를 지정한다.
   * 
   * <pre>
   * ex) <code>util.setSaveUrl("http://www.tagfree.com/tweditor/upload");</code>
   * 주의 -> 마지막에 '/'를 붙이지 않도록 한다.
   * </pre>
   * 
   * @param strSaveUrl 파일이 저장된 디렉터리에 대한 URL 경로
   */
  public void setSaveUrl(String strSaveUrl) {
    m_strSaveUrl = strSaveUrl;
  }

  /**
   * 디코딩 시에 파일을 저장할 디렉터리를 지정한다.
   * 
   * <pre>
   * ex) <code>util.setSaveUrl("c:/inetpub/www/tweditor/upload");</code>
   * 주의 -> 마지막에 '/'를 붙이지 않도록 한다.
   * </pre>
   * 
   * @param strSavePath 파일을 저장할 디렉터리 경로
   */
  public void setSavePath(String strSavePath) {
    m_strSavePath = strSavePath;
  }

  /**
   * 중복된 파일이 있을 경우 파일 이름을 변경할 것인지 지정한다. 새로운 이름의 경우 _(숫자) 형태로 생성이 된다.
   * 
   * @param bRename true이면 새로운 이름을 생성, false이면 덮어 씀.
   */
  public void setRename(boolean bRename) {
    m_bRename = bRename;
  }

  /**
   * MimeUtil 내에서 사용할 기본 출력 인코딩을 지정한다.
   * 
   * <pre>
   * ex) <code>util.setCharEncoding("euc-kr");</code>
   * </pre>
   * 
   * @param strEncoding 인코딩
   */
  public void setOutCharEncoding(String strEncoding) {
    m_strOutCharEncoding = strEncoding;
  }

  /**
   * MimeUtil 내에서 사용할 기본 입력 인코딩을 지정한다.
   * 
   * <pre>
   * ex) <code>util.setCharEncoding("iso8859-1");</code>
   * </pre>
   * 
   * @param strEncoding 인코딩
   */
  public void setInCharEncoding(String strEncoding) {
    m_strInCharEncoding = strEncoding;
  }

  /**
   * Well-Form HTML 문서 생성 시에 어떤 부분까지를 반환할지를 결정한다.
   * 
   * @param iRange Constant 클래스의 값을 참조.
   */
  public void setHtmlRange(int iRange) {
    m_iHtmlRange = iRange;
  }

  /**
   * 디코딩을 수행한다.
   *
   */
  public void processDecoding() {
    try {
      processParsing();
    } catch (MimeUtilException e) {
      e.printStackTrace();
    }
  }

  /**
   * Mime값에 포함된 본문을 별도로 제공하여 디코딩을 수행한다.
   * 
   * @param strHtml
   */
  public void processDecoding(String strHtml) {
    try {
      processParsing(strHtml);
    } catch (MimeUtilException e) {
      e.printStackTrace();
    }
  }

  /**
   * 
   * @return
   * @throws MimeUtilException
   */
  protected void processParsing() throws MimeUtilException {
    findBoundaryString();

    int iHeaderTemp = m_strMimeValue.indexOf(m_strBoundary);
    int iHeaderEnd = iHeaderTemp + m_strBoundary.length();
    m_strMimeValue = m_strMimeValue.substring(iHeaderEnd);
    StringTokenizer st = new StringTokenizer(m_strMimeValue, m_strBoundary);
    EncodePartData partData = new EncodePartData();
    String strEncodedContent;
    String strContentLocation;
    String strContentID;
    String strFileName;
    String strFileExtName;
    String strNewUrl;
    String exstrNewFileName = new String();
    File file = null;
    InputStream in = null;
    int iExt = 0;
    m_vecFileList.clear();

    try {
      for (int i = 0; i < st.countTokens() - 1; ++i) {
        partData.setEncodePartData(st.nextToken());
        strEncodedContent = partData.getContent();
        switch (partData.getEncodingType()) {
          case Constant.BASE64:
            in = MimeUtility.decode(new ByteArrayInputStream(strEncodedContent.getBytes()),
                "base64");
            break;
          case Constant.QP:
            in = MimeUtility.decode(new ByteArrayInputStream(strEncodedContent.getBytes()),
                "quoted-printable");
            break;
        }

        strContentLocation = partData.getContentLocation(true);
        strContentID = partData.getContentID();
        if (strContentLocation == null) {
          if (partData.getContentSubType() == Constant.SUB_TYPE_HTML) {
            BufferedReader br = new BufferedReader(new InputStreamReader(in, getCharsetInMime()));
            String strLine;
            StringBuffer sbDecodedHtml = new StringBuffer();

            while ((strLine = br.readLine()) != null) {
              sbDecodedHtml.append(strLine);
              if (strLine.length() > 1) {
                if (strLine.charAt(strLine.length() - 1) != '\013')
                  sbDecodedHtml.append('\n');
              }
            }

            m_strDecodedHtml = sbDecodedHtml.toString();
          }
        } else {
          strContentLocation = replace(strContentLocation, "\\", "//");
          file = new File(strContentLocation);
          strFileName = file.getName();
          iExt = strFileName.lastIndexOf(".");
          if (iExt == -1)
            strFileExtName = "";
          else {
            strFileExtName = strFileName.substring(iExt + 1);
            strFileName = strFileName.substring(0, iExt);
          }

          // 파일 이름 저장 패턴
          if (m_strSaveFilePattern != "") {
            SimpleDateFormat sdfCurrent = new SimpleDateFormat(m_strSaveFilePattern);
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            strFileName = sdfCurrent.format(currentTime);
          }
          exstrNewFileName = saveBinary(strFileName, strFileExtName, in);
          if (exstrNewFileName == null)
            throw new MimeUtilException("mimeutil not found filename.");

          // cid ---> url
          StringBuffer sbContentID = new StringBuffer();
          sbContentID.append(strContentID);
          sbContentID.insert(0, "cid:");
          strContentID = sbContentID.toString();

          strNewUrl = getStringFromEncoding(m_strSaveUrl + "/");
          strNewUrl = strNewUrl + exstrNewFileName;
          m_strDecodedHtml = replace(m_strDecodedHtml, strContentID, strNewUrl);
          m_vecFileList.addElement(exstrNewFileName);
        }
      }
    } catch (MimeUtilException e) {

    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    } catch (MessagingException e) {
      e.printStackTrace();
    }
  }

  /**
   * 
   * @param strHtml
   * @return
   * @throws MimeUtilException
   */
  protected void processParsing(String strHtml) throws MimeUtilException {
    findBoundaryString();

    int iHeaderTemp = m_strMimeValue.indexOf(m_strBoundary);
    int iHeaderEnd = iHeaderTemp + m_strBoundary.length();
    m_strMimeValue = m_strMimeValue.substring(iHeaderEnd);
    StringTokenizer st = new StringTokenizer(m_strMimeValue, m_strBoundary);
    EncodePartData partData = new EncodePartData();
    String strEncodedContent;
    String strContentLocation;
    String strContentID;
    String strFileName;
    String strFileExtName;
    String strNewUrl;
    String exstrNewFileName = new String();
    File file = null;
    InputStream in = null;
    int iExt = 0;
    m_vecFileList.clear();

    try {
      for (int i = 0; i < st.countTokens() - 1; ++i) {
        partData.setEncodePartData(st.nextToken());
        strEncodedContent = partData.getContent();
        switch (partData.getEncodingType()) {
          case Constant.BASE64:
            in = MimeUtility.decode(new ByteArrayInputStream(strEncodedContent.getBytes()),
                "base64");
            break;
          case Constant.QP:
            in = MimeUtility.decode(new ByteArrayInputStream(strEncodedContent.getBytes()),
                "quoted-printable");
            break;
        }

        strContentLocation = partData.getContentLocation(true);
        strContentID = partData.getContentID();
        if (strContentLocation == null) {
          if (partData.getContentSubType() == Constant.SUB_TYPE_HTML) {
            BufferedReader br = new BufferedReader(new InputStreamReader(in));
            String strLine;
            StringBuffer sbDecodedHtml = new StringBuffer();

            while ((strLine = br.readLine()) != null) {
              sbDecodedHtml.append(strLine);
              if (strLine.length() > 1) {
                if (strLine.charAt(strLine.length() - 1) != '\013')
                  sbDecodedHtml.append('\n');
              }
            }

            m_strDecodedHtml = sbDecodedHtml.toString();
            m_strDecodedHtml = strHtml;
          }
        } else {
          String changeContentLocation = partData.getContentLocation(false);
          strContentLocation = replace(strContentLocation, "\\", "//");
          file = new File(strContentLocation);
          strFileName = file.getName();
          iExt = strFileName.lastIndexOf(".");
          if (iExt == -1)
            strFileExtName = "";
          else {
            strFileExtName = strFileName.substring(iExt + 1);
            strFileName = strFileName.substring(0, iExt);
          }

          // Save Pattern of File Name
          if (m_strSaveFilePattern != "") {
            SimpleDateFormat sdfCurrent = new SimpleDateFormat(m_strSaveFilePattern);
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            strFileName = sdfCurrent.format(currentTime);
          }
          exstrNewFileName = saveBinary(strFileName, strFileExtName, in);
          if (exstrNewFileName == null)
            throw new MimeUtilException("mimeutil not found boundary data from mimevalue.");

          // cid ---> url
          StringBuffer sbContentID = new StringBuffer();
          sbContentID.append(strContentID);
          sbContentID.insert(0, "cid:");
          strContentID = sbContentID.toString();
          strNewUrl = getStringFromEncoding(m_strSaveUrl + "/");
          strNewUrl = strNewUrl + exstrNewFileName;

          m_strDecodedHtml = replace(m_strDecodedHtml, changeContentLocation, strContentID);

          m_strDecodedHtml = replace(m_strDecodedHtml, strContentID, strNewUrl);
          m_vecFileList.addElement(exstrNewFileName);
        }
      }
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    } catch (MessagingException e) {
      e.printStackTrace();
    }
  }

  /**
   * 
   * @throws MimeUtilException
   */
  protected void findBoundaryString() throws MimeUtilException {
    if (m_strMimeValue == null)
      throw new MimeUtilException("mimevalue set to null.");
    int iBoundStart = m_strMimeValue.indexOf("boundary=", 0);
    if (iBoundStart == -1)
      throw new MimeUtilException("mimeutil not found boundary data from mimevalue.");

    int iBoundEnd = m_strMimeValue.indexOf("\r\n", iBoundStart);
    if (iBoundEnd == -1)
      throw new MimeUtilException("mimeutil not found boundary data from mimevalue.");

    String strTemp = m_strMimeValue.substring(iBoundStart, iBoundEnd);
    strTemp = strTemp.trim();

    strTemp.replace('\'', '\010');
    strTemp.replace('\"', '\010');

    int iEqualStart = strTemp.indexOf("=");
    if (iEqualStart == -1)
      throw new MimeUtilException("mimeutil not found boundary data from mimevalue.");

    m_strBoundary = "--" + strTemp.substring(iEqualStart + 1);
    if (m_strBoundary.length() <= 2)
      throw new MimeUtilException("mimeutil not found boundary data from mimevalue.");
  }

  /**
   * 
   * @param strFileName
   * @param strFileExtName
   * @param in
   * @return
   */
  protected String saveBinary(String strFileName, String strFileExtName, InputStream in) {
    StringBuffer sbSavePath = new StringBuffer();
    File file;
    byte[] buffer;
    int iReadByte;
    int iCount = 0;

    sbSavePath.append(m_strSavePath);
    sbSavePath.append('/');
    sbSavePath.append(strFileName);

    if (strFileExtName.length() != 0) {
      sbSavePath.append('.');
      sbSavePath.append(strFileExtName);
    }
    String exstrNewFileName = sbSavePath.toString();
    if (m_strSaveFilePattern != "")
      m_bRename = true;
    if (m_bRename) {
      while (true) {
        file = new File(exstrNewFileName);

        if (file.exists()) {
          iCount++;

          sbSavePath.setLength(0);

          sbSavePath.append(m_strSavePath);
          sbSavePath.append('/');
          sbSavePath.append(strFileName);
          sbSavePath.append('-');
          sbSavePath.append('(');
          sbSavePath.append(iCount);
          sbSavePath.append(')');

          if (strFileExtName.length() != 0) {
            sbSavePath.append('.');
            sbSavePath.append(strFileExtName);
          }

          exstrNewFileName = sbSavePath.toString();
          file = null;
        } else {
          break;
        }
      }
    }

    try {
      FileOutputStream fos;

      fos = new FileOutputStream(exstrNewFileName);
      buffer = new byte[1024];
      while ((iReadByte = in.read(buffer)) != -1) {
        fos.write(buffer, 0, iReadByte);
      }
      fos.flush();
      fos.close();
      fos = null;

      String str = exstrNewFileName;
      int index = str.lastIndexOf("/");
      exstrNewFileName = str.substring(index + 1);
    } catch (IOException e) {
      e.printStackTrace();
    }
    return exstrNewFileName;
  }

  /**
   * 
   * @return
   */
  protected String getTidyHtml() {
    ByteArrayOutputStream out = new ByteArrayOutputStream();
    Tidy tidy = new Tidy();
    tidy.setCharEncoding(Configuration.ISO2022);
    tidy.setXmlOut(true);
    tidy.setSpaces(4);
    tidy.setDocType("omit");
    tidy.setTidyMark(false);
    // tidy.setIndentContent(false);
    tidy.setSmartIndent(true);
    tidy.setIndentAttributes(false);
    tidy.setWraplen(0);
    tidy.setQuiet(true);
    tidy.setShowWarnings(false);
    tidy.parse(new ByteArrayInputStream(m_strDecodedHtml.getBytes()), out);
    String strTidyHtml = out.toString();

    switch (m_iHtmlRange) {
      case Constant.HTML_INNER_BODY: {
        int idx1 = strTidyHtml.indexOf("<body");
        int idx2 = strTidyHtml.indexOf(">", idx1);
        int idx3 = strTidyHtml.indexOf("</body>", idx2);
        strTidyHtml = strTidyHtml.substring(idx2 + 1, idx3);
        break;
      }
      case Constant.HTML_OUTER_BODY: {
        int idx1 = strTidyHtml.indexOf("<body");
        int idx2 = strTidyHtml.indexOf("</body>", idx1) + 7;
        strTidyHtml = strTidyHtml.substring(idx1, idx2);
        break;
      }
    }

    tidy = null;
    out = null;

    return strTidyHtml;
  }

  /**
   * 
   * @param str
   * @return
   * @throws UnsupportedEncodingException
   */
  protected String getStringFromEncoding(String str) throws UnsupportedEncodingException {
    if (m_strInCharEncoding.trim().length() == 0 || m_strOutCharEncoding.trim().length() == 0) {
      return str;
    } else {
      return new String(str.getBytes(m_strInCharEncoding), m_strOutCharEncoding);
    }
  }

  /**
   * 
   * @param str
   * @param strInEnc
   * @param strOutEnc
   * @return
   * @throws UnsupportedEncodingException
   * @throws MimeUtilException
   */
  protected String getStringFromEncoding(String str, String strInEnc, String strOutEnc)
      throws UnsupportedEncodingException, MimeUtilException {
    strInEnc = strInEnc.trim();
    strOutEnc = strOutEnc.trim();

    if (strInEnc.length() == 0 && strOutEnc.length() == 0) {
      throw new MimeUtilException("Invalid Encoding...");
    } else {
      if (strInEnc.length() == 0 && strOutEnc.length() > 0) {
        return new String(str.getBytes(), strOutEnc);
      } else if (strInEnc.length() > 0 && strOutEnc.length() == 0) {
        return new String(str.getBytes(strInEnc));
      } else {
        return new String(str.getBytes(strInEnc), strOutEnc);
      }
    }
  }

  /**
   * str에 지정된 문자열에서 find에 해당하는 모든 문자열을 찾아 replace 문자열로 대체한다.
   * 
   * @param str 대상 문자열
   * @param find 찾을 문자열
   * @param replace 대체 문자열
   * @return String 변환된 문자열
   * 
   */
  public static String replace(String str, String find, String replace) {
    int findLength = find.length();
    int replaceLength = replace.length();
    int start = 0;
    int strLength = 0;
    int index = 0;
    StringBuffer sb = new StringBuffer();

    do {
      strLength = str.length();
      index = str.indexOf(find, start);

      if (index == -1)
        break;

      sb.setLength(0);
      sb.append(str.substring(0, index));
      sb.append(replace);
      sb.append(str.substring(index + findLength, strLength));
      str = sb.toString();

      start = index + replaceLength;
    } while (true);

    return str;
  }

  public static String getVersion() {
    String strVersion;
    strVersion = "v7.1";
    return strVersion;
  }

  public String getCharsetInMime() {
    String strCharset;
    strCharset = "";
    int index = m_strMimeValue.indexOf("charset=\"");
    if (index == -1)
      return strCharset;

    int indexEnd = m_strMimeValue.indexOf("\"", index);
    String strTmp;
    strTmp = m_strMimeValue.substring(index + 9);
    int i = 0;
    i = strTmp.indexOf("\"");
    strCharset = strTmp.substring(0, i);

    return strCharset;
  }
}

