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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.plani.custom.form.validator.groups.ValidationAdminJoin;
import egovframework.plani.custom.form.validator.groups.ValidationAdminModify;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CommonUtil;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.cmm.utils.UserInfoHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SysauthService;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.metsys.service.WithdrawalService;
import egovframework.plani.template.man.metsys.vo.WithdrawalVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 관리자 페이지 사용자 관리 액션 컨트롤러
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.web] [ModeurController.java]
 */
@Controller
@RequestMapping("/modeur")
public class ModeurController {

  @Resource(name = "memberService")
  MemberService memberService;

  @Resource(name = "syscodeService")
  private SyscodeService syscodeService;

  @Resource(name = "sysauthService")
  private SysauthService sysauthService;

  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** WithdrawalService */
  @Resource(name = "withdrawalService")
  private WithdrawalService withdrawalService;

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  @Resource
  private CrudTemplate crudTemplate;

  /**
   * 사용자 목록 검색
   * 
   * @param MemberVO 조회 할 사용자 정보가 담긴 VO
   * @param request
   * @param model
   * @return tiles
   * @throws Exception
   */
  @RequestMapping("/modeurList")
  public String modeurList(@ModelAttribute("memberVO") final MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "USR_MAN", "사용자관리", "사용자 목록조회", "L");
    // ////////////////////////////////////////////////////////////////////////////////////////////

    // 총괄 관리자가 아닌 경우 자신만 보여준다.
    if (tmpmemVO.getUser_auth_lv() > 2) {
      memberVO.setUser_id(tmpmemVO.getUser_id());
    }

