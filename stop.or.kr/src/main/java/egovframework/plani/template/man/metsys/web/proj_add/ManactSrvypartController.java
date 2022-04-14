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
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;
import egovframework.plani.template.survey.service.SrvymainService;
import egovframework.plani.template.survey.service.SrvypartService;
import egovframework.plani.template.survey.vo.SrvymainVO;
import egovframework.plani.template.survey.vo.SrvypartVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 설문파트 액션 컨트롤러
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.web.proj_add]
 *        [ManactSrvypartController.java]
 *
 */
@Controller
@RequestMapping("/manact/surveySrvypart")
public class ManactSrvypartController {


  /** SrvypartService */
  @Resource(name = "srvypartService")
  private SrvypartService srvypartService;

  /** SrvymainService */
  @Resource(name = "srvymainService")
  private SrvymainService srvymainService;

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
   * 설문 파트 목록을 조회한다.
   * 
   * @param srvypartVO : 조회할 정보
   * @param request
   * @param model
   * @return String : tiles
   * @exception Exception
   */
  @RequestMapping("/srvypartList")
  public String srvypartList(@ModelAttribute("srvypartVO") SrvypartVO srvypartVO,
      HttpServletRequest request, Model model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List srvypartList = srvypartService.selectSrvypartList(srvypartVO);
    model.addAttribute("resultList", srvypartList);

    SrvymainVO mainVO = new SrvymainVO();
    mainVO.setSrvy_idx(srvypartVO.getSrvy_idx());
    mainVO = srvymainService.selectSrvymain(mainVO);
    model.addAttribute("mainVO", mainVO);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYPART_MAN", "설문 파트관리", "설문 파트 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/manact/surveySrvypart/srvypartList";

  }

