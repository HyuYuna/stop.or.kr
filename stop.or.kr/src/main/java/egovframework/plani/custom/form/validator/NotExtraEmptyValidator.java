package egovframework.plani.custom.form.validator;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import com.google.gson.Gson;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.vo.BoardExtraVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;

/**
 * 여분필드 검증 2018-06-29
 * 
 * @author youchaehwa
 *
 */
public class NotExtraEmptyValidator implements ConstraintValidator<NotExtraEmpty, Object> {

  private boolean dependency;
  private String extra_name;

  @Autowired
  private HttpServletRequest request;

  /** Gson */
  @Resource(name = "gson")
  protected Gson gson;

  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  private BoardinfoService boardinfoService;

  @Override
  public void initialize(NotExtraEmpty constraintAnnotation) {
    // TODO Auto-generated method stub
    dependency = constraintAnnotation.dependency();
    extra_name = constraintAnnotation.field();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    // TODO Auto-generated method stub
    BoardExtraVO extra_array = null;
    String extra = (String) value;
    try {
      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

      brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

      // Gson gson = new Gson();

      if (extra_name.equals("extra1")) {
        extra_array = gson.fromJson((String) brdinfoVO.getExtra1(), BoardExtraVO.class);
      } else if (extra_name.equals("extra2")) {
        extra_array = gson.fromJson((String) brdinfoVO.getExtra2(), BoardExtraVO.class);
      }

      if (extra_array == null) {
        return true;
      } else {
        // 사용할경우만 체크
        if (extra_array.getExtra1_use() != null && extra_array.getExtra1_use().equals("Y")
            && extra_array.getExtra1_require().equals("Y")) {

          if (dependency == true) {
            if (extra.trim().equals(""))
              return true;

          } else {
            if (extra.trim().equals(""))
              return false;

          }
        }

        if (extra_array.getExtra2_use() != null && extra_array.getExtra2_use().equals("Y")
            && extra_array.getExtra1_require().equals("Y")) {

          if (dependency == true) {
            if (extra.trim().equals(""))
              return true;

          } else {
            if (extra.trim().equals(""))
              return false;

          }
        }
      }
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }


    return true;
  }
}
