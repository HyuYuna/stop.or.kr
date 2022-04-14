package egovframework.plani.template.man.metsys.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.plani.custom.form.validator.groups.ValidationUserComplicity;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.cmm.utils.CommonUtil;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.cmm.utils.UserInfoHelper;
import egovframework.plani.template.man.metsys.service.ComplicityService;
import egovframework.plani.template.man.metsys.vo.ComplicityAgreeVO;
import egovframework.plani.template.man.metsys.vo.ComplicityConfirmVO;
import egovframework.plani.template.man.metsys.vo.ComplicityItemVO;
import egovframework.plani.template.man.metsys.vo.ComplicityVO;

@Controller
@RequestMapping("/complicity")
public class ComplicityController {

  private static final String SESSION_AGREE_KEY = "complicityAgree";
  private static final String SESSION_SEARCH_EMAIL = "complicitySearchEmail";
  private static final String SESSION_SEARCH_NAME = "complicitySearchName";

  @Resource(name = "complicityService")
  private ComplicityService complicityService;

  /**
   * 공모전 접수 동의
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/agree", method = RequestMethod.GET)
  public String agree(@ModelAttribute("complicityAgreeVO") ComplicityAgreeVO complicityAgreeVO,
      HttpServletRequest request, Model model) throws Exception {
    return "/complicity/reception/none";
    // return "/complicity/reception/agree";
  }

  /**
   * 공모전 접수 동의 확인
   * 
   * @param complicityAgreeVO
   * @param result
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/agree", method = RequestMethod.POST)
  @ResponseBody
  public Object agree(@Valid ComplicityAgreeVO complicityAgreeVO, BindingResult result,
      HttpServletRequest request, Model model) throws Exception {

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/complicity/reception/agree");

    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    // 접수동의 세션
    EgovSessionCookieUtil.setSessionAttribute(request, SESSION_AGREE_KEY, "Y");

    // 완료
    return responseResultHelper.success(null, null,
        CommonUtil.getUrl("/complicity/application.do", "", true), null);

  }

  // 동의 확인
  private Boolean checkAgreement(HttpServletRequest request) throws Exception {
    String check = (String) EgovSessionCookieUtil.getSessionAttribute(request, SESSION_AGREE_KEY);
    if (check != null && check == "Y") {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 공모전 접수
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/application", method = RequestMethod.GET)
  public String application(@ModelAttribute("complicityVO") ComplicityVO complicityVO,
      HttpServletRequest request, Model model) throws Exception {

    if (checkAgreement(request) != true) {
      return "redirect:" + CommonUtil.getRedirectUrl("/complicity/agree.do", "", true);
    }

    // 이메일 선택
    ArrayList<String> emailSelectList = complicityService.getEmailSelectList();
    model.addAttribute("emailSelectList", emailSelectList);

    // 거주지 선택
    Map<String, String> citySelectList = complicityService.getCitySelectList();
    model.addAttribute("citySelectList", citySelectList);

    // 공모대상
    Map<String, String> targetSelectList = complicityService.getTargetSelectList();
    model.addAttribute("targetSelectList", targetSelectList);

    if (request.getMethod().equals("POST") == true) {
      System.out.println("POST");
      System.out.println("complicityVO : " + complicityVO.getItems().get(0));

      // complicityService.insertComplicity(complicityVO);
      // System.out.println("complicityVO GROUP id : " + complicityVO.getGroup_id());

      complicityVO.setGroup_id(1);
      complicityService.insertComplicityItems(request, complicityVO);

    } else {
      System.out.println("GET");
    }

    return "/complicity/reception/none";
    // return "/complicity/reception/application";
  }

  /**
   * 공모전 접수 처리
   * 
   * @param complicityVO
   * @param result
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/application", method = RequestMethod.POST)
  @ResponseBody
  public Object application(@Validated(ValidationUserComplicity.class) ComplicityVO complicityVO,
      BindingResult result, HttpServletRequest request, Model model) throws Exception {

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/complicity/reception/application");

    if (checkAgreement(request) != true) {
      return responseResultHelper.error(null, "작품접수 약관에 동의가 필요합니다.",
          CommonUtil.getUrl("/complicity/agree.do", "", true));
    }

    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    // 이메일
    if (StringUtils.isEmpty(complicityVO.getEmail_id()) == false
        && StringUtils.isEmpty(complicityVO.getEmail_host()) == false) {
      complicityVO.setEmail(complicityVO.getEmail_id() + "@" + complicityVO.getEmail_host());
      // 기존접수 체크
      int check = complicityService.selectComplicityByEmailCount(complicityVO);
      if (check > 0) {
        return responseResultHelper.error(null, "해당 메일로 작품접수 내역이 있습니다.");
      }
    } else {
      return responseResultHelper.error(null, "이메일정보가 필요합니다.");
    }


    // 세션 사용자 정보
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // 등록자
    complicityVO.setWriter(sessionUserData.getUser_id());
    // 수정자
    complicityVO.setModifier(sessionUserData.getUser_id());

    // 데이터 저장
    complicityService.insertComplicity(complicityVO);
    complicityService.insertComplicityItems(request, complicityVO);

    // 완료
    return responseResultHelper.success(null, null,
        CommonUtil.getUrl("/complicity/complete.do", "", true), null);

  }

  /**
   * 공모전 접수 완료
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/complete")
  public String complete(HttpServletRequest request) throws Exception {
    if (checkAgreement(request) != true) {
      return "redirect:" + CommonUtil.getRedirectUrl("/complicity/agree.do", "", true);
    }
    // 동의 세션 삭제
    EgovSessionCookieUtil.removeSessionAttribute(request, SESSION_AGREE_KEY);
    // return "/complicity/reception/complete";
    return "/complicity/reception/none";
  }

  /**
   * 공모전 접수 확인
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/confirm", method = RequestMethod.GET)
  public String confirm(
      @ModelAttribute("complicityConfirmVO") ComplicityConfirmVO complicityConfirmVO,
      HttpServletRequest request, Model model) throws Exception {

    EgovSessionCookieUtil.removeSessionAttribute(request, SESSION_SEARCH_EMAIL);
    EgovSessionCookieUtil.removeSessionAttribute(request, SESSION_SEARCH_NAME);
    // return "/complicity/reception/confirm";
    return "/complicity/reception/none";
  }

  /**
   * 공모전 접수 확인 체크
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/confirm", method = RequestMethod.POST)
  @ResponseBody
  public Object confirm(@Valid ComplicityConfirmVO complicityConfirmVO, BindingResult result,
      HttpServletRequest request, Model model) throws Exception {

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/complicity/reception/confirm");

    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    // 실제 등록 체크
    ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setEmail(complicityConfirmVO.getEmail());
    int check = complicityService.selectComplicityByEmailCount(complicityVO);

    check = 1;
    if (check < 1) {
      return responseResultHelper.error(null, "접수내역을 찾을수 없습니다.");
    } else {
      // 접수내역 세션 굽기?
      EgovSessionCookieUtil.setSessionAttribute(request, SESSION_SEARCH_EMAIL,
          complicityConfirmVO.getEmail());
      EgovSessionCookieUtil.setSessionAttribute(request, SESSION_SEARCH_NAME,
          complicityConfirmVO.getName());
      return responseResultHelper.success(null, null,
          CommonUtil.getUrl("/complicity/list.do", "", true), null);
    }
  }

  // 접수확인 체크
  private String[] checkSearch(HttpServletRequest request) throws Exception {
    String email =
        (String) EgovSessionCookieUtil.getSessionAttribute(request, SESSION_SEARCH_EMAIL);
    String name = (String) EgovSessionCookieUtil.getSessionAttribute(request, SESSION_SEARCH_NAME);
    if (email != null && StringUtils.isEmpty(email) == false && name != null
        && StringUtils.isEmpty(name) == false) {
      String[] data = {email, name};
      return data;
    } else {
      String[] data = {};
      return data;
    }
  }

  /**
   * 접수 리스트
   * 
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/list")
  public String list(HttpServletRequest request, Model model) throws Exception {

    String[] info = checkSearch(request);
    if (info.length != 2) {
      return "redirect:" + CommonUtil.getRedirectUrl("/complicity/confirm.do", "", true);
    }

    String email = info[0];
    String name = info[1];

    ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setEmail(email);
    complicityVO.setName(name);
    List<ComplicityItemVO> resultList =
        complicityService.selectComplicityItemGroupList(complicityVO);

    // System.out.println(resultList.get(0).getA);
    model.addAttribute("resultList", resultList);

    // return "/complicity/reception/list";
    return "/complicity/reception/none";
  }

}
