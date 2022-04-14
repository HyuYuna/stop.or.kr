package egovframework.plani.custom.form.validator;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import egovframework.plani.template.cmm.utils.RequestParameterHelper;
import egovframework.plani.template.man.metsys.vo.ComplicityItemVO;

public class ComplicityItemCheckValidator
    implements ConstraintValidator<ComplicityItemCheck, Object> {

  private String extensions;
  private List<String> extensionList; // 확장자리스트
  private int mb;
  private int limitMB;

  @Autowired
  private HttpServletRequest request;

  @Autowired
  private MultipartHttpServletRequest multipartRequest;

  @Override
  public void initialize(ComplicityItemCheck constraintAnnotation) {
    extensions = constraintAnnotation.extensions();
    extensionList = Arrays.asList(constraintAnnotation.extensions().replaceAll(" ", "").split(","));
    mb = constraintAnnotation.mb();
    limitMB = mb * 1024 * 1024;
  }

  @Override
  public boolean isValid(Object value, ConstraintValidatorContext context) {

    ArrayList<ComplicityItemVO> items = (ArrayList<ComplicityItemVO>) value;

    if (items.size() < 1) {
      setMessage(context, "출품작 정보가 없습니다.");
      return false;
    }

    if (items.size() > 5) {
      setMessage(context, "출품작 정보는 최대 5개까지 입니다.");
      return false;
    }

    String title = "[출품작 %d]";

    // 유효성 체크
    for (int i = 0; i < items.size(); i++) {
      int no = i + 1;
      ComplicityItemVO item = items.get(i);

      // 개인/팀 구분
      if (item.getItem_division() == null) {
        setMessage(context, String.format(title, no) + " 개인/팀 구분을 선택해주세요.");
        return false;
      }

      // 공모대상
      if (item.getItem_target() == null) {
        setMessage(context, String.format(title, no) + " 공모대상을 선택해주세요.");
        return false;
      }

      // 작품명
      if (StringUtils.isEmpty(item.getItem_name()) == true) {
        setMessage(context, String.format(title, no) + " 작품명을 입력해주세요.");
        return false;
      }

      // 작품설명
      if (StringUtils.isEmpty(item.getItem_explain()) == true) {
        setMessage(context, String.format(title, no) + " 작품설명을 입력해주세요.");
        return false;
      }

      try {
        // 파일첨부
        List<MultipartFile> files = (List<MultipartFile>) RequestParameterHelper
            .getParameter(request, request.getRequestURI(), "items[" + i + "].item_file");

        // System.out.println("files size : " + files.size());

        for (int j = 0; j < files.size(); j++) {
          MultipartFile file = files.get(j);

          // 파일 확장자 구하기
          String fileName = file.getOriginalFilename();
          String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
          fileExt = fileExt.toLowerCase();
          // 허용된 파일 이외에는 첨부할 수 없음
          if (extensionList.contains(fileExt) != true) {
            setMessage(context, String.format(title, no) + " 파일첨부는 " + extensions + " 확장자만 가능합니다.");
            return false;
          }

          // 최대 용량 체크
          if (file.getSize() > limitMB) {
            setMessage(context, String.format(title, no) + " 파일첨부 용량은 최대 " + limitMB + "MB입니다.");
            return false;
          }

          // System.out.println(file.getOriginalFilename());
          // System.out.println(file.getSize());

        }
      } catch (Exception e) {
        // e.printStackTrace();
        setMessage(context, String.format(title, no) + " 파일을 첨부해주세요.");
        return false;
      }

    }

    return true;
  }

  private void setMessage(ConstraintValidatorContext context, String message) {
    context.disableDefaultConstraintViolation();
    context.buildConstraintViolationWithTemplate(message).addConstraintViolation();
  }
}
