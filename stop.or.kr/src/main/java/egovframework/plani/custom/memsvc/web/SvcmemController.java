/*
 * Copyright 2008-2009 the original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
package egovframework.plani.custom.memsvc.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.plani.custom.form.validator.groups.ValidationUserJoin;
import egovframework.plani.custom.form.validator.groups.ValidationUserModify;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.IdentificationVO;
import egovframework.plani.custom.memsvc.vo.LoginVO;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CheckPlusSafe;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovHttpSessionBindingListener;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.cmm.utils.UserInfoHelper;
import egovframework.plani.template.cmm.vo.UserAuthVO;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.metsys.service.ContentsmanService;
import egovframework.plani.template.man.stat.service.CommstatService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 관리자 페이지 액션 컨트롤
 * 
 * @class : [OASIS] [egovframework.plani.man.metsys.web] [EgovMetsysController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 8. 오후 5:07:57
 * @version : 1.0
 */
@Controller
@RequestMapping("/svcmem")
public class SvcmemController {

  /** CommstatService */
  @Resource(name = "commstatService")
  protected CommstatService commstatService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** ContentsmanService */
  @Resource(name = "contentsmanService")
  private ContentsmanService contentsmanService;

  /** ContentsmanService */
  @Resource(name = "syscodeService")
  private SyscodeService syscodeService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** MemberService */
  @Resource(name = "memberService")
  MemberService memberService;

  @Autowired
  private EgovHttpSessionBindingListener listener;

