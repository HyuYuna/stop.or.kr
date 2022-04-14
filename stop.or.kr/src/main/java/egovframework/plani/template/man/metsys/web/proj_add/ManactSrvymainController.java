package egovframework.plani.template.man.metsys.web.proj_add;

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
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.exceptions.CmmnPopException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
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
 * 설문 메인 액션 컨트롤러
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.web.proj_add]
 *        [ManactSrvymainController.java]
 */
@Controller
@RequestMapping("/manact/surveySrvymain")
public class ManactSrvymainController {

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

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  protected AtchfileService atchfileService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /**
   * 설문 메인 목록을 조회한다.
   * 
   * @param srvymainVO : 조회할 정보
   * @param request
   * @param model
   * @return "String : tiles"
   * @exception Exception
   */
  @RequestMapping("/srvymainList")
  public String srvymainList(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      HttpServletRequest request, Model model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

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


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYMAIN_MAN", "설문 메인관리", "설문 메인 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/manact/surveySrvymain/srvymainList";

  }

  /**
   * 설문 메인 항목 상세조회 페이지 이동.
   * 
   * @param srvymainVO : 조회할 정보
   * @param request
   * @param model
   * @return "String : tiles"
   * @exception Exception
   */
  @RequestMapping("/srvymainView")
  public String srvymainView(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    if ("M".equals(srvymainVO.getEdomweivgp())) {

      // 상세 내용 조회
      SrvymainVO resultVO = srvymainService.selectSrvymain(srvymainVO);
      if (resultVO != null) {
        resultVO.setEdomweivgp(srvymainVO.getEdomweivgp());
        resultVO.setSrch_mu_site(srvymainVO.getSrch_mu_site());
        resultVO.setSrch_mu_lang(srvymainVO.getSrch_mu_lang());
        resultVO.setSrch_menu_nix(srvymainVO.getSrch_menu_nix());
        resultVO.setSeltab_idx(srvymainVO.getSeltab_idx());
        resultVO.setPageIndex(srvymainVO.getPageIndex());
        resultVO.setSearchCondition(srvymainVO.getSearchCondition());
        resultVO.setSearchKeyword(srvymainVO.getSearchKeyword());
        resultVO.setSrchFromDT(srvymainVO.getSrchFromDT());
        resultVO.setSrchToDT(srvymainVO.getSrchToDT());
        resultVO.setSrvy_act_yn(srvymainVO.getSrvy_act_yn());
        model.addAttribute("srvymainVO", resultVO);
      }

      // 첨부파일 목록 가져오기
      AtchfileVO fileVO = new AtchfileVO();
      fileVO.setAtckey_1st("SRVYPOP");
      fileVO.setAtckey_2nd(new Integer(resultVO.getSrvy_idx()).toString());
      fileVO.setAtckey_3rd(1);
      List fileList = atchfileService.selectAtchfileList(fileVO);

      model.addAttribute("atchfileList", fileList);
      model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());

      /*
       * // 코드 조회하기 SyscodeVO codeVO = new SyscodeVO(); codeVO.setUse_yn("Y");
       * codeVO.setUp_code_idx(""); List xxxxcode = syscodeService.selectSyscodeList(codeVO);
       * model.addAttribute("xxxxcode", xxxxcode);
       */

    }

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYMAIN_MAN", "설문 메인관리",
        "설문 메인 상세조회 " + "[" + srvymainVO.getSrvy_nm() + "]", "R");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/manact/surveySrvymain/srvymainWrite";
  }


  /**
   * 설문 결과를 조회한다.
   * 
   * @param srvymainVO : 조회할 정보
   * @param request
   * @param model
   * @return "String : /template/metsys/sv/srvymainResult"
   * @exception Exception
   */
  @RequestMapping("/srvymainResult")
  public String srvymainResult(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      HttpServletRequest request, Model model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnPopException(
          MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYMAIN_MAN", "설문 메인관리", "설문 결과 조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    SrvymainVO mainVO = srvymainService.selectSrvymain(srvymainVO);
    if (mainVO == null)
      throw new CmmnPopException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

    model.addAttribute("mainVO", mainVO);

    SrvypartVO partVO = new SrvypartVO();
    partVO.setSrvy_idx(srvymainVO.getSrvy_idx());
    List partList = srvypartService.selectSrvypartList(partVO);
    if (partList == null || partList.size() == 0)
      throw new CmmnPopException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);
    model.addAttribute("partList", partList);

    SrvyquesansVO quesansVO = new SrvyquesansVO();
    quesansVO.setSrvy_idx(srvymainVO.getSrvy_idx());
    List quesansList = srvyquesansService.selectSrvyquesansResult(quesansVO);
    if (quesansList == null || quesansList.size() == 0)
      throw new CmmnPopException("저장된 설문 결과가 없습니다.");
    model.addAttribute("quesansList", quesansList);

    SrvydataVO dataVO = new SrvydataVO();
    dataVO.setSrvy_idx(srvymainVO.getSrvy_idx());
    List dataList = srvydataService.selectSrvydataCont(dataVO);
    model.addAttribute("dataList", dataList);

    return "/template/metsys/sv/srvymainResult";

  }



  /**
   * 설문 메인 항목을 추가한다.
   * 
   * @param srvymainVO : 추가할 정보
   * @param request
   * @param model
   * @return "String : redirect[srch_menu_nix='메뉴 코드명']"
   * @exception Exception
   */
  @RequestMapping("/addSrvymain")
  public String addSrvymain(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    srvymainVO.setWriter(user.getUser_id());
    srvymainService.insertSrvymain(request, srvymainVO);


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYMAIN_MAN", "설문 메인관리",
        "설문 메인 추가 " + "[" + srvymainVO.getSrvy_nm() + "]", "C");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "redirect:/manact/surveySrvymain/srvymainList.do?srch_menu_nix="
        + srvymainVO.getSrch_menu_nix();
  }

  /**
   * 설문 메인 항목을 삭제한다.
   * 
   * @param srvymainVO : 삭제할 정보
   * @param request
   * @param model
   * @return String : redirect[srch_menu_nix='메뉴 코드명',pageIndex='현재페이지']
   * @exception Exception
   */
  @RequestMapping("/rmvSrvymain")
  public String rmvSrvymain(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    SrvymainVO resultVO = srvymainService.selectSrvymain(srvymainVO);
    if (resultVO != null) {
      srvymainService.deleteSrvymain(srvymainVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "SRVYMAIN_MAN", "설문 메인관리",
          "설문 메인 삭제 " + "[" + resultVO.getSrvy_nm() + "]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////
    }



    return "redirect:/manact/surveySrvymain/srvymainList.do?srch_menu_nix="
        + srvymainVO.getSrch_menu_nix() + "&pageIndex=1";
  }

  /**
   * 설문 메인 항목을 수정한다.
   * 
   * @param srvymainVO : 수정할 정보
   * @param request
   * @param model
   * @return String : redirect['/manact/surveySrvymain/srvymainList.do?srch_menu_nix="
   *         ?&edomweivgp=M']
   * @exception Exception
   */
  @RequestMapping("/mdfSrvymain")
  public String mdfSrvymain(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    srvymainVO.setModifier(tmpmemVO.getUser_id());
    srvymainService.updateSrvymain(request, srvymainVO);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYMAIN_MAN", "설문 메인관리",
        "설문 메인 수정 " + "[" + srvymainVO.getSrvy_nm() + "]", "U");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    // 아래 리다이렉트 파라미터에 키값이 더 추가되어야 함.
    return "redirect:/manact/surveySrvymain/srvymainList.do?srch_menu_nix="
        + srvymainVO.getSrch_menu_nix() + "&edomweivgp=M";
  }

  /**
   * 설문 메인 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param srvymainVO : 엑셀 다운 받을 정보
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsSrvyresultSave")
  public void xlsSrvyresultSave(@ModelAttribute("srvymainVO") SrvymainVO srvymainVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {


    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();


    SrvyquesansVO quesansVO = new SrvyquesansVO();
    quesansVO.setSrvy_idx(srvymainVO.getSrvy_idx());
    
    // List quesansList = srvyquesansService.selectSrvyquesansList(quesansVO);
    List quesansList = srvyquesansService.selectXlsSrvyquesansList(quesansVO);

    HashMap ifmap = new HashMap();
    ifmap.put("COL_NAME", "RN");
    ifmap.put("COL_INFO", "순번");
    colinfoList.add(ifmap);

    ifmap = new HashMap();
    ifmap.put("COL_NAME", "TIMESTAMP");
    ifmap.put("COL_INFO", "시간");
    colinfoList.add(ifmap);

    int last_ques_idx = 0;
    String last_ques = "";

    for (int i = 0; i < quesansList.size(); i++) {
      quesansVO = (SrvyquesansVO) quesansList.get(i);
      if ("Q".equals(quesansVO.getQuesans_type())) {
        last_ques_idx = quesansVO.getQues_idx();
        last_ques = quesansVO.getQuesans_cont();

        //if ("CDIDX00085|CDIDX00086".lastIndexOf(quesansVO.getQues_type()) < 0) {//20191119 주관식(250) 도 보이도록 처리
          ifmap = new HashMap();
          ifmap.put("COL_NAME", new Integer(quesansVO.getQues_idx()).toString() + "_1");
          ifmap.put("COL_INFO", quesansVO.getQuesans_cont());
          colinfoList.add(ifmap);
        //}
      }
      // 보기가 있는 경우 보기 표시
      else {
        if ("CDIDX00085|CDIDX00086".lastIndexOf(quesansVO.getQues_type()) >= 0
            && quesansVO.getQues_idx() == last_ques_idx) {
          ifmap = new HashMap();
          ifmap.put("COL_NAME", new Integer(quesansVO.getQues_idx()).toString() + "_"
              + new Integer(quesansVO.getAns_ord()).toString());
          ifmap.put("COL_INFO", last_ques + " [ " + quesansVO.getQuesans_cont() + " ]");
          colinfoList.add(ifmap);
        }
      }

    }

    // ifmap = new HashMap();
    // ifmap.put("COL_NAME", new Integer(quesansVO.getSrvy_nm_idx()).toString());
    // ifmap.put("COL_INFO", "이름");
    // colinfoList.add(ifmap);
    //
    // ifmap = new HashMap();
    // ifmap.put("COL_NAME", new Integer(quesansVO.getSrvy_cp_idx()).toString());
    // ifmap.put("COL_INFO", "전화번호");
    // colinfoList.add(ifmap);

    SrvydataVO srvydataVO = new SrvydataVO();
    srvydataVO.setSrvy_idx(srvymainVO.getSrvy_idx());
    List srvydataOrgList = srvydataService.xlsSrvydataList(srvydataVO);


    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List srvydataXlsList = new ArrayList();
    int last_data_idx = 0;
    int data_cnt = 1;
    HashMap rsmap = null;

    String mapkey = "";
    String mapval = "";

    for (int i = 0; i < srvydataOrgList.size(); i++) {
      SrvydataVO vo = (SrvydataVO) srvydataOrgList.get(i);

      if (last_data_idx != vo.getData_idx()) {
        if (rsmap != null)
          srvydataXlsList.add(rsmap);

        rsmap = new HashMap();
        rsmap.put("RN", data_cnt++);
        rsmap.put("TIMESTAMP", vo.getWdt());
      }

      if (vo.getQuessub_idx() == vo.getSrvy_nm_idx()
          || vo.getQuessub_idx() == vo.getSrvy_cp_idx()) {
        mapkey = new Integer(vo.getQuessub_idx()).toString();
        // 전화번호는 디코딩
        if (vo.getQuessub_idx() == vo.getSrvy_cp_idx())
          mapval = EgovFileScrty.decode(vo.getData_cont());
        else
          mapval = vo.getData_cont();

      }

      else {
        // 객관식 답변은 번호가 아닌 답변으로 표시한다.
        if (vo.getRef_cont() != null && "".equals(vo.getRef_cont()) == false) {
          mapkey = new Integer(vo.getQues_idx()).toString() + "_"
              + new Integer(vo.getQuessub_idx()).toString();
          mapval = vo.getRef_cont();

        } else {
          mapkey = new Integer(vo.getQues_idx()).toString() + "_"
              + new Integer(vo.getQuessub_idx()).toString();
          // 답변이 null인 경우 임의로 지정했던 데이터 468482는 엑셀 출력 시 빈 값으로 넣는다.
          mapval = "468482".equals(vo.getData_cont()) ? "" : vo.getData_cont();
        }

        if (vo.getData_spl() != null && "".equals(vo.getData_spl()) == false)
          mapval = vo.getData_spl();

      }

      rsmap.put(mapkey, mapval);

      last_data_idx = vo.getData_idx();
    }

    srvydataXlsList.add(rsmap);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYMAIN_MAN", "설문 메인관리", "설문 결과 엑셀저장", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    String fileName = "설문 조사 결과";
    xlsDownUtil.ExcelSrvyWrite(response, srvydataXlsList, colinfoList, fileName);
  }


}
