package egovframework.plani.template.cmm.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.util.FileCopyUtils;

public class EgovFileDownUtil {

  private static final Logger LOG = Logger.getLogger(EgovFileDownUtil.class.getName());


  /**
   * 브라우저 구분 얻기.
   * 
   * @param request
   * @return
   */
  private String getBrowser(HttpServletRequest request) {
    String header = request.getHeader("User-Agent");
    if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {
      return "MSIE";
    } else if (header.indexOf("Chrome") > -1) {
      return "Chrome";
    } else if (header.indexOf("Opera") > -1) {
      return "Opera";
    }
    return "Firefox";
  }


  /**
   * Disposition 지정하기.
   * 
   * @param filename
   * @param request
   * @param response
   * @throws Exception
   */
  private void setDisposition(String filename, HttpServletRequest request,
      HttpServletResponse response) throws Exception {

    String browser = getBrowser(request);

    String dispositionPrefix = "attachment; filename=";
    String encodedFilename = null;

    if (browser.equals("MSIE")) {
      encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
    } else if (browser.equals("Firefox")) {
      encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
    } else if (browser.equals("Opera")) {
      encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
    } else if (browser.equals("Chrome")) {
      StringBuffer sb = new StringBuffer();
      for (int i = 0; i < filename.length(); i++) {
        char c = filename.charAt(i);
        if (c > '~') {
          sb.append(URLEncoder.encode("" + c, "UTF-8"));
        } else {
          sb.append(c);
        }
      }
      encodedFilename = sb.toString();
    } else {
      // throw new RuntimeException("Not supported browser");
      throw new IOException("Not supported browser");
    }

    response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

    if ("Opera".equals(browser)) {
      response.setContentType("application/octet-stream;charset=UTF-8");
    }
  }



  /**
   * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
   * 
   * @param commandMap
   * @param response
   * @throws Exception
   */
  public void cvplFileDownload(String storePath, String realFileName, String orgFileName,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    File uFile = new File(storePath, realFileName);
    int fSize = (int) uFile.length();

    if (fSize > 0) {
      String mimetype = "application/octet-stream";

      // response.setBufferSize(fSize); // OutOfMemeory 발생
      response.setContentType(mimetype);
      // response.setHeader("Content-Disposition", "attachment; filename=\"" +
      // URLEncoder.encode(orgFileName, "utf-8") + "\"");
      setDisposition(orgFileName, request, response);
      response.setContentLength(fSize);

      /*
       * FileCopyUtils.copy(in, response.getOutputStream()); in.close();
       * response.getOutputStream().flush(); response.getOutputStream().close();
       */
      BufferedInputStream in = null;
      BufferedOutputStream out = null;

      try {
        in = new BufferedInputStream(new FileInputStream(uFile));
        out = new BufferedOutputStream(response.getOutputStream());

        FileCopyUtils.copy(in, out);
        out.flush();
      } catch (Exception ex) {
        // ex.printStackTrace();
        // 다음 Exception 무시 처리
        // Connection reset by peer: socket write error
        LOG.debug("IGNORED: " + ex.getMessage());
      } finally {
        if (in != null) {
          try {
            in.close();
          } catch (Exception ignore) {
            LOG.debug("IGNORED: " + ignore.getMessage());
          }
        }

        if (out != null) {
          try {
            out.close();
          } catch (Exception ignore) {
            LOG.debug("IGNORED: " + ignore.getMessage());
          }
        }
      }

    } else {
      response.setContentType("text/html");

      PrintWriter printwriter = response.getWriter();
      printwriter.println("<script>alert('The file does not exist');history.go(-1);</script>");
      printwriter.flush();
      printwriter.close();
    }
  }

}
