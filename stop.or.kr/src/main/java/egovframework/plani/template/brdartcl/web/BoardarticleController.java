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
import egovframework.plani.template.brdartcl.service.BoardarticleService;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.service.BoardrcmndService;
import egovframework.plani.template.brdartcl.service.BoardreplyService;
import egovframework.plani.template.brdartcl.vo.BoardExtraVO;
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.brdartcl.vo.BoardrcmndVO;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.exceptions.UnknownBoardException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.CommonUtil;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.cmm.utils.jcaptcha.CaptchaServiceSingleton;
import egovframework.plani.template.man.menuctgry.service.SyscategoryService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SyscategoryVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 게시판 관련 요청을 처리함
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.web]
 *        [BoardarticleController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:57:50
 * @version : 1.0
 */
@Controller
@RequestMapping("/brdartcl")
public class BoardarticleController {

	/** BoardrcmndService */
	@Resource(name = "boardrcmndService")
	private BoardrcmndService boardrcmndService;

	/** BoardarticleService */
	@Resource(name = "boardarticleService")
	private BoardarticleService boardarticleService;

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

	/** Gson */
	@Resource(name = "gson")
	protected Gson gson;

	/**
	 * 목록을 조회한다.
	 * 
	 * @param boardarticleVO
	 *            : 등록할 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return "/brdartcl/boardarticleList"
	 * @exception Exception
	 */
	@RequestMapping("/boardarticleList")
	public String boardarticleList(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, Model model) throws Exception {

		String returnUrl = "/brdartcl/boardarticleList";
		String srch_menu_nix = boardarticleVO.getSrch_menu_nix();
		String ext = EgovWebUtil.getExtension(request.getRequestURI());

		String mu_lang = boardarticleVO.getSrch_mu_lang();
		mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;
		mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_lang);//20191108 취약점 조치 추가

		String mu_site = boardarticleVO.getSrch_mu_site();
		mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
		mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;
		mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_site);//20191108 취약점 조치 추가

		/*******************************
		 * 탭메뉴 구성 처리 Start
		 *******************************/

		SysmenuVO menuVO = new SysmenuVO();
		menuVO.setSrch_menu_nix(srch_menu_nix);
		menuVO = sysmenuService.selectSysmenu(menuVO);
		String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
		int subcnt = 0;

		if (menuVO == null)
			throw new CmmnException(MessageHelper.getMessage(
					"THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
																 * 요청하신 컨텐츠가
																 * 존재하지 않습니다 .
																 */);
		model.addAttribute("nowMenuVO", menuVO);

		// 탭메뉴인 경우 탭메뉴 형제 탭메뉴 컨텐츠를 읽어온다.
		if ("Y".equals(menuVO.getTabmenu_yn())) {
			// 메뉴와 연관된 컨텐츠 목록을 직접 읽어오기 어려우므로
			// 이미 구성되어 세션에 저장된 메뉴목록에서 현재 탭으로 구성된 메뉴 목록을 구한다.
			// 메인페이지를 거치지 않고 주소 입력으로 바로 들어온 경우 세션에 메뉴구성이 되어있지 않으므로
			// 조회해서 메뉴목록을 가져온다.
			List sess_main_menu = null;

			if ("USR".equals(boardarticleVO.getSrch_mu_gub()) && "CDIDX00022".equals(mu_lang)) {
				if ("CDIDX00002".equals(mu_site))
					sess_main_menu = (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MAIN_MENU");

				else if ("CDIDX00003".equals(mu_site))
					sess_main_menu = (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MBL_MENU");
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
		if (boardarticleVO.getBrd_id() == null || "".equals(boardarticleVO.getBrd_id()))
			throw new CmmnException(MessageHelper
					.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

		/** 게시판 기본 정보 가져와서 저장하기 */
		BoardinfoVO brdinfoVO = new BoardinfoVO();
		brdinfoVO.setBrd_id(boardarticleVO.getBrd_id());
		brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

		if (brdinfoVO == null)
			throw new UnknownBoardException(MessageHelper.getMessage(
					"BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
																	 * 게시판 조회정보가
																	 * 잘못되었습니다.
																	 */);

		if ("CDIDX00042".equals(brdinfoVO.getBrd_gb()) == false)
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);

		EgovSessionCookieUtil.removeSessionAttribute(request, "SESS_BRD_INFO");
		EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);

		/* 게시판 여분 필드 정보 모델에 담기 */
		// Gson gson = new Gson();
		BoardExtraVO extra1_array = gson.fromJson((String) brdinfoVO.getExtra1(), BoardExtraVO.class);
		model.addAttribute("extra1_array", extra1_array);
		BoardExtraVO extra2_array = gson.fromJson((String) brdinfoVO.getExtra2(), BoardExtraVO.class);
		model.addAttribute("extra2_array", extra2_array);

		/** pageing setting */
		PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
		paginationInfo.setContextPath(request.getContextPath());
		paginationInfo.setCurrentPageNo(boardarticleVO.getPageIndex());

		// 모바일 처리
		if ("CDIDX00003".equals(mu_site)) {
			paginationInfo.setRecordCountPerPage(10);
			paginationInfo.setPageSize(5);
		} else {
			paginationInfo.setRecordCountPerPage(brdinfoVO.getAtcl_per_pg());
			paginationInfo.setPageSize(brdinfoVO.getPg_per_navi());
		}

		boardarticleVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardarticleVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardarticleVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());

		boardarticleVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
		boardarticleVO.setUse_rjct(brdinfoVO.getUse_rjct());
		boardarticleVO.setReply_gb(brdinfoVO.getReply_gb());
		if ("Y".equals(brdinfoVO.getUse_notice())) {
			// 공지사항 목록 가져오기
			BoardarticleVO noticeVO = new BoardarticleVO();
			noticeVO.setIs_notice("Y");
			noticeVO.setBrd_id(brdinfoVO.getBrd_id());
			noticeVO.setTbl_nm(brdinfoVO.getTbl_nm());
			noticeVO.setSrch_ctgry_idx(boardarticleVO.getSrch_ctgry_idx());
			List noticeList = boardarticleService.selectBoardarticleList(noticeVO);
			model.addAttribute("noticeList", noticeList);
		}

		// 공지사항 제외 목록 가져오기
		boardarticleVO.setIs_notice("N");
		/* 20180514-ych 댓글테이블 셋팅 */
		if (brdinfoVO.getReply_gb().equals("R") || brdinfoVO.getReply_gb().equals("B")) {
			boardarticleVO.setReply_tbl_nm("CMS_BRD_REPLY_IDX_VXD5L880");
		}
		List boardarticleList = boardarticleService.selectBoardarticleList(boardarticleVO);
		model.addAttribute("resultList", boardarticleList);

		int totCnt = boardarticleService.selectBoardarticleListTotCnt(boardarticleVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("curPage", paginationInfo.getCurrentPageNo());
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("totPage", paginationInfo.getTotalPageCount());

		// 카테고리 항목 조회
		if ("Y".equals(brdinfoVO.getUse_ctgry())) {
			SyscategoryVO ctgryVO = new SyscategoryVO();
			ctgryVO.setUse_yn("Y");
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
					throw new CmmnException(MessageHelper.getMessage(
							"INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

				returnUrl = "/metsys" + returnUrl;
			}

			else {

				// 2018-05-01(pigcos) : 다국어처리
				returnUrl = "/brdartcl/boardarticleList";
				if ("CDIDX00022".equals(mu_lang) == false) {
					returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
				}

			}
		}

		/*************************************************
		 * 본인인증을 사용하는 경우 활성화 CheckPlusSafe safe = new CheckPlusSafe(); String
		 * hpData = safe.getEncPlanData("M", "", "");
		 * model.addAttribute("hpData", hpData);
		 *
		 *************************************************/
System.out.println("returnUrl##"+returnUrl);
		// return returnUrl;
		return CommonUtil.getViewPageUrl(returnUrl);

	}

	/**
	 * 게시판 validation get과 post에서 둘다 필요한 부분
	 * 
	 * @throws Exception
	 * 
	 * 
	 */

	public String article_moveview_common(BoardarticleVO boardarticleVO, Model model, HttpServletRequest request)
			throws Exception {

		String returnUrl = "";
		String srch_menu_nix = boardarticleVO.getSrch_menu_nix();
		String ext = EgovWebUtil.getExtension(request.getRequestURI());

		String mu_lang = boardarticleVO.getSrch_mu_lang();
		mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

		// System.out.println(mu_lang);
		MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

		// 비로그인 사용자의 쓰기를 허용하지 않는다.
		if (user.getUser_auth_lv() > 10000)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		// ///////////////////////////////////////////////
		// 메뉴정보 조회
		SysmenuVO menuVO = new SysmenuVO();
		menuVO.setSrch_menu_nix(srch_menu_nix);
		menuVO = sysmenuService.selectSysmenu(menuVO);
		String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
		int subcnt = 0;

		if (menuVO == null)
			throw new CmmnException(MessageHelper.getMessage(
					"THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
																 * 요청하신 컨텐츠가
																 * 존재하지 않습니다 .
																 */);
		model.addAttribute("nowMenuVO", menuVO);

		// 메뉴정보 조회
		// ///////////////////////////////////////////////

		SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
		String wdt = sm.format(new Date());
		String writer = user.getUser_id();

		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

		// 요청하는 게시판 정보도 존재하지 않는 경우 잘못된 접근임
		if (boardarticleVO.getBrd_id() == null || "".equals(boardarticleVO.getBrd_id()))
			throw new CmmnException(MessageHelper
					.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

		/* 게시판 여분 필드 정보 모델에 담기 */
		// Gson gson = new Gson();
		BoardExtraVO extra1_array = gson.fromJson((String) brdinfoVO.getExtra1(), BoardExtraVO.class);
		model.addAttribute("extra1_array", extra1_array);
		BoardExtraVO extra2_array = gson.fromJson((String) brdinfoVO.getExtra2(), BoardExtraVO.class);
		model.addAttribute("extra2_array", extra2_array);

		// 세션에 저장된 게시판 정보가 없는 경우 (주소에서 직접 치고 들어온 경우 또는 목록이 없어서 쓰기화면으로 바로들어가는
		// 게시판)
		if (brdinfoVO == null || boardarticleVO.getBrd_id().equals(brdinfoVO.getBrd_id()) == false) {

			/** 게시판 기본 정보 가져와서 저장하기 */
			brdinfoVO = new BoardinfoVO();
			brdinfoVO.setBrd_id(boardarticleVO.getBrd_id());
			brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

			if (brdinfoVO == null)
				throw new UnknownBoardException(
						MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
																								 * 게시판
																								 * 조회정보가
																								 * 잘못되었습니다.
																								 */);

			EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);
		}

		if ("CDIDX00042".equals(brdinfoVO.getBrd_gb()) == false)
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);

		// 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
		if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		boardarticleVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
		boardarticleVO.setUse_rjct(brdinfoVO.getUse_rjct());

		if ("A".equals(boardarticleVO.getEdomweivgp())) {
			boardarticleVO.setWriter(writer);
			boardarticleVO.setWdt(wdt);
			model.addAttribute("atchfileListCount", 0);
			model.addAttribute("boardarticleVO", boardarticleVO);

			returnUrl = "/brdartcl/boardarticleWrite";

		} else {
			BoardarticleVO resultVO = boardarticleService.selectBoardarticle(boardarticleVO);
			if (resultVO == null)
				throw new CmmnException(MessageHelper.getMessage(
						"THIS-POST-DOES-NOT-EXIST")/*
													 * 게시물이 존재하지 않습니다.
													 */);

			// 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 변경할 수 없다.
			if (user.getUser_auth_lv() > 1000 && resultVO.getWriter().equals(user.getUser_id()) == false)
				throw new CmmnException(MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-CHANGE-YOUR-POST")/*
																													 * 게시글을
																													 * 변경할
																													 * 권한이
																													 * 없습니다.
																													 */);

			boardarticleVO.setWriter(resultVO.getWriter());
			boardarticleVO.setKogl(resultVO.getKogl());

			if ("M".equals(boardarticleVO.getEdomweivgp())) {
				AtchfileVO fileVO = new AtchfileVO();
				fileVO.setAtckey_1st(boardarticleVO.getBrd_id());
				fileVO.setAtckey_2nd(new Integer(boardarticleVO.getCont_idx()).toString());
				fileVO.setAtckey_3rd(1);
				List fileList = atchfileService.selectAtchfileList(fileVO);
				model.addAttribute("atchfileList", fileList);
				model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());

				returnUrl = "/brdartcl/boardarticleUpdate";

			} else if ("P".equals(boardarticleVO.getEdomweivgp())) {
				String subject = resultVO.getSubject();
				subject = "[Re.] " + subject;

				String brd_cont = resultVO.getBrd_cont();
				String reply_prefix = "&lt;p&gt;&lt;/p&gt;";
				reply_prefix += "&lt;p&gt;&lt;/p&gt;";
				reply_prefix += "&lt;p&gt;&lt;/p&gt;";
				reply_prefix += "&lt;p&gt;&lt;/p&gt;";
				reply_prefix += "&lt;p&gt;----------------------------------- [ " + resultVO.getWriter_nm()
						+ " ] 님의 메세지 -----------------------------------&lt;/p&gt;";
				reply_prefix += "&lt;p&gt;&gt;&lt;/p&gt;";
				reply_prefix += "&lt;p&gt;&gt;&lt;/p&gt;";

				brd_cont = brd_cont.replaceAll("&lt;p&gt;", "&lt;p&gt;&gt; ");
				brd_cont = brd_cont.replaceAll("&lt;div&gt;", "&lt;div&gt;&gt; ");
				brd_cont = brd_cont.replaceAll("&lt;br&gt;", "&lt;br&gt;&gt; ");
				brd_cont = brd_cont.replaceAll("&lt;br/&gt;", "&lt;br/&gt;&gt; ");

				resultVO.setSubject(subject);
				resultVO.setBrd_cont(reply_prefix + brd_cont);
				resultVO.setWriter(writer);
				resultVO.setWdt(wdt);

				model.addAttribute("atchfileListCount", 0);
				returnUrl = "/brdartcl/boardarticleWrite";

				// 원글이 비밀글이면 답글도 비밀글이고
				// 그 비밀번호는 원글과 동일하게 한다.
				resultVO.setIs_scrt(boardarticleVO.getIs_scrt());

			}

			resultVO.setEdomweivgp(boardarticleVO.getEdomweivgp());
			resultVO.setSrch_ctgry_idx(boardarticleVO.getSrch_ctgry_idx());
			resultVO.setPageIndex(boardarticleVO.getPageIndex());
			resultVO.setSeltab_idx(boardarticleVO.getSeltab_idx());
			resultVO.setSrch_mu_lang(boardarticleVO.getSrch_mu_lang());
			model.addAttribute("boardarticleVO", resultVO);

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
					throw new CmmnException(MessageHelper.getMessage(
							"INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

				returnUrl = "/metsys" + returnUrl;
			}

			else {

				returnUrl = "/brdartcl/boardarticleWrite";
				// if ("CDIDX00022".equals(mu_lang) == false) {
				// returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
				// }

			}
		}

		return returnUrl;

	}

	/**
	 * 수정/답글 페이지로 이동한다.
	 * 
	 * @param boardarticleVO
	 *            : 등록할 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return "/brdartcl/boardarticleWrite"
	 * @exception Exception
	 */
	@RequestMapping(value = "/boardarticleMoveView", method = RequestMethod.GET)
	public String boardarticleMoveView(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, Model model) throws Exception {
		String returnUrl = article_moveview_common(boardarticleVO, model, request);

		System.out.println("return url : " + CommonUtil.getViewPageUrl(returnUrl));
		// return returnUrl;
		return CommonUtil.getViewPageUrl(returnUrl);

	}

	/* add가 일어나는 부분 */
	@RequestMapping(value = "/boardarticleMoveView", method = RequestMethod.POST)
	@ResponseBody
	public Object boardarticleMoveView(
			@Validated({ ValidationBoardAdd.class, ValidationBoardModify.class }) BoardarticleVO boardarticleVO,
			BindingResult result, HttpServletRequest request, Model model) throws Exception {

		/* 공통요소 체킹하고 url 얻어오기 */
		String returnUrl = article_moveview_common(boardarticleVO, model, request);

		/* validation 적용하기 */
		ResponseResultHelper responseResultHelper = new ResponseResultHelper(request, returnUrl);

		// 유효성 검사
		if (result.hasErrors()) {
			return responseResultHelper.validation(result);
		}

		MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");

		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		if (boardarticleVO.getCont_idx() == 0) {
			boardarticleVO.setWriter(user.getUser_id());
			boardarticleService.insertBoardarticle(boardarticleVO);
		} else {
			boardarticleVO.setModifier(user.getUser_id());
			boardarticleService.updateBoardarticle(boardarticleVO);
		}
		List id = new ArrayList();
		id.add(boardarticleVO.getCont_idx());

		return responseResultHelper.success(null, null, null, id);

	}

	/**
	 * 작성완료 페이지로 이동한다.
	 * 
	 * @param boardarticleVO
	 *            : 등록할 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return "/brdartcl/boardComplete"
	 * @exception Exception
	 */
	@RequestMapping("/boardComplete")
	public String boardComplete(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, Model model) throws Exception {

		return "/brdartcl/boardComplete";

	}

	/**
	 * 항목을 상세 조회한다.
	 * 
	 * @param boardarticleVO
	 *            : 조회할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/boardarticleView")
	public String boardarticleView(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		String returnUrl = "/brdartcl/boardarticleView";
		String srch_menu_nix = boardarticleVO.getSrch_menu_nix();
		String ext = EgovWebUtil.getExtension(request.getRequestURI());

		String mu_lang = boardarticleVO.getSrch_mu_lang();
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
			throw new CmmnException(MessageHelper.getMessage(
					"THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
																 * 요청하신 컨텐츠가
																 * 존재하지 않습니다 .
																 */);

		model.addAttribute("nowMenuVO", menuVO);
		// 메뉴정보 조회
		// ///////////////////////////////////////////////

		// 요청하는 게시판 정보도 존재하지 않는 경우 잘못된 접근임
		if (boardarticleVO.getBrd_id() == null || "".equals(boardarticleVO.getBrd_id()))
			throw new CmmnException(MessageHelper
					.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

		// 세션에 저장된 게시판 정보 가져오기
		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

		// 세션에 저장된 게시판 정보가 없는 경우 (주소에서 직접 치고 들어온 경우)
		if (brdinfoVO == null || boardarticleVO.getBrd_id().equals(brdinfoVO.getBrd_id()) == false) {

			/** 게시판 기본 정보 가져와서 저장하기 */
			brdinfoVO = new BoardinfoVO();
			brdinfoVO.setBrd_id(boardarticleVO.getBrd_id());
			brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

			if (brdinfoVO == null)
				throw new UnknownBoardException(
						MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
																								 * 게시판
																								 * 조회정보가
																								 * 잘못되었습니다.
																								 */);

			EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);
		}

		if ("CDIDX00042".equals(brdinfoVO.getBrd_gb()) == false)
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);

		/* 2018-05-16 ych 로그인자 권한처리 */
		if ("0".equals(brdinfoVO.getOn_viewmode()) == true && user.getUser_auth_lv() > 1000
				&& user.getUser_auth_lv() < 10000) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		/* 2018-05-16 ych 비로그인자권한처리 */
		if ("0".equals(brdinfoVO.getOff_viewmode()) == true && user.getUser_auth_lv() > 10000) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		/* 게시판 여분 필드 정보 모델에 담기 */
		// Gson gson = new Gson();
		BoardExtraVO extra1_array = gson.fromJson((String) brdinfoVO.getExtra1(), BoardExtraVO.class);
		model.addAttribute("extra1_array", extra1_array);
		BoardExtraVO extra2_array = gson.fromJson((String) brdinfoVO.getExtra2(), BoardExtraVO.class);
		model.addAttribute("extra2_array", extra2_array);

		// 첨부파일 목록 가져오기
		AtchfileVO fileVO = new AtchfileVO();
		fileVO.setAtckey_1st(boardarticleVO.getBrd_id());
		fileVO.setAtckey_2nd(new Integer(boardarticleVO.getCont_idx()).toString());
		fileVO.setAtckey_3rd(1);
		System.out.println("filevo" + fileVO);
		List fileList = atchfileService.selectAtchfileList(fileVO);

		// 댓글을 사용하는 경우 댓글 가져오기
		if ("R".equals(brdinfoVO.getReply_gb()) || "B".equals(brdinfoVO.getReply_gb())) {
			// 댓글 목록 가져오기
			BoardreplyVO replyVO = new BoardreplyVO();
			replyVO.setBrd_id(boardarticleVO.getBrd_id());
			replyVO.setCont_idx(boardarticleVO.getCont_idx());
			replyVO.setTbl_nm(brdinfoVO.getTbl_nm());
			List replyList = boardreplyService.selectBoardreplyList(replyVO);

			model.addAttribute("replyList", replyList);
			model.addAttribute("replyCnt", (replyList == null) ? 0 : replyList.size());
		}

		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		boardarticleVO.setUse_rcmnd(brdinfoVO.getUse_rcmnd());
		boardarticleVO.setUse_rjct(brdinfoVO.getUse_rjct());
		BoardarticleVO resultVO = boardarticleService.selectBoardarticle(boardarticleVO);

		if (resultVO == null)
			throw new CmmnException(MessageHelper
					.getMessage("THIS-POST-DOES-NOT-EXIST")/* 게시물이 존재하지 않습니다. */);

		if ("Y".equals(resultVO.getIs_scrt()) && "2".equals(brdinfoVO.getOff_viewmode()) == false) {
			// 관리자가 아니고, 글의 작성자가 아닌 경우
			if (user.getUser_auth_lv() > 1000 && resultVO.getWriter().equals(user.getUser_id()) == false)

				// 자신이 쓴 글에 대한 답글은 자신이 쓴글이 아니어도 확인 가능하다.
				if (resultVO.getGrp_lv() > 1) {
					// 현재 게시물과 같은 그룹내에 자신이 작성한 글이 있으면
					// 그 그룹에 해당하는 글은 비공개여도 확인 가능하도록 한다.
					BoardarticleVO twVO = new BoardarticleVO();
					twVO.setGrp_no(resultVO.getGrp_no());
					twVO.setTbl_nm(brdinfoVO.getTbl_nm());
					twVO.setBrd_id(resultVO.getBrd_id());
					twVO.setWriter(user.getUser_id());
					int wcnt = boardarticleService.selectBoardarticleGrpwriterCnt(twVO);

					if (wcnt == 0)
						throw new CmmnException(
								MessageHelper.getMessage("SELECTED-POSTS-ARE-PRIVATE-AND-CAN-NOT-BE-VIEWED")/*
																											 * 선택하신
																											 * 게시물은
																											 * 비공개이므로
																											 * 조회하실
																											 * 수
																											 * 없습니다.
																											 */);

				} else
					throw new CmmnException(
							MessageHelper.getMessage("SELECTED-POSTS-ARE-PRIVATE-AND-CAN-NOT-BE-VIEWED")/*
																										 * 선택하신
																										 * 게시물은
																										 * 비공개이므로
																										 * 조회하실
																										 * 수
																										 * 없습니다.
																										 */);

		}

		int hits = resultVO.getHits() + 1;
		resultVO.setHits(hits);
		resultVO.setPageIndex(boardarticleVO.getPageIndex());
		resultVO.setEditor_gb(boardarticleVO.getEditor_gb());
		resultVO.setSearchCondition(boardarticleVO.getSearchCondition());
		resultVO.setSearchKeyword(boardarticleVO.getSearchKeyword());
		resultVO.setSrch_ctgry_idx(boardarticleVO.getSrch_ctgry_idx());
		resultVO.setSrch_mu_lang(boardarticleVO.getSrch_mu_lang());
		resultVO.setSeltab_idx(boardarticleVO.getSeltab_idx());

		int rcmndCnt = 0;
		int rjctCnt = 0;
		if ("Y".equals(brdinfoVO.getUse_rcmnd()) || "Y".equals(brdinfoVO.getUse_rjct())) {
			BoardrcmndVO boardrcmndVO = new BoardrcmndVO();
			boardrcmndVO.setBrd_id(boardarticleVO.getBrd_id());
			boardrcmndVO.setCont_idx(boardarticleVO.getCont_idx());
			boardrcmndVO.setRcmnd_gb("R");
			rcmndCnt = boardrcmndService.selectBoardrcmndListTotCnt(boardrcmndVO);

			boardrcmndVO.setRcmnd_gb("J");
			rjctCnt = boardrcmndService.selectBoardrcmndListTotCnt(boardrcmndVO);
		}

		model.addAttribute("rcmndCnt", rcmndCnt);
		model.addAttribute("rjctCnt", rjctCnt);
		model.addAttribute("boardarticleVO", resultVO);
		model.addAttribute("atchfileList", fileList);
		model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());

		// /////////////////////////
		// hits + 1
		boardarticleVO.setHits(hits);
		boardarticleService.updateBoardxcount(boardarticleVO);

		// 모바일 처리
		if ("mdo".equals(ext))
			returnUrl = "/mbl" + returnUrl;

		else {
			// 관리자 처리
			if ("794x409U|wZ311Dfx|IR3T73EE".indexOf(srch_menu_nix) >= 0) {
				if (user.getUser_auth_lv() > 100)
					throw new CmmnException(MessageHelper.getMessage(
							"INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

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
	 * 항목을 추가한다.
	 * 
	 * @param boardarticleVO
	 *            : 추가할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/checkBoardarticleCaptcha")
	@ResponseBody
	public String checkBoardarticleCaptcha(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		String captchaId = request.getSession().getId();// 세션으로 정의함
		boolean isResponseCorrect = false;
		String captcha_val = boardarticleVO.getCaptcha_val();
		isResponseCorrect = CaptchaServiceSingleton.getInstance().validateResponseForID(captchaId, captcha_val);

		if (isResponseCorrect)
			return "SUCCESS";

		else
			return "FAIL";

	}

	/**
	 * 항목을 추가한다.
	 * 
	 * @param boardarticleVO
	 *            : 추가할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/addBoardarticle")
	@ResponseBody
	public String addBoardarticle(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
		if (user.getUser_auth_lv() > 10000)
			throw new AjaxException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
		if (brdinfoVO == null) {
			throw new AjaxException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);
		}

		if ("CDIDX00042".equals(brdinfoVO.getBrd_gb()) == false)
			throw new AjaxException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);

		// 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
		if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
			throw new AjaxException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		boardarticleVO.setWriter(user.getUser_id());
		// int key = boardarticleService.insertBoardarticle(boardarticleVO);
		boardarticleService.insertBoardarticle(boardarticleVO);
		int key = boardarticleVO.getCont_idx();
		return Integer.toString(key);

	}

	/**
	 * 폼필드 파일을 업로드한다.
	 * 
	 * @param boardarticleVO
	 *            : 추가할 정보
	 * @param request
	 * @param model
	 * @return "/brdartcl/boardarticleList"
	 * @exception Exception
	 */
	@RequestMapping("/uploadBoardarticleForm")
	public String uploadBoardarticleForm(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		String ext = EgovWebUtil.getExtension(request.getRequestURI());

		MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
		if (user.getUser_auth_lv() > 10000)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
		if (brdinfoVO == null) {
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);
		}

		if ("CDIDX00042".equals(brdinfoVO.getBrd_gb()) == false)
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);

		// 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
		if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		boardarticleVO.setModifier(user.getUser_id());
		List linklist = atchfileService.uploadProcFormfiles(request, boardarticleVO.getBrd_id(),
				new Integer(boardarticleVO.getCont_idx()).toString(), 1, "GNR");

		// 내용에 이미지 추가하기를 선택한 경우
		if ("Y".equals(boardarticleVO.getChk_imgintocont())) {
			BoardarticleVO resultVO = boardarticleService.selectBoardarticle(boardarticleVO);
			if (resultVO == null)
				throw new CmmnException(MessageHelper
						.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

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
					cont += "&lt;img src='" + request.getContextPath() + "/atchfile/imageAtchfile.do?vchkcode=" + org[4]
							+ "' width='95%' /&gt;";
					cont += "&lt;/p&gt;";
				}
				// 그외의 경우 링크를 주석으로 삽입한다.
				else if (org[5] != null && org[5].length() > 0) {
					cont += "&lt;!--";
					cont += "&lt;p&gt;";
					cont += "&lt;a href='javascript:cmmfn_download_atchfile('" + request.getContextPath() + "', '"
							+ org[4] + "')'&gt;" + org[6] + "&lt;/a&gt;";
					cont += "&lt;/p&gt;";
					cont += "--&gt;";
				}
			}

			resultVO.setTbl_nm(boardarticleVO.getTbl_nm());
			resultVO.setBrd_cont(cont);
			resultVO.setModifier(resultVO.getWriter());
			boardarticleService.updateBoardarticle(resultVO);
		}

		return "redirect:/brdartcl/boardarticleList." + ext + "?srch_menu_nix=" + boardarticleVO.getSrch_menu_nix()
				+ "&brd_id=" + boardarticleVO.getBrd_id() + "&seltab_idx=" + boardarticleVO.getSeltab_idx()
				+ "&pageIndex=" + boardarticleVO.getPageIndex();
	}

	/**
	 * 항목을 삭제한다.
	 * 
	 * @param boardarticleVO
	 *            : 삭제할 정보
	 * @param request
	 * @param model
	 * @return "/brdartcl/boardarticleList"
	 * @exception Exception
	 */
	@RequestMapping("/rmvBoardarticle")
	public String rmvBoardarticle(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		String srch_menu_nix = boardarticleVO.getSrch_menu_nix();
		String ext = EgovWebUtil.getExtension(request.getRequestURI());

		MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
		if (user.getUser_auth_lv() > 10000)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
		if (brdinfoVO == null) {
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);
		}

		if ("CDIDX00042".equals(brdinfoVO.getBrd_gb()) == false)
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);

		// 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
		if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		// 삭제대상 게시물 조회
		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		BoardarticleVO compVO = boardarticleService.selectBoardarticle(boardarticleVO);

		if (compVO == null)
			throw new CmmnException(MessageHelper.getMessage(
					"CAN-NOT-FIND-DATA-TO-DELETE")/*
													 * 삭제할 데이터를 찾을 수 없습니다.
													 */);

		// 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 삭제할 수 없다.
		if (user.getUser_auth_lv() > 1000 && compVO.getWriter().equals(user.getUser_id()) == false)
			throw new CmmnException(MessageHelper.getMessage(
					"YOU-DO-NOT-HAVE-PERMISSION-TO-DELETE-THE-POST")/*
																	 * 게시글을 삭제할
																	 * 권한이 없습니다.
																	 */);

		boardarticleService.deleteBoardarticle(boardarticleVO);

		return "redirect:/brdartcl/boardarticleList." + ext + "?srch_menu_nix=" + boardarticleVO.getSrch_menu_nix()
				+ "&brd_id=" + boardarticleVO.getBrd_id() + "&seltab_idx=" + boardarticleVO.getSeltab_idx()
				+ "&srch_mu_lang=" + boardarticleVO.getSrch_mu_lang() + "&srch_mu_site="
				+ boardarticleVO.getSrch_mu_site();
	}

	/**
	 * 글 (그룹 포함) 을/를 삭제한다. 글을 삭제했을때, 그 답글과 댓글을 함께 삭제한다.
	 * 
	 * @param boardarticleVO
	 *            : 삭제할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 * @return '/brdartcl/boardarticleList'
	 */
	@RequestMapping("/rmvBoardarticlegroup")
	public String rmvBoardarticlegroup(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, Model model) throws Exception {

		String srch_menu_nix = boardarticleVO.getSrch_menu_nix();
		String ext = EgovWebUtil.getExtension(request.getRequestURI());

		MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
		if (user.getUser_auth_lv() > 10000)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
		if (brdinfoVO == null) {
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);
		}

		if ("CDIDX00042".equals(brdinfoVO.getBrd_gb()) == false)
			throw new CmmnException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);

		// 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
		if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		// 삭제대상 게시물 조회
		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		BoardarticleVO compVO = boardarticleService.selectBoardarticle(boardarticleVO);
		if (compVO == null)
			throw new CmmnException(MessageHelper.getMessage(
					"CAN-NOT-FIND-DATA-TO-DELETE")/*
													 * 삭제할 데이터를 찾을 수 없습니다.
													 */);

		// 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 삭제할 수 없다.
		if (user.getUser_auth_lv() > 1000 && compVO.getWriter().equals(user.getUser_id()) == false)
			throw new CmmnException(MessageHelper.getMessage(
					"YOU-DO-NOT-HAVE-PERMISSION-TO-DELETE-THE-POST")/*
																	 * 게시글을 삭제할
																	 * 권한이 없습니다.
																	 */);

		boardarticleService.deleteBoardarticlegroup(boardarticleVO);

		return "redirect:/brdartcl/boardarticleList." + ext + "?srch_menu_nix=" + boardarticleVO.getSrch_menu_nix()
				+ "&brd_id=" + boardarticleVO.getBrd_id() + "&seltab_idx=" + boardarticleVO.getSeltab_idx();
	}

	/**
	 * 게시물 항목을 수정한다.
	 * 
	 * @param boardarticleVO
	 *            : 수정할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/mdfBoardarticle")
	@ResponseBody
	public String mdfBoardarticle(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
		if (user.getUser_auth_lv() > 10000)
			throw new AjaxException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
		if (brdinfoVO == null) {
			throw new AjaxException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);
		}

		if ("CDIDX00042".equals(brdinfoVO.getBrd_gb()) == false)
			throw new AjaxException(MessageHelper.getMessage(
					"THIS-IS-NOT-A-NORMAL-REQUEST")/*
													 * 정상적인 요청이 아닙니다.
													 */);

		// 로그인한 사용자에 대한 쓰기권한이 없고 (!=2) 관리자가 아니면 작성/변경/삭제할 수 없다.
		if (user.getUser_auth_lv() > 100 && "2".equals(brdinfoVO.getOn_viewmode()) == false) {
			throw new AjaxException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}

		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		boardarticleVO.setModifier(user.getUser_id());

		// 변경대상 게시물 조회
		BoardarticleVO compVO = boardarticleService.selectBoardarticle(boardarticleVO);
		if (compVO == null)
			throw new AjaxException(MessageHelper.getMessage(
					"COULD-NOT-FIND-THE-DATA-TO-CHANGE")/*
														 * 변경할 데이터를 찾을 수 없습니다.
														 */);

		// 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 변경할 수 없다.
		if (user.getUser_auth_lv() > 1000 && compVO.getWriter().equals(user.getUser_id()) == false)
			throw new AjaxException(MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-CHANGE-YOUR-POST")/*
																												 * 게시글을
																												 * 변경할
																												 * 권한이
																												 * 없습니다.
																												 */);

		boardarticleService.updateBoardarticle(boardarticleVO);
		return Integer.toString(boardarticleVO.getCont_idx());

	}

	/**
	 * 
	 * @param boardreplyVO
	 *            : 추가할 정보
	 * @param request
	 * @param model
	 * @return "SUCCESS"
	 * @exception Exception
	 */
	@RequestMapping("/chkBoardPwd")
	@ResponseBody
	public String chkBoardPwd(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		boardarticleVO = boardarticleService.selectBoardarticlePwd(boardarticleVO);

		if (boardarticleVO == null) {
			throw new AjaxException(MessageHelper
					.getMessage("PASSWORDS-DO-NOT-MATCH")/* 패스워드가 일치하지 않습니다. */);
		} else {
			return "SUCCESS";
		}
	}

	/**
	 * 
	 * @param boardreplyVO
	 *            : 추가할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/chkBoardreply")
	@ResponseBody
	public Boolean chkBoardreply(@ModelAttribute("boardreplyVO") BoardreplyVO boardreplyVO, HttpServletRequest request,
			ModelMap model) throws Exception {

		boardreplyVO = boardreplyService.selectBoardreply(boardreplyVO);

		if (null != boardreplyVO) {
			return true;
		} else {
			return false;
		}

	}

	/**
	 * 댓글 항목을 추가한다.
	 * 
	 * @param boardreplyVO
	 *            : 추가할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/addBoardreply")
	@ResponseBody
	public BoardreplyVO addBoardreply(@ModelAttribute("boardreplyVO") BoardreplyVO boardreplyVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		try {
			// /*
			// * int userlv = (Integer)
			// EgovSessionCookieUtil.getSessionAttribute(request,
			// "SESS_USR_LV");
			// * if(userlv > 10000) throw new
			// AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/*
			// 권한이 부족합니다. */);
			// */

			String writer = boardreplyVO.getWriter_nm();

			BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
			boardreplyVO.setTbl_nm(brdinfoVO.getTbl_nm());
			boardreplyVO.setWriter(writer);
			boardreplyService.insertBoardreply(boardreplyVO);
			int reply_idx = boardreplyVO.getReply_idx();
			boardreplyVO.setReply_idx(reply_idx);
			BoardreplyVO resultVO = boardreplyService.selectBoardreply(boardreplyVO);

			return resultVO;

		} catch (Exception e) {

			e.printStackTrace();
			if (e instanceof AjaxException)
				throw e;
			else
				throw new AjaxException(e.getClass().getName(), null, e);
		}
	}

	/**
	 * 댓글 항목을 삭제한다.
	 * 
	 * @param boardreplyVO
	 *            : 삭제할 정보
	 * @param request
	 * @param model
	 * @return "SUCCESS"
	 * @exception Exception
	 */
	@RequestMapping("/rmvBoardreply")
	@ResponseBody
	public String rmvBoardreply(@ModelAttribute("boardreplyVO") BoardreplyVO boardreplyVO, HttpServletRequest request,
			ModelMap model) throws Exception {
		try {

			// /*
			// * int userlv = (Integer)
			// EgovSessionCookieUtil.getSessionAttribute(request,
			// "SESS_USR_LV");
			// * if(userlv > 10000) throw new
			// AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/*
			// 권한이 부족합니다. */);
			// */

			BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
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
	 * 댓글 항목을 수정한다.
	 * 
	 * @param boardreplyVO
	 *            : 수정할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/mdfBoardreply")
	@ResponseBody
	public BoardreplyVO mdfBoardreply(@ModelAttribute("boardreplyVO") BoardreplyVO boardreplyVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		try {
			// /*
			// * int userlv = (Integer)
			// EgovSessionCookieUtil.getSessionAttribute(request,
			// "SESS_USR_LV");
			// * if(userlv > 10000) throw new
			// AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/*
			// 권한이 부족합니다. */);
			// */

			String modifier = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
			BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");

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

	/**
	 * 추천/반대 항목을 추가한다.
	 * 
	 * @param boardrcmndVO
	 *            : 추가할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 * @return '/brdartcl/boardarticleView'
	 */
	@RequestMapping("/addBoardrcmnd")
	public String addBoardrcmnd(@ModelAttribute("boardrcmndVO") BoardrcmndVO boardrcmndVO, HttpServletRequest request,
			ModelMap model) throws Exception {

		String srch_menu_nix = boardrcmndVO.getSrch_menu_nix();
		String ext = EgovWebUtil.getExtension(request.getRequestURI());

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 10000)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
		boardrcmndVO.setRcmnd_id(writer);
		boardrcmndService.insertBoardrcmnd(boardrcmndVO);

		return "redirect:/brdartcl/boardarticleView." + ext + "?srch_menu_nix=" + boardrcmndVO.getSrch_menu_nix()
				+ "&brd_id=" + boardrcmndVO.getBrd_id() + "&cont_idx=" + boardrcmndVO.getCont_idx();
	}

	/**
	 * 항목을 상세 조회한다.
	 * 
	 * @param boardarticleVO
	 *            : 조회할 정보
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("/boardPreview")
	public String boardPreview(HttpServletRequest request, ModelMap model) throws Exception {

		String returnUrl = "/brdartcl/boardPreview";
		String ext = EgovWebUtil.getExtension(request.getRequestURI());
		String content = request.getParameter("previewContent");
		model.addAttribute("content", content);

		if ("mdo".equals(ext))
			returnUrl = "/mbl" + returnUrl;

		return returnUrl;
	}

	/**
	 * 
	 * @param request
	 * @param boardarticleVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updateHits")
	@ResponseBody
	public String updateHits(HttpServletRequest request,
			@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO) throws Exception {
		BoardinfoVO brdinfoVO = (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
		// 세션에 저장된 게시판 정보가 없는 경우 (주소에서 직접 치고 들어온 경우 또는 목록이 없어서 쓰기화면으로 바로들어가는
		// 게시판)
		if (brdinfoVO == null || boardarticleVO.getBrd_id().equals(brdinfoVO.getBrd_id()) == false) {

			/** 게시판 기본 정보 가져와서 저장하기 */
			brdinfoVO = new BoardinfoVO();
			brdinfoVO.setBrd_id(boardarticleVO.getBrd_id());
			brdinfoVO = boardinfoService.selectBoardinfo(brdinfoVO);

			if (brdinfoVO == null)
				throw new UnknownBoardException(
						MessageHelper.getMessage("BULLETIN-BOARD-LOOKUP-INFORMATION-IS-INVALID")/*
																								 * 게시판
																								 * 조회정보가
																								 * 잘못되었습니다.
																								 */);

			EgovSessionCookieUtil.setSessionAttribute(request, "SESS_BRD_INFO", brdinfoVO);
		}
		boardarticleVO.setTbl_nm(brdinfoVO.getTbl_nm());
		BoardarticleVO resultVO = boardarticleService.selectBoardarticle(boardarticleVO);
		int hits = resultVO.getHits() + 1;
		// /////////////////////////
		// hits + 1
		boardarticleVO.setHits(hits);
		// System.out.println("ccccccccccccccccccc" + boardarticleVO);
		boardarticleService.updateBoardxcount(boardarticleVO);

		return "SUCCESS";
	}

}