  /**
   * 설문 파트 항목 상세조회 페이지 이동.
   * 
   * @param srvypartVO : 조회할 정보
   * @param request
   * @param model
   * @return String : tiles
   * @exception Exception
   */
  @RequestMapping("/srvypartView")
  public String srvypartView(@ModelAttribute("srvypartVO") SrvypartVO srvypartVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    if ("M".equals(srvypartVO.getEdomweivgp())) {

      // 상세 내용 조회
      SrvypartVO resultVO = srvypartService.selectSrvypart(srvypartVO);
      if (resultVO != null) {
        resultVO.setEdomweivgp(srvypartVO.getEdomweivgp());
        resultVO.setSrch_mu_site(srvypartVO.getSrch_mu_site());
        resultVO.setSrch_mu_lang(srvypartVO.getSrch_mu_lang());
        resultVO.setSrch_menu_nix(srvypartVO.getSrch_menu_nix());
        resultVO.setSeltab_idx(srvypartVO.getSeltab_idx());
        resultVO.setPageIndex(srvypartVO.getPageIndex());
        resultVO.setSearchCondition(srvypartVO.getSearchCondition());
        resultVO.setSearchKeyword(srvypartVO.getSearchKeyword());
        resultVO.setSrchFromDT(srvypartVO.getSrchFromDT());
        resultVO.setSrchToDT(srvypartVO.getSrchToDT());
        resultVO.setSrvy_act_yn(srvypartVO.getSrvy_act_yn());
        model.addAttribute("srvypartVO", resultVO);
      }

      /*
       * // 첨부파일 목록 가져오기 AtchfileVO fileVO = new AtchfileVO(); fileVO.setAtckey_1st("");
       * fileVO.setAtckey_2nd(""); fileVO.setAtckey_3rd(""); List fileList =
       * atchfileService.selectAtchfileList(fileVO);
       * 
       * model.addAttribute("atchfileList", fileList); model.addAttribute("atchfileListCount",
       * fileList == null ? 0 : fileList.size());
       */

    }

    // 코드 조회하기
    SyscodeVO codeVO = new SyscodeVO();
    codeVO.setUse_yn("Y");
    codeVO.setUp_code_idx("CDIDX00061");
    List partcode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("partcode", partcode);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYPART_MAN", "설문 파트관리",
        "설문 파트 상세조회 " + "[" + srvypartVO.getPart_nm() + "]", "R");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/manact/surveySrvypart/srvypartWrite";
  }



  /**
   * 설문 파트 항목을 추가한다.
   * 
   * @param srvypartVO : 추가할 정보
   * @param request
   * @param model
   * @return String :
   *         redirect[srch_menu_nix='메뉴코드명',pageIndex='현재페이지',srvy_idx='설문번호',srvy_act_yn='설문활성화여부']
   * @exception Exception
   */
  @RequestMapping("/addSrvypart")
  public String addSrvypart(@ModelAttribute("srvypartVO") SrvypartVO srvypartVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    srvypartVO.setWriter(user.getUser_id());
    srvypartService.insertSrvypart(srvypartVO);


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYPART_MAN", "설문 파트관리",
        "설문 파트 추가 " + "[" + srvypartVO.getPart_nm() + "]", "C");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "redirect:/manact/surveySrvypart/srvypartList.do?srch_menu_nix="
        + srvypartVO.getSrch_menu_nix() + "pageIndex=" + srvypartVO.getPageIndex() + "&srvy_idx="
        + srvypartVO.getSrvy_idx() + "&srvy_act_yn=" + srvypartVO.getSrvy_act_yn();
  }

  /**
   * 설문 파트 항목을 삭제한다.
   * 
   * @param srvypartVO : 삭제할 정보
   * @param request
   * @param model
   * @return String :
   *         redirect[srch_menu_nix='메뉴코드명',pageIndex='현재페이지',srvy_idx='설문번호',srvy_act_yn='설문활성화여부']
   * @exception Exception
   */
  @RequestMapping("/rmvSrvypart")
  public String rmvSrvypart(@ModelAttribute("srvypartVO") SrvypartVO srvypartVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    SrvypartVO resultVO = srvypartService.selectSrvypart(srvypartVO);
    if (resultVO != null) {
      srvypartService.deleteSrvypart(srvypartVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "SRVYPART_MAN", "설문 파트관리",
          "설문 파트 삭제 " + "[" + resultVO.getPart_nm() + "]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////
    }



    return "redirect:/manact/surveySrvypart/srvypartList.do?srch_menu_nix="
        + srvypartVO.getSrch_menu_nix() + "&pageIndex=" + srvypartVO.getPageIndex() + "&srvy_idx="
        + srvypartVO.getSrvy_idx() + "&srvy_act_yn=" + srvypartVO.getSrvy_act_yn();
  }

  /**
   * 설문 파트 항목을 수정한다.
   * 
   * @param srvypartVO : 수정할 정보
   * @param request
   * @param model
   * @return String :
   *         redirect[srch_menu_nix='메뉴코드명',pageIndex='현재페이지',srvy_idx='설문번호',srvy_act_yn='설문활성화여부']
   * @exception Exception
   */
  @RequestMapping("/mdfSrvypart")
  public String mdfSrvypart(@ModelAttribute("srvypartVO") SrvypartVO srvypartVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    srvypartVO.setModifier(tmpmemVO.getUser_id());
    srvypartService.updateSrvypart(srvypartVO);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYPART_MAN", "설문 파트관리",
        "설문 파트 수정 " + "[" + srvypartVO.getPart_nm() + "]", "U");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    // 아래 리다이렉트 파라미터에 키값이 더 추가되어야 함.
    return "redirect:/manact/surveySrvypart/srvypartList.do?srch_menu_nix="
        + srvypartVO.getSrch_menu_nix() + "&pageIndex=" + srvypartVO.getPageIndex() + "&srvy_idx="
        + srvypartVO.getSrvy_idx() + "&srvy_act_yn=" + srvypartVO.getSrvy_act_yn();
  }

  /**
   * 설문 파트 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param srvypartVO : 엑셀 다운 받을 정보
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsSrvypartSave")
  public void xlsSrvypartSave(@ModelAttribute("srvypartVO") SrvypartVO srvypartVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = {{"RN", "순번"}, {"SRVY_IDX", "설문조사 번호"}, {"PART_IDX", "파트 번호"},
        {"PART_NM", "파트 명"}, {"PART_TYPE", "파트 구분 (개인정보 / 일반파트)"}, {"PART_PSN_INFO", "개인정보 수집 안내"},
        {"WRITER", "작성자"}, {"WDT", "작성일"}, {"MODIFIER", "수정자"}, {"MDT", "수정일"}

    };

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List srvypartOrgList = srvypartService.xlsSrvypartList(srvypartVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List srvypartXlsList = new ArrayList();
    for (int i = 0; i < srvypartOrgList.size(); i++) {
      SrvypartVO vo = (SrvypartVO) srvypartOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("SRVY_IDX", vo.getSrvy_idx());
      rsmap.put("PART_IDX", vo.getPart_idx());
      rsmap.put("PART_NM", vo.getPart_nm());
      rsmap.put("PART_TYPE", vo.getPart_type());
      rsmap.put("PART_PSN_INFO", vo.getPart_psn_info());
      rsmap.put("WRITER", vo.getWriter());
      rsmap.put("WDT", vo.getWdt());
      rsmap.put("MODIFIER", vo.getModifier());
      rsmap.put("MDT", vo.getMdt());


      srvypartXlsList.add(rsmap);
    }


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYPART_MAN", "설문 파트관리", "설문 파트 엑셀저장", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    String fileName = "설문 파트";
    xlsDownUtil.ExcelWrite(response, srvypartXlsList, colinfoList, fileName);
  }


}
