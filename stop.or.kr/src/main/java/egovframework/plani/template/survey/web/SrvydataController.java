package egovframework.plani.template.survey.web;

import java.util.ArrayList;
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
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.exceptions.CmmnPopException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.survey.service.SrvydataService;
import egovframework.plani.template.survey.service.SrvymainService;
import egovframework.plani.template.survey.service.SrvypartService;
import egovframework.plani.template.survey.service.SrvyquesansService;
import egovframework.plani.template.survey.vo.SrvydataVO;
import egovframework.plani.template.survey.vo.SrvymainVO;
import egovframework.plani.template.survey.vo.SrvypartVO;
import egovframework.plani.template.survey.vo.SrvyquesansVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * ????????? ??????????????? ?????? ????????????
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.web] [SrvydataController.java]
 */
@Controller
@RequestMapping("/usract/surveySrvydata/*")
public class SrvydataController {

  /** SrvymainService */
  @Resource(name = "srvymainService")
  private SrvymainService srvymainService;

  /** SrvypartService */
  @Resource(name = "srvypartService")
  private SrvypartService srvypartService;

  /** SrvyquesansService */
  @Resource(name = "srvyquesansService")
  private SrvyquesansService srvyquesansService;

  /** SrvydataService */
  @Resource(name = "srvydataService")
  private SrvydataService srvydataService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** SyscodeService */
  @Resource(name = "syscodeService")
  protected SyscodeService syscodeService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  protected AtchfileService atchfileService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;



  /**
   * ?????? ?????? ????????? ????????????.
   * 
   * @param srvymainVO : ????????? ??????
   * @exception Exception
   */
  @RequestMapping
  public String srvymainList(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      HttpServletRequest request, Model model) throws Exception {



    String srch_menu_nix = srvymainVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = srvymainVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

    String mu_site = srvymainVO.getSrch_mu_site();
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;

    /*******************************
     * ????????? ?????? ?????? Start
     *******************************/
    /** pageing setting */
    PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
    paginationInfo.setContextPath(request.getContextPath());
    paginationInfo.setCurrentPageNo(srvymainVO.getPageIndex());
    paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

    srvymainVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    srvymainVO.setLastIndex(paginationInfo.getLastRecordIndex());
    srvymainVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    List srvymainList = srvymainService.selectSrvymainList(srvymainVO);
    model.addAttribute("resultList", srvymainList);

    int totCnt = srvymainService.selectSrvymainListTotCnt(srvymainVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    model.addAttribute("curPage", paginationInfo.getCurrentPageNo());
    model.addAttribute("totCnt", totCnt);
    model.addAttribute("totPage", paginationInfo.getTotalPageCount());



    return "/survey/srvyList";

  }

  /**
   * ????????? ?????? ????????????.
   * 
   * @param srvymainVO : ????????? ??????
   * @return "/usract/surveySrvydata/srvyView"
   * @exception Exception
   */
  @RequestMapping("/srvyView")
  public String srvyView(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      @ModelAttribute("srvydataVO") SrvydataVO srvydataVO, HttpServletRequest request,
      ModelMap model) throws Exception {


    String returnUrl = "/survey/srvyView";
    String srch_menu_nix = srvymainVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = srvymainVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

    String mu_site = srvymainVO.getSrch_mu_site();
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");


    SrvymainVO resultVO = srvymainService.selectSrvymain(srvymainVO);

    if (resultVO == null)
      throw new CmmnException("???????????? ???????????? ????????????.");


    resultVO.setPageIndex(srvymainVO.getPageIndex());
    resultVO.setSearchCondition(srvymainVO.getSearchCondition());
    resultVO.setSearchKeyword(srvymainVO.getSearchKeyword());
    resultVO.setSrch_mu_lang(srvymainVO.getSrch_mu_lang());
    resultVO.setSeltab_idx(srvymainVO.getSeltab_idx());


    model.addAttribute("srvymainVO", resultVO);

    // ????????? ??????
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;

    else {
      // ????????? ??????
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
        if (user.getUser_auth_lv() > 100)
          throw new CmmnException("????????? ???????????????.");

        returnUrl = "/metsys" + returnUrl;
      }

      else {
        if ("CDIDX00022".equals(mu_lang) == false) {
          returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
        }

      }
    }

    SrvypartVO partVO = new SrvypartVO();
    partVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    List<SrvypartVO> partList = srvypartService.selectSrvypartList(partVO);

    if (partList == null || partList.size() == 0)
      throw new CmmnPopException("????????? ????????? ??? ????????????1.");


    SrvyquesansVO quesansVO = new SrvyquesansVO();
    quesansVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    List<SrvyquesansVO> quesansList = srvyquesansService.selectSrvyquesansList(quesansVO);

    if (quesansList == null || quesansList.size() == 0)
      throw new CmmnPopException("????????? ????????? ??? ????????????2.");
    model.addAttribute("partList", partList);
    model.addAttribute("quesansList", quesansList);


    List dataList = srvydataService.selectSrvydataList(srvydataVO);
    model.addAttribute("dataList", dataList);

    return returnUrl;
  }


