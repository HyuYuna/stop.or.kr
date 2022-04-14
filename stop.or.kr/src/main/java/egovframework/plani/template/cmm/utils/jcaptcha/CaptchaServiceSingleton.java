package egovframework.plani.template.cmm.utils.jcaptcha;

import com.octo.captcha.engine.image.gimpy.SimpleListImageCaptchaEngine;
import com.octo.captcha.service.captchastore.FastHashMapCaptchaStore;
import com.octo.captcha.service.image.DefaultManageableImageCaptchaService;
import com.octo.captcha.service.image.ImageCaptchaService;

public class CaptchaServiceSingleton {
  private static ImageCaptchaService instance = initializeService();

  private static ImageCaptchaService initializeService() {
    SimpleListImageCaptchaEngine engine = new PlaniImageCaptchaEngine();
    return new DefaultManageableImageCaptchaService(new FastHashMapCaptchaStore(), engine, 180,
        100000, 75000);
  }

  public static ImageCaptchaService getInstance() {
    return instance;
  }
}
