package egovframework.plani.custom.form.validator;

import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.hibernate.validator.constraintvalidation.HibernateConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.RequestParameterHelper;

public class UploadCheckValidator implements ConstraintValidator<UploadCheck, Object> {

  @Autowired
  private HttpServletRequest request;

  private String message;
  private String field;
  private String extensions;
  private boolean dependency;

  @Override
  public void initialize(UploadCheck constraintAnnotation) {
    message = constraintAnnotation.message();
    field = constraintAnnotation.field();
    extensions = constraintAnnotation.extensions();
    dependency = constraintAnnotation.dependency();
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {

    String template = MessageHelper.getMessage("UploadCheck.message");
    template = template.isEmpty() ? message : template;

    // System.out.println("template : " + template);
    HibernateConstraintValidatorContext hibernateContext =
        context.unwrap(HibernateConstraintValidatorContext.class);
    hibernateContext.disableDefaultConstraintViolation();
    hibernateContext.addExpressionVariable("extensions", extensions);
    hibernateContext.buildConstraintViolationWithTemplate(template).addConstraintViolation();


    List<MultipartFile> files = null;

    try {
      files = (List<MultipartFile>) RequestParameterHelper.getParameter(request,
          request.getRequestURI(), field);
    } catch (Exception e) {
    }

    if (dependency == true) { //
      // 입력이 없는 경우 true, NotEmpty로 필수 처리
      if (files == null || files.size() < 1) {
        return true;
      }
    } else {
      // 입력이 없는 경우 false
      if (files == null || files.size() < 1) {
        return false;
      }
    }

    // 확장자 공백제거
    extensions = extensions.replaceAll(" ", "");

    String[] extensionArray = extensions.split(",");
    List<String> extensionList = Arrays.asList(extensionArray);

    // List<MultipartFile> files = (List<MultipartFile>)
    // RequestParameterHelper.getParameter(request,
    // request.getRequestURI(), field);
    // System.out.println("file : " + files[0]);


    String[] values = new String[files.size()];
    for (int i = 0; i < files.size(); i++) {
      values[i] = files.get(i).getOriginalFilename();
    }

    // System.out.println("field name : " + field);
    // System.out.println("ext : " + extensionArray);
    // System.out.println("validate : " + values);


    for (int i = 0; i < values.length; i++) {
      String file = values[i];
      // 파일 확장자 구하기
      String file_ext = file.substring(file.lastIndexOf(".") + 1, file.length());
      file_ext = file_ext.toLowerCase();
      // 허용된 파일 이외에는 첨부할 수 없음
      // if (extensions.indexOf(file_ext) < 0) {
      if (extensionList.contains(file_ext) != true) {
        return false;
      }
    }

    return true;
  }
}
