package egovframework.plani.template.man.metsys.web;

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
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SysauthService;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;
import egovframework.plani.template.man.metsys.service.AccessipService;
import egovframework.plani.template.man.metsys.vo.AccessipVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 관리자 페이지 접근 IP관리 액션 컨트롤러
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.web] [ModeipController.java]
 *
 */
@Controller
@RequestMapping("/modeip")
public class ModeipController {

  /** AccessipService */
  @Resource(name = "accessipService")
  private AccessipService accessipService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** SyscodeService */
  @Resource(name = "syscodeService")
  protected SyscodeService syscodeService;

  @Resource(name = "sysauthService")
  private SysauthService sysauthService;

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
   * 관리자 접근 IP 제한 목록을 조회한다.
   * 
   * @param accessipVO : 조회할 조건을 가진 VO
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/accessipList")
  public String accessipList(@ModelAttribute("accessipVO") AccessipVO accessipVO,
      HttpServletRequest request, Model model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    /** pageing setting */
    PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
    paginationInfo.setContextPath(request.getContextPath());
    paginationInfo.setCurrentPageNo(accessipVO.getPageIndex());
    paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

    accessipVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    accessipVO.setLastIndex(paginationInfo.getLastRecordIndex());
    accessipVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    List accessipList = accessipService.selectAccessipList(accessipVO);
    model.addAttribute("resultList", accessipList);

    int totCnt = accessipService.selectAccessipListTotCnt(accessipVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    model.addAttribute("curPage", paginationInfo.getCurrentPageNo());
    model.addAttribute("totCnt", totCnt);
    model.addAttribute("totPage", paginationInfo.getTotalPageCount());

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "ACCESSIP_MAN", "접근IP관리", "관리자 접근 IP 제한 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/modeip/accessipList";

  }

  /**
   * 관리자 접근 IP 제한 항목 상세조회 페이지 이동.
   * 
   * @param accessipVO : 조회할 조건이 담긴 VO
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/accessipView")
  public String accessipView(@ModelAttribute("accessipVO") AccessipVO accessipVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    if ("M".equals(accessipVO.getEdomweivgp())) {

      // 상세 내용 조회
      AccessipVO resultVO = accessipService.selectAccessip(accessipVO);
      if (resultVO != null) {
        resultVO.setEdomweivgp(accessipVO.getEdomweivgp());
        resultVO.setSrch_mu_site(accessipVO.getSrch_mu_site());
        resultVO.setSrch_mu_lang(accessipVO.getSrch_mu_lang());
        resultVO.setSrch_menu_nix(accessipVO.getSrch_menu_nix());
        resultVO.setSeltab_idx(accessipVO.getSeltab_idx());
        resultVO.setPageIndex(accessipVO.getPageIndex());
        model.addAttribute("accessipVO", resultVO);
      }

      /*
       * // 첨부파일 목록 가져오기 AtchfileVO fileVO = new AtchfileVO(); fileVO.setAtckey_1st("");
       * fileVO.setAtckey_2nd(""); fileVO.setAtckey_3rd(""); List fileList =
       * atchfileService.selectAtchfileList(fileVO);
       * 
       * model.addAttribute("atchfileList", fileList); model.addAttribute("atchfileListCount",
       * fileList == null ? 0 : fileList.size());
       */

      /*
       * // 코드 조회하기 SyscodeVO codeVO = new SyscodeVO(); codeVO.setUse_yn("Y");
       * codeVO.setUp_code_idx(""); List xxxxcode = syscodeService.selectSyscodeList(codeVO);
       * model.addAttribute("xxxxcode", xxxxcode);
       */

    }