  /**
   * 사용자 로그인.
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  //@RequestMapping(value = "/siteLogin", method = RequestMethod.GET)	//20200706 웹취약점 조치로 주석처리
  public String siteLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request,
      Model model, HttpServletResponse response) throws Exception {
    // 로그인 상태 인지 체크
    if (UserInfoHelper.isLogin() == true) {
      throw new CmmnException(MessageHelper.getMessage("YOU-ARE-ALREADY-SIGNED-IN"));
    }
    return "/svcmem/siteLogin";
  }

  /**
   * 사용자 로그인 처리
   * 
   * @param loginVO
   * @param result
   * @param request
   * @param memberVO
   * @return
   * @throws Exception
   */
  //@RequestMapping(value = "/siteLogin", method = RequestMethod.POST)	//20200706 웹취약점 조치로 주석처리
  @ResponseBody
  public Object siteLogin(@Valid LoginVO loginVO, BindingResult result, HttpServletRequest request,
      @ModelAttribute("memberVO") MemberVO memberVO) throws Exception {
    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/svcmem/siteLogin");
    // 로그인 상태 인지 체크
    if (UserInfoHelper.isLogin() == true) {
      return responseResultHelper.error("", MessageHelper.getMessage("YOU-ARE-ALREADY-SIGNED-IN"),
          "/", null);
    }
    // 폼 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }
    // 사용자 ID 존재 여부
    MemberVO selmemVO = memberService.selectMember(memberVO);
    if (selmemVO == null) {
      return responseResultHelper.error("",
          MessageHelper.getMessage("NO-MATCHING-MEMBER-INFORMATION")/* 존재하지 않는 ID 입니다. */, null,
          null);
    }
    // 사용자 ID, 패스워드 일치 여부
    MemberVO chkVO = memberService.checkMember(memberVO);
    if (chkVO == null) {
      return responseResultHelper.error("",
          MessageHelper.getMessage("NO-MATCHING-MEMBER-INFORMATION")/* 비밀번호가 일치하지 않습니다. */, null,
          null);
    }
    // 정지 또는 탈퇴회원 인 경우
    if ("G0002".equals(chkVO.getUser_auth_cd())) {
      return responseResultHelper.error("", MessageHelper.getMessage("NOT-REGISTERED-MEMBER")/*
                                                                                              * 회원자격
                                                                                              * 정지되었거나
                                                                                              * 탈퇴한
                                                                                              * 회원입니다
                                                                                              * .
                                                                                              */,
          null, null);
    }
    String referer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_RETURN_URL");
    // 로그인 처리
    UserInfoHelper.setSessionValues(request, chkVO);
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_RETURN_URL", referer);
    // ////////////////////////////////////////////////////////////////////////////////
    // 중복로그인 방지 Start
    // 하나의 아이디가 로그인되어있는 상태에서 같은 아이디로 중복 로그인 할 경우
    // 이전에 했던 로그인은 무효화되며 최종 로그인된 세션만 남게 된다.
    // 또는 사용자 정보를 담고 세션에 저장되는 MemberVO에
    // 직접 HttpSessionBindingListener 인터페이스를 구현함으로써 이 과정을 생략할 수 있다.
    // 2015. 11. 20 bhhan
    // EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_DUPPRV_" + chkVO.getUser_id(),
        listener);
    // 중복로그인 방지 End
    // ////////////////////////////////////////////////////////////////////////////////
    // 로그인 시간 기록
    memberService.updateMemberLastlogin(memberVO);
    // 로그인 로그 기록
    // commstatService.insertCommstat(request, "LOGIN_USR",
    // MessageHelper.getMessage("MEMBER.LOGIN")/* 사용자로그인 */, "");
    commstatService.insertCommstat(request, "LOGIN_USR", "사용자로그인", "");
    /*
     * // 로그인한 일반 사용자가 한번도 본인인증을 받지 않은 경우 // 본인인증 페이지로 보냄 if(chkVO.getUser_auth_lv() > 100 &&
     * (chkVO.getUser_dup_info() == null || "".equals(chkVO.getUser_dup_info()))) returnUrl =
     * "redirect:/svcmem/usrcertForm.do?srch_menu_nix=05Gzq9MQ&pg_ret_type=E";
     * 
     * if(returnUrl == null || returnUrl == "") returnUrl = "redirect:/contents/siteMain.do";
     */
    // 로그인 완료
    return responseResultHelper.success(null, null, "/", null);
  }

  /**
   * 사용자 회원가입.
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/memJoinForm", method = RequestMethod.GET)
  public String memJoin(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request,
      Model model) throws Exception {
    return "/svcmem/memJoinForm";
  }

  /**
   * 사용자 회원가입 처리.
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/memJoinForm", method = RequestMethod.POST)
  @ResponseBody
  public Object memJoin(@Validated(ValidationUserJoin.class) MemberVO memberVO,
      BindingResult result, HttpServletRequest request) throws Exception {
    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/svcmem/memJoinForm");
    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }
    // 사용자 정보를 추가한다.
    memberVO.setWriter(memberVO.getUser_id());
    memberVO.setUser_auth_cd("U0003");
    memberVO.setAllow_ip("*");
    memberService.insertMember(memberVO);
    // 첨부파일 처리
    atchfileService.uploadProcFormfiles(request, "USR_LOGO", memberVO.getUser_id(), 1, "IMG");
    /*
     * MemberVO joinVO = (MemberVO)EgovSessionCookieUtil.getSessionAttribute(request,
     * "SESS_JOIN_INFO"); if(joinVO != null) EgovSessionCookieUtil.removeSessionAttribute(request,
     * "SESS_JOIN_INFO"); EgovSessionCookieUtil.setSessionAttribute(request, "SESS_JOIN_INFO",
     * memberVO);
     */
    // 회원가입 완료
    return responseResultHelper.success(null, null, "/svcmem/siteLogin.do", null);
  }

  /**
   * 회원정보수정
   * 
   * @param memberVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/memUserInfo", method = RequestMethod.GET)
  public String memUserInfo(@ModelAttribute("memberVO") MemberVO memberVO, Model model)
      throws Exception {
    // 회원정보체크
    if (UserInfoHelper.isLogin() != true) {
      throw new CmmnException(
          MessageHelper.getMessage("YOU-CAN-CHANG-YOUR-INFORMATION-AFTER-LOGIN"));
    }
    // 회원정보 가져오기
    memberVO = memberService.selectMember(UserInfoHelper.getLoginData());
    model.addAttribute("memberVO", memberVO);
    // 첨부파일 목록 가져오기
    AtchfileVO fileVO = new AtchfileVO();
    fileVO.setAtckey_1st("USR_LOGO");
    fileVO.setAtckey_2nd(memberVO.getUser_id());
    fileVO.setAtckey_3rd(1);
    List fileList = atchfileService.selectAtchfileList(fileVO);
    model.addAttribute("atchfileList", fileList);
    return "/svcmem/memJoinForm";
  }

  /**
   * 회원정보수정 처리
   * 
   * @param memberVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/memUserInfo", method = RequestMethod.POST)
  @ResponseBody
  public Object memUserInfo(@Validated(ValidationUserModify.class) MemberVO memberVO,
      BindingResult result, HttpServletRequest request) throws Exception {
    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/svcmem/memJoinForm");
    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }
    // 첨부파일 업로드
    atchfileService.uploadProcFormfiles(request, "USR_LOGO", UserInfoHelper.getLoginData()
        .getUser_id(), 1, "IMG");
    // 정보수정 완료
    return responseResultHelper.success(null, null, "/svcmem/memUserInfo.do", null);
  }

  /**
   * 사용자 로그아웃.
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @param request
   * @return "redirect:/svcmem/siteLogin.do"
   * @exception Exception
   */
  @RequestMapping("/siteLogout")
  public String siteLogout(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {
    // 로그아웃 처리
    UserInfoHelper.removeSessionValues(request);
    // return "redirect:/"; // 페이지 캐쉬? 때문에 메인으로 처리??
    return "redirect:/svcmem/siteLogin.do?srch_menu_nix=05I2d7YX";
  }

  /**
   * 사이트맵으로 이동.
   * 
   * @param model
   * @return '/svcmem/siteMap'
   * @exception Exception
   */
  @RequestMapping("/siteMapView")
  public String siteMapView(ModelMap model) throws Exception {
    return "/svcmem/siteMap";
  }



  /* ################################################################################### */
  /* 이하 정리 필요 */
  /* ################################################################################### */



  /**
   * 회원서비스 페이지 이동.
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @param request
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/sysmemPagemove")
  public String sysmemPagemove(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {

    String return_url = "";
    if (null != request.getParameter("returnURL")) {
      return_url = request.getParameter("returnURL");
      return_url = EgovWebUtil.UTF8Decode(return_url);
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_RETURN_URL", return_url);
    }

    String sReservedParam2 = "";
    if (request.getParameter("param_r2") != null) {
      sReservedParam2 = request.getParameter("param_r2");
    }

    String ret_ = "";
    String tgtact = request.getParameter("tgtact");

    if (tgtact == null || "".equals(tgtact))
      throw new CmmnException(MessageHelper.getMessage("PAGE-NOT-FOUND")/* 페이지를 찾을 수 없습니다 */);
    else
      ret_ = "/svcmem/" + tgtact;

    if (EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO") != null) {
      memberVO = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    }


    if ("memJoinStep01|memJoinStep02|memRecover|modUsrinfo|memWithdraw".indexOf(tgtact) >= 0) {
      String pg_ret_type = "";

      // 실제 적용시 주석해제
      switch (tgtact) {
        case "memJoinStep01":
          pg_ret_type = "A";
          break;
        case "memJoinStep02":
          pg_ret_type = "A";
          break;
        case "memRecover":
          pg_ret_type = "B";
          break;
        case "modUsrinfo":
          pg_ret_type = "C";
          break;
        case "memWithdraw":
          pg_ret_type = "D";
          break;
      }

      // UserAuthVO authVO =
      // (UserAuthVO) EgovSessionCookieUtil.getSessionAttribute(request, "USER_AUTH_SESS");
      // if (authVO == null)
      // return "redirect:/svcmem/usrcertForm.do?srch_menu_nix=05Gzq9MQ&pg_ret_type=" + pg_ret_type;

      if ("modUsrinfo|memWithdraw".indexOf(tgtact) >= 0) {
        if (memberVO.getUser_auth_lv() > 10000) {
          throw new CmmnException(
              MessageHelper.getMessage("YOU-CAN-CHANG-YOUR-INFORMATION-AFTER-LOGIN")/*
                                                                                     * 로그인 후에 사용자
                                                                                     * 정보를 변경할 수
                                                                                     * 있습니다.
                                                                                     */);
        }

        model.addAttribute("memberVO", memberVO);
      }
    } else
      throw new CmmnException(MessageHelper.getMessage("PAGE-NOT-FOUND")/* 페이지를 찾을 수 없습니다 */);


    model.addAttribute("tgtact", tgtact);

    return ret_;
  }


  /**
   * 본인인증 페이지 이동.
   * 
   * @param request
   * @param model
   * @return '/svcmem/userCertForm'
   * @throws Exception
   */
  @RequestMapping("/usrcertForm")
  public String usrcertForm(HttpServletRequest request, ModelMap model) throws Exception {

    EgovSessionCookieUtil.removeSessionAttribute(request, "USER_AUTH_SESS");

    String pg_ret_type = request.getParameter("pg_ret_type");
    if (pg_ret_type == null || "".equals(pg_ret_type))
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-ACCESS")/* 잘못된 접근입니다 */);

    String mpatt = "^[A-Z]{1}$";
    if (Pattern.matches(mpatt, pg_ret_type) == false)
      throw new CmmnException(MessageHelper.getMessage("REQUIRED-PARAMETERS-ARE-OUT-OF-RANGE")/*
                                                                                               * 필수
                                                                                               * 파라미터가
                                                                                               * 정상적인
                                                                                               * 값의
                                                                                               * 범위를
                                                                                               * 벗어납니다
                                                                                               * .
                                                                                               */);


    try {
      CheckPlusSafe safe = new CheckPlusSafe();
      String hpData = safe.getEncPlanData("M", "", "");
      String certData = safe.getEncPlanData("X", "", "");
      model.addAttribute("hpData", hpData);
      model.addAttribute("certData", certData);
      model.addAttribute("pg_ret_type", pg_ret_type);
    } catch (Exception e) {
      e.printStackTrace();
    }

    return "/svcmem/userCertForm";
  }



  /**
   * 본인인증 성공
   * 
   * @param request
   * @param model
   * @return 'redirect:/svcmem/closePopAndRedirect.do'
   * @throws Exception
   */
  @RequestMapping("/successHpAndCert")
  public String successHpAndCert(HttpServletRequest request, ModelMap model) throws Exception {

    CheckPlusSafe safe = new CheckPlusSafe();

    UserAuthVO userAuth =
        safe.getUserAuth(request.getParameter("EncodeData"), request.getParameter("param_r1"));
    String pg_ret_type = request.getParameter("param_r2");
    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user != null && user.getUser_auth_lv() < 10000) {
      // 현재로그인한 사용자의 인증된 이름과 회원이름이 일치하지 않는 경우 => 인증불일치
      if (user.getUser_nm().equals(userAuth.getName()) == false)
        return "redirect:/svcmem/closePop.do?errorCode=0101";

      // 일치하는 경우 인증정보를 저장한다.
      else {
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
        user.setUser_dup_info(sf.format(new Date()));
        memberService.updateMemberDupinfo(user);
      }
    }
    // 로그인하지 않은 상태인 경우
    else {
      // 아이디/패스워드 찾기 인 경우
      if ("B".equals(pg_ret_type)) {
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
        user.setUser_dup_info(sf.format(new Date()));
      } else
        pg_ret_type = "E";
    }

    IdentificationVO idfVO = new IdentificationVO();
    idfVO.setUser_nm(userAuth.getName());
    idfVO.setConfirm_way("2");
    idfVO.setIdkey(userAuth.getDupInfo());

    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_IDIF_INFO", idfVO);
    EgovSessionCookieUtil.setSessionAttribute(request, "USER_AUTH_SESS", userAuth);
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_NM", userAuth.getName());

    return "redirect:/svcmem/closePopAndRedirect.do?pg_ret_type=" + pg_ret_type;
  }



  /**
   * 본인인증 성공 (인증창 닫기)
   * 
   * @param request
   * @param model
   * @return '/svcmem/closePopAndRedirect'
   * @throws Exception
   */
  @RequestMapping("/closePopAndRedirect")
  public String closePopAndRedirect(HttpServletRequest request, ModelMap model) throws Exception {

    UserAuthVO authVO =
        (UserAuthVO) EgovSessionCookieUtil.getSessionAttribute(request, "USER_AUTH_SESS");
    if (authVO == null)
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-ACCESS")/* 잘못된 접근입니다 */);

    return "/svcmem/closePopAndRedirect";
  }


  /**
   * 본인인증 실패
   * 
   * @param request
   * @param model
   * @return 'redirect:/svcmem/closePop.do'
   * @throws Exception
   */
  @RequestMapping("/failHpAndCert")
  public String failHpAndCert(HttpServletRequest request, ModelMap model) throws Exception {

    CheckPlusSafe safe = new CheckPlusSafe();
    safe.getUserAuth(request.getParameter("EncodeData"), request.getParameter("param_r1"));

    return "redirect:/svcmem/closePop.do?errorCode=" + safe.getErrorCode();
  }


  /**
   * 본인인증 실패 (인증창 닫기)
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/closePop")
  public String closePop(HttpServletRequest request, ModelMap model) throws Exception {

    return "/svcmem/closePop";
  }

  /**
   * 본인인증 성공후 목적지 페이지 이동.
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @param request
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/authPageView")
  public String authPageView(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {

    String pg_ret_type = request.getParameter("pg_ret_type");
    if (pg_ret_type == null || "".equals(pg_ret_type))
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-ACCESS")/* 잘못된 접근입니다 */);

    String mpatt = "^[A-Z]{1}$";
    if (Pattern.matches(mpatt, pg_ret_type) == false)
      throw new CmmnException(MessageHelper.getMessage("REQUIRED-PARAMETERS-ARE-OUT-OF-RANGE")/*
                                                                                               * 필수
                                                                                               * 파라미터가
                                                                                               * 정상적인
                                                                                               * 값의
                                                                                               * 범위를
                                                                                               * 벗어납니다
                                                                                               * .
                                                                                               */);

    String return_url = getReturnUrl(request, pg_ret_type);

    UserAuthVO userAuth =
        (UserAuthVO) EgovSessionCookieUtil.getSessionAttribute(request, "USER_AUTH_SESS");
    memberVO = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    if (userAuth != null) {
      memberVO.setUser_nm(userAuth.getName());
      memberVO.setUser_birth(userAuth.getBirthDate());
    }

    model.addAttribute("memberVO", memberVO);
    model.addAttribute("userAuth", userAuth);

    return return_url;
  }

  /**
   * Gpin 세션 삭제
   * 
   * @param request
   * @throws Exception
   */

  private void removeGpinSession(HttpServletRequest request) throws Exception {
    EgovSessionCookieUtil.removeSessionAttribute(request, "gpinUserIP");
    EgovSessionCookieUtil.removeSessionAttribute(request, "dupInfo");
    EgovSessionCookieUtil.removeSessionAttribute(request, "virtualNo");
    EgovSessionCookieUtil.removeSessionAttribute(request, "realName");
    EgovSessionCookieUtil.removeSessionAttribute(request, "sex");
    EgovSessionCookieUtil.removeSessionAttribute(request, "age");
    EgovSessionCookieUtil.removeSessionAttribute(request, "birthDate");
    EgovSessionCookieUtil.removeSessionAttribute(request, "nationalInfo");
    EgovSessionCookieUtil.removeSessionAttribute(request, "authInfo");
  }


  /**
   * 사이트 메인화면 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/parentAuthInfo")
  @ResponseBody
  public int parentAuthInfo(HttpServletRequest request, Model model) throws Exception {

    String type = request.getParameter("type");

    int age = 0;
    if ("gpin".equals(type)) {
      CheckPlusSafe safe = new CheckPlusSafe();
      age = safe.getAge((String) EgovSessionCookieUtil.getSessionAttribute(request, "birthDate"));
      removeGpinSession(request);
    } else {
      Object userAuthObject = EgovSessionCookieUtil.getSessionAttribute(request, "USER_AUTH_SESS");
      if (userAuthObject != null) {
        UserAuthVO userAuth = (UserAuthVO) userAuthObject;
        age = userAuth.getAge();
        EgovSessionCookieUtil.removeSessionAttribute(request, "USER_AUTH_SESS");
      }
    }
    return age;
  }

  /**
   * 미사용매소드
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/jumpcodeOper")
  public String jumpcodeOper(HttpServletRequest request, Model model) throws Exception {

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    if (user == null || user.getUser_auth_lv() >= 100)
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-ACCESS")/* 잘못된 접근입니다 */);

    String oper = request.getParameter("oper");

    if (oper == null || "".equals(oper))
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-ACCESS")/* 잘못된 접근입니다 */);

    String retUrl = "";
    String id = "";

    if (oper.equals("OASIS")) {
      // 접속을 위한 ID값
      id = user.getUser_id();

      // retUrl = "http://meteorite.kigam.re.kr/svcmem/jumpcodeOper.do";
      retUrl = EgovProperties.GLOBALS_SVR_NM + "control/svcmem/jumpcodeOper.jsp";
    } /*
       * else if(oper.equals("PRES")) { // 접속을 위한 ID값 id = "pres_admin";
       * 
       * //retUrl = "http://meteorite.kigam.re.kr/svcmem/jumpcodeOper.do"; retUrl =
       * EgovProperties.GLOBALS_SVR_NM + "pres/login/jumpcodeOper.jsp"; }
       */
    else {
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-ACCESS")/* 잘못된 접근입니다 */);
    }

    SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd");


    // 비교를 위한 IP값
    String addr = EgovWebUtil.getRemoteAddr(request);

    // 비교를 위한 날짜
    String dt = sd.format(new Date());

    // 비교를 위한 ID + IP + 날짜 (끝 5자리만 취함)
    String flag = EgovFileScrty.encryptPassword(id + addr + dt);
    flag = flag.substring(flag.length() - 5, flag.length());

    String delm = "|";

    String oper_k = id;
    oper_k += delm;
    oper_k += EgovFileScrty.encryptPassword(addr);
    oper_k += delm;
    oper_k += flag;

    // BASE64 인코딩 한다.
    oper_k = EgovFileScrty.encode(oper_k);

    retUrl += "?oper_k=" + oper_k;

    return "redirect:" + retUrl;
  }


  /**
   * 사용자 스스로 탈퇴한다.
   * 
   * @param memberVO 삭제할 정보
   * @param request
   * @param model
   * @return 'redirect:/contents/siteMain.do'
   * @throws Exception
   */
  @RequestMapping("/withdrawMember")
  public String withdrawMember(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    UserAuthVO authVO =
        (UserAuthVO) EgovSessionCookieUtil.getSessionAttribute(request, "USER_AUTH_SESS");
    if (authVO == null)
      return "redirect:/svcmem/sysmemPagemove.do?tgtact=memWithdraw&srch_menu_nix=ozIN3SH3";

    memberVO.setUser_id(user.getUser_id());
    memberVO.setUser_scrt(memberVO.getUser_scrt_org());
    MemberVO selmemVO = memberService.checkMember(memberVO);
    if (selmemVO == null) {
      throw new CmmnException(MessageHelper.getMessage("NO-MATCHING-MEMBER-INFORMATION")/*
                                                                                         * 일치하는
                                                                                         * 회원정보가
                                                                                         * 존재하지
                                                                                         * 않습니다.
                                                                                         */);
    }

    memberService.deleteMember(memberVO);
    // model.addAttribute("resultVO", memberVO);

    // 로그아웃 처리
    UserInfoHelper.removeSessionValues(request);

    return "redirect:/contents/siteMain.do";
  }

  /**
   * 사용자 정보 항목을 상세 조회한다.
   * 
   * @param memberVO 조회할 정보
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/recoverMember")
  @ResponseBody
  public String recoverMember(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    String returl = "";

    if ("ID".equals(memberVO.getUser_recover_type())) {
      if (memberVO.getUser_nm() == null || "".equals(memberVO.getUser_nm())
          || memberVO.getUser_birth() == null || "".equals(memberVO.getUser_birth()))
        throw new AjaxException(
            MessageHelper.getMessage("SOME-OF-THE-REQUIRED-INFORMATION-IS-MISSING")/*
                                                                                    * 아이디 조회에 필요한
                                                                                    * 정보가 누락되었습니다.
                                                                                    */);

      memberVO.setUser_nm(EgovWebUtil.UTF8Decode(memberVO.getUser_nm()));
      MemberVO findVO = memberService.recoverMember(memberVO);

      if (findVO != null)
        return findVO.getUser_id();
      else
        return "FAIL";

    } else if ("PWD".equals(memberVO.getUser_recover_type())) {
      if ("".equals(memberVO.getUser_id()) || "".equals(memberVO.getUser_birth()))
        throw new AjaxException(
            MessageHelper.getMessage("SOME-OF-THE-REQUIRED-INFORMATION-IS-MISSING")/*
                                                                                    * 패스워드 조회에 필요한
                                                                                    * 정보가 누락되었습니다.
                                                                                    */);

      MemberVO findVO = memberService.recoverMember(memberVO);
      if (findVO != null) {
        MemberVO newpwVO = new MemberVO();
        String newpwd = "TPWD" + EgovWebUtil.generateIDString("", 8);
        newpwVO.setUser_id(memberVO.getUser_id());
        newpwVO.setUser_scrt(newpwd);
        newpwVO.setModifier(findVO.getUser_id());
        memberService.updateMember(newpwVO);

        /*
         * /////////////////////////////// // TODO : Mail 전송 /////////////////////////////// String
         * phone = EgovFileScrty.decode(memberVO.getUser_cp_1()); phone +=
         * EgovFileScrty.decode(memberVO.getUser_cp_2()); phone +=
         * EgovFileScrty.decode(memberVO.getUser_cp_3());
         * 
         * String message = "오류가 발생하였습니다."; String subject = "국립대구박물관 패스워드 변경 안내입니다.";
         * 
         * // 문화 체험 message = "회원님의 패스워드가 변경되었습니다."; message = "변경된 임시 패스워드는 [ " + newpwd +
         * " ] 입니다."; message = message + "빠른 시간내에 접속하여 패스워드를 변경해주십시오."; MessageVO messageVo = new
         * MessageVO(phone, message, subject); messageService.sendMms(messageVo);
         */

        if (findVO.getUser_email() != null && "".equals(findVO.getUser_email()) == false)
          /*
           * SendmessageUtil.SendMail( EgovProperties.GLOBALS_MAIL_ADDR,
           * EgovProperties.GLOBALS_MAIL_NM, findVO.getUser_email(), "오아시스 회원님의 패스워드가 변경되었습니다.",
           * "변경된 임시 패스워드는 [ " + newpwd + " ] 입니다.<br/>빠른 시간내에 접속하여 패스워드를 변경해주십시오.");
           */
          return findVO.getUser_email();
      } else
        return "FAIL";
    }

    return returl;

  }

  /**
   * 페이지 타입별 리턴 url 반환
   * 
   * @param request
   * @param pg_ret_type
   * @return
   * @throws Exception
   */
  public String getReturnUrl(HttpServletRequest request, String pg_ret_type) throws Exception {

    String return_url = "";

    // 회원가입
    if ("A".equals(pg_ret_type)) {
      return_url = "redirect:/svcmem/sysmemPagemove.do?tgtact=memJoinStep01&srch_menu_nix=67rO8E9h";
    }
    // 아이디/패스워드 찾기
    else if ("B".equals(pg_ret_type)) {
      return_url = "redirect:/svcmem/sysmemPagemove.do?tgtact=memRecover&srch_menu_nix=KfgV39Q9";
    }
    // 회원정보 수정
    else if ("C".equals(pg_ret_type)) {
      return_url = "redirect:/svcmem/sysmemPagemove.do?tgtact=modUsrinfo&srch_menu_nix=0IfOGN79";
    }
    // 회원탈퇴
    else if ("D".equals(pg_ret_type)) {
      return_url = "redirect:/svcmem/sysmemPagemove.do?tgtact=memWithdraw&srch_menu_nix=ozIN3SH3";
    }
    // 메인화면
    else if ("E".equals(pg_ret_type)) {
      return_url = "redirect:/contents/siteMain.do";
    }
    // 인증화면
    else if ("F".equals(pg_ret_type)) {
      return_url = "redirect:/svcmem/usrcertForm.do?srch_menu_nix=05Gzq9MQ&pg_ret_type=E";
    } else if ("".equals(pg_ret_type)) {
      String referer =
          (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_RETURN_URL");
      if (null == referer || "null".equals(referer) || "".equals(referer)) {
        return_url = "redirect:/contents/siteMain.do";
      } else {
        referer = referer.replaceAll(request.getContextPath(), "");
        return_url = "redirect:" + referer;
      }
    }


    return return_url;
  }



}
