/*
 * Copyright 2008-2009 the original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
package egovframework.plani.template.man.metsys.web;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.google.gson.Gson;

import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.vo.BoardExtraVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SyscategoryService;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 게시판 정보 액션 컨트롤
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.man.metsys.web]
 *        [EgovModebdController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 8. 오후 5:06:50
 * @version : 1.0
 */
@Controller
@RequestMapping("/modebd")
public class ModebdController {

	/** BoardinfoService */
	@Resource(name = "boardinfoService")
	private BoardinfoService boardinfoService;

	/** SyscategoryService */
	@Resource(name = "syscategoryService")
	private SyscategoryService syscategoryService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** ManlogService */
	@Resource(name = "manlogService")
	protected ManlogService manlogService;

	/** SysmenuService */
	@Resource(name = "sysmenuService")
	private SysmenuService sysmenuService;

	/** SyscodeService */
	@Resource(name = "syscodeService")
	private SyscodeService syscodeService;

	/** Gson */
	@Resource(name = "gson")
	protected Gson gson;

	/**
	 * 게시판 메인화면 처리
	 * 
	 * @param searchVO
	 *            목록 조회조건 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return tiles
	 * @exception Exception
	 */
	@RequestMapping("/modebdList")
	public String modebdList(@ModelAttribute("boardinfoVO") BoardinfoVO boardinfoVO, HttpServletRequest request,
			Model model) throws Exception {

		MemberVO tmpmemVO = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
		if (tmpmemVO.getUser_auth_lv() > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		// //////////////////////////////////////////////////////////////////////////////////
		// pageing setting Start
		String mu_site = boardinfoVO.getSrch_mu_site();
		mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
		boardinfoVO.setSrch_mu_site(mu_site);

		String mu_lang = boardinfoVO.getSrch_mu_lang();
		mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;
		boardinfoVO.setSrch_mu_lang(mu_lang);

		// 총괄 관리자가 아닌 경우 자신에게 권한이 있는 게시판만 보여준다.
		// if (tmpmemVO.getUser_auth_lv() > 2)
		// boardinfoVO.setBrd_auth_usr(tmpmemVO.getUser_id());

		List boardinfoList = boardinfoService.selectBoardinfoList(boardinfoVO);
		model.addAttribute("resultList", boardinfoList);

		int totCnt = boardinfoService.selectBoardinfoListTotCnt(boardinfoVO);
		NumberFormat nf = NumberFormat.getInstance();
		model.addAttribute("totCnt", nf.format(totCnt));

		// pageing setting End
		// //////////////////////////////////////////////////////////////////////////////////

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

		// ////////////////////////////////////////////////////////////////////////////////////////////
		//
		// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
		manlogService.insertManlog(request, "BD_MAN", "게시판관리", "게시판 목록조회", "L");
		//
		// ////////////////////////////////////////////////////////////////////////////////////////////

		return "/metsys/modebdList";
	}

	/**
	 * 게시판 (메뉴구조 보기) 처리
	 * 
	 * @param searchVO
	 *            목록 조회조건 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return tiles
	 * @exception Exception
	 */
	@RequestMapping("/modebdmenuList")
	public String modebdmenuList(@ModelAttribute("boardinfoVO") BoardinfoVO boardinfoVO, HttpServletRequest request,
			Model model) throws Exception {

		MemberVO tmpmemVO = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
		if (tmpmemVO.getUser_auth_lv() > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		// //////////////////////////////////////////////////////////////////////////////////
		// pageing setting Start
		String mu_site = boardinfoVO.getSrch_mu_site();
		mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
		boardinfoVO.setSrch_mu_site(mu_site);

		String mu_lang = boardinfoVO.getSrch_mu_lang();
		mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;
		boardinfoVO.setSrch_mu_lang(mu_lang);

		// 총괄 관리자가 아닌 경우 자신에게 권한이 있는 게시판만 보여준다.
		if (tmpmemVO.getUser_auth_lv() > 2)
			boardinfoVO.setBrd_auth_usr(tmpmemVO.getUser_id());

		// List boardinfoList =
		// boardinfoService.selectBoardinfomenuList(boardinfoVO);
		List boardinfoList = null;

		String dbtype = EgovProperties.getProperty("Globals.DbType");
		boardinfoList = boardinfoService.selectBoardinfomenuList(boardinfoVO);

		if ("mysql".equals(dbtype)) {

			EgovWebUtil.getLeveldList(boardinfoList, null, 1, new Integer(1));

			if (boardinfoList.size() > 0) {
				// 조작하기 편하도록 필요한 데이터만 String 배열로 빼낸다.
				String[][] orgList = new String[boardinfoList.size()][3];
				for (int i = 0; i < boardinfoList.size(); i++) {
					SysmenuVO menuVO = (SysmenuVO) boardinfoList.get(i);
					// if(menuVO.getBrd_id())

					orgList[i][0] = menuVO.getMenu_idx();
					orgList[i][1] = menuVO.getUp_menu_idx();
					orgList[i][2] = menuVO.getBrd_id();
				}

				// 게시판과 연동된 메뉴만 상위메뉴까지 포함해서 가져와 리스트를 만든다.
				List srchList = new ArrayList();
				for (int i = 0; i < orgList.length; i++) {
					if (orgList[i][2] != null && "".equals(orgList[i][2]) == false) {
						srchList.add(orgList[i][0]);
						EgovWebUtil.getParentList(orgList, orgList[i][1], srchList);
					}
				}

				// 위에서 만들어진 리스트에 포함되지 않은 메뉴들은 삭제한다.
				for (int i = boardinfoList.size() - 1; i >= 0; i--) {
					SysmenuVO menuVO = (SysmenuVO) boardinfoList.get(i);

					String chkmenu = menuVO.getMenu_idx();
					boolean chkbool = false;

					for (int j = 0; j < srchList.size(); j++) {
						String vMenu = (String) srchList.get(j);
						if (vMenu.equals(chkmenu))
							chkbool = true;
					}

					if (chkbool == false)
						boardinfoList.remove(i);
				}

				// 번호순서가 바뀌었기때문에 맞게 변경한다.
				for (int i = 0; i < boardinfoList.size(); i++) {
					SysmenuVO menuVO = (SysmenuVO) boardinfoList.get(i);
					menuVO.setRn(i + 1);
				}

			}
		}
		model.addAttribute("resultList", boardinfoList);

		// pageing setting End
		// //////////////////////////////////////////////////////////////////////////////////

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

		// ////////////////////////////////////////////////////////////////////////////////////////////
		//
		// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
		manlogService.insertManlog(request, "BD_MAN", "게시판관리", "게시판 목록조회", "L");
		//
		// ////////////////////////////////////////////////////////////////////////////////////////////

		return "/metsys/modebdmenuList";
	}

	/**
	 * 게시판 정보 참고를 위한 게시판 목록 조회
	 * 
	 * @param searchVO
	 *            목록 조회조건 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return JSON
	 * @exception Exception
	 */
	@RequestMapping("/modebdJsonList")
	@ResponseBody
	public List modebdJsonList(@ModelAttribute("boardinfoVO") BoardinfoVO boardinfoVO, HttpServletRequest request,
			Model model) throws Exception {

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		// //////////////////////////////////////////////////////////////////////////////////
		// pageing setting Start

		List boardinfoList = boardinfoService.selectBoardinfoList(boardinfoVO);

		return boardinfoList;
	}

	/**
	 * 게시판 정보 조회하면
	 * 
	 * @param searchVO
	 *            상세조회조건 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return tiles
	 * @exception Exception
	 */
	@RequestMapping("/modebdView")
	public String modebdView(@ModelAttribute("boardinfoVO") BoardinfoVO boardinfoVO, HttpServletRequest request,
			Model model) throws Exception {

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		// 카테고리 정보 가져오기
		List ctgryList = syscategoryService.selectSyscategoryList(null);
		model.addAttribute("ctgryList", ctgryList);

		if (!"".equals(boardinfoVO.getBrd_id())) {
			BoardinfoVO resultVO = boardinfoService.selectBoardinfo(boardinfoVO);
			if (resultVO != null) {
				/* json customize... */
				// Gson gson = new Gson();
				BoardExtraVO boardextraVO = new BoardExtraVO();
				if (resultVO.getExtra1() != null) {
					BoardExtraVO obj1 = gson.fromJson((String) resultVO.getExtra1(), BoardExtraVO.class);

					boardextraVO.setExtra1_name(obj1.getExtra1_name());
					boardextraVO.setExtra1_use(obj1.getExtra1_use());
					boardextraVO.setExtra1_require(obj1.getExtra1_require());
				}
				if (resultVO.getExtra2() != null) {
					BoardExtraVO obj2 = gson.fromJson((String) resultVO.getExtra2(), BoardExtraVO.class);

					boardextraVO.setExtra2_name(obj2.getExtra2_name());
					boardextraVO.setExtra2_use(obj2.getExtra2_use());
					boardextraVO.setExtra2_require(obj2.getExtra2_require());
				}

				resultVO.setBrd_extra(boardextraVO);
				// System.out.println("resultVOresultVO2" + resultVO);

				resultVO.setEdomweivgp("M");
				resultVO.setSrch_mu_site(boardinfoVO.getSrch_mu_site());
				resultVO.setSrch_mu_lang(boardinfoVO.getSrch_mu_lang());
				resultVO.setSeltab_idx(boardinfoVO.getSeltab_idx());

				model.addAttribute("boardinfoVO", resultVO);

				// ////////////////////////////////////////////////////////////////////////////////////////////
				//
				// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
				manlogService.insertManlog(request, "BD_MAN", "게시판관리", "게시판 상세조회 " + "[" + resultVO.getBrd_nm() + "]",
						"R");
				//
				// ////////////////////////////////////////////////////////////////////////////////////////////
			}

		}

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

		// 게시판구분 코드 조회
		codeVO.setUp_code_idx("CDIDX00041");

		List brdcode = syscodeService.selectSyscodeList(codeVO);
		model.addAttribute("brdcode", brdcode);

		return "/metsys/modebdView";
	}

	/**
	 * 게시판 정보 추가
	 * 
	 * @param searchVO
	 *            추가 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return redirect[srch_menu_nix="메뉴코드명"]
	 * @exception Exception
	 */
	@RequestMapping("/addBoardinfo")
	public String addBoardinfo(@ModelAttribute("boardinfoVO") BoardinfoVO boardinfoVO, HttpServletRequest request,
			Model model) throws Exception {

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		// Gson gson = new Gson();
		Map<String, String> extra_data1 = new HashMap<String, String>();
		Map<String, String> extra_data2 = new HashMap<String, String>();

		for (int i = 1; i <= 2; i++) {
			if (i == 1) {
				if (boardinfoVO.getBrd_extra().getExtra1_use().equals("N"))
					continue;
				extra_data1.put("extra" + i + "_use", boardinfoVO.getBrd_extra().getExtra1_use());
				extra_data1.put("extra" + i + "_require", boardinfoVO.getBrd_extra().getExtra1_require());
				extra_data1.put("extra" + i + "_name", boardinfoVO.getBrd_extra().getExtra1_name());
				boardinfoVO.setExtra1(gson.toJson(extra_data1));
			} else if (i == 2) {
				if (boardinfoVO.getBrd_extra().getExtra2_use().equals("N"))
					continue;
				extra_data2.put("extra" + i + "_use", boardinfoVO.getBrd_extra().getExtra2_use());
				extra_data2.put("extra" + i + "_require", boardinfoVO.getBrd_extra().getExtra2_require());
				extra_data2.put("extra" + i + "_name", boardinfoVO.getBrd_extra().getExtra2_name());
				boardinfoVO.setExtra2(gson.toJson(extra_data2));
			}
		}

		boardinfoVO.setWriter((String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID"));
		boardinfoService.insertBoardinfo(boardinfoVO);

		// ////////////////////////////////////////////////////////////////////////////////////////////
		//
		// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
		manlogService.insertManlog(request, "BD_MAN", "게시판관리", "게시판 추가 " + "[" + boardinfoVO.getBrd_nm() + "]", "C");
		//
		// ////////////////////////////////////////////////////////////////////////////////////////////

		return "redirect:/modebd/modebdList.do?srch_menu_nix=" + boardinfoVO.getSrch_menu_nix();
	}

	/**
	 * 게시판 정보 수정
	 * 
	 * @param searchVO
	 *            수정 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return redirect[srch_menu_nix="메뉴코드명",brd_id="게시판id"]
	 * @exception Exception
	 */
	@RequestMapping("/mdfBoardinfo")
	public String mdfBoardinfo(@ModelAttribute("boardinfoVO") BoardinfoVO boardinfoVO, HttpServletRequest request,
			Model model) throws Exception {

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		// Gson gson = new Gson();
		Map<String, String> extra_data1 = new HashMap<String, String>();
		Map<String, String> extra_data2 = new HashMap<String, String>();

		for (int i = 1; i <= 2; i++) {
			if (i == 1) {
				if (boardinfoVO.getBrd_extra().getExtra1_use().equals("N"))
					continue;
				extra_data1.put("extra" + i + "_use", boardinfoVO.getBrd_extra().getExtra1_use());
				extra_data1.put("extra" + i + "_require", boardinfoVO.getBrd_extra().getExtra1_require());
				extra_data1.put("extra" + i + "_name", boardinfoVO.getBrd_extra().getExtra1_name());
				boardinfoVO.setExtra1(gson.toJson(extra_data1));
			} else if (i == 2) {
				if (boardinfoVO.getBrd_extra().getExtra2_use().equals("N"))
					continue;
				extra_data2.put("extra" + i + "_use", boardinfoVO.getBrd_extra().getExtra2_use());
				extra_data2.put("extra" + i + "_require", boardinfoVO.getBrd_extra().getExtra2_require());
				extra_data2.put("extra" + i + "_name", boardinfoVO.getBrd_extra().getExtra2_name());
				boardinfoVO.setExtra2(gson.toJson(extra_data2));
			}
		}
		boardinfoVO.setModifier((String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID"));

		boardinfoService.updateBoardinfo(boardinfoVO);

		// ////////////////////////////////////////////////////////////////////////////////////////////
		//
		// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
		manlogService.insertManlog(request, "BD_MAN", "게시판관리", "게시판 정보 변경 " + "[" + boardinfoVO.getBrd_nm() + "]", "U");
		//
		// ////////////////////////////////////////////////////////////////////////////////////////////

		return "redirect:/modebd/modebdView.do?srch_menu_nix=" + boardinfoVO.getSrch_menu_nix() + "&brd_id="
				+ boardinfoVO.getBrd_id();
	}

	/**
	 * 게시판 정보 삭제
	 * 
	 * @param searchVO
	 *            삭제 정보가 담긴 VO
	 * @param request
	 * @param model
	 * @return redirect[srch_menu_nix="메뉴코드명"]
	 * @exception Exception
	 */
	@RequestMapping("/rmvBoardinfo")
	public String rmvBoardinfo(@ModelAttribute("boardinfoVO") BoardinfoVO boardinfoVO, HttpServletRequest request,
			Model model) throws Exception {

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		BoardinfoVO resultVO = boardinfoService.selectBoardinfo(boardinfoVO);
		if (resultVO != null) {
			boardinfoService.deleteBoardinfo(resultVO);

			// ////////////////////////////////////////////////////////////////////////////////////////////
			//
			// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
			manlogService.insertManlog(request, "BD_MAN", "게시판관리", "게시판 정보 삭제" + "[" + resultVO.getBrd_nm() + "]", "D");
			//
			// ////////////////////////////////////////////////////////////////////////////////////////////
		}

		return "redirect:/modebd/modebdList.do?srch_menu_nix=" + boardinfoVO.getSrch_menu_nix();
	}

	/**
	 * 연결메뉴를 삭제한다.
	 * 
	 * @param contentsmanVO
	 *            : 삭제할정보
	 * @param request
	 * @param model
	 * @return "success"
	 * @exception Exception
	 */
	@RequestMapping("/rmvRef_srch_menu_nix")
	@ResponseBody
	public String rmvRef_srch_menu_nix(@ModelAttribute("boardinfoVO") BoardinfoVO boardinfoVO,
			HttpServletRequest request, ModelMap model) throws Exception {

		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new AjaxException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		boardinfoService.updateBoardinfoMenunix(boardinfoVO);

		return "SUCCESS";
	}

}
