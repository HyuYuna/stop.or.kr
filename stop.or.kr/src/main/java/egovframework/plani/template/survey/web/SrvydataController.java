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
 * 사용자 설문페이지 액션 컨트롤러
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
   * 설문 메인 목록을 조회한다.
   * 
   * @param srvymainVO : 조회할 정보
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
     * 탭메뉴 구성 처리 Start
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
   * 항목을 상세 조회한다.
   * 
   * @param srvymainVO : 조회할 정보
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
      throw new CmmnException("게시물이 존재하지 않습니다.");


    resultVO.setPageIndex(srvymainVO.getPageIndex());
    resultVO.setSearchCondition(srvymainVO.getSearchCondition());
    resultVO.setSearchKeyword(srvymainVO.getSearchKeyword());
    resultVO.setSrch_mu_lang(srvymainVO.getSrch_mu_lang());
    resultVO.setSeltab_idx(srvymainVO.getSeltab_idx());


    model.addAttribute("srvymainVO", resultVO);

    // 모바일 처리
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;

    else {
      // 관리자 처리
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
        if (user.getUser_auth_lv() > 100)
          throw new CmmnException("권한이 부족합니다.");

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
      throw new CmmnPopException("설문을 실행할 수 없습니다1.");


    SrvyquesansVO quesansVO = new SrvyquesansVO();
    quesansVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    List<SrvyquesansVO> quesansList = srvyquesansService.selectSrvyquesansList(quesansVO);

    if (quesansList == null || quesansList.size() == 0)
      throw new CmmnPopException("설문을 실행할 수 없습니다2.");
    model.addAttribute("partList", partList);
    model.addAttribute("quesansList", quesansList);


    List dataList = srvydataService.selectSrvydataList(srvydataVO);
    model.addAttribute("dataList", dataList);

    return returnUrl;
  }


  /**
   * 설문 데이터 목록을 조회한다.
   * 
   * @param srvydataVO : 조회할 정보
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
      throw new CmmnPopException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

    // 설문이 진행중이 아닐 경우
    if ("N".equals(mainVO.getSrvy_act_yn()))
      throw new CmmnPopException(
          MessageHelper.getMessage("THIS-IS-NOT-A-SURVEY-PERIOD")/* 설문조사기간이 아닙니다. */);

    // 설문인원이 지정되어있고
    // 설문참여자 수가 지정인원을 넘어선 경우
    int max_ans = mainVO.getSrvy_max_ans();
    if (max_ans > 0 && max_ans <= mainVO.getSrvy_appl_cnt()) {
      throw new CmmnPopException(
          MessageHelper.getMessage("YOU-HAVE-EXCEEDED-SURVEY-SETTING")/* 설문조사 설정 인원을 초과했습니다. */);
    }


    // if ("N".equals(mainVO.getSrvy_allow_dup())) {
    // // srvydataVO.setData_addr(EgovFileScrty.encode(EgovWebUtil.getRemoteAddr(request)));
    // int cnt = srvydataService.selectSrvydataDupCnt(srvydataVO);
    //
    // if (cnt > 0)
    // throw new CmmnPopException(
    // MessageHelper.getMessage("YOU-HAVE-ALREADY-JOINED-THE-SURVEY")/* 이미 설문에 참여하셨습니다. */);
    // }

    SrvypartVO partVO = new SrvypartVO();
    partVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    List<SrvypartVO> partList = srvypartService.selectSrvypartList(partVO);

    if (partList == null || partList.size() == 0)
      throw new CmmnPopException(MessageHelper.getMessage("CAN-NOT-RUN-POLL")/* 설문을 실행할 수 없습니다. */);


    SrvyquesansVO quesansVO = new SrvyquesansVO();
    quesansVO.setSrvy_idx(srvydataVO.getSrvy_idx());
    List<SrvyquesansVO> quesansList = srvyquesansService.selectSrvyquesansList(quesansVO);

    if (quesansList == null || quesansList.size() == 0)
      throw new CmmnPopException(MessageHelper.getMessage("CAN-NOT-RUN-POLL")/* 설문을 실행할 수 없습니다. */);

    model.addAttribute("mainVO", mainVO);
    model.addAttribute("partList", partList);
    model.addAttribute("quesansList", quesansList);

    return "/template/cmmn/survey/survey_usr";

  }

  /**
   * 설문 데이터 항목을 추가한다.
   * 
   * @param srvydataVO : 추가할 정보
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
      throw new CmmnPopException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

    // 설문이 진행중이 아닐 경우
    if ("N".equals(mainVO.getSrvy_act_yn()))
      throw new CmmnPopException(
          MessageHelper.getMessage("THIS-IS-NOT-A-SURVEY-PERIOD")/* 설문조사기간이 아닙니다. */);


    // 중복응답허용시 ip주소 입력, 미허용시 이메일 입력받음
    if ("N".equals(mainVO.getSrvy_allow_dup())) {
      int cnt = srvydataService.selectSrvydataDupCnt(srvydataVO);
      if (cnt > 0)
        throw new CmmnPopException(
            MessageHelper.getMessage("YOU-HAVE-ALREADY-JOINED-THE-SURVEY")/* 이미 설문에 참여하셨습니다. */);
    } else {
      srvydataVO.setData_addr(EgovFileScrty.encode(EgovWebUtil.getRemoteAddr(request)));
    }



    srvydataService.insertSrvydata(srvydataVO);

    return "redirect:/usract/surveySrvydata/srvydataComplete.do";

  }

  /**
   * 설문 데이터 추가 완료 페이지를 띄운다.
   * 
   * @param srvydataVO : 추가할 정보
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
   * 설문 데이터 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param srvydataVO : 엑셀 다운 받을 정보
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsSrvydataSave")
  public void xlsSrvydataSave(@ModelAttribute("srvydataVO") SrvydataVO srvydataVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {


    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = {{"RN", "순번"}, {"DATA_IDX", "데이터 번호 (설문조사 응답자 일련번호;시퀀스)"},
        {"QUES_IDX", "질문 번호"}, {"SRVY_IDX", "설문 번호"}, {"DATA_CONT", "답변 저장 값"},
        {"DATA_SPL", "답변 저장 보충 값"}, {"DATA_ADDR", "답변자 식별값 (IP주소 등)"}, {"WRITER", "작성자"},
        {"WDT", "작성일"}, {"MODIFIER", "수정자"}, {"MDT", "수정일"}

    };

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List srvydataOrgList = srvydataService.xlsSrvydataList(srvydataVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
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

    String fileName = "설문 데이터";
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
        returnMsg = "잘못된 접근입니다.";
      // 설문이 진행중이 아닐 경우
      if ("N".equals(mainVO.getSrvy_act_yn()))
        returnMsg = "설문조사기간이 아닙니다.";

      if ("N".equals(mainVO.getSrvy_allow_dup())) {
        // srvydataVO.setData_addr(EgovFileScrty.encode(EgovWebUtil.getRemoteAddr(request)));
        int cnt = srvydataService.selectSrvydataDupCnt(srvydataVO);
        if (cnt > 0) {
          returnMsg = "이미 설문에 참여하셨습니다.";
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