  /**
   * ?????? ????????? ????????? ????????????.
   * 
   * @param srvydataVO : ????????? ??????
   * @param request
   * @param model
   * @return String : /template/cmmn/survey/survey_usr
   * @exception Exception
   */
  @RequestMapping("/srvydataList")
  public String srvydataList(@ModelAttribute("srvydataVO") SrvydataVO srvydataVO,
      HttpServletRequest request, Model model) throws Exception {


    SrvymainVO mainVO = new SrvymainVO();
    mainVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    mainVO = srvymainService.selectSrvymain(mainVO);

    if (mainVO == null)
      throw new CmmnPopException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* ????????? ???????????????. */);

    // ????????? ???????????? ?????? ??????
    if ("N".equals(mainVO.getSrvy_act_yn()))
      throw new CmmnPopException(
          MessageHelper.getMessage("THIS-IS-NOT-A-SURVEY-PERIOD")/* ????????????????????? ????????????. */);

    // ??????????????? ??????????????????
    // ??????????????? ?????? ??????????????? ????????? ??????
    int max_ans = mainVO.getSrvy_max_ans();
    if (max_ans > 0 && max_ans <= mainVO.getSrvy_appl_cnt()) {
      throw new CmmnPopException(
          MessageHelper.getMessage("YOU-HAVE-EXCEEDED-SURVEY-SETTING")/* ???????????? ?????? ????????? ??????????????????. */);
    }


    // if ("N".equals(mainVO.getSrvy_allow_dup())) {
    // // srvydataVO.setData_addr(EgovFileScrty.encode(EgovWebUtil.getRemoteAddr(request)));
    // int cnt = srvydataService.selectSrvydataDupCnt(srvydataVO);
    //
    // if (cnt > 0)
    // throw new CmmnPopException(
    // MessageHelper.getMessage("YOU-HAVE-ALREADY-JOINED-THE-SURVEY")/* ?????? ????????? ?????????????????????. */);
    // }

    SrvypartVO partVO = new SrvypartVO();
    partVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    List<SrvypartVO> partList = srvypartService.selectSrvypartList(partVO);

    if (partList == null || partList.size() == 0)
      throw new CmmnPopException(MessageHelper.getMessage("CAN-NOT-RUN-POLL")/* ????????? ????????? ??? ????????????. */);


    SrvyquesansVO quesansVO = new SrvyquesansVO();
    quesansVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    List<SrvyquesansVO> quesansList = srvyquesansService.selectSrvyquesansList(quesansVO);

    if (quesansList == null || quesansList.size() == 0)
      throw new CmmnPopException(MessageHelper.getMessage("CAN-NOT-RUN-POLL")/* ????????? ????????? ??? ????????????. */);

    model.addAttribute("mainVO", mainVO);
    model.addAttribute("partList", partList);
    model.addAttribute("quesansList", quesansList);

