package egovframework.plani.custom.form.validator;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;

public class NotCategoryEmptyValidator implements ConstraintValidator<NotCategoryEmpty, Object> {

  private boolean dependency;

  @Autowired
  private HttpServletRequest request;

  @Override
  public void initialize(NotCategoryEmpty constraintAnnotation) {
    // TODO Auto-generated method stub
    dependency = constraintAnnotation.dependency();

  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    // TODO Auto-generated method stub

    String s_value = (String) value;
    try {
      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

      if (brdinfoVO.getUse_ctgry().equals("Y")) {
        if (dependency == true) {
          if (s_value.equals("")) {
            return true;
          }
        } else {
          if (s_value.equals("")) {
            return false;
          }
        }
      }
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    return true;
  }

}
