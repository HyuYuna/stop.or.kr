package egovframework.plani.custom.form.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.cmm.utils.RequestParameterHelper;

/**
 * 회원가입 이메일 검증 2018-05-30
 * 
 * @author pigcos
 *
 */
public class AdminUserEmailCheckValidator
    implements ConstraintValidator<AdminUserEmailCheck, Object> {

  private boolean dependency;
  private String field;

  @Autowired
  private HttpServletRequest request;

  @Autowired
  MemberService memberService;

  @Override
  public void initialize(AdminUserEmailCheck constraintAnnotation) {
    dependency = constraintAnnotation.dependency();
    field = constraintAnnotation.field();
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
    // 관리자 회원 수정인 경우
    String[] id =
        (String[]) RequestParameterHelper.getParameter(request, request.getRequestURI(), field);
    if (id != null) {
      // System.out.println("id : " + id[0]);
      if (StringUtils.isEmpty(id[0]) == false) {
        try {
          MemberVO memberVO = new MemberVO();
          memberVO.setUser_id(id[0]);
          MemberVO user = memberService.selectMember(memberVO);
          if (email.equals(user.getUser_email())) {
            return true;
          }
        } catch (Exception e) {
          e.printStackTrace();
        }
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
