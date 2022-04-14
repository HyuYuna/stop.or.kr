package egovframework.plani.custom.form.validator;

import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.RetentionPolicy.RUNTIME;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

@Target({FIELD, METHOD, PARAMETER, ANNOTATION_TYPE})
@Retention(RUNTIME)
@Constraint(validatedBy = UploadCheckValidator.class)
@Documented
public @interface UploadCheck {

  String field() default "";

  String message() default "{extensions} 파일만 업로드 할수 있습니다.";

  Class<?>[] groups() default {};

  Class<? extends Payload>[] payload() default {};


  String extensions() default "";

  boolean dependency() default false;

}
