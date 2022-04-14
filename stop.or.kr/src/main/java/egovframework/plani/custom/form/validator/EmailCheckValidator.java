package egovframework.plani.custom.form.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class EmailCheckValidator implements ConstraintValidator<EmailCheck, Object> {

  public static String VALIDATION_EMAIL_REGEX = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";
  private boolean dependency;

  @Override
  public void initialize(EmailCheck constraintAnnotation) {
    dependency = constraintAnnotation.dependency();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    String email = (String) value;
    if (dependency == true) { //
      // 이메일 입력이 없는 경우 true, NotEmpty로 필수 처리
      if (email.equals("")) {
        return true;
      }
    }
    Matcher matcher = Pattern.compile(VALIDATION_EMAIL_REGEX).matcher(email);
    return matcher.matches();
  }
}
