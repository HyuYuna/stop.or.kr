package egovframework.plani.custom.memsvc.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.service.MessageService;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.vo.MessageVO;
import egovframework.plani.template.cmm.vo.UserAuthVO;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/memuser")
public class MemberController {

  /** MemberService */
  @Resource(name = "memberService")
  private MemberService memberService;

  /** SyscodeService */
  @Resource(name = "syscodeService")
  private SyscodeService syscodeService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /** messageService */
  @Resource(name = "messageService")
  private MessageService messageService;


  /**
   * ????????? ?????? ????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param request : path ??????
   * @param model : ?????? ???
   * @return '/metsys/memberList'
   * @exception Exception
   */
  @RequestMapping("/memberList")
  public String memberList(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {


    /** pageing setting */
    PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
    paginationInfo.setContextPath(request.getContextPath());

    paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
    paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

    memberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    memberVO.setLastIndex(paginationInfo.getLastRecordIndex());
    memberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    List memberList = memberService.selectMemberList(memberVO);
    model.addAttribute("resultList", memberList);

    int totCnt = memberService.selectMemberListTotCnt(memberVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    NumberFormat nf = NumberFormat.getInstance();
    model.addAttribute("curPage", nf.format(paginationInfo.getCurrentPageNo()));
    model.addAttribute("totCnt", nf.format(totCnt));
    model.addAttribute("totPage", nf.format(paginationInfo.getTotalPageCount()));

    return "/metsys/memberList";

  }

  /**
   * ????????? ?????? ????????? ?????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param model : ?????? ???
   * @exception Exception
   * @return '/metsys/memberView'
   */
  @RequestMapping("/memberView")
  public String memberView(@ModelAttribute("memberVO") MemberVO memberVO, ModelMap model)
      throws Exception {

    /*
     * MemberVO resultVO = memberService.selectMember(memberVO); model.addAttribute("resultVO",
     * resultVO);
     */

    return "/metsys/memberView";
  }


  /**
   * ??????????????? ?????? ?????? ????????? ??????.
   * 
   * @param searchVO ?????? ???????????? ????????? ?????? VO
   * @param request
   * @param model
   * @exception Exception
   * @return "/cnslreq/cnslreqStep01"
   */
  @RequestMapping("/sysmemInputmove")
  public String sysmemInputmove(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {

    UserAuthVO userAuth =
        (UserAuthVO) EgovSessionCookieUtil.getSessionAttribute(request, "USER_AUTH_SESS");

    memberVO.setUser_nm(userAuth.getName());
    memberVO.setUser_birth(userAuth.getBirthDate());
    memberVO.setUser_name_chk(userAuth.getAuthType());
    memberVO.setUser_dupinfo(userAuth.getDupInfo());

    MemberVO resultVO = new MemberVO();
    resultVO = memberService.selectMemberByDupInfo(memberVO);

    if (null != resultVO) {
      throw new CmmnException(MessageHelper.getMessage("REGISTERED-MEMBER")/* ?????? ????????? ???????????????. */);
    }


    return "/svcmem/memJoinStep2";
  }


  // /**
  // * ????????? ?????? ????????? ????????????.
  // *
  // * @param memberVO : ????????? ??????
  // * @param request
  // * @param model
  // * @exception Exception
  // * @return 'redirect:/svcmem/memJoinStep01.do?tgtact=02&rcvact=joinCRPozEV'
  // */
  // @RequestMapping("/addMember")
  // public String addMember(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest
  // request,
  // ModelMap model) throws Exception {
  //
  // // ????????? ??? ??????
  // if ("".equals(memberVO.getUser_id()) || "".equals(memberVO.getUser_scrt())
  // || "".equals(memberVO.getUser_email()))
  // throw new CmmnException(MessageHelper.getMessage(
  // "SOME-OF-THE-REQUIRED-INFORMATION-IS-MISSING")/* ?????? ????????? ????????? ?????? ????????? ????????? ????????????????????? */);
  //
  // // ????????? ????????? ????????????.
  // memberVO.setWriter(memberVO.getUser_id());
  // memberVO.setUser_auth_cd("U0003");
  // memberVO.setAllow_ip("*");
  // memberService.insertMember(memberVO);
  //
  // atchfileService.uploadProcFormfiles(request, "USR_LOGO", memberVO.getUser_id(), 1, "IMG");
  //
  // /*
  // * MemberVO joinVO = (MemberVO)EgovSessionCookieUtil.getSessionAttribute(request,
  // * "SESS_JOIN_INFO"); if(joinVO != null) EgovSessionCookieUtil.removeSessionAttribute(request,
  // * "SESS_JOIN_INFO"); EgovSessionCookieUtil.setSessionAttribute(request, "SESS_JOIN_INFO",
  // * memberVO);
  // */
  //
  // return "redirect:/svcmem/memJoinStep01.do?tgtact=02&rcvact=joinCRPozEV";
  // }


  /**
   * ????????? ?????? ????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param request
   * @param model
   * @exception Exception
   * @return 'redirect:/svcmem/memberList.do'
   */
  @RequestMapping("/rmvMember")
  public String rmvMember(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request,
      ModelMap model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    memberService.deleteMember(memberVO);
    // model.addAttribute("resultVO", memberVO);

    return "redirect:/svcmem/memberList.do";
  }


  /**
   * ????????? ?????? ????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param request
   * @param model
   * @exception Exception
   * @return 'redirect:/svcmem/modMemInfo.do?tgtact=05&rcvact=modmemCRPozEV'
   */
  @RequestMapping("/mdfMember")
  public String mdfMember(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest request,
      ModelMap model) throws Exception {

    MemberVO orgmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (orgmemVO.getUser_auth_lv() > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    // ????????? ???????????? ?????? ??????
    String newscrt = memberVO.getUser_scrt();

    // ?????? ??????????????? ????????? ????????? ????????? ????????????.
    memberVO.setUser_scrt(memberVO.getUser_scrt_org());
    MemberVO memVO = memberService.checkMember(memberVO);
    if (memVO == null)
      throw new CmmnException(MessageHelper
          .getMessage("USER-INFORMATION-DOES-NOT-MATCH")/* ????????? ????????? ???????????? ????????????. ??????????????? ?????????????????????. */);

    if ("".equals(memberVO.getUser_id()) || "".equals(memberVO.getUser_email())
        || "".equals(memberVO.getUser_cp_1()) || "".equals(memberVO.getUser_cp_2())
        || "".equals(memberVO.getUser_cp_3()))
      throw new CmmnException(MessageHelper
          .getMessage("SOME-OF-YOUR-REQUIRED-INFORMATION-IS-MISSING")/* ????????? ?????? ????????? ????????? ?????????????????????. */);

    memberVO.setUser_scrt(newscrt);
    memberVO.setModifier(memberVO.getUser_nm());
    memberService.updateMember(memberVO);

    memVO = memberService.selectMember(memberVO);
    if (memVO != null) {
      memVO.setLoginsess_id(orgmemVO.getLoginsess_id());
      memVO.setLoginsess_ip(orgmemVO.getLoginsess_ip());
      memVO.setLoginsess_bw(orgmemVO.getLoginsess_bw());
      memVO.setLoginsess_os(orgmemVO.getLoginsess_os());

      EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_USR_INFO");
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_USR_INFO", memVO);
    }

    atchfileService.uploadProcFormfiles(request, "USR_LOGO", memberVO.getUser_id(), 1, "IMG");

    return "redirect:/svcmem/modMemInfo.do?tgtact=05&rcvact=modmemCRPozEV";
  }


  /**
   * ????????? ??????????????? ?????? ????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param model
   * @exception Exception
   */
  /*@RequestMapping("/chkdupMember")
  @ResponseBody
  public String chkdupMember(@ModelAttribute("memberVO") MemberVO memberVO, ModelMap model)
      throws Exception {

    try {
      int cnt = memberService.checkDuplication(memberVO);
      return Integer.toString(cnt);

    } catch (Exception e) {

      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }
  }*/

  /**
   * ????????? ?????? ???????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param model
   * @exception Exception
   * @return 'SUCCESS'
   */
  @RequestMapping("/preCheckMember")
  @ResponseBody
  public String preCheckMember(@ModelAttribute("memberVO") MemberVO memberVO, ModelMap model)
      throws Exception {

    // ????????? ID ?????? ??????
    MemberVO selmemVO = memberService.selectMember(memberVO);
    if (selmemVO == null) {
      // return "???????????? ?????? ID ?????????.";
      return MessageHelper.getMessage("NO-MATCHING-MEMBER-INFORMATION");
    }

    // ????????? ID, ???????????? ?????? ??????
    selmemVO = memberService.checkMember(memberVO);
    if (selmemVO == null) {
      // return "??????????????? ???????????? ????????????.";
      return MessageHelper.getMessage("NO-MATCHING-MEMBER-INFORMATION");
    }

    return "SUCCESS";

  }

  /**
   * ????????? ?????? ????????? ?????? ???????????? ????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsMemberSave")
  public void xlsMemberSave(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = {{"RN", "??????"}, {"USER_ID", "?????????"}, {"USER_NM", "??????"},
        {"USER_EMAIL", "EMAIL"}, {"USER_CP", "?????????"}, {"USER_ORGAN", "????????????"}, {"USER_GRADE", "??????"},
        {"USER_SCH_NM", "????????????"}, {"USER_MAJOR", "??????"}, {"USER_DEGREE_NM", "??????"},
        {"USER_AUTH_NM", "????????? ??????"}, {"WDT", "?????????"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List memberOrgList = memberService.xlsMemberList(memberVO);

    /************************************************************
     * ?????? ????????? ????????? ????????? ????????? ??? ???????????? ???????????? ????????????. ????????? ???????????? ?????? ??????(????????? ???????????? ??????) ???????????? ????????????....
     ************************************************************/
    List memberXlsList = new ArrayList();
    for (int i = 0; i < memberOrgList.size(); i++) {
      MemberVO vo = (MemberVO) memberOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("USER_ID", vo.getUser_id());
      rsmap.put("USER_NM", vo.getUser_nm());
      rsmap.put("USER_EMAIL", EgovFileScrty.decode(vo.getUser_email()));
      rsmap.put("USER_CP",
          EgovFileScrty.decode(vo.getUser_cp_1()) + "-" + EgovFileScrty.decode(vo.getUser_cp_2())
              + "-" + EgovFileScrty.decode(vo.getUser_cp_3()));
      rsmap.put("USER_AUTH_NM", vo.getUser_auth_nm());
      rsmap.put("WDT", vo.getWdt());

      memberXlsList.add(rsmap);
    }

    String fileName = "????????? ??????";
    xlsDownUtil.ExcelWrite(response, memberXlsList, colinfoList, fileName);
  }

  /**
   * ?????? ????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param request
   * @param model
   * @exception Exception
   * @return 'success'
   */
  @RequestMapping("/sendPinCode")
  @ResponseBody
  public String sendPinCode(HttpServletRequest request,
      @ModelAttribute("memberVO") MemberVO memberVO, Model model) throws Exception {

    if ("".equals(memberVO.getUser_nm()) || "".equals(memberVO.getUser_cp_1())
        || "".equals(memberVO.getUser_cp_2()) || "".equals(memberVO.getUser_cp_3())
        || "".equals(memberVO.getUser_id()))
      return "0";

    MemberVO selectMember = memberService.recoverMember(memberVO);
    if (selectMember == null) {
      return "0";
    }

    String pinCode = String.valueOf(((int) (Math.random() * (900000)) + 100000));
    EgovSessionCookieUtil.setSessionAttribute(request, "PW_PIN_CODE", pinCode);
    EgovSessionCookieUtil.setSessionAttribute(request, "PIN_CODE_STATE", "fail");

    String phone = EgovFileScrty.decode(memberVO.getUser_cp_1());
    phone += EgovFileScrty.decode(memberVO.getUser_cp_2());
    phone += EgovFileScrty.decode(memberVO.getUser_cp_3());

    String message = "<???????????????> ??????????????? [ " + pinCode + " ]?????????.";

    MessageVO messageVo = new MessageVO(phone, message);
    messageService.sendSms(messageVo);

    return "success";
  }

  /**
   * ?????? ????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/checkPinCode")
  @ResponseBody
  public String checkPinCode(HttpServletRequest request,
      @ModelAttribute("memberVO") MemberVO memberVO, Model model) throws Exception {

    String inputPinCode = memberVO.getPinCode();
    String pinCode = "";
    String result = "fail";

    Object pinCodeObj = EgovSessionCookieUtil.getSessionAttribute(request, "PW_PIN_CODE");
    if (pinCodeObj != null) {
      pinCode = (String) pinCodeObj;
      result = (String) EgovSessionCookieUtil.getSessionAttribute(request, "PIN_CODE_STATE");
    }

    if (inputPinCode != null && inputPinCode != "" && inputPinCode.equals(pinCode)) {
      result = "success";
      EgovSessionCookieUtil.setSessionAttribute(request, "PIN_CODE_STATE", "success");
    }

    return result;
  }

  /**
   * ???????????? ?????? ??????
   * 
   * @param request
   * @param model
   * @exception Exception
   * @return '/svcmem/changePwForm'
   */
  @RequestMapping("/changePwForm")
  public String changePwForm(HttpServletRequest request, ModelMap model) throws Exception {

    String userId = (String) EgovSessionCookieUtil.getSessionAttribute(request, "PW_CHANGE_ID");
    model.addAttribute("userId", userId);

    model.addAttribute("tgtact", "changePwForm");
    return "/svcmem/changePwForm";
  }

  /**
   * ???????????? ??????
   * 
   * @param request
   * @param memberVO
   * @param model
   * @exception Exception
   * @return '/movepage/redirect'
   */
  @RequestMapping("/changePw")
  public String changePw(HttpServletRequest request, @ModelAttribute("memberVO") MemberVO memberVO,
      ModelMap model) throws Exception {

    String userId = (String) EgovSessionCookieUtil.getSessionAttribute(request, "PW_CHANGE_ID");
    memberVO.setUser_id(userId);
    memberService.updateMember(memberVO);

    EgovSessionCookieUtil.removeSessionAttribute(request, "PW_PIN_CODE");
    EgovSessionCookieUtil.removeSessionAttribute(request, "PIN_CODE_STATE");
    EgovSessionCookieUtil.removeSessionAttribute(request, "PW_CHANGE_ID");

    model.addAttribute("msg", MessageHelper.getMessage("YOUR-PASSWORD-IS-CHANGED"));
    model.addAttribute("returnUrl",
        "/svcmem/sysmemPagemove.do?tgtact=siteLogin&srch_menu_nix=p20RQqzK");
    return "/movepage/redirect";
  }

  /**
   * ?????? ????????? ????????????.
   * 
   * @param memberVO : ????????? ??????
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/checkMemberScrt")
  @ResponseBody
  public String checkMemberScrt(HttpServletRequest request,
      @ModelAttribute("memberVO") MemberVO memberVO, Model model) throws Exception {

    String result = "fail";

    MemberVO vo = memberService.checkMember(memberVO);
    if (vo != null) {
      result = "success";
    }
    return result;
  }


  /**
   * ????????? ?????????
   * 
   * @param args
   */

  public static void main(String[] args) {
    Calendar cal = Calendar.getInstance();
    int yr = cal.get(Calendar.YEAR);
    int mon = cal.get(Calendar.MONTH);
    int dt = cal.get(Calendar.DAY_OF_MONTH);

    System.out.println(
        yr + " " + EgovWebUtil.getZerofillStr(mon, 2) + " " + EgovWebUtil.getZerofillStr(dt, 2));

    try {
      System.out.println(EgovFileScrty.encryptPassword("TPWDsnMI9fXS"));
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

  }


}

