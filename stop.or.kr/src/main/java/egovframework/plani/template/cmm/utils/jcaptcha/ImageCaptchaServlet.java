package egovframework.plani.template.cmm.utils.jcaptcha;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.octo.captcha.service.CaptchaServiceException;

public class ImageCaptchaServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  public void init(ServletConfig servletConfig) throws ServletException {
    super.init(servletConfig);
  }

  protected void doGet(HttpServletRequest httpServletRequest,
      HttpServletResponse httpServletResponse) throws ServletException, IOException {

    byte[] captchaChallengeAsJpeg = null;
    ByteArrayOutputStream jpegOutputStream = new ByteArrayOutputStream();
    try {
      String captchaId = httpServletRequest.getSession().getId();
      // call the ImageCaptchaService getChallenge method
      BufferedImage challenge = CaptchaServiceSingleton.getInstance()
          .getImageChallengeForID(captchaId, httpServletRequest.getLocale());
      // a jpeg encoder

      /*
       * // JDK1.7 - linux 에서 에러 - 아래 코드로 변경.. JPEGImageEncoder jpegEncoder =
       * JPEGCodec.createJPEGEncoder(jpegOutputStream); jpegEncoder.encode(challenge);
       */

      ImageIO.write(challenge, "jpeg", jpegOutputStream);
    } catch (IllegalArgumentException e) {
      httpServletResponse.sendError(HttpServletResponse.SC_NOT_FOUND);
      return;
    } catch (CaptchaServiceException e) {
      httpServletResponse.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      return;
    }

    captchaChallengeAsJpeg = jpegOutputStream.toByteArray();
    // flush it in the response
    httpServletResponse.setHeader("Cache-Control", "no-store");
    httpServletResponse.setHeader("Pragma", "no-cache");
    httpServletResponse.setDateHeader("Expires", 0);
    httpServletResponse.setContentType("image/jpeg");
    ServletOutputStream responseOutputStream = httpServletResponse.getOutputStream();
    responseOutputStream.write(captchaChallengeAsJpeg);
    responseOutputStream.flush();
    responseOutputStream.close();
  }
}
