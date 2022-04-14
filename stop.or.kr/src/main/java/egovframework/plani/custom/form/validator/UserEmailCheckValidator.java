package egovframework.plani.custom.form.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.cmm.utils.UserInfoHelper;

/**
 * 회원가입 이메일 검증 2018-05-30
 * 
 * @author pigcos
 *
 */
public class UserEmailCheckValidator implements ConstraintValidator<UserEmailCheck, Object> {

  private boolean dependency;

  @Autowired
  MemberService memberService;

  @Override
  public void initialize(UserEmailCheck constraintAnnotation) {
    dependency = constraintAnnotation.dependency();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    String email = (String) value;
    if (dependency == true) {
      // 이메일이 없는 경우 true, NotEmpty로 필수 처리
      if (email.equals("")) {
        return true;
      }
      // 이메일 형식에 맞지 않는 경우 true ?, EmailCheck로 체크 먼저 되도록......;;;;
      Matcher matcher = Pattern.compile(EmailCheckValidator.VALIDATION_EMAIL_REGEX).matcher(email);
      if (matcher.matches() != true) {
        return true;
      }
    }
    // 회원 로그인인 경우 자신이 사용하고 있는 이메일인 경우
    if (UserInfoHelper.isLogin() == true) {
      try {
        MemberVO memberVO = new MemberVO();
        memberVO.setUser_id(UserInfoHelper.getLoginData().getUser_id());
        MemberVO user = memberService.selectMember(memberVO);
        if (email.equals(user.getUser_email())) {
          return true;
        }
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    // 실제 이메일이 사용되고 있는지 체크
    MemberVO memberVO = new MemberVO();
    memberVO.setUser_email(email);
    try {
      int cnt = memberService.checkDuplication(memberVO);
      // System.out.println("member email cnt : " + cnt);
      if (cnt > 0) {
        return false;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return true;
  }
}
