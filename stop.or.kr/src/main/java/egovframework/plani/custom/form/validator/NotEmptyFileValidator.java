package egovframework.plani.custom.form.validator;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import egovframework.plani.template.cmm.utils.RequestParameterHelper;

public class NotEmptyFileValidator implements ConstraintValidator<NotEmptyFile, Object> {

  @Autowired
  private HttpServletRequest request;

  private String message;
  private String field;

  @Override
  public void initialize(NotEmptyFile constraintAnnotation) {
    message = constraintAnnotation.message();
    field = constraintAnnotation.field();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {
    try {
      List<MultipartFile> files = (List<MultipartFile>) RequestParameterHelper.getParameter(request,
          request.getRequestURI(), field);
      return files == null || files.size() < 1 ? false : true;
    } catch (Exception e) {
      return false;
    }
  }
}
