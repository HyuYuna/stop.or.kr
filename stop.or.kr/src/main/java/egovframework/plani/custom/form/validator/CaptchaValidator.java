package egovframework.plani.custom.form.validator;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.jcaptcha.CaptchaServiceSingleton;

public class CaptchaValidator implements ConstraintValidator<Captcha, Object> {

  @Autowired
  private HttpServletRequest request;
  private boolean dependency;
  private String capchaField;

  @Override
  public void initialize(Captcha constraintAnnotation) {
    // TODO Auto-generated method stub
    dependency = constraintAnnotation.dependency();
    capchaField = constraintAnnotation.field();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    // TODO Auto-generated method stub
    /* CAPCHA CHECK */


    try {

      /* 관리자이면 return true하기 */
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(request.getParameter("srch_menu_nix")) >= 0) {
        return true;
      }
      String tmp = (String) value;

      String captchaId = request.getSession().getId();// 세션으로 정의함

      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

      if (brdinfoVO.getBrd_gb().equals("CDIDX00046")) {
        if (dependency == true) {
          // 비밀번호확인 입력이 없는 경우 true, NotEmpty로 필수 처리
          if (tmp.equals("")) {
            return true;
          }
        }

        boolean isResponseCorrect = false;
        String captcha_val = tmp;
        isResponseCorrect =
            CaptchaServiceSingleton.getInstance().validateResponseForID(captchaId, captcha_val);

        if (isResponseCorrect)
          return true;
        else
          return false;

      }

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }



    return true;
  }

}
