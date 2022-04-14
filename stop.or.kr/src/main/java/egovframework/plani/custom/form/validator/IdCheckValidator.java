package egovframework.plani.custom.form.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 * 회원가입 아이디 검증 2018-05-28
 * 
 * @author pigcos
 *
 */
public class IdCheckValidator implements ConstraintValidator<IdCheck, Object> {

  public static String VALIDATION_ID_REGEX = "^[a-zA-Z]{1}[a-zA-Z0-9_]{4,11}$";
  private boolean dependency;

  @Override
  public void initialize(IdCheck constraintAnnotation) {
    dependency = constraintAnnotation.dependency();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    String userId = (String) value;
    if (dependency == true) {
      // 아이디가 없는 경우 true, NotEmpty로 필수 처리
      if (userId.equals("")) {
        return true;
      }
    }
    // 아이디 형식에 맞는지 체크
    Matcher matcher = Pattern.compile(VALIDATION_ID_REGEX).matcher(userId);
    return matcher.matches();
  }
}
