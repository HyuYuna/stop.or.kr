package egovframework.plani.custom.form.validator;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import egovframework.plani.template.cmm.utils.RequestParameterHelper;

/**
 * 회원가입 비밀번호, 비밀번호 확인 검증 2018-05-28
 * 
 * @author pigcos
 *
 */
public class ConfirmPasswordValidator implements ConstraintValidator<ConfirmPassword, Object> {

  @Autowired
  private HttpServletRequest request;

  @Autowired
  private MultipartHttpServletRequest multipartRequest;

  private String passwordField;
  private boolean dependency;

  @Override
  public void initialize(ConfirmPassword constraintAnnotation) {
    passwordField = constraintAnnotation.field();
    dependency = constraintAnnotation.dependency();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    String confirm = (String) value;

    if (dependency == true) {
      // 비밀번호확인 입력이 없는 경우 true, NotEmpty로 필수 처리
      if (confirm.equals("")) {
        return true;
      }
    }

    String[] passwords = (String[]) RequestParameterHelper.getParameter(request,
        request.getRequestURI(), passwordField);

    // 비밀번호와 비밀번호 확인 체크
    return confirm.equals(passwords[0]);
  }
}