    // memberVO.setPageUnit(2);

    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, memberVO, new CrudStrategy<MemberVO>() {
      @Override
      public int totalCount() throws Exception {
        return memberService.selectMemberListTotCnt(memberVO);
      }

      @Override
      public List<MemberVO> pagingList() throws Exception {
        return memberService.selectMemberList(memberVO);
      }
    });

    return "/modeur/modeurList";
  }

  /**
   * 사용자 한명에 대한 상세 조회
   * 
   * @param MemberVO 상세조회 할 사용자 정보가 담긴 VO
   * @param request
   * @param model
   * @return tiles
   * @throws Exception
   */
  @RequestMapping(value = "/modeurView", method = RequestMethod.GET)
  public String modeurView(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {

    // 관리자 접근 체크
		// UserInfoHelper.adminCheck();
		MemberVO tmpmemVO = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
		if (tmpmemVO.getUser_auth_lv() > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		MemberVO resultVO = new MemberVO();
		// 총괄 관리자가 아닌 경우 자신만 보여준다.
		if (tmpmemVO.getUser_auth_lv() > 2) {

			resultVO = modeurViewProc(tmpmemVO.getUser_id(), model);
		} else {
			// 관리자 회원 가입/수정 추가 정보
			resultVO = modeurViewProc(request.getParameter("id"), model);
		}

    // 수정인 경우 로그 기록
    if (StringUtils.isEmpty(resultVO.getUser_id()) == false) {
      // //////////////////////////////////////////////////////////////////////////////////////////
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "USR_MAN", "사용자관리",
          "사용자 상세조회 : [ " + resultVO.getUser_id() + " ]", "R");
      // //////////////////////////////////////////////////////////////////////////////////////////
    }
    return "/modeur/modeurForm";
  }

  /**
   * 관리자 회원 가입/수정 추가 정보
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  private MemberVO modeurViewProc(String id, Model model) throws Exception {
    boolean isModify = false;
    MemberVO resultVO = new MemberVO();
    if (StringUtils.isEmpty(id) == false) {
      isModify = true;
      // 회원 정보 조회
      MemberVO searchMemberVO = new MemberVO();
      searchMemberVO.setUser_id(id);

      resultVO = memberService.selectMember(searchMemberVO);
      if (resultVO == null) {
        throw new CmmnException(MessageHelper.getMessage("NO-MATCHING-MEMBER-INFORMATION"));
      }
    }
    // 회원가입 설정
    memberService.setView(model, id, isModify, resultVO);
    return resultVO;
  }

  /**
   * 관리자 회원가입 수정
   * 
   * @param memberVO
   * @param result
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/modeurView", method = RequestMethod.POST)
  @ResponseBody
  public Object modeurView(@Validated(ValidationAdminModify.class) MemberVO memberVO,
      BindingResult result, HttpServletRequest request, Model model) throws Exception {
    return modeurProc(memberVO, result, request, model);
  }

  /**
   * 관리자 회원가입 등록
   * 
   * @param memberVO
   * @param result
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/modeurAdd", method = RequestMethod.POST)
  @ResponseBody
  public Object modeurAdd(@Validated(ValidationAdminJoin.class) MemberVO memberVO,
      BindingResult result, HttpServletRequest request, Model model) throws Exception {
    return modeurProc(memberVO, result, request, model);
  }

  /**
   * 관리자 회원가입 수정/등록 처리
   * 
   * @param memberVO
   * @param result
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  private Object modeurProc(MemberVO memberVO, BindingResult result, HttpServletRequest request,
      Model model) throws Exception {
    // 관리자 접근 체크
    //UserInfoHelper.adminCheck();
    // 관리자 회원 가입/수정 추가 정보

    MemberVO resultVO = modeurViewProc(request.getParameter("id"), model);
    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/modeur/modeurForm");
    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }
    // 세션 사용자 정보
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // 수정인 경우
    if (StringUtils.isEmpty(resultVO.getUser_id()) == false) {
      memberVO.setUser_id(request.getParameter("id"));
    }
    // 작성자 정보
    memberVO.setWriter(sessionUserData.getUser_id());
    // 신규 등록인 경우 로그 기록
    if (StringUtils.isEmpty(resultVO.getUser_id()) == true) {
      memberService.insertMember(memberVO);
      // //////////////////////////////////////////////////////////////////////////////////////////
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "USR_MAN", "사용자관리",
          "사용자 정보추가 : [ " + memberVO.getUser_id() + " ]", "C");
      // //////////////////////////////////////////////////////////////////////////////////////////
    } else {

			if (!memberVO.getIs_lock().equals(resultVO.getIs_lock())) {

				String message = memberVO.getIs_lock().equals("Y") ? "차단" : "해제";

				manlogService.insertManlog(request, "USR_MAN", "사용자관리",
						"계정잠금수정 : [ " + memberVO.getUser_id() + " : " + message + " ]",
						"U");
				memberVO.setLock_count(0);
				memberService.updateLockCount(memberVO);
			}
      memberService.updateMember(memberVO);
    }
    // 사용자 업로드파일
    atchfileService.uploadProcFormfiles(request, "USR_LOGO", memberVO.getUser_id(), 1, "IMG");
    // 완료
    return responseResultHelper.success(null, null,
        CommonUtil.getUrl("/modeur/modeurList.do", "id=", true), null);
  }


  /**
   * 사용자 정보 삭제 - form action
   * 
   * @param MemberVO 삭제 할 정보가 담긴 사용자 VO
   * @param request
   * @param model
   * @return redirect[srch_menu_nix="메뉴코드명"]
   * @throws Exception
   */
  @RequestMapping("/rmvModeur")
  public String rmvModeur(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    try {
      if (memberVO.getUser_id() == null || "".equals(memberVO.getUser_id())) {
        throw new Exception(MessageHelper.getMessage("ID-IS-MISSING")/* 입력값 누락 - 아이디 */);
      }

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "USR_MAN", "사용자관리",
          "사용자 정보 삭제 : [ " + memberVO.getUser_id() + " ]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

      memberVO.setModifier((String) EgovSessionCookieUtil.getSessionAttribute(request,
          "SESS_USR_ID"));
      memberService.deleteMember(memberVO);
    } catch (Exception e) {
      throw e;
    }

    return "redirect:/modeur/modeurList.do?srch_menu_nix=" + memberVO.getSrch_menu_nix();
  }


  // /**
  // * 사용자 정보 수정
  // *
  // * @param memberVO 수정할 정보가 담긴 사용자 VO
  // * @param request
  // * @param model
  // * @return redirect[srch_menu_nix="메뉴코드명"]
  // * @throws Exception
  // */
  // @RequestMapping("/mdfModeur")
  // public String mdfModeur(@ModelAttribute("memberVO") MemberVO memberVO, HttpServletRequest
  // request,
  // Model model) throws Exception {
  //
  // int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
  // if (userlv > 100)
  // throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
  //
  // try {
  // if (memberVO.getUser_id() == null || memberVO.getUser_id().equals("")) {
  // throw new Exception(
  // MessageHelper.getMessage("REQUIRED-VALUE-IS-MISSING")/* 필수 입력값이 누락되었습니다. */);
  // }
  //
  // // ////////////////////////////////////////////////////////////////////////////////////////////
  // //
  // // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
  // manlogService.insertManlog(request, "USR_MAN", "사용자관리",
  // "사용자 상세조회 : [ " + memberVO.getUser_id() + " ]", "U");
  // //
  // // ////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  // if (memberVO.getUser_scrt() != null && memberVO.getUser_scrt().length() > 0) {
  // String scrt = memberVO.getUser_scrt();
  // Pattern p1 = Pattern.compile(".*[^가-힣a-zA-Z0-9].*"); // 특수문자 포함여부
  // Pattern p2 = Pattern.compile(".*[0-9].*"); // 숫자 포함여부
  // Pattern p3 = Pattern.compile(".*[a-zA-Z].*"); // 영문자 포함여부
  //
  //
  // Matcher m1 = p1.matcher(scrt);
  // Matcher m2 = p2.matcher(scrt);
  // Matcher m3 = p3.matcher(scrt);
  //
  // if (scrt.length() < 8) {
  // // if(! (m1.matches() && m2.matches() && m3.matches()) )
  // throw new Exception(
  // MessageHelper.getMessage("INVALID-PASSWORD-FORMAT")/* 패스워드 형식이 잘못되었습니다. */);
  //
  // }
  // /*
  // * else { if(! (m2.matches() && m3.matches()) ) throw new Exception("패스워드 형식이 잘못되었습니다."); }
  // */
  // }
  //
  //
  // memberVO
  // .setModifier((String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID"));
  // memberService.updateMember(memberVO);
  //
  // atchfileService.uploadProcFormfiles(request, "USR_LOGO", memberVO.getUser_id(), 1, "IMG");
  //
  // } catch (Exception e) {
  // throw e;
  // }
  //
  // // response.sendRedirect("modeurView.do?user_id=" + vo.getUser_id() + "&" +
  // // vo.getUrlParams().replaceAll("&amp;", "&"));
  //
  // return "redirect:/modeur/modeurList.do?srch_menu_nix=" + memberVO.getSrch_menu_nix();
  // }


  // /**
  // * 사용자 정보 추가
  // *
  // * @param memberVO 추가 할 정보가 담긴 사용자 VO
  // * @param request
  // * @param model
  // * @return redirect[srch_menu_nix="메뉴코드명"]
  // * @throws Exception
  // */
  // @RequestMapping("/addModeur")
  // public String addModeur(HttpServletRequest request, @ModelAttribute("memberVO") MemberVO
  // memberVO,
  // Model model) throws Exception {
  //
  // int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
  // if (userlv > 100)
  // throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
  //
  // if (memberVO.getUser_id() == null || memberVO.getUser_id().equals("")
  // || memberVO.getUser_scrt() == null || memberVO.getUser_scrt().equals("")
  // || memberVO.getUser_email() == null || memberVO.getUser_email().equals("")
  // || memberVO.getUser_nm() == null || memberVO.getUser_nm().equals("")) {
  // throw new Exception(
  // MessageHelper.getMessage("REQUIRED-VALUE-IS-MISSING")/* 필수 입력값이 누락되었습니다. */);
  // }
  //
  //
  // String scrt = memberVO.getUser_scrt();
  // Pattern p1 = Pattern.compile(".*[^가-힣a-zA-Z0-9].*"); // 특수문자 포함여부
  // Pattern p2 = Pattern.compile(".*[0-9].*"); // 숫자 포함여부
  // Pattern p3 = Pattern.compile(".*[a-zA-Z].*"); // 영문자 포함여부
  //
  //
  // Matcher m1 = p1.matcher(scrt);
  // Matcher m2 = p2.matcher(scrt);
  // Matcher m3 = p3.matcher(scrt);
  //
  // if (scrt.length() < 4) {
  // // if(! (m1.matches() && m2.matches() && m3.matches()) )
  // throw new Exception(
  // MessageHelper.getMessage("INVALID-PASSWORD-FORMAT")/* 패스워드 형식이 잘못되었습니다. */);
  //
  // }
  // /*
  // * else { if(! (m2.matches() && m3.matches()) ) throw new Exception("패스워드 형식이 잘못되었습니다."); }
  // */
  //
  // // ////////////////////////////////////////////////////////////////////////////////////////////
  // //
  // // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
  // manlogService.insertManlog(request, "USR_MAN", "사용자관리",
  // "사용자 정보추가 : [ " + memberVO.getUser_id() + " ]", "C");
  // //
  // // ////////////////////////////////////////////////////////////////////////////////////////////
  //
  //
  // memberVO.setWriter((String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID"));
  // memberService.insertMember(memberVO);
  //
  // atchfileService.uploadProcFormfiles(request, "USR_LOGO", memberVO.getUser_id(), 1, "IMG");
  //
  //
  // // response.sendRedirect("modeurView.do?user_id=" + vo.getUser_id() + "&" +
  // // vo.getUrlParams().replaceAll("&amp;", "&"));
  //
  // return "redirect:/modeur/modeurList.do?srch_menu_nix=" + memberVO.getSrch_menu_nix();
  // }


  /**
   * 사용자 로그인.
   * 
   * @param memberVO 로그인 조회 조건 정보가 담긴 VO
   * @param model
   * @param request
   * @return String 성공하면 OK, 실패하면 FAIL
   * @exception Exception
   */
  @RequestMapping("/modeurScrtcheck")
  @ResponseBody
  public String modeurScrtcheck(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, Model model) throws Exception {


    MemberVO chkVO = memberService.checkMember(memberVO);

    if (chkVO == null)
      return "FAIL";
    else
      return "OK";

  }

  /**
   * 사용자 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param usrVO : 엑셀 다운로드 할 조건이 담긴 사용자 VO
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/xlsModeurList")
  public void xlsModeurList(@ModelAttribute("memberVO") MemberVO memberVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name =
        { {"RN", "NO"}, {"USER_ID", "ID"}, {"USER_NM", "성명"}, {"USER_EMAIL", "이메일"},
            {"USER_CP", "H.P"}, {"USER_AUTH_NM", "권한"}, {"WDT", "등록일"}, {"IS_LOCK", "계정잠김"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List memberOrgList = memberService.xlsMemberList(memberVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List memberXlsList = new ArrayList();
    for (int i = 0; i < memberOrgList.size(); i++) {
      MemberVO vo = (MemberVO) memberOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("USER_ID", vo.getUser_id());
      rsmap.put("USER_NM", vo.getUser_nm());
      rsmap.put("USER_EMAIL", EgovFileScrty.decode(vo.getUser_email()));
      rsmap.put("USER_CP",
          EgovFileScrty.decode(vo.getUser_cp_1()) + "-" + EgovFileScrty.decode(vo.getUser_cp_2())
              + "-" + EgovFileScrty.decode(vo.getUser_cp_3()));
      rsmap.put("USER_AUTH_NM", vo.getUser_auth_nm());
      // rsmap.put("USER_DEPT", vo.getUser_dept());
      rsmap.put("WDT", vo.getWdt());
      rsmap.put("IS_LOCK", vo.getIs_lock());//20200710 추가

      memberXlsList.add(rsmap);
    }

    String fileName = "사용자 정보";


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "USR_MAN", "사용자관리", "사용자 목록 엑셀저장", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    xlsDownUtil.ExcelWrite(response, memberXlsList, colinfoList, fileName);
  }


  /**
   * 탈퇴회원정보 목록을 조회한다.
   * 
   * @param withdrawalVO : 탈퇴한 사용자 조회 조건을 담은 VO
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/withdrawalList")
  public String withdrawalList(@ModelAttribute("withdrawalVO") WithdrawalVO withdrawalVO,
      HttpServletRequest request, Model model) throws Exception {


    /** pageing setting */
    PaginationInfo paginationInfo = new PaginationInfo();
    paginationInfo.setCurrentPageNo(withdrawalVO.getPageIndex());
    paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

    withdrawalVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    withdrawalVO.setLastIndex(paginationInfo.getLastRecordIndex());
    withdrawalVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    List withdrawalList = withdrawalService.selectWithdrawalList(withdrawalVO);
    model.addAttribute("resultList", withdrawalList);

    int totCnt = withdrawalService.selectWithdrawalListTotCnt(withdrawalVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    NumberFormat nf = NumberFormat.getInstance();
    model.addAttribute("curPage", nf.format(paginationInfo.getCurrentPageNo()));
    model.addAttribute("totCnt", nf.format(totCnt));
    model.addAttribute("totPage", nf.format(paginationInfo.getTotalPageCount()));

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "USR_MAN", "사용자관리", "탈퇴회원 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "/modeec/withdrawalList";

  }

  /**
   * 탈퇴회원정보 항목을 삭제한다.
   * 
   * @param withdrawalVO : 삭제할 정보 조건을 가진 사용자 VO
   * @param model
   * @return redirect
   * @exception Exception
   */
  @RequestMapping("/rmvWithdrawal")
  public String rmvWithdrawal(@ModelAttribute("withdrawalVO") WithdrawalVO withdrawalVO,
      ModelMap model) throws Exception {

    withdrawalService.deleteWithdrawal(withdrawalVO);
    // model.addAttribute("resultVO", withdrawalVO);

    return "redirect:/modeur/withdrawalList.do";
  }


  /**
   * 탈퇴회원정보 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param withdrawalVO : 엑셀 다운로드 조건을 가진 사용자 VO
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsWithdrawalSave")
  public void xlsWithdrawalSave(@ModelAttribute("withdrawalVO") WithdrawalVO withdrawalVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name =
        { {"RN", "순번"}, {"WD_IDX", "순번"}, {"USER_ID", "회원ID"}, {"USER_NM", "게시물 순번"},
            {"JDT", "가입일"}, {"WDT", "탈퇴일"}, {"WREASON", "탈퇴사유"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List withdrawalOrgList = withdrawalService.xlsWithdrawalList(withdrawalVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List withdrawalXlsList = new ArrayList();
    for (int i = 0; i < withdrawalOrgList.size(); i++) {
      WithdrawalVO vo = (WithdrawalVO) withdrawalOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("WD_IDX", vo.getWd_idx());
      rsmap.put("USER_ID", vo.getUser_id());
      rsmap.put("USER_NM", vo.getUser_nm());
      rsmap.put("JDT", vo.getJdt());
      rsmap.put("WDT", vo.getWdt());
      rsmap.put("WREASON", vo.getWreason());

      withdrawalXlsList.add(rsmap);
    }

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "USR_MAN", "사용자관리", "탈퇴회원 목록 엑셀저장", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    String fileName = "탈퇴회원정보";
    xlsDownUtil.ExcelWrite(response, withdrawalXlsList, colinfoList, fileName);
  }

	/**
	 * 관리자 회원비밀번호 리셋
	 * 
	 * @param memberVO
	 * @param result
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/resetPass", method = RequestMethod.POST)
	@ResponseBody
	public Object rest_password(@ModelAttribute("memberVO") MemberVO memberVO, BindingResult result,
			HttpServletRequest request, Model model) throws Exception {

		memberVO.setUser_scrt("stop1050*");
		memberService.resetPassword(memberVO);

		// ////////////////////////////////////////////////////////////////////////////////////////////
		//
		// 관리자 로그 저장 C/R/U/D L :
		manlogService.insertManlog(request, "USR_MAN", "사용자관리", "사용자 비밀번호 리셋 : " + memberVO.getUser_id(), "U");
		//
		// ////////////////////////////////////////////////////////////////////////////////////////////

		return "OK";
	}


}
