package egovframework.plani.custom.form.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 * 에디터 검증 2018-06-21
 * 
 * @author youchaehwa
 *
 */


public class NotEditorEmptyValidator implements ConstraintValidator<NotEditorEmpty, Object> {

  private boolean dependency;

  @Override
  public void initialize(NotEditorEmpty constraintAnnotation) {

    dependency = constraintAnnotation.dependency();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {

    /* 에디터 형식에 맞게 체크 */
    String brd_cont = (String) value;

    if (dependency == true) {
      if (brd_cont.trim().equals("") || brd_cont.trim().equals("<p><br></p>"))
        return true;

    } else {

      if (brd_cont.trim().equals("") || brd_cont.trim().equals("<p><br></p>"))
        return false;

    }


    return true;
  }

}