    // 관리자 권한 상세 유형 조회하기
    SysauthVO authVO = new SysauthVO();
    authVO.setUp_auth_cd("M0000");
    authVO.setUse_yn("Y");
    List authcode = sysauthService.selectSysauthList(authVO);
    model.addAttribute("authcode", authcode);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "ACCESSIP_MAN", "접근IP관리",
        "관리자 접근 IP 제한 상세조회 " + "[" + accessipVO.getAccess_ip() + "]", "R");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/modeip/accessipWrite";
  }



  /**
   * 관리자 접근 IP 제한 항목을 추가한다.
   * 
   * @param accessipVO : 추가할 정보를 담은 VO
   * @param request
   * @param model
   * @return redirect[srch_menu_nix="메뉴코드명"]
   * @exception Exception
   */
  @RequestMapping("/addAccessip")
  public String addAccessip(@ModelAttribute("accessipVO") AccessipVO accessipVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    accessipVO.setWriter(user.getUser_id());
    accessipService.insertAccessip(accessipVO);


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "ACCESSIP_MAN", "접근IP관리",
        "관리자 접근 IP 제한 추가 " + "[" + accessipVO.getAccess_ip() + "]", "C");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "redirect:/modeip/accessipList.do?srch_menu_nix=" + accessipVO.getSrch_menu_nix();
  }

  /**
   * 관리자 접근 IP 제한 항목을 삭제한다.
   * 
   * @param accessipVO : 삭제할 정보 조건이 담긴 VO
   * @param request
   * @param model
   * @return redirect[srch_menu_nix="메뉴코드명",pageIndex="현재페이지"]
   * @exception Exception
   */
  @RequestMapping("/rmvAccessip")
  public String rmvAccessip(@ModelAttribute("accessipVO") AccessipVO accessipVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    AccessipVO resultVO = accessipService.selectAccessip(accessipVO);
    if (resultVO != null) {
      accessipService.deleteAccessip(accessipVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "ACCESSIP_MAN", "접근IP관리",
          "관리자 접근 IP 제한 삭제 " + accessipVO.getAccess_ip() + "]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////
    }



    return "redirect:/modeip/accessipList.do?srch_menu_nix=" + accessipVO.getSrch_menu_nix()
        + "&pageIndex=1";
  }

  /**
   * 관리자 접근 IP 제한 항목을 수정한다.
   * 
   * @param accessipVO : 수정할 정보 조건이 담긴 VO
   * @param request
   * @param model
   * @return redirect[srch_menu_nix="메뉴코드명",edomweivgp="페이지조회모드"]
   * @exception Exception
   */
  @RequestMapping("/mdfAccessip")
  public String mdfAccessip(@ModelAttribute("accessipVO") AccessipVO accessipVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    accessipVO.setModifier(tmpmemVO.getUser_id());
    accessipService.updateAccessip(accessipVO);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "ACCESSIP_MAN", "접근IP관리",
        "관리자 접근 IP 제한 수정 " + "[" + accessipVO.getAccess_ip() + "]", "U");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    // 아래 리다이렉트 파라미터에 키값이 더 추가되어야 함.
    return "redirect:/modeip/accessipList.do?srch_menu_nix=" + accessipVO.getSrch_menu_nix()
        + "&edomweivgp=M";
  }

  /**
   * 관리자 접근 IP 제한 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param accessipVO : 엑셀 다운 받을 조건이 담긴 VO
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsAccessipSave")
  public void xlsAccessipSave(@ModelAttribute("accessipVO") AccessipVO accessipVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = {{"RN", "순번"}, {"AUTH_CD", "권한코드"}, {"ACCESS_IP", "접근 IP"},
        {"WRITER", "작성자"}, {"WDT", "작성일"}, {"MODIFIER", "수정자"}, {"MDT", "수정일"}

    };

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List accessipOrgList = accessipService.xlsAccessipList(accessipVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List accessipXlsList = new ArrayList();
    for (int i = 0; i < accessipOrgList.size(); i++) {
      AccessipVO vo = (AccessipVO) accessipOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("AUTH_CD", vo.getAuth_cd());
      rsmap.put("ACCESS_IP", vo.getAccess_ip());
      rsmap.put("WRITER", vo.getWriter());
      rsmap.put("WDT", vo.getWdt());
      rsmap.put("MODIFIER", vo.getModifier());
      rsmap.put("MDT", vo.getMdt());


      accessipXlsList.add(rsmap);
    }


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "ACCESSIP_MAN", "접근IP관리", "관리자 접근 IP 제한 엑셀저장", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    String fileName = "관리자 접근 IP 제한";
    xlsDownUtil.ExcelWrite(response, accessipXlsList, colinfoList, fileName);
  }


}
