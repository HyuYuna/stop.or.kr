package egovframework.plani.custom.form.validator;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;

public class NotAnmEmptyValidator implements ConstraintValidator<NotAnmEmpty, Object> {

  @Autowired
  private HttpServletRequest request;
  private boolean dependency;

  @Override
  public void initialize(NotAnmEmpty constraintAnnotation) {
    // TODO Auto-generated method stub
    dependency = constraintAnnotation.dependency();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    // TODO Auto-generated method stub
    if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(request.getParameter("srch_menu_nix")) >= 0) {
      return true;
    }
    String tmp = (String) value;
    try {
      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

      if (brdinfoVO.getBrd_gb().equals("CDIDX00046")) {
        if (dependency == true) {
          // 비밀번호확인 입력이 없는 경우 true, NotEmpty로 필수 처리
          if (tmp.equals("")) {
            return true;
          }
        } else {
          if (tmp.equals("")) {
            return false;
          }
        }
      } else {
        return true;
      }

    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    return true;
  }

}
