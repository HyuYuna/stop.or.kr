package egovframework.plani.custom.form.validator;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

@Documented
@Constraint(validatedBy = ComplicityItemCheckValidator.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface ComplicityItemCheck {

  String message() default "출품작 정보를 확인해주세요.";

  Class<?>[] groups() default {};

  Class<? extends Payload>[] payload() default {};

  String extensions() default "";

  int mb() default 10;
}
