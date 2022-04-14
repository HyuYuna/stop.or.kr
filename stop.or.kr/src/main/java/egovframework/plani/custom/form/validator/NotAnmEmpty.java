package egovframework.plani.custom.form.validator;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

@Documented
@Constraint(validatedBy = NotAnmEmptyValidator.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface NotAnmEmpty {

  String message() default "반드시 값이 존재하고 길이 혹은 크기가 0보다 커야 합니다.";

  Class<?>[] groups() default {};

  Class<? extends Payload>[] payload() default {};

  String field() default "";

  boolean dependency() default false;

}
