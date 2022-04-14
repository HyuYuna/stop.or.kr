package egovframework.plani.custom.form.validator;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

@Documented
@Constraint(validatedBy = IdCheckValidator.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IdCheck {

  String message() default "영문으로 시작하고 영문, 숫자, '_'로 이루어진 5~12자 이하로 작성해주세요.";

  Class<?>[] groups() default {};

  Class<? extends Payload>[] payload() default {};

  boolean dependency() default false;

}
