package egovframework.plani.template.man.menuctgry.web;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SysauthService;
import egovframework.plani.template.man.menuctgry.service.SysauthmenuService;
import egovframework.plani.template.man.menuctgry.service.SyscategoryService;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;
import egovframework.plani.template.man.menuctgry.vo.SyscategoryVO;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.plani.template.man.popup.service.PopupService;
import egovframework.plani.template.man.popup.vo.PopupVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 시스템 메뉴, 코드, 카테고리, 사용자 권한등의 코드값 (관리자의 기타관리 메뉴)을 처리한다. 모두 비슷한 구조로 거의 동일하게 처리되기때문에 하나로 합쳐놓음.
 * 
 * @class : [KIGAM_PH] [egovframework.plani.menuctgry.web] [SysmenuctgryController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 9. 5. 오전 10:34:14
 * @version : 1.0
 */
@Controller
@RequestMapping("/menuctgry")
public class SyscodeController {

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;


  /** SyscategoryService */
  @Resource(name = "syscategoryService")
  private SyscategoryService syscategoryService;

  /** SyscodeService */
  @Resource(name = "syscodeService")
  private SyscodeService syscodeService;

  /** SysauthService */
  @Resource(name = "sysauthService")
  private SysauthService sysauthService;

  /** PopupService */
  @Resource(name = "popupService")
  protected PopupService popupService;

  /** SysauthmenuService */
  @Resource(name = "sysauthmenuService")
  private SysauthmenuService sysauthmenuService;

  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  private BoardinfoService boardinfoService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;



  // ////////////////////////////////////////////
  // //
  // 시스템 메뉴 관리 Start //
  // //
  // ////////////////////////////////////////////

  /**
   * 액션 설명
   * 
   * @param param 파라미터 설명 VO
   * @return return value 설명
   * @exception Exception
   */
  @RequestMapping("/moveSysmenuView")
  public String moveSysmenuView(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO,
      HttpServletRequest request, Model model) throws Exception {

    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(sysmenuVO.getSrch_menu_nix());
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
    int subcnt = 0;

    if ("M".equals(sysmenuVO.getEdomweivgp())) {
      sysmenuVO.setSrch_menu_nix("");
      SysmenuVO resultVO = sysmenuService.selectSysmenu(sysmenuVO);
      resultVO.setEdomweivgp(sysmenuVO.getEdomweivgp());
      resultVO.setSeltab_idx(sysmenuVO.getSeltab_idx());
      resultVO.setSrch_mu_gub(sysmenuVO.getSrch_mu_gub());
      resultVO.setSrch_mu_site(sysmenuVO.getSrch_mu_site());
      resultVO.setSrch_mu_lang(sysmenuVO.getSrch_mu_lang());
      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "MN_MAN", "메뉴관리", "메뉴 상세조회 [" + resultVO.getMenu_nm()
          + "]", "R");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

      model.addAttribute("sysmenuVO", resultVO);
    } else {
      sysmenuVO.setMenu_idx("");

      model.addAttribute("sysmenuVO", sysmenuVO);
    }

    // 사이트구분 코드 조회
    SyscodeVO codeVO = new SyscodeVO();
    codeVO.setUp_code_idx("CDIDX00001");
    codeVO.setUse_yn("Y");
    List sitecode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("sitecode", sitecode);

    // 언어구분 코드 조회
    codeVO.setUp_code_idx("CDIDX00021");
    List langcode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("langcode", langcode);

    // 게시판유형 코드 조회
    codeVO.setUp_code_idx("CDIDX00041");
    List brdcode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("brdcode", brdcode);


    return "/modeec/menuView";

  }


  /**
   * 관리자 메뉴관리 페이지를 열기위한 목록을 조회한다.
   * 
   * @param sysmenuVO : 조회할 정보
   * @return "/menuctgry/sysmenuList"
   * @exception Exception
   */
  @RequestMapping("/sysmenuList")
  public String sysmenuList(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    if ("".equals(sysmenuVO.getSrch_mu_gub()) || sysmenuVO.getSeltab_idx() == 0)
      sysmenuVO.setSrch_mu_gub("MAN");

    if ("".equals(sysmenuVO.getSrch_mu_site()))
      sysmenuVO.setSrch_mu_site("CDIDX00002");

    if ("".equals(sysmenuVO.getSrch_mu_lang()))
      sysmenuVO.setSrch_mu_lang("CDIDX00022");

    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setUp_menu_idx("MNIDX00002");
    List subMenuList = sysmenuService.selectSysmenuListSub(menuVO);
    model.addAttribute("subMenuList", subMenuList);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "MN_MAN", "메뉴관리", "메뉴 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    List sysmenuList = sysmenuService.selectSysmenumanList(sysmenuVO);

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    if ("mysql".equals(dbtype)) {
      EgovWebUtil.getLeveldList(sysmenuList, null, 1, new Integer(1));
    }

    model.addAttribute("resultList", sysmenuList);
    int totCnt = sysmenuList == null ? 0 : sysmenuList.size();

    NumberFormat nf = NumberFormat.getInstance();
    model.addAttribute("totCnt", nf.format(totCnt));


    // 사이트구분 코드 조회
    SyscodeVO codeVO = new SyscodeVO();
    codeVO.setUse_yn("Y");
    codeVO.setUp_code_idx("CDIDX00001");
    List sitecode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("sitecode", sitecode);

    // 언어구분 코드 조회
    codeVO.setUp_code_idx("CDIDX00021");

    List langcode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("langcode", langcode);

    return "/modeec/menuList";

  }


  /**
   * 사이트 메인화면 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param sysmenuVO : 조회할 정보
   * @exception Exception
   */
  @RequestMapping("/mainmenuList")
  @ResponseBody
  public List mainmenuList(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO,
      HttpServletRequest request, Model model) throws Exception {


    String mu_lang = sysmenuVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;
    mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_lang);//20191108 취약점 조치 추가

    String mu_site = sysmenuVO.getSrch_mu_site();
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_site);//20191108 취약점 조치 추가
    sysmenuVO.setSrch_mu_site(mu_site);

    List sess_main_menu = null;

    // 국문 사이트들의 메뉴는 세션을 이용한다.
    if ("USR".equals(sysmenuVO.getSrch_mu_gub()) && "CDIDX00022".equals(mu_lang)) {
      if ("CDIDX00002".equals(mu_site))
        sess_main_menu =
            (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MAIN_MENU");
      else if ("CDIDX00005".equals(mu_site))
        sess_main_menu =
            (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_WOMEN_MENU");
      else if ("CDIDX00003".equals(mu_site))
        sess_main_menu = (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MBL_MENU");
    }

    if (sess_main_menu == null) {

      // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
      String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
      if (auth_cd == null)
        auth_cd = "G0001";

      sysmenuVO.setUse_yn("Y");
      sysmenuVO.setAuth_cd(auth_cd);
      sess_main_menu = sysmenuService.selectSysmenuList(sysmenuVO);

      String dbtype = EgovProperties.getProperty("Globals.DbType");

      if ("mysql".equals(dbtype)) {
        EgovWebUtil.getLeveldList(sess_main_menu, null, 1, new Integer(1));
      }

      // 사용자 국문 메뉴만 세션을 사용한다.
      if ("USR".equals(sysmenuVO.getSrch_mu_gub()) && "CDIDX00022".equals(mu_lang)) {
        if ("CDIDX00002".equals(mu_site))
          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_MAIN_MENU", sess_main_menu);
        else if ("CDIDX00005".equals(mu_site))
          sess_main_menu =
              (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_WOMEN_MENU");
        else if ("CDIDX00003".equals(mu_site))
          EgovSessionCookieUtil.setSessionAttribute(request, "SESS_MBL_MENU", sess_main_menu);
      }
    }
    /*
     * int totCnt = sysmenuService.selectSysmenuListTotCnt(sysmenuVO); NumberFormat nf =
     * NumberFormat.getInstance(); model.addAttribute("totCnt", nf.format(totCnt));
     */
    return sess_main_menu;

  }


  /**
   * 사이트 레프트 메뉴정보를 조회한다.
   * 
   * @param sysmenuVO : 조회할 정보
   * @exception Exception
   */
  @RequestMapping("/leftmenuList")
  @ResponseBody
  public List leftmenuList(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO,
      HttpServletRequest request, Model model) throws Exception {

    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");

    if (auth_cd == null)
      auth_cd = "G0001";

    sysmenuVO.setMu_gub("USR");
    sysmenuVO.setUse_yn("Y");
    sysmenuVO.setAuth_cd(auth_cd);

    if (sysmenuVO.getSrch_menu_nix() == null || "".equals(sysmenuVO.getSrch_menu_nix()))
      throw new AjaxException(
          MessageHelper.getMessage("THERE-IS-NO-MENU-AVAILABLE-OR-MENU-INFORMATION-IS-INVALID")/*
                                                                                                * 사용하실
                                                                                                * 수
                                                                                                * 있는
                                                                                                * 메뉴가
                                                                                                * 없거나
                                                                                                * 메뉴
                                                                                                * 조회정보가
                                                                                                * 잘못되었습니다
                                                                                                * .
                                                                                                */);

    List sidemenuList = sysmenuService.selectSubmenuList(sysmenuVO);

    if (sidemenuList == null || sidemenuList.size() == 0)
      throw new AjaxException(
          MessageHelper.getMessage("THERE-IS-NO-MENU-AVAILABLE-OR-MENU-INFORMATION-IS-INVALID")/*
                                                                                                * 사용하실
                                                                                                * 수
                                                                                                * 있는
                                                                                                * 메뉴가
                                                                                                * 없거나
                                                                                                * 메뉴
                                                                                                * 조회정보가
                                                                                                * 잘못되었습니다
                                                                                                * .
                                                                                                */);

    /*
     * model.addAttribute("submenuList", submenuList);
     * 
     * SysmenuVO upmenu = sysmenuService.selectSysupmenu(sysmenuVO); model.addAttribute("upmenu",
     * upmenu);
     */

    return sidemenuList;

  }

  /**
   * 사이트 메인화면 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param sysmenuVO : 조회할 정보
   * @exception Exception
   */
  @RequestMapping("/bannerList")
  @ResponseBody
  public List bannerList(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request,
      Model model) throws Exception {

    List bannerList = null;
    bannerList = (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BANNER_LIST");

    if (bannerList == null || bannerList.isEmpty()) {
      popupVO.setPop_type("R");
      bannerList = popupService.selectValidPopupList(popupVO);

      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BANNER_LIST", bannerList);
    }
    return bannerList;

  }


  /**
   * 관리자 메인화면 메뉴을 생성하기 위해 메뉴목록을 조회한다.
   * 
   * @param sysmenuVO : 조회할 정보
   * @exception Exception
   */
  @RequestMapping("/managemenuList")
  @ResponseBody
  public List managemenuList(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO,
      HttpServletRequest request, Model model) throws Exception {

    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");

    sysmenuVO.setSrch_mu_gub("MAN");
    sysmenuVO.setSrch_mu_site("CDIDX00002");
    sysmenuVO.setSrch_mu_lang("CDIDX00022");
    sysmenuVO.setUse_yn("Y");
    sysmenuVO.setAuth_cd(auth_cd);

    List sess_man_menu = (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MAN_MENU");
    if (sess_man_menu == null || sess_man_menu.isEmpty()) {
      sess_man_menu = sysmenuService.selectSysmenuList(sysmenuVO);
      String dbtype = EgovProperties.getProperty("Globals.DbType");

      if ("mysql".equals(dbtype)) {
        EgovWebUtil.getLeveldList(sess_man_menu, null, 1, new Integer(1));
      }

      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_MAN_MENU", sess_man_menu);
    }

    // /////////////////////////////////////
    // 메뉴 권한 체크를 위한 세션 등록 Start
    Map menmenu_auth =
        (Map) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MANMENU_AUTH");
    if (menmenu_auth == null || menmenu_auth.isEmpty()) {
      menmenu_auth = new HashMap();
      for (int i = 0; i < sess_man_menu.size(); i++) {
        // 권한있는 메뉴 체크
        SysmenuVO menuVO = (SysmenuVO) sess_man_menu.get(i);
        if ("Y".equals(menuVO.getAuth_yn()))
          menmenu_auth.put(menuVO.getMenu_nix(), "Y");
      }
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_MANMENU_AUTH", menmenu_auth);
    }
    // 메뉴 권한 체크를 위한 세션 등록 End
    // /////////////////////////////////////

    // model.addAttribute("menuList", sess_man_menu);

    return sess_man_menu;

  }


  /**
   * 메뉴 항목을 상세 조회한다.
   * 
   * @param sysmenuVO : 조회할 정보
   * @return "/menuctgry/sysmenuView"
   * @exception Exception
   */
  @RequestMapping("/sysmenuView")
  public String sysmenuView(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO, ModelMap model)
      throws Exception {

    /*
     * SysmenuVO resultVO = sysmenuService.selectSysmenu(sysmenuVO); model.addAttribute("resultVO",
     * resultVO);
     */

    return "/modeec/menuPage";
  }


  /**
   * 메뉴 항목을 추가한다.
   * 
   * @param sysmenuVO : 추가할 정보
   * @return "/menuctgry/sysmenuView"
   * @exception Exception
   */
  @RequestMapping("/addSysmenu")
  @ResponseBody
  public String addSysmenu(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "MN_MAN", "메뉴관리", "메뉴 추가 [" + sysmenuVO.getMenu_nm()
          + "]", "C");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

      String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      sysmenuVO.setWriter(writer);

      sysmenuService.insertSysmenu(sysmenuVO);
    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }


    return "SUCCESS";
  }

  /**
   * 메뉴 항목을 삭제한다.
   * 
   * @param sysmenuVO : 삭제할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/rmvSysmenu")
  @ResponseBody
  public String rmvSysmenu(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "MN_MAN", "메뉴관리", "메뉴 삭제 [" + sysmenuVO.getMenu_nm()
          + "]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////


      // 여러개를 선택해서 한꺼번에 삭제하는 경우
      // 하나를 삭제할때마다 하위메뉴를 같이 삭제해야 하기때문에
      // 선택된 개수만큼 반복해서 삭제한다.
      if (sysmenuVO.getMenu_idx().indexOf(":") >= 0) {
        StringTokenizer token = new StringTokenizer(sysmenuVO.getMenu_idx(), ":");
        while (token.hasMoreTokens()) {
          sysmenuVO.setMenu_idx(token.nextToken());
          sysmenuService.deleteSysmenu(sysmenuVO);
        }
      } else {
        sysmenuService.deleteSysmenu(sysmenuVO);
      }


    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return "SUCCESS";
  }

  /**
   * 메뉴 항목을 수정한다.
   * 
   * @param sysmenuVO : 수정할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/mdfSysmenu")
  @ResponseBody
  public String mdfSysmenu(@ModelAttribute("sysmenuVO") SysmenuVO sysmenuVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      String modifier = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      sysmenuVO.setModifier(modifier);


      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "MN_MAN", "메뉴관리", "메뉴 정보 변경 [" + sysmenuVO.getMenu_nm()
          + "]", "U");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

      sysmenuService.updateSysmenu(sysmenuVO);
    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);

    }
    return "SUCCESS";
  }


  // ////////////////////////////////////////////
  // //
  // 시스템 카테고리 관리 Start //
  // //
  // ////////////////////////////////////////////
  /**
   * 액션 설명
   * 
   * @param param 파라미터 설명 VO
   * @return return value 설명
   * @exception Exception
   */
  @RequestMapping("/moveSyscategoryView")
  public String moveSyscategoryView(@ModelAttribute("syscategoryVO") SyscategoryVO syscategoryVO,
      Model model) throws Exception {


    if ("M".equals(syscategoryVO.getEdomweivgp())) {
      SyscategoryVO resultVO = syscategoryService.selectSyscategory(syscategoryVO);
      resultVO.setEdomweivgp(syscategoryVO.getEdomweivgp());
      model.addAttribute("syscategoryVO", resultVO);
    }

    return "/menuctgry/syscategoryBase";

  }

  /**
   * 카테고리 목록을 조회한다.
   * 
   * @param syscategoryVO : 조회할 정보
   * @return "/menuctgry/syscategoryList"
   * @exception Exception
   */
  @RequestMapping("/syscategoryList")
  public String syscategoryList(@ModelAttribute("syscategoryVO") SyscategoryVO syscategoryVO,
      HttpServletRequest request, Model model) throws Exception {

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "CTG_MAN", "카테고리관리", "카테고리 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "/modeec/ctgryList";

  }


  /**
   * 카테고리 목록을 조회한다.
   * 
   * @param syscategoryVO : 조회할 정보
   * @return "/menuctgry/syscategoryList"
   * @exception Exception
   */
  @RequestMapping("/syscategoryJsonList")
  @ResponseBody
  public List syscategoryJsonList(@ModelAttribute("syscategoryVO") SyscategoryVO syscategoryVO,
      Model model) throws Exception {

    List syscategoryList = null;

    try {
      syscategoryList = syscategoryService.selectSyscategoryList(syscategoryVO);
    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return syscategoryList;

  }


  /**
   * 카테고리 항목을 추가한다.
   * 
   * @param syscategoryVO : 추가할 정보
   * @return "/menuctgry/syscategoryView"
   * @exception Exception
   */
  @RequestMapping("/addSyscategory")
  @ResponseBody
  public String addSyscategory(@ModelAttribute("syscategoryVO") SyscategoryVO syscategoryVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      syscategoryVO.setWriter(writer);
      syscategoryService.insertSyscategory(syscategoryVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "CTG_MAN", "카테고리관리",
          "카테고리 추가 [" + syscategoryVO.getCtgry_nm() + "]", "C");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }


    return "SUCCESS";
  }

  /**
   * 카테고리 항목을 삭제한다. 실제값은 삭제되지 않고 use_yn 의 값을 N으로 변경시키기만 한다.
   * 
   * @param syscategoryVO : 삭제할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/rmvSyscategory")
  @ResponseBody
  public String rmvSyscategory(@ModelAttribute("syscategoryVO") SyscategoryVO syscategoryVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      syscategoryService.deleteSyscategory(syscategoryVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      SyscategoryVO resultVO = syscategoryService.selectSyscategory(syscategoryVO);
      manlogService.insertManlog(request, "CTG_MAN", "카테고리관리", "카테고리 삭제 ["
          + (resultVO == null ? syscategoryVO.getCtgry_idx() : resultVO.getCtgry_nm()) + "]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////


    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }


    return "SUCCESS";
  }

  /**
   * 카테고리 항목을 수정한다.
   * 
   * @param syscategoryVO : 수정할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/mdfSyscategory")
  @ResponseBody
  public String mdfSyscategory(@ModelAttribute("syscategoryVO") SyscategoryVO syscategoryVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    try {
      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      String modifier = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      syscategoryVO.setModifier(modifier);
      syscategoryService.updateSyscategory(syscategoryVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "CTG_MAN", "카테고리관리",
          "카테고리 변경 [" + syscategoryVO.getCtgry_nm() + "]", "U");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return "SUCCESS";
  }



  // ////////////////////////////////////////////
  // //
  // 시스템 코드 관리 Start //
  // //
  // ////////////////////////////////////////////
  /**
   * 액션 설명
   * 
   * @param param 파라미터 설명 VO
   * @return return value 설명
   * @exception Exception
   */
  @RequestMapping("/moveSyscodeView")
  public String moveSyscodeView(@ModelAttribute("syscodeVO") SyscodeVO syscodeVO, Model model)
      throws Exception {

    if ("M".equals(syscodeVO.getEdomweivgp())) {
      SyscodeVO resultVO = syscodeService.selectSyscode(syscodeVO);
      resultVO.setEdomweivgp(syscodeVO.getEdomweivgp());
      model.addAttribute("syscodeVO", resultVO);
    }

    return "/menuctgry/syscodeBase";

  }

  /**
   * 코드 목록을 조회한다.
   * 
   * @param syscodeVO : 조회할 정보
   * @return "/menuctgry/syscategoryList"
   * @exception Exception
   */
  @RequestMapping("/syscodeList")
  public String syscodeList(@ModelAttribute("syscodeVO") SyscodeVO syscodeVO,
      HttpServletRequest request, Model model) throws Exception {


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "CD_MAN", "코드관리", "코드 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/modeec/codeList";

  }


  /**
   * 코드 목록을 조회한다.
   * 
   * @param syscodeVO : 조회할 정보
   * @return "/menuctgry/syscategoryList"
   * @exception Exception
   */
  @RequestMapping("/syscodeJsonList")
  @ResponseBody
  public List syscodeJsonList(@ModelAttribute("syscodeVO") SyscodeVO syscodeVO, Model model)
      throws Exception {

    List syscodeList = null;

    try {
      syscodeList = syscodeService.selectSyscodeList(syscodeVO);
    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return syscodeList;

  }

  /**
   * 코드 항목을 추가한다.
   * 
   * @param syscodeVO : 추가할 정보
   * @return "/menuctgry/syscategoryView"
   * @exception Exception
   */
  @RequestMapping("/addSyscode")
  @ResponseBody
  public String addSyscode(@ModelAttribute("syscodeVO") SyscodeVO syscodeVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      syscodeVO.setWriter(writer);
      syscodeService.insertSyscode(syscodeVO);


      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "CD_MAN", "코드관리", "코드 추가 [" + syscodeVO.getCode_nm()
          + "]", "C");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }


    return "SUCCESS";
  }

  /**
   * 코드 항목을 삭제한다. 실제값은 삭제되지 않고 use_yn 의 값을 N으로 변경시키기만 한다.
   * 
   * @param syscodeVO : 삭제할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/rmvSyscode")
  @ResponseBody
  public String rmvSyscode(@ModelAttribute("syscodeVO") SyscodeVO syscodeVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    try {
      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      syscodeService.deleteSyscode(syscodeVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      SyscodeVO resultVO = syscodeService.selectSyscode(syscodeVO);
      manlogService.insertManlog(request, "CD_MAN", "코드관리", "코드 삭제 ["
          + (resultVO == null ? syscodeVO.getCode_idx() : resultVO.getCode_nm()) + "]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////


    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }


    return "SUCCESS";
  }

  /**
   * 코드 항목을 수정한다.
   * 
   * @param syscodeVO : 수정할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/mdfSyscode")
  @ResponseBody
  public String mdfSyscode(@ModelAttribute("syscodeVO") SyscodeVO syscodeVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    try {
      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


      String modifier = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      syscodeVO.setModifier(modifier);
      syscodeService.updateSyscode(syscodeVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "CD_MAN", "코드관리", "코드 변경 [" + syscodeVO.getCode_nm()
          + "]", "U");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////


    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return "SUCCESS";
  }



  // ////////////////////////////////////////////
  // //
  // 시스템 권한 관리 Start //
  // //
  // ////////////////////////////////////////////
  /**
   * 시스템권한 설명
   * 
   * @param param 파라미터 설명 VO
   * @return return value 설명
   * @exception Exception
   */
  @RequestMapping("/moveSysauthView")
  public String moveSysauthView(@ModelAttribute("sysauthVO") SysauthVO sysauthVO, Model model)
      throws Exception {

    if ("M".equals(sysauthVO.getEdomweivgp())) {
      SysauthVO resultVO = sysauthService.selectSysauth(sysauthVO);
      resultVO.setEdomweivgp(sysauthVO.getEdomweivgp());
      model.addAttribute("sysauthVO", resultVO);
    }

    return "/menuctgry/sysauthBase";

  }

  /**
   * 시스템권한 목록을 조회한다.
   * 
   * @param sysauthVO : 조회할 정보
   * @return "/menuctgry/syscategoryList"
   * @exception Exception
   */
  @RequestMapping("/sysauthList")
  public String sysauthList(@ModelAttribute("sysauthVO") SysauthVO sysauthVO,
      HttpServletRequest request, Model model) throws Exception {

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "AUTH_MAN", "권한관리", "권한 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/modeec/authList";

  }


  /**
   * 시스템권한 목록을 조회한다.
   * 
   * @param sysauthVO : 조회할 정보
   * @return "/menuctgry/syscategoryList"
   * @exception Exception
   */
  @RequestMapping("/sysauthJsonList")
  @ResponseBody
  public List sysauthJsonList(@ModelAttribute("sysauthVO") SysauthVO sysauthVO,
      HttpServletRequest request, Model model) throws Exception {

    List sysauthList = null;

    try {
      int usr_lv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      sysauthVO.setAuth_lv(usr_lv);
      sysauthList = sysauthService.selectSysauthList(sysauthVO);
    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return sysauthList;

  }

  /**
   * 시스템권한 항목을 추가한다.
   * 
   * @param sysauthVO : 추가할 정보
   * @return "/menuctgry/syscategoryView"
   * @exception Exception
   */
  @RequestMapping("/addSysauth")
  @ResponseBody
  public String addSysauth(@ModelAttribute("sysauthVO") SysauthVO sysauthVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      sysauthVO.setWriter(writer);
      sysauthService.insertSysauth(sysauthVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "AUTH_MAN", "권한관리", "권한 추가 [" + sysauthVO.getAuth_nm()
          + "]", "C");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }


    return "SUCCESS";
  }

  /**
   * 시스템권한 항목을 삭제한다. 실제값은 삭제되지 않고 use_yn 의 값을 N으로 변경시키기만 한다.
   * 
   * @param sysauthVO : 삭제할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/rmvSysauth")
  @ResponseBody
  public String rmvSysauth(@ModelAttribute("sysauthVO") SysauthVO sysauthVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    try {
      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      sysauthService.deleteSysauth(sysauthVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      SysauthVO resultVO = sysauthService.selectSysauth(sysauthVO);
      manlogService.insertManlog(request, "AUTH_MAN", "권한관리", "권한 삭제 ["
          + (resultVO == null ? sysauthVO.getAuth_nm() : resultVO.getAuth_nm()) + "]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////


    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }


    return "SUCCESS";
  }

  /**
   * 시스템권한 항목을 수정한다.
   * 
   * @param sysauthVO : 수정할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/mdfSysauth")
  @ResponseBody
  public String mdfSysauth(@ModelAttribute("sysauthVO") SysauthVO sysauthVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {
      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


      String modifier = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      sysauthVO.setModifier(modifier);
      sysauthService.updateSysauth(sysauthVO);

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "AUTH_MAN", "권한관리", "권한 변경 [" + sysauthVO.getAuth_nm()
          + "]", "U");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////


    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return "SUCCESS";
  }


  /**
   * 권한별 사용 메뉴 목록을 조회한다.
   * 
   * @param sysauthVO : 조회할 정보
   * @return "/menuctgry/syscategoryList"
   * @exception Exception
   */
  @RequestMapping("/sysauthmenuJsonList")
  @ResponseBody
  public List sysauthmenuJsonList(@ModelAttribute("sysauthmenuVO") SysmenuVO sysauthmenuVO,
      Model model) throws Exception {

    List sysauthList = null;

    try {
      sysauthList = sysauthmenuService.selectSysauthmenuList(sysauthmenuVO);
      String dbtype = EgovProperties.getProperty("Globals.DbType");

      if ("mysql".equals(dbtype)) {
        EgovWebUtil.getLeveldList(sysauthList, null, 1, new Integer(1));
      }
    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return sysauthList;

  }


  /**
   * 권한별 메뉴 항목을 추가한다.
   * 
   * @param sysauthVO : 추가할 정보
   * @return "/menuctgry/syscategoryView"
   * @exception Exception
   */
  @RequestMapping("/addSysauthmenu")
  @ResponseBody
  public String addSysauthmenu(@ModelAttribute("sysauthmenuVO") SysmenuVO sysauthmenuVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {
      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 100)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


      String menuList = request.getParameter("menuList");
      String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      sysauthmenuVO.setWriter(writer);
      sysauthmenuVO.setModifier(writer);

      if (menuList != null && !"".equals(menuList)) {
        // 메뉴 권한을 설정하기 전에 권한의 사용가능 메뉴를 모두 'N'으로 바꿔놓는다.
        sysauthmenuService.updateSysauthmenu(sysauthmenuVO);

        // 선택된 메뉴에 대한 권한을 설정한다.
        StringTokenizer token = new StringTokenizer(menuList, ",");
        while (token.hasMoreTokens()) {
          sysauthmenuVO.setMenu_idx(token.nextToken());
          sysauthmenuService.insertSysauthmenu(sysauthmenuVO);
        }
      }

    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return "SUCCESS";
  }



  // /**
  // * Mysql에서 지원하지 않는 Connect By 절을 구현.. 호출은 반드시 다음과 같이 한다. getLeveldList(list, null, 1, new
  // * Integer(1)); 2014.08.26 bhhan
  // *
  // * @param rowlist : connect by가 적용되지 않은 (적용해야 할) 결과 리스트
  // * @param parentVal : start with 에 들어가야 할 조건 (최상위 노드)
  // * @param nowlevel : 현재 Level
  // * @param startOrd : 정렬 시작값
  // */
  // public static Integer getLeveldList(List<SysmenuVO> rowlist, String parentVal, int nowlevel,
  // Integer startOrd) {
  // List<SysmenuVO> list = new ArrayList<SysmenuVO>();
  //
  // ////////////////////////////////////////////////////////
  // // Step 1 ..
  // // parentVal 를 부모로 갖는 녀석들을 먼저 골라낸다..
  // // 레벨값을 셋팅한다.
  // for (int i = 0; i < rowlist.size(); i++) {
  // SysmenuVO menuVO = (SysmenuVO) rowlist.get(i);
  //
  // if (parentVal == null || "".equals(parentVal)) {
  // if (menuVO.getUp_menu_idx() == null || "".equals(menuVO.getUp_menu_idx())) {
  // menuVO.setMenu_lv(nowlevel);
  // list.add(menuVO);
  // }
  // } else {
  // if (parentVal.equals(menuVO.getUp_menu_idx())) {
  // menuVO.setMenu_lv(nowlevel);
  // list.add(menuVO);
  // }
  // }
  // }
  //
  // {
  // // 같은 부모의 자식들을 정해진정렬 기준으로 정렬함
  // // 여기서는 menu_ord 의 값으로 정렬함.
  // // 이부분이 Order Siblings By 가 됨..
  // Comparator<SysmenuVO> sort = new Comparator<SysmenuVO>() {
  // public int compare(SysmenuVO o1, SysmenuVO o2) {
  // return EgovWebUtil.getZerofillStr(o1.getMenu_ord(), 6)
  // .compareTo(EgovWebUtil.getZerofillStr(o2.getMenu_ord(), 6));
  // }
  // };
  // Collections.sort(list, sort); // 위에 설정한 내용대로 정렬(sort!)
  // }
  // //
  // /////////////////////////////////////////////////////////
  //
  //
  // ///////////////////////////////////////////////////////
  // // 이부분은 디버깅시 진행상황을 한눈에 확인하도록
  // // 값을 출력하는 부분이다.
  // // 아래 Step 3 내부에 포인트 찍고 한단계씩 진행하면서
  // // 값을 확인하면 오류를 쉽게 찾을 수 있다.
  // /*
  // * System.out.println("\n############################"); for(int i = 0; i < rowlist.size(); i++)
  // * { SysmenuVO menuVO = (SysmenuVO)rowlist.get(i); System.out.println(menuVO.getMenu_idx() + " "
  // * + menuVO.getUp_menu_idx() + " " + menuVO.getMenu_lv() + " " + menuVO.getConnectOrder()); }
  // */
  // //
  // ////////////////////////////////////////////////////////
  //
  // //////////////////////////////////////////////////////////
  // // Step 2 ..
  // // 위에서 뽑아낸 같은 부모의 자식들을 재귀 탐색하여
  // // 레벨과 정렬 번호를 붙인다..
  // for (int j = 0; j < list.size(); j++) {
  // SysmenuVO menuVO = (SysmenuVO) list.get(j);
  // menuVO.setConnectOrder(startOrd++);
  // startOrd = getLeveldList(rowlist, menuVO.getMenu_idx(), nowlevel + 1, startOrd);
  // }
  // //
  // ///////////////////////////////////////////////////////////
  //
  //
  // ///////////////////////////////////////////////////////////
  // // Step 3 ..
  // // 재귀호출이 종료될때
  // // 최종적으로 connectOrd 값으로 정렬을 시켜
  // // connect by 기능을 완성한다.
  // if (parentVal == null) {
  //
  // Comparator<SysmenuVO> sort = new Comparator<SysmenuVO>() {
  // public int compare(SysmenuVO o1, SysmenuVO o2) {
  // return EgovWebUtil.getZerofillStr(o1.getConnectOrder(), 6)
  // .compareTo(EgovWebUtil.getZerofillStr(o2.getConnectOrder(), 6));
  // }
  // };
  // Collections.sort(rowlist, sort); // 위에 설정한 내용대로 정렬(sort!)
  //
  // }
  // //
  // ///////////////////////////////////////////////////////////
  //
  // return startOrd;
  // }
  //
  //
  // /*
  // * public static void main(String[] args) { List<SysmenuVO> list = new ArrayList<SysmenuVO>();
  // *
  // * SysmenuVO menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX001");
  // * menuVO.setUp_menu_idx(null); menuVO.setMenu_ord(1); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX002"); menuVO.setUp_menu_idx(null);
  // * menuVO.setMenu_ord(2); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX003"); menuVO.setUp_menu_idx(null);
  // * menuVO.setMenu_ord(3); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX004"); menuVO.setUp_menu_idx(null);
  // * menuVO.setMenu_ord(4); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX005"); menuVO.setUp_menu_idx(null);
  // * menuVO.setMenu_ord(5); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX006"); menuVO.setUp_menu_idx("MNIDX001");
  // * menuVO.setMenu_ord(1); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX007"); menuVO.setUp_menu_idx("MNIDX001");
  // * menuVO.setMenu_ord(2); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX008"); menuVO.setUp_menu_idx("MNIDX002");
  // * menuVO.setMenu_ord(1); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX009"); menuVO.setUp_menu_idx("MNIDX002");
  // * menuVO.setMenu_ord(2); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX010"); menuVO.setUp_menu_idx("MNIDX005");
  // * menuVO.setMenu_ord(1); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX011"); menuVO.setUp_menu_idx("MNIDX002");
  // * menuVO.setMenu_ord(3); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX012"); menuVO.setUp_menu_idx("MNIDX005");
  // * menuVO.setMenu_ord(2); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX013"); menuVO.setUp_menu_idx("MNIDX012");
  // * menuVO.setMenu_ord(1); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX014"); menuVO.setUp_menu_idx("MNIDX012");
  // * menuVO.setMenu_ord(2); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX015"); menuVO.setUp_menu_idx("MNIDX009");
  // * menuVO.setMenu_ord(1); list.add(menuVO);
  // *
  // * menuVO = new SysmenuVO(); menuVO.setMenu_idx("MNIDX016"); menuVO.setUp_menu_idx("MNIDX009");
  // * menuVO.setMenu_ord(2); list.add(menuVO);
  // *
  // * SyscodeController.getLeveldList(list, null, 1, new Integer(1));
  // *
  // * /////////////////////////////////////////////////////// // 이부분은 디버깅시 진행상황을 한눈에 확인하도록 // 값을
  // 출력하는
  // * 부분이다. // 아래 Step 3 내부에 포인트 찍고 한단계씩 진행하면서 // 값을 확인하면 오류를 쉽게 찾을 수 있다. for(int i = 0; i <
  // * list.size(); i++) { menuVO = (SysmenuVO)list.get(i); System.out.println(menuVO.getMenu_idx()
  // +
  // * " " + menuVO.getUp_menu_idx() + " " + menuVO.getMenu_lv() + " " + menuVO.getConnectOrder());
  // }
  // * // ////////////////////////////////////////////////////////
  // *
  // *
  // * }
  // */
  //


}
