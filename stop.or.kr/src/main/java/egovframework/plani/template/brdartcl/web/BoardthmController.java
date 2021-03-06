package egovframework.plani.template.brdartcl.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;
import com.google.gson.Gson;
import egovframework.plani.custom.form.validator.groups.ValidationBoardAdd;
import egovframework.plani.custom.form.validator.groups.ValidationBoardModify;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.service.BoardrcmndService;
import egovframework.plani.template.brdartcl.service.BoardreplyService;
import egovframework.plani.template.brdartcl.service.BoardthmService;
import egovframework.plani.template.brdartcl.vo.BoardExtraVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.brdartcl.vo.BoardrcmndVO;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;
import egovframework.plani.template.brdartcl.vo.BoardthmVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.exceptions.UnknownBoardException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.CommonUtil;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.man.menuctgry.service.SyscategoryService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SyscategoryVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/brdthm/*")
public class BoardthmController {

  /** BoardrcmndService */
  @Resource(name = "boardrcmndService")
  private BoardrcmndService boardrcmndService;

  /** BoardreplyService */
  @Resource(name = "boardreplyService")
  private BoardreplyService boardreplyService;

  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  private BoardinfoService boardinfoService;

  /** BoardthmService */
  @Resource(name = "boardthmService")
  private BoardthmService boardthmService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /** SyscategoryService */
  @Resource(name = "syscategoryService")
  private SyscategoryService syscategoryService;

  /** Gson */
  @Resource(name = "gson")
  protected Gson gson;

  /**
   * ????????? ????????????.
   * 
   * @param boardthmVO : ????????? ??????
   * @exception Exception
   */
  @RequestMapping("/boardthmList")
  public String boardthmList(HttpServletRequest request,
      @ModelAttribute("boardthmVO") BoardthmVO boardthmVO, Model model) throws Exception {


    String returnUrl = "/brdthm/boardthmList";
    String srch_menu_nix = boardthmVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = boardthmVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;
    mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_lang);//20191108 ????????? ?????? ??????

    String mu_site = boardthmVO.getSrch_mu_site();
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;
    mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_site);//20191108 ????????? ?????? ??????

    /*******************************
     * ????????? ?????? ?????? Start
     *******************************/

    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(srch_menu_nix);
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
    int subcnt = 0;

    if (menuVO == null)
      throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * .
                                                                                                   */);
    model.addAttribute("nowMenuVO", menuVO);


    // ???????????? ?????? ????????? ?????? ????????? ???????????? ????????????.
    if ("Y".equals(menuVO.getTabmenu_yn())) {
      // ????????? ????????? ????????? ????????? ?????? ???????????? ???????????????
      // ?????? ???????????? ????????? ????????? ?????????????????? ?????? ????????? ????????? ?????? ????????? ?????????.
      // ?????????????????? ????????? ?????? ?????? ???????????? ?????? ????????? ?????? ????????? ??????????????? ???????????? ????????????
      // ???????????? ??????????????? ????????????.
      List sess_main_menu = null;

      if ("USR".equals(boardthmVO.getSrch_mu_gub()) && "CDIDX00022".equals(mu_lang)) {
        if ("CDIDX00002".equals(mu_site))
          sess_main_menu =
              (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MAIN_MENU");

        else if ("CDIDX00003".equals(mu_site))
          sess_main_menu =
              (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MBL_MENU");
      }

      if (sess_main_menu == null) {
        SysmenuVO srchmenuVO = new SysmenuVO();
        srchmenuVO.setSrch_mu_gub("USR");
        srchmenuVO.setSrch_mu_site(mu_site);
        srchmenuVO.setSrch_mu_lang(mu_lang);

        srchmenuVO.setUse_yn("Y");
        srchmenuVO.setAuth_cd("D0001");
        sess_main_menu = sysmenuService.selectSysmenuList(srchmenuVO);
      }

      String submenunix = "";
      List menuList = new ArrayList();
      int cnt = 0;
      for (int i = 0; i < sess_main_menu.size(); i++) {
        menuVO = (SysmenuVO) sess_main_menu.get(i);
        if (up_menu_idx.equals(menuVO.getUp_menu_idx())) {
          menuList.add(cnt++, menuVO);
        }
      }

      model.addAttribute("siblmenuList", menuList);
    }

    /*******************************
     * ????????? ?????? ?????? Start
     *******************************/
    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    // ???????????? ????????? ????????? ???????????? ?????? ?????? ????????? ?????????
    if (boardthmVO.getBrd_id() == null || "".equals(boardthmVO.getBrd_id()))
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* ????????? ???????????????. */);



    /** ????????? ?????? ?????? ???????????? ???????????? */
    BoardinfoVO brdinfoVO = new BoardinfoVO();
    brdinfoVO.setBrd_id(boardthmVO.getBrd_id());
    brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

    if (brdinfoVO == null)
      throw new UnknownBoardException(
          MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
                                                                                   * ????????? ???????????????
                                                                                   * ?????????????????????.
                                                                                   */);

    if ("CDIDX00044".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);

    EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_BRD_INFO");
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);

    /** pageing setting */
    PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
    paginationInfo.setContextPath(request.getContextPath());
    paginationInfo.setCurrentPageNo(boardthmVO.getPageIndex());

    // ????????? ??????
    if ("CDIDX00003".equals(mu_site)) {
      paginationInfo.setRecordCountPerPage(10);
      paginationInfo.setPageSize(5);
    } else {
      // paginationInfo.setRecordCountPerPage(brdinfoVO.getAtcl_per_pg());
      paginationInfo.setRecordCountPerPage(12);
      paginationInfo.setPageSize(brdinfoVO.getPg_per_navi());
    }

    boardthmVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    boardthmVO.setLastIndex(paginationInfo.getLastRecordIndex());
    boardthmVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    boardthmVO.setTbl_nm(brdinfoVO.getTbl_nm());

    boardthmVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
    boardthmVO.setUse_rjct(brdinfoVO.getUse_rjct());
    boardthmVO.setReply_gb(brdinfoVO.getReply_gb());
    /* 20180514-ych ??????????????? ?????? */
    if (brdinfoVO.getReply_gb().equals("R") || brdinfoVO.getReply_gb().equals("B")) {
      boardthmVO.setReply_tbl_nm("CMS_BRD_REPLY_IDX_VXD5L880");
    }
    List boardthmList = boardthmService.selectBoardthmList(boardthmVO);
    model.addAttribute("resultList", boardthmList);

    int totCnt = boardthmService.selectBoardthmListTotCnt(boardthmVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    model.addAttribute("curPage", paginationInfo.getCurrentPageNo());
    model.addAttribute("totCnt", totCnt);
    model.addAttribute("totPage", paginationInfo.getTotalPageCount());


    // ???????????? ?????? ??????
    if ("Y".equals(brdinfoVO.getUse_ctgry())) {
      SyscategoryVO ctgryVO = new SyscategoryVO();
      ctgryVO.setUse_yn("Y");
      ctgryVO.setUp_ctgry_idx(brdinfoVO.getCtgry_idx());
      List ctgryList = syscategoryService.selectSyscategoryList(ctgryVO);
      model.addAttribute("ctgryList", ctgryList);
    }

    /* brdinfoVO brd_gb_sub ?????? return url */
    if (srch_menu_nix.equals("hn8TL907")) {
      if (brdinfoVO.getBrd_gb_sub().equals("B")) {
        returnUrl = "/brdthm/boardthmListB";
      }
    }

    // ????????? ??????
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;


    else {
      // ????????? ??????
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
        if (user.getUser_auth_lv() > 100)
          throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

        returnUrl = "/metsys" + returnUrl;
      }

      else {
        if ("CDIDX00022".equals(mu_lang) == false) {
          returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
        }

      }
    }

    /*************************************************
     * ??????????????? ???????????? ?????? ????????? CheckPlusSafe safe = new CheckPlusSafe(); String hpData =
     * safe.getEncPlanData("M", "", ""); model.addAttribute("hpData", hpData);
     *
     *************************************************/

    // return returnUrl;
    return CommonUtil.getViewPageUrl(returnUrl);
  }


  /**
   * ????????? ?????? ????????????.
   * 
   * @param boardthmVO : ????????? ??????
   * @exception Exception
   */
  @RequestMapping("/boardthmView")
  public String boardthmView(@ModelAttribute("boardthmVO") BoardthmVO boardthmVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    String returnUrl = "/brdthm/boardthmView";
    String srch_menu_nix = boardthmVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = boardthmVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    // ///////////////////////////////////////////////
    // ???????????? ??????
    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(srch_menu_nix);
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
    int subcnt = 0;

    if (menuVO == null)
      throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * .
                                                                                                   */);

    model.addAttribute("nowMenuVO", menuVO);
    // ???????????? ??????
    // ///////////////////////////////////////////////

    // ???????????? ????????? ????????? ???????????? ?????? ?????? ????????? ?????????
    if (boardthmVO.getBrd_id() == null || "".equals(boardthmVO.getBrd_id()))
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* ????????? ???????????????. */);

    // ????????? ????????? ????????? ?????? ????????????
    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

    // ????????? ????????? ????????? ????????? ?????? ?????? (???????????? ?????? ?????? ????????? ??????)
    if (brdinfoVO == null || boardthmVO.getBrd_id().equals(brdinfoVO.getBrd_id()) == false) {

      /** ????????? ?????? ?????? ???????????? ???????????? */
      brdinfoVO = new BoardinfoVO();
      brdinfoVO.setBrd_id(boardthmVO.getBrd_id());
      brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

      if (brdinfoVO == null)
        throw new UnknownBoardException(
            MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
                                                                                     * ????????? ???????????????
                                                                                     * ?????????????????????.
                                                                                     */);

      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);
    }

    if ("CDIDX00044".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);

    /* 2018-05-16 ych ???????????? ???????????? */
    if ("0".equals(brdinfoVO.getOn_viewmode()) == true && user.getUser_auth_lv() > 1000
        && user.getUser_auth_lv() < 10000) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/*
                                                                                  * ???????????? ????????? ????????????.
                                                                                  */);
    }

    /* 2018-05-16 ych ??????????????????????????? */
    if ("0".equals(brdinfoVO.getOff_viewmode()) == true && user.getUser_auth_lv() > 10000) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/*
                                                                                  * ???????????? ????????? ????????????.
                                                                                  */);
    }

    BoardExtraVO extra1_array = gson.fromJson((String) brdinfoVO.getExtra1(), BoardExtraVO.class);
    model.addAttribute("extra1_array", extra1_array);
    BoardExtraVO extra2_array = gson.fromJson((String) brdinfoVO.getExtra2(), BoardExtraVO.class);
    model.addAttribute("extra2_array", extra2_array);

    // ???????????? ?????? ????????????
    AtchfileVO fileVO = new AtchfileVO();
    fileVO.setAtckey_1st(boardthmVO.getBrd_id());
    fileVO.setAtckey_2nd(new Integer(boardthmVO.getCont_idx()).toString());
    fileVO.setAtckey_3rd(1);

    fileVO.setIs_thumb("N");
    List fileList = atchfileService.selectAtchfileList(fileVO);

    if ("R".equals(brdinfoVO.getReply_gb()) || "B".equals(brdinfoVO.getReply_gb())) {
      // ?????? ?????? ????????????
      BoardreplyVO replyVO = new BoardreplyVO();
      replyVO.setBrd_id(boardthmVO.getBrd_id());
      replyVO.setCont_idx(boardthmVO.getCont_idx());
      replyVO.setTbl_nm(brdinfoVO.getTbl_nm());
      List replyList = boardreplyService.selectBoardreplyList(replyVO);

      model.addAttribute("replyList", replyList);
      model.addAttribute("replyCnt", (replyList == null) ? 0 : replyList.size());
    }

    boardthmVO.setTbl_nm(brdinfoVO.getTbl_nm());
    /*
     * boardthmVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
     * boardthmVO.setUse_rjct(brdinfoVO.getUse_rjct());
     */
    BoardthmVO resultVO = boardthmService.selectBoardthm(boardthmVO);

    if (resultVO == null)
      throw new CmmnException(MessageHelper.getMessage("THIS-POST-DOES-NOT-EXIST")/* ???????????? ???????????? ????????????. */);

    if ("Y".equals(resultVO.getIs_scrt()) && "2".equals(brdinfoVO.getOff_viewmode()) == false) {
      // ???????????? ?????????, ?????? ???????????? ?????? ??????
      if (user.getUser_auth_lv() >= 1001 && resultVO.getWriter() != user.getUser_id())
        throw new CmmnException(
            MessageHelper.getMessage("SELECTED-POSTS-ARE-PRIVATE-AND-CAN-NOT-BE-VIEWED")/*
                                                                                         * ???????????? ????????????
                                                                                         * ??????????????????
                                                                                         * ???????????? ???
                                                                                         * ????????????.
                                                                                         */);
    }


    int hits = resultVO.getHits() + 1;
    resultVO.setHits(hits);
    resultVO.setPageIndex(boardthmVO.getPageIndex());
    resultVO.setEditor_gb(boardthmVO.getEditor_gb());
    resultVO.setSearchCondition(boardthmVO.getSearchCondition());
    resultVO.setSearchKeyword(boardthmVO.getSearchKeyword());
    resultVO.setSrch_ctgry_idx(EgovWebUtil.clearXSSMaximum(boardthmVO.getSrch_ctgry_idx()));//20200706 XSS??????
    resultVO.setSrch_mu_lang(boardthmVO.getSrch_mu_lang());
    resultVO.setSeltab_idx(boardthmVO.getSeltab_idx());

    int rcmndCnt = 0;
    int rjctCnt = 0;
    if ("Y".equals(brdinfoVO.getUse_rcmnd()) || "Y".equals(brdinfoVO.getUse_rjct())) {
      // ?????? / ?????? ????????? ????????? ????????? ??????
      String uid = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      BoardrcmndVO boardrcmndVO = new BoardrcmndVO();
      boardrcmndVO.setBrd_id(boardthmVO.getBrd_id());
      boardrcmndVO.setCont_idx(boardthmVO.getCont_idx());
      boardrcmndVO.setRcmnd_gb("R");
      rcmndCnt = boardrcmndService.selectBoardrcmndListTotCnt(boardrcmndVO);

      boardrcmndVO.setRcmnd_gb("J");
      rjctCnt = boardrcmndService.selectBoardrcmndListTotCnt(boardrcmndVO);
    }

    model.addAttribute("rcmndCnt", rcmndCnt);
    model.addAttribute("rjctCnt", rjctCnt);
    model.addAttribute("boardthmVO", resultVO);
    model.addAttribute("atchfileList", fileList);
    model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());


    // /////////////////////////
    // hits + 1
    boardthmVO.setHits(hits);
    boardthmService.updateBoardxcount(boardthmVO);


    // ????????? ??????
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;


    else {
      // ????????? ??????
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
        if (user.getUser_auth_lv() > 100)
          throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

        returnUrl = "/metsys" + returnUrl;
      }

      else {
        if ("CDIDX00022".equals(mu_lang) == false) {
          returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
        }

      }
    }



    // return returnUrl;
    return CommonUtil.getViewPageUrl(returnUrl);
  }



  /**
   * get_post ?????? ??????
   * 
   * 
   * 
   */

  public String thm_movieview_common(BoardthmVO boardthmVO, HttpServletRequest request, Model model)
      throws Exception {

    String returnUrl = "/brdthm/boardthmView";
    String srch_menu_nix = boardthmVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = boardthmVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    if (user.getUser_auth_lv() > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    // ///////////////////////////////////////////////
    // ???????????? ??????
    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(srch_menu_nix);
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
    int subcnt = 0;

    if (menuVO == null)
      throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * ????????????
                                                                                                   * .
                                                                                                   */);
    model.addAttribute("nowMenuVO", menuVO);

    // ???????????? ??????
    // ///////////////////////////////////////////////

    SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
    String wdt = sm.format(new Date());
    String writer = user.getUser_id();

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

    BoardExtraVO extra1_array = gson.fromJson((String) brdinfoVO.getExtra1(), BoardExtraVO.class);
    model.addAttribute("extra1_array", extra1_array);
    BoardExtraVO extra2_array = gson.fromJson((String) brdinfoVO.getExtra2(), BoardExtraVO.class);
    model.addAttribute("extra2_array", extra2_array);


    // ???????????? ????????? ????????? ???????????? ?????? ?????? ????????? ?????????
    if (boardthmVO.getBrd_id() == null || "".equals(boardthmVO.getBrd_id()))
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* ????????? ???????????????. */);

    // ????????? ????????? ????????? ????????? ?????? ?????? (???????????? ?????? ?????? ????????? ?????? ?????? ????????? ????????? ?????????????????? ?????????????????? ?????????)
    if (brdinfoVO == null || boardthmVO.getBrd_id().equals(brdinfoVO.getBrd_id()) == false) {

      /** ????????? ?????? ?????? ???????????? ???????????? */
      brdinfoVO = new BoardinfoVO();
      brdinfoVO.setBrd_id(boardthmVO.getBrd_id());
      brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

      if (brdinfoVO == null)
        throw new UnknownBoardException(
            MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
                                                                                     * ????????? ???????????????
                                                                                     * ?????????????????????.
                                                                                     */);

      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);
    }

    if ("CDIDX00044".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);

    // ???????????? ???????????? ?????? ??????????????? ?????? (!=2) ???????????? ????????? ??????/??????/????????? ??? ??????.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);
    }

    boardthmVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardthmVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
    boardthmVO.setUse_rjct(brdinfoVO.getUse_rjct());

    if ("A".equals(boardthmVO.getEdomweivgp())) {
      boardthmVO.setWriter(writer);
      boardthmVO.setWdt(wdt);
      model.addAttribute("atchfileListCount", 0);
      model.addAttribute("boardarticleVO", boardthmVO);

      returnUrl = "/brdthm/boardthmWrite";
    }

    else if ("M".equals(boardthmVO.getEdomweivgp())) {
      BoardthmVO resultVO = boardthmService.selectBoardthm(boardthmVO);
      if (resultVO == null)
        throw new CmmnException(MessageHelper.getMessage("THIS-POST-DOES-NOT-EXIST")/*
                                                                                     * ???????????? ????????????
                                                                                     * ????????????.
                                                                                     */);

      // ???????????? ?????????, ???????????? ????????? ????????? ?????? ?????? ?????? ????????? ??? ??????.
      if (user.getUser_auth_lv() > 1000 && resultVO.getWriter().equals(user.getUser_id()) == false)
        throw new CmmnException(
            MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-CHANGE-YOUR-POST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????? ????????????.
                                                                                       */);


      boardthmVO.setIs_notice(resultVO.getIs_notice());
      boardthmVO.setWriter(resultVO.getWriter());
      boardthmVO.setWdt(resultVO.getWdt());
      boardthmVO.setImg_width(resultVO.getImg_width());
      boardthmVO.setImg_height(resultVO.getImg_height());

      resultVO.setEdomweivgp(boardthmVO.getEdomweivgp());
      resultVO.setSrch_ctgry_idx(boardthmVO.getSrch_ctgry_idx());
      resultVO.setPageIndex(boardthmVO.getPageIndex());
      resultVO.setSeltab_idx(boardthmVO.getSeltab_idx());
      resultVO.setSrch_mu_lang(boardthmVO.getSrch_mu_lang());
      model.addAttribute("boardthmVO", resultVO);

      AtchfileVO fileVO = new AtchfileVO();
      fileVO.setAtckey_1st(boardthmVO.getBrd_id());
      fileVO.setAtckey_2nd(boardthmVO.getCont_idx() + "");
      fileVO.setAtckey_3rd(1);
      fileVO.setAtckey_4th(boardthmVO.getImg_idx());
      fileVO.setIs_thumb("N");
      List fileList = atchfileService.selectAtchfileList(fileVO);
      model.addAttribute("atchfileList", fileList);
      model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());


      returnUrl = "/brdthm/boardthmUpdate";
    }

    // ???????????? ?????? ??????
    if ("Y".equals(brdinfoVO.getUse_ctgry())) {
      SyscategoryVO ctgryVO = new SyscategoryVO();
      ctgryVO.setUp_ctgry_idx(brdinfoVO.getCtgry_idx());
      List ctgryList = syscategoryService.selectSyscategoryList(ctgryVO);
      model.addAttribute("ctgryList", ctgryList);

    }


    // ????????? ??????
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;

    else {
      // ????????? ??????
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
        if (user.getUser_auth_lv() > 100)
          throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

        returnUrl = "/metsys" + returnUrl;
      }

      else {
        if ("CDIDX00022".equals(mu_lang) == false) {
          returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
        }

      }
    }
    // return returnUrl;
    return CommonUtil.getViewPageUrl(returnUrl);
  }

  /**
   * ??????/?????? ???????????? ????????????.
   * 
   * @param boardthmVO : ????????? ????????? ?????? VO
   * @return "/brdartcl/boardthmList"
   * @exception Exception
   */
  @RequestMapping(value = "/boardthmMoveView", method = RequestMethod.GET)
  public String boardthmMoveView(@ModelAttribute("boardthmVO") BoardthmVO boardthmVO,
      HttpServletRequest request, Model model) throws Exception {

    String returnUrl = thm_movieview_common(boardthmVO, request, model);
    return returnUrl;
  }



  /**
   * ????????? ????????????.
   * 
   * @param boardthmVO : ????????? ??????
   * @exception Exception
   */
  @RequestMapping(value = "/boardthmMoveView", method = RequestMethod.POST)
  @ResponseBody
  public Object addBoardthm(
      @Validated({ValidationBoardAdd.class, ValidationBoardModify.class}) BoardthmVO boardthmVO,
      BindingResult result, HttpServletRequest request, Model model) throws Exception {

    /* ???????????? ???????????? url ???????????? */
    String returnUrl = thm_movieview_common(boardthmVO, request, model);

    /* validation ???????????? */
    ResponseResultHelper responseResultHelper = new ResponseResultHelper(request, returnUrl);

    // ????????? ??????
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

    boardthmVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardthmVO.setImg_idx(1); // ????????? ????????? ???????????? 1??? ????????????.
    boardthmVO.setThm_img_idx(2); // ????????? ????????? ????????? ???????????? 2??? ????????????.

    if (boardthmVO.getCont_idx() == 0) {
      boardthmVO.setWriter(user.getUser_id());
      boardthmService.insertBoardthm(boardthmVO);
    } else {
      boardthmVO.setModifier(user.getUser_id());
      boardthmService.updateBoardthm(boardthmVO);
    }

    List id = new ArrayList();
    id.add(boardthmVO.getCont_idx());

    return responseResultHelper.success(null, null, null, id);

  }



  /**
   * ????????? ????????? ???????????????.
   * 
   * @param boardarticleVO : ????????? ??????
   * @return "/brdartcl/boardarticleView"
   * @exception Exception
   */
  @RequestMapping("/uploadBoardthmForm")
  public String uploadBoardthmForm(@ModelAttribute("boardthmVO") BoardthmVO boardthmVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);
    }

    if ("CDIDX00044".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);

    // ???????????? ???????????? ?????? ??????????????? ?????? (!=2) ???????????? ????????? ??????/??????/????????? ??? ??????.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);
    }

    boardthmVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardthmVO.setModifier(user.getUser_id());
    List linklist =
        atchfileService.uploadProcFormfiles(request, boardthmVO.getBrd_id(),
            new Integer(boardthmVO.getCont_idx()).toString(), 1, "GNR");

    // ????????? ????????? ??????????????? ????????? ??????
    if ("Y".equals(boardthmVO.getChk_imgintocont())) {
      BoardthmVO resultVO = boardthmService.selectBoardthm(boardthmVO);
      if (resultVO == null)
        throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* ????????? ???????????????. */);

      String cont = resultVO.getBrd_cont();

      for (int i = 0; i < linklist.size(); i++) {
        StringTokenizer stok = new StringTokenizer((String) linklist.get(i), "&");
        String[] org = new String[10];

        for (int j = 0; stok.hasMoreTokens(); j++) {
          org[j] = stok.nextToken();
        }

        if (org[0] == null)
          continue;

        // ????????? ????????? ?????? ???????????? ???????????? ????????????.
        if ("jpg|gif|bmp|png".indexOf(org[5]) >= 0) {
          cont += "&lt;p&gt;";
          cont +=
              "&lt;img src='" + request.getContextPath() + "/atchfile/imageAtchfile.do?vchkcode="
                  + org[4] + "' width='95%' /&gt;";
          cont += "&lt;/p&gt;";
        }
        // ????????? ?????? ????????? ???????????? ????????????.
        else if (org[5] != null && org[5].length() > 0) {
          cont += "&lt;!--";
          cont += "&lt;p&gt;";
          cont +=
              "&lt;a href='javascript:cmmfn_download_atchfile('" + request.getContextPath()
                  + "', '" + org[4] + "')'&gt;" + org[6] + "&lt;/a&gt;";
          cont += "&lt;/p&gt;";
          cont += "--&gt;";
        }
      }

      resultVO.setTbl_nm(boardthmVO.getTbl_nm());
      resultVO.setBrd_cont(cont);
      resultVO.setModifier(resultVO.getWriter());
      boardthmService.updateBoardthm(resultVO);
    }

    return "redirect:/brdthm/boardthmList." + ext + "?srch_menu_nix="
        + boardthmVO.getSrch_menu_nix() + "&brd_id=" + boardthmVO.getBrd_id() + "&seltab_idx="
        + boardthmVO.getSeltab_idx() + "&pageIndex=" + boardthmVO.getPageIndex();
  }



  /**
   * ????????? ????????????.
   * 
   * @param boardthmVO : ????????? ??????
   * @exception Exception
   */
  @RequestMapping("/rmvBoardthm")
  public String rmvBoardthm(@ModelAttribute("boardthmVO") BoardthmVO boardthmVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    String srch_menu_nix = boardthmVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 1000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);
    }

    if ("CDIDX00044".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);

    // ???????????? ???????????? ?????? ??????????????? ?????? (!=2) ???????????? ????????? ??????/??????/????????? ??? ??????.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);
    }

    // ////////////////////////////////////////////////////////////////
    // ?????? ?????? ?????? Start
    boardthmVO.setTbl_nm(brdinfoVO.getTbl_nm());
    BoardthmVO compVO = boardthmService.selectBoardthm(boardthmVO);

    if (compVO == null)
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-FIND-DATA-TO-DELETE")/*
                                                                                      * ????????? ???????????? ??????
                                                                                      * ??? ????????????.
                                                                                      */);

    // ???????????? ?????????, ???????????? ????????? ????????? ?????? ?????? ?????? ????????? ??? ??????.
    if (user.getUser_auth_lv() > 1000
        && !compVO.getWriter().equals(
            EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID")))
      throw new CmmnException(
          MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-DELETE-THE-POST")/*
                                                                                    * ???????????? ????????? ?????????
                                                                                    * ????????????.
                                                                                    */);

    // ?????? ?????? ?????? End
    // ////////////////////////////////////////////////////////////////

    boardthmService.deleteBoardthmgroup(boardthmVO);
System.out.println("boardthmVO.getSrch_mu_site():"+boardthmVO.getSrch_mu_site());
    return "redirect:/brdthm/boardthmList." + ext + "?srch_menu_nix="
        + boardthmVO.getSrch_menu_nix() + "&brd_id=" + boardthmVO.getBrd_id() + "&seltab_idx="
        + boardthmVO.getSeltab_idx() + "&srch_mu_lang=" + boardthmVO.getSrch_mu_lang()
        + "&srch_mu_site=" + boardthmVO.getSrch_mu_site();
  }

  /**
   * ????????? ????????????.
   * 
   * @param boardthmVO : ????????? ??????
   * @exception Exception
   */
  @RequestMapping("/mdfBoardthm")
  @ResponseBody
  public String mdfBoardthm(@ModelAttribute("boardthmVO") BoardthmVO boardthmVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 10000)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);
    }

    if ("CDIDX00044".equals(brdinfoVO.getBrd_gb()) == false)
      throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * ???????????? ?????????
                                                                                       * ????????????.
                                                                                       */);

    // ???????????? ???????????? ?????? ??????????????? ?????? (!=2) ???????????? ????????? ??????/??????/????????? ??? ??????.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);
    }

    boardthmVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardthmVO.setModifier(user.getUser_id());

    // ???????????? ????????? ??????
    BoardthmVO compVO = boardthmService.selectBoardthm(boardthmVO);
    if (compVO == null)
      throw new AjaxException(MessageHelper.getMessage("COULD-NOT-FIND-THE-DATA-TO-CHANGE")/*
                                                                                            * ?????????
                                                                                            * ????????????
                                                                                            * ?????? ???
                                                                                            * ????????????.
                                                                                            */);

    // ???????????? ?????????, ???????????? ????????? ????????? ?????? ?????? ?????? ????????? ??? ??????.
    if (user.getUser_auth_lv() > 1000 && compVO.getWriter().equals(user.getUser_id()) == false)
      throw new AjaxException(
          MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-CHANGE-YOUR-POST")/*
                                                                                     * ???????????? ????????? ?????????
                                                                                     * ????????????.
                                                                                     */);

    boardthmService.updateBoardthm(boardthmVO);
    return Integer.toString(boardthmVO.getCont_idx());

  }


  /**
   * ?????? ????????? ????????????.
   * 
   * @param boardreplyVO : ????????? ??????
   * @return "/brdartcl/boardreplyView"
   * @exception Exception
   */
  @RequestMapping("/addBoardreply")
  @ResponseBody
  public BoardreplyVO addBoardreply(@ModelAttribute("boardreplyVO") BoardreplyVO boardreplyVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {
      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 10000)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

      String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
      boardreplyVO.setTbl_nm(brdinfoVO.getTbl_nm());
      boardreplyVO.setWriter(writer);
      boardreplyService.insertBoardreply(boardreplyVO);
      int reply_idx = boardreplyVO.getReply_idx();
      boardreplyVO.setReply_idx(reply_idx);
      boardreplyVO = boardreplyService.selectBoardreply(boardreplyVO);

      return boardreplyVO;

    } catch (Exception e) {

      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }
  }

  /**
   * ?????? ????????? ????????????.
   * 
   * @param boardreplyVO : ????????? ??????
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/rmvBoardreply")
  @ResponseBody
  public String rmvBoardreply(@ModelAttribute("boardreplyVO") BoardreplyVO boardreplyVO,
      HttpServletRequest request, ModelMap model) throws Exception {
    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 10000)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
      boardreplyVO.setTbl_nm(brdinfoVO.getTbl_nm());
      boardreplyService.deleteBoardreply(boardreplyVO);

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
   * ?????? ????????? ????????????.
   * 
   * @param boardreplyVO : ????????? ??????
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/mdfBoardreply")
  @ResponseBody
  public BoardreplyVO mdfBoardreply(@ModelAttribute("boardreplyVO") BoardreplyVO boardreplyVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 10000)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);


      String modifier = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

      boardreplyVO.setTbl_nm(brdinfoVO.getTbl_nm());
      boardreplyVO.setModifier(modifier);
      boardreplyService.updateBoardreply(boardreplyVO);

      boardreplyVO = boardreplyService.selectBoardreply(boardreplyVO);

    } catch (Exception e) {

      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return boardreplyVO;
  }


}