    return "/template/cmmn/survey/survey_usr";

  }

  /**
   * ?????? ????????? ????????? ????????????.
   * 
   * @param srvydataVO : ????????? ??????
   * @param request
   * @param model
   * @return "String : redirect['/usract/surveySrvydata/srvydataComplete.do']"
   * @exception Exception
   */
  @RequestMapping("/addSrvydata")
  public String addSrvydata(@ModelAttribute("srvydataVO") SrvydataVO srvydataVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    SrvymainVO mainVO = new SrvymainVO();
    mainVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    mainVO = srvymainService.selectSrvymain(mainVO);

    if (mainVO == null)
      throw new CmmnPopException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* ????????? ???????????????. */);

    // ????????? ???????????? ?????? ??????
    if ("N".equals(mainVO.getSrvy_act_yn()))
      throw new CmmnPopException(
          MessageHelper.getMessage("THIS-IS-NOT-A-SURVEY-PERIOD")/* ????????????????????? ????????????. */);


    // ????????????????????? ip?????? ??????, ???????????? ????????? ????????????
    if ("N".equals(mainVO.getSrvy_allow_dup())) {
      int cnt = srvydataService.selectSrvydataDupCnt(srvydataVO);
      if (cnt > 0)
        throw new CmmnPopException(
            MessageHelper.getMessage("YOU-HAVE-ALREADY-JOINED-THE-SURVEY")/* ?????? ????????? ?????????????????????. */);
    } else {
      srvydataVO.setData_addr(EgovFileScrty.encode(EgovWebUtil.getRemoteAddr(request)));
    }



    srvydataService.insertSrvydata(srvydataVO);

    return "redirect:/usract/surveySrvydata/srvydataComplete.do";

  }

  /**
   * ?????? ????????? ?????? ?????? ???????????? ?????????.
   * 
   * @param srvydataVO : ????????? ??????
   * @param request
   * @param model
   * @return "String : /template/cmmn/survey/survey_comp"
   * @exception Exception
   */
  @RequestMapping("/srvydataComplete")
  public String srvydataComplete(@ModelAttribute("srvydataVO") SrvydataVO srvydataVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    return "/template/cmmn/survey/survey_comp";
  }


  /**
   * ?????? ????????? ????????? ?????? ???????????? ????????? ????????????.
   * 
   * @param srvydataVO : ?????? ?????? ?????? ??????
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsSrvydataSave")
  public void xlsSrvydataSave(@ModelAttribute("srvydataVO") SrvydataVO srvydataVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {


    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = {{"RN", "??????"}, {"DATA_IDX", "????????? ?????? (???????????? ????????? ????????????;?????????)"},
        {"QUES_IDX", "?????? ??????"}, {"SRVY_IDX", "?????? ??????"}, {"DATA_CONT", "?????? ?????? ???"},
        {"DATA_SPL", "?????? ?????? ?????? ???"}, {"DATA_ADDR", "????????? ????????? (IP?????? ???)"}, {"WRITER", "?????????"},
        {"WDT", "?????????"}, {"MODIFIER", "?????????"}, {"MDT", "?????????"}

    };

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List srvydataOrgList = srvydataService.xlsSrvydataList(srvydataVO);

    /************************************************************
     * ?????? ????????? ????????? ????????? ????????? ??? ???????????? ???????????? ????????????. ????????? ???????????? ?????? ??????(????????? ???????????? ??????) ???????????? ????????????....
     ************************************************************/
    List srvydataXlsList = new ArrayList();
    for (int i = 0; i < srvydataOrgList.size(); i++) {
      SrvydataVO vo = (SrvydataVO) srvydataOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("DATA_IDX", vo.getData_idx());
      rsmap.put("QUES_IDX", vo.getQues_idx());
      rsmap.put("SRVY_IDX", vo.getSrvy_idx());
      rsmap.put("DATA_CONT", vo.getData_cont());
      rsmap.put("DATA_SPL", vo.getData_spl());
      rsmap.put("DATA_ADDR", vo.getData_addr());
      rsmap.put("WRITER", vo.getWriter());
      rsmap.put("WDT", vo.getWdt());
      rsmap.put("MODIFIER", vo.getModifier());
      rsmap.put("MDT", vo.getMdt());


      srvydataXlsList.add(rsmap);
    }

    String fileName = "?????? ?????????";
    xlsDownUtil.ExcelWrite(response, srvydataXlsList, colinfoList, fileName);
  }

  @RequestMapping("/chkSrvyJson")
  @ResponseBody
  public String chkSrvyJson(@ModelAttribute("srvydataVO") SrvydataVO srvydataVO,
      HttpServletRequest request, Model model) throws Exception {

    String returnMsg = "";
    try {

      SrvymainVO mainVO = new SrvymainVO();
      mainVO.setSrvy_idx(srvydataVO.getSrvy_idx());
      mainVO = srvymainService.selectSrvymain(mainVO);
      if (mainVO == null)
        returnMsg = "????????? ???????????????.";
      // ????????? ???????????? ?????? ??????
      if ("N".equals(mainVO.getSrvy_act_yn()))
        returnMsg = "????????????????????? ????????????.";

      if ("N".equals(mainVO.getSrvy_allow_dup())) {
        // srvydataVO.setData_addr(EgovFileScrty.encode(EgovWebUtil.getRemoteAddr(request)));
        int cnt = srvydataService.selectSrvydataDupCnt(srvydataVO);
        if (cnt > 0) {
          returnMsg = "?????? ????????? ?????????????????????.";
        }

      }
    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return returnMsg;

  }

}
