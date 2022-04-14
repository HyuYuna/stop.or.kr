package egovframework.plani.custom.form.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;

/**
 * 회원가입 아이디 검증 2018-05-28
 * 
 * @author pigcos
 *
 */
public class UserIdCheckValidator implements ConstraintValidator<UserIdCheck, Object> {

  @Autowired
  MemberService memberService;

  private boolean dependency;

  @Override
  public void initialize(UserIdCheck constraintAnnotation) {
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
      // 아이디 형식에 맞지 않는 경우 true ?, IdCheck로 체크 먼저 되도록......;;;;
      Matcher matcher = Pattern.compile(IdCheckValidator.VALIDATION_ID_REGEX).matcher(userId);
      if (matcher.matches() != true) {
        return true;
      }
    }
    // 실제 아이디가 사용되고 있는지 체크
    MemberVO memberVO = new MemberVO();
    memberVO.setUser_id(userId);
    try {
      int cnt = memberService.checkDuplication(memberVO);
      // System.out.println("member cnt : " + cnt);
      if (cnt > 0) {
        return false;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return true;
  }
}

