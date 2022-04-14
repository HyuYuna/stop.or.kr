package egovframework.plani.custom.form.validator;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

@Documented
@Constraint(validatedBy = CaptchaValidator.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface Captcha {
  String message() default "보안문자를 정확하게 입력해주세요.";

  Class<?>[] groups() default {};

  Class<? extends Payload>[] payload() default {};

  boolean dependency() default false;

  String field() default "";
}
