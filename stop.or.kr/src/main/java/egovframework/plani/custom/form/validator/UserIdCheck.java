package egovframework.plani.custom.form.validator;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import javax.validation.Constraint;
import javax.validation.Payload;

@Documented
@Constraint(validatedBy = UserIdCheckValidator.class)
@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface UserIdCheck {

  String message() default "사용할수 없는 아이디입니다.";

  Class<?>[] groups() default {};

  Class<? extends Payload>[] payload() default {};

  boolean dependency() default false;

}
