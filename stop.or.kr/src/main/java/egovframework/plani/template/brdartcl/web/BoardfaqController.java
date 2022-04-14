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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.brdartcl.service.BoardfaqService;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.service.BoardrcmndService;
import egovframework.plani.template.brdartcl.service.BoardreplyService;
import egovframework.plani.template.brdartcl.vo.BoardfaqVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.brdartcl.vo.BoardrcmndVO;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.exceptions.UnknownBoardException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.jcaptcha.CaptchaServiceSingleton;
import egovframework.plani.template.man.menuctgry.service.SyscategoryService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SyscategoryVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 게시판 관련 요청을 처리함
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.web] [BoardfaqController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:57:50
 * @version : 1.0
 */
@Controller
@RequestMapping("/brdfaq")
public class BoardfaqController {

  /** BoardrcmndService */
  @Resource(name = "boardrcmndService")
  private BoardrcmndService boardrcmndService;

  /** BoardfaqService */
  @Resource(name = "boardfaqService")
  private BoardfaqService boardfaqService;

  /** BoardreplyService */
  @Resource(name = "boardreplyService")
  private BoardreplyService boardreplyService;

  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  private BoardinfoService boardinfoService;

  /** SyscategoryService */
  @Resource(name = "syscategoryService")
  private SyscategoryService syscategoryService;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;



  /**
   * 목록을 조회한다.
   * 
   * @param boardfaqVO : 등록할 정보가 담긴 VO
   * @return "/brdfaq/boardfaqList"
   * @exception Exception
   */
  @RequestMapping("/boardfaqList")
  public String boardfaqList(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, Model model) throws Exception {

    String returnUrl = "/brdfaq/boardfaqList";
    String srch_menu_nix = boardfaqVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = boardfaqVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

    String mu_site = boardfaqVO.getSrch_mu_site();
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;

    /*******************************
     * 탭메뉴 구성 처리 Start
     *******************************/

    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(srch_menu_nix);
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
    int subcnt = 0;

    if (menuVO == null)
      throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
                                                                                                   * 요청하신
                                                                                                   * 컨텐츠가
                                                                                                   * 존재하지
                                                                                                   * 않습니다
                                                                                                   * .
                                                                                                   */);
    model.addAttribute("nowMenuVO", menuVO);


    // 탭메뉴인 경우 탭메뉴 형제 탭메뉴 컨텐츠를 읽어온다.
    if ("Y".equals(menuVO.getTabmenu_yn())) {
      // 메뉴와 연관된 컨텐츠 목록을 직접 읽어오기 어려우므로
      // 이미 구성되어 세션에 저장된 메뉴목록에서 현재 탭으로 구성된 메뉴 목록을 구한다.
      // 메인페이지를 거치지 않고 주소 입력으로 바로 들어온 경우 세션에 메뉴구성이 되어있지 않으므로
      // 조회해서 메뉴목록을 가져온다.
      List sess_main_menu = null;

      if ("USR".equals(boardfaqVO.getSrch_mu_gub()) && "CDIDX00022".equals(mu_lang)) {
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
     * 탭메뉴 구성 처리 Start
     *******************************/
    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    // 요청하는 게시판 정보도 존재하지 않는 경우 잘못된 접근임
    if (boardfaqVO.getBrd_id() == null || "".equals(boardfaqVO.getBrd_id()))
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);


    /** 게시판 기본 정보 가져와서 저장하기 */
    BoardinfoVO brdinfoVO = new BoardinfoVO();
    brdinfoVO.setBrd_id(boardfaqVO.getBrd_id());
    brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

    if (brdinfoVO == null)
      throw new UnknownBoardException(
          MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
                                                                                   * 게시판 조회정보가
                                                                                   * 잘못되었습니다.
                                                                                   */);

    // 2018-04-26(pigcos) : Q형식이 아닌 CDIDX00043 형식으로
    if ("CDIDX00043".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_BRD_INFO");
    EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);


    /** pageing setting */
    PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
    paginationInfo.setContextPath(request.getContextPath());
    paginationInfo.setCurrentPageNo(boardfaqVO.getPageIndex());

    // 모바일 처리
    if ("CDIDX00003".equals(mu_site)) {
      paginationInfo.setRecordCountPerPage(10);
      paginationInfo.setPageSize(5);
    } else {
      paginationInfo.setRecordCountPerPage(brdinfoVO.getAtcl_per_pg());
      paginationInfo.setPageSize(brdinfoVO.getPg_per_navi());
    }

    boardfaqVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    boardfaqVO.setLastIndex(paginationInfo.getLastRecordIndex());
    boardfaqVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    boardfaqVO.setTbl_nm(brdinfoVO.getTbl_nm());

    boardfaqVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
    boardfaqVO.setUse_rjct(brdinfoVO.getUse_rjct());
    boardfaqVO.setReply_gb(brdinfoVO.getReply_gb());
    if ("Y".equals(brdinfoVO.getUse_notice())) {
      // 공지사항 목록 가져오기
      BoardfaqVO noticeVO = new BoardfaqVO();
      noticeVO.setIs_notice("Y");
      noticeVO.setBrd_id(brdinfoVO.getBrd_id());
      noticeVO.setTbl_nm(brdinfoVO.getTbl_nm());
      noticeVO.setSrch_ctgry_idx(boardfaqVO.getSrch_ctgry_idx());
      List noticeList = boardfaqService.selectBoardfaqList(noticeVO);
      model.addAttribute("noticeList", noticeList);
    }

    // 공지사항 제외 목록 가져오기
    boardfaqVO.setIs_notice("N");
    List boardfaqList = boardfaqService.selectBoardfaqList(boardfaqVO);
    model.addAttribute("resultList", boardfaqList);

    int totCnt = boardfaqService.selectBoardfaqListTotCnt(boardfaqVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    model.addAttribute("curPage", paginationInfo.getCurrentPageNo());
    model.addAttribute("totCnt", totCnt);
    model.addAttribute("totPage", paginationInfo.getTotalPageCount());

    // 카테고리 항목 조회
    if ("Y".equals(brdinfoVO.getUse_ctgry())) {
      SyscategoryVO ctgryVO = new SyscategoryVO();
      ctgryVO.setUp_ctgry_idx(brdinfoVO.getCtgry_idx());
      List ctgryList = syscategoryService.selectSyscategoryList(ctgryVO);
      model.addAttribute("ctgryList", ctgryList);
    }

    // 모바일 처리
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;

    else {
      // 관리자 처리
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
        if (user.getUser_auth_lv() > 100)
          throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

        returnUrl = "/metsys" + returnUrl;
      }

      else {
        if ("CDIDX00022".equals(mu_lang) == false) {
          returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
        }

      }
    }

    /*************************************************
     * 본인인증을 사용하는 경우 활성화 CheckPlusSafe safe = new CheckPlusSafe(); String hpData =
     * safe.getEncPlanData("M", "", ""); model.addAttribute("hpData", hpData);
     *
     *************************************************/

    return returnUrl;

  }



  /**
   * 수정/답글 페이지로 이동한다.
   * 
   * @param boardfaqVO : 등록할 정보가 담긴 VO
   * @return "/brdfaq/boardfaqList"
   * @exception Exception
   */
  @RequestMapping("/boardfaqMoveView")
  public String boardfaqMoveView(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, Model model) throws Exception {

    String returnUrl = "";
    String srch_menu_nix = boardfaqVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = boardfaqVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

    // 비로그인 사용자의 쓰기를 허용하지 않는다.
    if (user.getUser_auth_lv() > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    // ///////////////////////////////////////////////
    // 메뉴정보 조회
    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(srch_menu_nix);
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
    int subcnt = 0;

    if (menuVO == null)
      throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
                                                                                                   * 요청하신
                                                                                                   * 컨텐츠가
                                                                                                   * 존재하지
                                                                                                   * 않습니다
                                                                                                   * .
                                                                                                   */);
    model.addAttribute("nowMenuVO", menuVO);

    // 메뉴정보 조회
    // ///////////////////////////////////////////////

    SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
    String wdt = sm.format(new Date());

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

    // 요청하는 게시판 정보도 존재하지 않는 경우 잘못된 접근임
    if (boardfaqVO.getBrd_id() == null || "".equals(boardfaqVO.getBrd_id()))
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

    // 세션에 저장된 게시판 정보가 없는 경우 (주소에서 직접 치고 들어온 경우 또는 목록이 없어서 쓰기화면으로 바로들어가는 게시판)
    if (brdinfoVO == null || boardfaqVO.getBrd_id().equals(brdinfoVO.getBrd_id()) == false) {

      /** 게시판 기본 정보 가져와서 저장하기 */
      brdinfoVO = new BoardinfoVO();
      brdinfoVO.setBrd_id(boardfaqVO.getBrd_id());
      brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

      if (brdinfoVO == null)
        throw new UnknownBoardException(
            MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
                                                                                     * 게시판 조회정보가
                                                                                     * 잘못되었습니다.
                                                                                     */);

      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);
    }

    // 2018-04-26(pigcos) : Q형식이 아닌 CDIDX00043 형식으로
    if ("CDIDX00043".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    // 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    boardfaqVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardfaqVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
    boardfaqVO.setUse_rjct(brdinfoVO.getUse_rjct());

    if ("A".equals(boardfaqVO.getEdomweivgp())) {
      boardfaqVO.setWriter(user.getWriter());
      boardfaqVO.setWdt(wdt);
      model.addAttribute("atchfileListCount", 0);
      model.addAttribute("boardfaqVO", boardfaqVO);

      returnUrl = "/brdfaq/boardfaqWrite";

    } else {
      BoardfaqVO resultVO = boardfaqService.selectBoardfaq(boardfaqVO);
      if (resultVO == null)
        throw new CmmnException(MessageHelper.getMessage("THIS-POST-DOES-NOT-EXIST")/*
                                                                                     * 게시물이 존재하지
                                                                                     * 않습니다.
                                                                                     */);

      // 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 변경할 수 없다.
      if (user.getUser_auth_lv() > 1000 && resultVO.getWriter().equals(user.getUser_id()) == false)
        throw new CmmnException(
            MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-CHANGE-YOUR-POST")/*
                                                                                       * 게시글을 변경할
                                                                                       * 권한이 없습니다.
                                                                                       */);

      boardfaqVO.setWriter(resultVO.getWriter());
      boardfaqVO.setKogl(resultVO.getKogl());


      if ("M".equals(boardfaqVO.getEdomweivgp())) {
        AtchfileVO fileVO = new AtchfileVO();
        fileVO.setAtckey_1st(boardfaqVO.getBrd_id());
        fileVO.setAtckey_2nd(new Integer(boardfaqVO.getCont_idx()).toString());
        fileVO.setAtckey_3rd(1);
        List fileList = atchfileService.selectAtchfileList(fileVO);
        model.addAttribute("atchfileList", fileList);
        model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());

        returnUrl = "/brdfaq/boardfaqUpdate";


      } else if ("P".equals(boardfaqVO.getEdomweivgp())) {
        String subject = resultVO.getSubject();
        subject = "[Re.] " + subject;

        String brd_cont = resultVO.getBrd_cont();
        String reply_prefix = "&lt;p&gt;&lt;/p&gt;";
        reply_prefix += "&lt;p&gt;&lt;/p&gt;";
        reply_prefix += "&lt;p&gt;&lt;/p&gt;";
        reply_prefix += "&lt;p&gt;&lt;/p&gt;";
        reply_prefix +=
            "&lt;p&gt;----------------------------------- [ " + resultVO.getWriter_nm()
                + " ] 님의 메세지 -----------------------------------&lt;/p&gt;";
        reply_prefix += "&lt;p&gt;&gt;&lt;/p&gt;";
        reply_prefix += "&lt;p&gt;&gt;&lt;/p&gt;";

        brd_cont = brd_cont.replaceAll("&lt;p&gt;", "&lt;p&gt;&gt; ");
        brd_cont = brd_cont.replaceAll("&lt;div&gt;", "&lt;div&gt;&gt; ");
        brd_cont = brd_cont.replaceAll("&lt;br&gt;", "&lt;br&gt;&gt; ");
        brd_cont = brd_cont.replaceAll("&lt;br/&gt;", "&lt;br/&gt;&gt; ");

        resultVO.setSubject(subject);
        resultVO.setBrd_cont(reply_prefix + brd_cont);
        resultVO.setWriter(user.getWriter());
        resultVO.setWdt(wdt);

        model.addAttribute("atchfileListCount", 0);
        returnUrl = "/brdfaq/boardfaqWrite";

        // 원글이 비밀글이면 답글도 비밀글이고
        // 그 비밀번호는 원글과 동일하게 한다.
        resultVO.setIs_scrt(boardfaqVO.getIs_scrt());

      }

      resultVO.setEdomweivgp(boardfaqVO.getEdomweivgp());
      resultVO.setSrch_ctgry_idx(boardfaqVO.getSrch_ctgry_idx());
      resultVO.setPageIndex(boardfaqVO.getPageIndex());
      resultVO.setSeltab_idx(boardfaqVO.getSeltab_idx());
      resultVO.setSrch_mu_lang(boardfaqVO.getSrch_mu_lang());
      model.addAttribute("boardfaqVO", resultVO);

    }

    // 카테고리 항목 조회
    if ("Y".equals(brdinfoVO.getUse_ctgry())) {
      SyscategoryVO ctgryVO = new SyscategoryVO();
      ctgryVO.setUp_ctgry_idx(brdinfoVO.getCtgry_idx());
      List ctgryList = syscategoryService.selectSyscategoryList(ctgryVO);
      model.addAttribute("ctgryList", ctgryList);
    }

    // 모바일 처리
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;

    else {
      // 관리자 처리
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
        if (user.getUser_auth_lv() > 100)
          throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

        returnUrl = "/metsys" + returnUrl;
      }

      else {
        if ("CDIDX00022".equals(mu_lang) == false) {
          returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
        }

      }
    }

    return returnUrl;

  }


  /**
   * 작성완료 페이지로 이동한다.
   * 
   * @param boardfaqVO : 등록할 정보가 담긴 VO
   * @return "/brdfaq/boardfaqList"
   * @exception Exception
   */
  @RequestMapping("/boardComplete")
  public String boardComplete(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, Model model) throws Exception {

    return "/brdfaq/boardComplete";

  }



  /**
   * 항목을 상세 조회한다.
   * 
   * @param boardfaqVO : 조회할 정보
   * @return "/brdfaq/boardfaqView"
   * @exception Exception
   */
  @RequestMapping("/boardfaqView")
  public String boardfaqView(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    String returnUrl = "/brdfaq/boardfaqView";
    String srch_menu_nix = boardfaqVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = boardfaqVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");


    // ///////////////////////////////////////////////
    // 메뉴정보 조회
    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(srch_menu_nix);
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
    int subcnt = 0;

    if (menuVO == null)
      throw new CmmnException(MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
                                                                                                   * 요청하신
                                                                                                   * 컨텐츠가
                                                                                                   * 존재하지
                                                                                                   * 않습니다
                                                                                                   * .
                                                                                                   */);

    model.addAttribute("nowMenuVO", menuVO);
    // 메뉴정보 조회
    // ///////////////////////////////////////////////

    // 요청하는 게시판 정보도 존재하지 않는 경우 잘못된 접근임
    if (boardfaqVO.getBrd_id() == null || "".equals(boardfaqVO.getBrd_id()))
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

    // 세션에 저장된 게시판 정보 가져오기
    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

    // 세션에 저장된 게시판 정보가 없는 경우 (주소에서 직접 치고 들어온 경우)
    if (brdinfoVO == null || boardfaqVO.getBrd_id().equals(brdinfoVO.getBrd_id()) == false) {

      /** 게시판 기본 정보 가져와서 저장하기 */
      brdinfoVO = new BoardinfoVO();
      brdinfoVO.setBrd_id(boardfaqVO.getBrd_id());
      brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

      if (brdinfoVO == null)
        throw new UnknownBoardException(
            MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
                                                                                     * 게시판 조회정보가
                                                                                     * 잘못되었습니다.
                                                                                     */);

      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);
    }

    // 2018-04-26(pigcos) : Q형식이 아닌 CDIDX00043 형식으로
    if ("CDIDX00043".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);


    // 첨부파일 목록 가져오기
    AtchfileVO fileVO = new AtchfileVO();
    fileVO.setAtckey_1st(boardfaqVO.getBrd_id());
    fileVO.setAtckey_2nd(new Integer(boardfaqVO.getCont_idx()).toString());
    fileVO.setAtckey_3rd(1);
    List fileList = atchfileService.selectAtchfileList(fileVO);

    // 댓글을 사용하는 경우 댓글 가져오기
    if ("R".equals(brdinfoVO.getReply_gb()) || "B".equals(brdinfoVO.getReply_gb())) {
      // 댓글 목록 가져오기
      BoardreplyVO replyVO = new BoardreplyVO();
      replyVO.setBrd_id(boardfaqVO.getBrd_id());
      replyVO.setCont_idx(boardfaqVO.getCont_idx());
      replyVO.setTbl_nm(brdinfoVO.getTbl_nm());
      List replyList = boardreplyService.selectBoardreplyList(replyVO);

      model.addAttribute("replyList", replyList);
      model.addAttribute("replyCnt", (replyList == null) ? 0 : replyList.size());
    }

    boardfaqVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardfaqVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
    boardfaqVO.setUse_rjct(brdinfoVO.getUse_rjct());
    BoardfaqVO resultVO = boardfaqService.selectBoardfaq(boardfaqVO);

    if (resultVO == null)
      throw new CmmnException(MessageHelper.getMessage("THIS-POST-DOES-NOT-EXIST")/* 게시물이 존재하지 않습니다. */);


    if ("Y".equals(resultVO.getIs_scrt()) && "2".equals(brdinfoVO.getOff_viewmode()) == false) {
      // 관리자가 아니고, 글의 작성자가 아닌 경우
      if (user.getUser_auth_lv() > 1000 && resultVO.getWriter() != user.getUser_id())
        throw new CmmnException(
            MessageHelper.getMessage("SELECTED-POSTS-ARE-PRIVATE-AND-CAN-NOT-BE-VIEWED")/*
                                                                                         * 선택하신 게시물은
                                                                                         * 비공개이므로
                                                                                         * 조회하실 수
                                                                                         * 없습니다.
                                                                                         */);
    }


    int hits = resultVO.getHits() + 1;
    resultVO.setHits(hits);
    resultVO.setPageIndex(boardfaqVO.getPageIndex());
    resultVO.setEditor_gb(boardfaqVO.getEditor_gb());
    resultVO.setSearchCondition(boardfaqVO.getSearchCondition());
    resultVO.setSearchKeyword(boardfaqVO.getSearchKeyword());
    resultVO.setSrch_ctgry_idx(boardfaqVO.getSrch_ctgry_idx());
    resultVO.setSrch_mu_lang(boardfaqVO.getSrch_mu_lang());
    resultVO.setSeltab_idx(boardfaqVO.getSeltab_idx());

    int rcmndCnt = 0;
    int rjctCnt = 0;
    if ("Y".equals(brdinfoVO.getUse_rcmnd()) || "Y".equals(brdinfoVO.getUse_rjct())) {
      BoardrcmndVO boardrcmndVO = new BoardrcmndVO();
      boardrcmndVO.setBrd_id(boardfaqVO.getBrd_id());
      boardrcmndVO.setCont_idx(boardfaqVO.getCont_idx());
      boardrcmndVO.setRcmnd_gb("R");
      rcmndCnt = boardrcmndService.selectBoardrcmndListTotCnt(boardrcmndVO);

      boardrcmndVO.setRcmnd_gb("J");
      rjctCnt = boardrcmndService.selectBoardrcmndListTotCnt(boardrcmndVO);
    }

    model.addAttribute("rcmndCnt", rcmndCnt);
    model.addAttribute("rjctCnt", rjctCnt);
    model.addAttribute("boardfaqVO", resultVO);
    model.addAttribute("atchfileList", fileList);
    model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());

    // /////////////////////////
    // hits + 1
    boardfaqVO.setHits(hits);
    boardfaqService.updateBoardxcount(boardfaqVO);

    // 모바일 처리
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;

    else {
      // 관리자 처리
      if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
        if (user.getUser_auth_lv() > 100)
          throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

        returnUrl = "/metsys" + returnUrl;
      }

      else {
        if ("CDIDX00022".equals(mu_lang) == false) {
          returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
        }

      }
    }


    return returnUrl;
  }


  /**
   * 항목을 추가한다.
   * 
   * @param boardfaqVO : 추가할 정보
   * @return "/brdfaq/boardfaqView"
   * @exception Exception
   */
  @RequestMapping("/checkBoardfaqCaptcha")
  @ResponseBody
  public String checkBoardfaqCaptcha(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    String captchaId = request.getSession().getId();// 세션으로 정의함
    boolean isResponseCorrect = false;
    String captcha_val = boardfaqVO.getCaptcha_val();
    isResponseCorrect =
        CaptchaServiceSingleton.getInstance().validateResponseForID(captchaId, captcha_val);

    if (isResponseCorrect)
      return "SUCCESS";

    else
      return "FAIL";

  }


  /**
   * 항목을 추가한다.
   * 
   * @param boardfaqVO : 추가할 정보
   * @return "/brdfaq/boardfaqView"
   * @exception Exception
   */
  @RequestMapping("/addBoardfaq")
  @ResponseBody
  public String addBoardfaq(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 10000)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);
    }

    // 2018-04-26(pigcos) : Q형식이 아닌 CDIDX00043 형식으로
    if ("CDIDX00043".equals(brdinfoVO.getBrd_gb()) == false)
      throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    // 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    boardfaqVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardfaqVO.setWriter(user.getUser_id());
    boardfaqService.insertBoardfaq(boardfaqVO);
    // int key = boardfaqService.insertBoardfaq(boardfaqVO);
    int key = boardfaqVO.getCont_idx();
    return Integer.toString(key);

  }


  /**
   * 폼필드 파일을 업로드한다.
   * 
   * @param boardfaqVO : 추가할 정보
   * @return "/brdfaq/boardfaqView"
   * @exception Exception
   */
  @RequestMapping("/uploadBoardfaqForm")
  public String uploadBoardfaqForm(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);
    }

    // 2018-04-26(pigcos) : Q형식이 아닌 CDIDX00043 형식으로
    if ("CDIDX00043".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    // 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    boardfaqVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardfaqVO.setModifier(user.getUser_id());
    List linklist =
        atchfileService.uploadProcFormfiles(request, boardfaqVO.getBrd_id(),
            new Integer(boardfaqVO.getCont_idx()).toString(), 1, "GNR");

    // 내용에 이미지 추가하기를 선택한 경우
    if ("Y".equals(boardfaqVO.getChk_imgintocont())) {
      BoardfaqVO resultVO = boardfaqService.selectBoardfaq(boardfaqVO);
      if (resultVO == null)
        throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

      String cont = resultVO.getBrd_cont();

      for (int i = 0; i < linklist.size(); i++) {
        StringTokenizer stok = new StringTokenizer((String) linklist.get(i), "&");
        String[] org = new String[10];

        for (int j = 0; stok.hasMoreTokens(); j++) {
          org[j] = stok.nextToken();
        }

        if (org[0] == null)
          continue;

        // 이미지 등록인 경우 컨텐츠에 이미지를 삽입한다.
        if ("jpg|gif|bmp|png".indexOf(org[5]) >= 0) {
          cont += "&lt;p class=\"cls_center\"&gt;";
          cont +=
              "&lt;img src='" + request.getContextPath() + "/atchfile/imageAtchfile.do?vchkcode="
                  + org[4] + "' width='95%' /&gt;";
          cont += "&lt;/p&gt;";
        }
        // 그외의 경우 링크를 주석으로 삽입한다.
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

      resultVO.setTbl_nm(boardfaqVO.getTbl_nm());
      resultVO.setBrd_cont(cont);
      resultVO.setModifier(resultVO.getWriter());
      boardfaqService.updateBoardfaq(resultVO);
    }

    return "redirect:/brdfaq/boardfaqList." + ext + "?srch_menu_nix="
        + boardfaqVO.getSrch_menu_nix() + "&brd_id=" + boardfaqVO.getBrd_id() + "&seltab_idx="
        + boardfaqVO.getSeltab_idx() + "&pageIndex=" + boardfaqVO.getPageIndex();
  }


  /**
   * 항목을 삭제한다.
   * 
   * @param boardfaqVO : 삭제할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/rmvBoardfaq")
  public String rmvBoardfaq(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    String srch_menu_nix = boardfaqVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);
    }

    // 2018-04-26(pigcos) : Q형식이 아닌 CDIDX00043 형식으로
    if ("CDIDX00043".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    // 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    // 삭제대상 게시물 조회
    boardfaqVO.setTbl_nm(brdinfoVO.getTbl_nm());
    BoardfaqVO compVO = boardfaqService.selectBoardfaq(boardfaqVO);

    if (compVO == null)
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-FIND-DATA-TO-DELETE")/*
                                                                                      * 삭제할 데이터를 찾을
                                                                                      * 수 없습니다.
                                                                                      */);

    // 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 삭제할 수 없다.
    if (user.getUser_auth_lv() > 1000 && compVO.getWriter().equals(user.getUser_id()) == false)
      throw new CmmnException(
          MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-DELETE-THE-POST")/*
                                                                                    * 게시글을 삭제할 권한이
                                                                                    * 없습니다.
                                                                                    */);

    boardfaqService.deleteBoardfaq(boardfaqVO);

    return "redirect:/brdfaq/boardfaqList." + ext + "?srch_menu_nix="
        + boardfaqVO.getSrch_menu_nix() + "&brd_id=" + boardfaqVO.getBrd_id() + "&seltab_idx="
        + boardfaqVO.getSeltab_idx() + "&srch_mu_lang=" + boardfaqVO.getSrch_mu_lang();
  }


  /**
   * 글 (그룹 포함) 을/를 삭제한다. 글을 삭제했을때, 그 답글과 댓글을 함께 삭제한다.
   * 
   * @param boardfaqVO : 삭제할 정보
   * @exception Exception
   */
  @RequestMapping("/rmvBoardfaqgroup")
  public String rmvBoardfaqgroup(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, Model model) throws Exception {

    String srch_menu_nix = boardfaqVO.getSrch_menu_nix();
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 10000)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);
    }

    // 2018-04-26(pigcos) : Q형식이 아닌 CDIDX00043 형식으로
    if ("CDIDX00043".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    // 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    // 삭제대상 게시물 조회
    boardfaqVO.setTbl_nm(brdinfoVO.getTbl_nm());
    BoardfaqVO compVO = boardfaqService.selectBoardfaq(boardfaqVO);
    if (compVO == null)
      throw new CmmnException(MessageHelper.getMessage("CAN-NOT-FIND-DATA-TO-DELETE")/*
                                                                                      * 삭제할 데이터를 찾을
                                                                                      * 수 없습니다.
                                                                                      */);

    // 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 삭제할 수 없다.
    if (user.getUser_auth_lv() > 1000 && compVO.getWriter().equals(user.getUser_id()) == false)
      throw new CmmnException(
          MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-DELETE-THE-POST")/*
                                                                                    * 게시글을 삭제할 권한이
                                                                                    * 없습니다.
                                                                                    */);

    boardfaqService.deleteBoardfaqgroup(boardfaqVO);

    return "redirect:/brdfaq/boardfaqList." + ext + "?srch_menu_nix="
        + boardfaqVO.getSrch_menu_nix() + "&brd_id=" + boardfaqVO.getBrd_id() + "&seltab_idx="
        + boardfaqVO.getSeltab_idx();
  }


  /**
   * 게시물 항목을 수정한다.
   * 
   * @param boardfaqVO : 수정할 정보
   * @return "/cnslreq/cnslreqView"
   * @exception Exception
   */
  @RequestMapping("/mdfBoardfaq")
  @ResponseBody
  public String mdfBoardfaq(@ModelAttribute("boardfaqVO") BoardfaqVO boardfaqVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (user.getUser_auth_lv() > 10000)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);
    }

    // 2018-04-26(pigcos) : Q형식이 아닌 CDIDX00043 형식으로
    if ("CDIDX00043".equals(brdinfoVO.getBrd_gb()) == false)
      throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    // 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
    if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    boardfaqVO.setTbl_nm(brdinfoVO.getTbl_nm());
    boardfaqVO.setModifier(user.getUser_id());

    // 변경대상 게시물 조회
    BoardfaqVO compVO = boardfaqService.selectBoardfaq(boardfaqVO);
    if (compVO == null)
      throw new AjaxException(MessageHelper.getMessage("COULD-NOT-FIND-THE-DATA-TO-CHANGE")/*
                                                                                            * 변경할
                                                                                            * 데이터를
                                                                                            * 찾을 수
                                                                                            * 없습니다.
                                                                                            */);

    // 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 변경할 수 없다.
    if (user.getUser_auth_lv() > 1000 && compVO.getWriter().equals(user.getUser_id()) == false)
      throw new AjaxException(
          MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-CHANGE-YOUR-POST")/*
                                                                                     * 게시글을 변경할 권한이
                                                                                     * 없습니다.
                                                                                     */);

    boardfaqService.updateBoardfaq(boardfaqVO);
    return Integer.toString(boardfaqVO.getCont_idx());

  }



}
