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
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.nhncorp.lucy.security.xss.XssSaxFilter;

import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.tagfree.TagFree;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.plani.template.man.metsys.service.ContentsmanService;
import egovframework.plani.template.man.metsys.vo.ContentsmanVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 디자인모드 액션 컨트롤
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.man.metsys.web] [EgovModedgController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 8. 오후 5:08:11
 * @version : 1.0
 */
@Controller
@RequestMapping("/modedg")
public class ModedgController {

  /** ContentsmanService */
  @Resource(name = "contentsmanService")
  private ContentsmanService contentsmanService;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;

  /** SyscodeService */
  @Resource(name = "syscodeService")
  private SyscodeService syscodeService;


  /**
   * 컨텐츠 목록을 조회한다.
   * 
   * @param contentsmanVO : 조회할 정보
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/modedgList")
  public String modedgList(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, Model model) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "CONT_MAN", "컨텐츠관리", "컨텐츠 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    String mu_site = contentsmanVO.getSrch_mu_site();
    if(mu_site!=null){
    	mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_site);//20191108 취약점 조치 추가
    }
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    contentsmanVO.setSrch_mu_site(mu_site);

    String mu_lang = contentsmanVO.getSrch_mu_lang();
    if(mu_lang!=null){
    	mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_lang);//20191108 취약점 조치 추가
    }
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;
    contentsmanVO.setSrch_mu_lang(mu_lang);

    /** pageing setting */
    PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
    paginationInfo.setContextPath(request.getContextPath());
    paginationInfo.setCurrentPageNo(contentsmanVO.getPageIndex());
    paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

    contentsmanVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    contentsmanVO.setLastIndex(paginationInfo.getLastRecordIndex());
    contentsmanVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    List contentsmanList = contentsmanService.selectContentsmanList(contentsmanVO);
    model.addAttribute("resultList", contentsmanList);

    int totCnt = contentsmanService.selectContentsmanListTotCnt(contentsmanVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    NumberFormat nf = NumberFormat.getInstance();
    model.addAttribute("curPage", nf.format(paginationInfo.getCurrentPageNo()));
    model.addAttribute("totCnt", nf.format(totCnt));
    model.addAttribute("totPage", nf.format(paginationInfo.getTotalPageCount()));

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

    return "/metsys/modedgList";

  }


  /**
   * 메뉴와 연결된 컨텐트 메뉴 구조를 보여준다.
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/modedgmenuList")
  public String modedgmenuList(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, Model model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    // //////////////////////////////////////////////////////////////////////////////////
    // pageing setting Start
    String mu_site = contentsmanVO.getSrch_mu_site();
    if(mu_site!=null){
    	mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_site);//20191108 취약점 조치 추가
    }
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    contentsmanVO.setSrch_mu_site(mu_site);

    String mu_lang = contentsmanVO.getSrch_mu_lang();
    if(mu_lang!=null){
    	mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_lang);//20191108 취약점 조치 추가
    }
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;
    contentsmanVO.setSrch_mu_lang(mu_lang);

    // List boardinfoList = contentsmanService.selectContentsmanmenuList(contentsmanVO);
    String dbtype = EgovProperties.getProperty("Globals.DbType");
    List contentsList = contentsmanService.selectContentsmanmenuList(contentsmanVO);

    if ("mysql".equals(dbtype)) {

      EgovWebUtil.getLeveldList(contentsList, null, 1, new Integer(1));

      if (contentsList.size() > 0) {
        // 조작하기 편하도록 필요한 데이터만 String 배열로 빼낸다.
        String[][] orgList = new String[contentsList.size()][3];
        for (int i = 0; i < contentsList.size(); i++) {
          SysmenuVO menuVO = (SysmenuVO) contentsList.get(i);
          // if(menuVO.getBrd_id())

          orgList[i][0] = menuVO.getMenu_idx();
          orgList[i][1] = menuVO.getUp_menu_idx();
          orgList[i][2] = menuVO.getUcont_id();
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
        for (int i = contentsList.size() - 1; i >= 0; i--) {
          SysmenuVO menuVO = (SysmenuVO) contentsList.get(i);

          String chkmenu = menuVO.getMenu_idx();
          boolean chkbool = false;

          for (int j = 0; j < srchList.size(); j++) {
            String vMenu = (String) srchList.get(j);
            if (vMenu.equals(chkmenu))
              chkbool = true;
          }

          if (chkbool == false)
            contentsList.remove(i);
        }

        // 번호순서가 바뀌었기때문에 맞게 변경한다.
        for (int i = 0; i < contentsList.size(); i++) {
          SysmenuVO menuVO = (SysmenuVO) contentsList.get(i);
          menuVO.setRn(i + 1);
        }

      }
    }

    model.addAttribute("resultList", contentsList);

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
    manlogService.insertManlog(request, "CONT_MAN", "컨텐츠관리", "컨텐츠 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/metsys/modedgmenuList";
  }


  /**
   * 목록을 조회한다. JSON 반환
   * 
   * @param contentsmanVO : 조회할 정보
   * @param request
   * @param model
   * @return List
   * @exception Exception
   */
  @RequestMapping("/modedgJsonList")
  @ResponseBody
  public List modedgJsonList(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    contentsmanVO.setFirstIndex(0);
    contentsmanVO.setLastIndex(1000);
    contentsmanVO.setRecordCountPerPage(1000);

    List contentsmanList = contentsmanService.selectContentsmanList(contentsmanVO);

    return contentsmanList;
  }

  /**
   * 컨텐츠 추가 / 조회 / 수정 화면으로 이동.
   * 
   * @param contentsmanVO : 조회할 정보
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/contentsmanView")
  public String contentsmanView(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    String edomweivgp = contentsmanVO.getEdomweivgp();
    if ("M".equals(edomweivgp) || "P".equals(edomweivgp)) {
      ContentsmanVO resultVO = contentsmanService.selectContentsman(contentsmanVO);
      resultVO.setEdomweivgp(edomweivgp);
      resultVO.setPageIndex(contentsmanVO.getPageIndex());
      resultVO.setSrch_mu_gub(contentsmanVO.getSrch_mu_gub());
      resultVO.setSrch_mu_site(contentsmanVO.getSrch_mu_site());
      resultVO.setSrch_mu_lang(contentsmanVO.getSrch_mu_lang());
      resultVO.setSeltab_idx(contentsmanVO.getSeltab_idx());
      model.addAttribute("contentsmanVO", resultVO);

      // 첨부파일 목록 가져오기
      AtchfileVO fileVO = new AtchfileVO();
      fileVO.setAtckey_1st(EgovProperties.CONTENTS_UPLOAD_KEY);
      fileVO.setAtckey_2nd(resultVO.getUcont_id());
      fileVO.setAtckey_3rd(resultVO.getUcont_version());
      List fileList = atchfileService.selectAtchfileList(fileVO);

      model.addAttribute("atchfileList", fileList);
      model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());

      List contentsmanList = contentsmanService.selectContentsmanList(contentsmanVO);
      model.addAttribute("resultList", contentsmanList);
      model.addAttribute("totCnt", contentsmanList.size());


      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "CONT_MAN", "컨텐츠관리",
          "컨텐츠 상세조회 [" + resultVO.getUcont_subject() + "]", "R");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

    } else {
      model.addAttribute("totCnt", 0);
    }

    model.addAttribute("CONTENTS_UPLOAD_KEY", EgovProperties.CONTENTS_UPLOAD_KEY);


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

    // 미리보기
    if (("P".equals(edomweivgp)))
      return "/metsys/contentsmanPreview";
    else
      return "/metsys/contentsmanView";
  }


  /**
   * 항목을 추가한다.
   * 
   * @param contentsmanVO : 추가할 정보
   * @param request
   * @param model
   * @return seq값
   * @exception Exception
   */
  @RequestMapping("/addContentsman")
  @ResponseBody
  public String addContentsman(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    if (contentsmanVO.getUcont_subject() == null || "".equals(contentsmanVO.getUcont_subject())
        || contentsmanVO.getUcont_cont() == null || "".equals(contentsmanVO.getUcont_cont())) {
      throw new AjaxException(
          MessageHelper.getMessage("REQUIRED-VALUE-IS-MISSING")/*
                                                                * 필수 입력값이 누락되었습니다.
                                                                */);
    }

    String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
    contentsmanVO.setWriter(writer);

    contentsmanService.insertContentsman(contentsmanVO);
    String key = contentsmanVO.getUcont_id();

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "CONT_MAN", "컨텐츠관리",
        "컨텐츠 추가 [" + contentsmanVO.getUcont_subject() + "]", "C");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return key + "_" + 1;
  }

  /**
   * 항목을 추가한다.
   * 
   * @param contentsmanVO : 추가할 정보
   * @exception Exception
   */
  @RequestMapping("/newverContentsman")
  @ResponseBody
  public String newverContentsman(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
    contentsmanVO.setWriter(writer);

    int version = contentsmanService.insertContentsmanNewver(contentsmanVO);

    return contentsmanVO.getUcont_id() + "_" + version;
  }

  /**
   * 항목을 삭제한다.
   * 
   * @param contentsmanVO : 삭제할 정보
   * @param request
   * @param model
   * @return redirect[srch_menu_nix="메뉴코드명",pageIndex="현재페이지"]
   * @exception Exception
   */
  @RequestMapping("/rmvContentsman")
  public String rmvContentsman(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    contentsmanService.deleteContentsman(contentsmanVO);
    // model.addAttribute("resultVO", contentsmanVO);


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    ContentsmanVO resultVO = contentsmanService.selectContentsman(contentsmanVO);
    manlogService.insertManlog(request, "CONT_MAN", "컨텐츠관리", "컨텐츠 삭제 ["
        + (resultVO == null ? contentsmanVO.getUcont_subject() : contentsmanVO.getUcont_subject())
        + "]", "D");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "redirect:/modedg/ContentsmanList.do?srch_menu_nix=" + contentsmanVO.getSrch_menu_nix()
        + "pageIndex=1&seltab_idx=" + contentsmanVO.getSeltab_idx();
  }

  /**
   * 항목을 수정한다.
   * 
   * @param contentsmanVO : 수정할 정보
   * @param request
   * @param model
   * @return 컨텐츠id,컨텐츠버전
   * @exception Exception
   */
  @RequestMapping("/mdfContentsman")
  @ResponseBody
  public String mdfContentsman(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    String modifier = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
    contentsmanVO.setModifier(modifier);

    contentsmanService.updateContentsman(contentsmanVO);


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "CONT_MAN", "컨텐츠관리",
        "컨텐츠 변경 [" + contentsmanVO.getUcont_subject() + "]", "U");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return contentsmanVO.getUcont_id() + "_" + contentsmanVO.getUcont_version();
  }


  /**
   * 컨텐츠의 버전을 복원한다 을/를 삭제한다.
   * 
   * @param modedgVO : 삭제할 정보
   * @param request
   * @param model
   * @return success
   * @exception Exception
   */
  @RequestMapping("/restoreContentsman")
  @ResponseBody
  public String restoreContentsman(@ModelAttribute("modedgVO") ContentsmanVO modedgVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    contentsmanService.restoreContentsman(modedgVO);
    return "SUCCESS";
  }


  /**
   * 연결메뉴를 삭제한다.
   * 
   * @param contentsmanVO : 삭제할정보
   * @param request
   * @param model
   * @return success
   * @exception Exception
   */
  @RequestMapping("/rmvRef_srch_menu_nix")
  @ResponseBody
  public String rmvRef_srch_menu_nix(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    contentsmanService.updateContentsmanMenunix(contentsmanVO);

    return "SUCCESS";
  }



  /**
   * 컨텐츠 조회.
   * 
   * @param contentsmanVO : 조회할 정보
   * @param request
   * @param model
   * @return tiles/컨텐츠언어/
   * @exception Exception
   */
  @RequestMapping("/contentsView")
  public String contentsView(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, ModelMap model) throws Exception {
	  
    String returnUrl = "/contents/contentsView";
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String mu_lang = contentsmanVO.getSrch_mu_lang();
    if(mu_lang!=null){
    	mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_lang);//20191108 취약점 조치 추가
    }
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;

    String mu_site = contentsmanVO.getSrch_mu_site();
    if(mu_site!=null){
    	mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(mu_site);//20191108 취약점 조치 추가
    }
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;
    System.out.println("##mu_site:"+mu_site);
    contentsmanVO.setSrch_mu_site(mu_site);


    if ("mdo".equals(ext)) {
      returnUrl = "/mbl" + returnUrl;
    } else {

      if ("CDIDX00002".equals(mu_site) == true) {
        // if ("CDIDX00022".equals(mu_lang) == false)
        // returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
        if ("CDIDX00022".equals(mu_lang) == false)
          returnUrl = "/eng" + returnUrl;
      } else if ("CDIDX00005".equals(mu_site) == true)
        returnUrl = "/women" + returnUrl;
      // 2018-07-20 : pigcos 공모전
      else if ("CDIDX00004".equals(mu_site) == true)
        returnUrl = "/complicity" + returnUrl;
    }

    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(contentsmanVO.getSrch_menu_nix());
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();
    int subcnt = 0;
    model.addAttribute("nowMenuVO", menuVO);

    // 탭메뉴인 경우 탭메뉴 형제 탭메뉴 컨텐츠를 읽어온다.
    if ("Y".equals(menuVO.getTabmenu_yn())) {
      // 메뉴와 연관된 컨텐츠 목록을 직접 읽어오기 어려우므로
      // 이미 구성되어 세션에 저장된 메뉴목록에서 현재 탭으로 구성된 메뉴 목록을 구한다.
      // 메인페이지를 거치지 않고 주소 입력으로 바로 들어온 경우 세션에 메뉴구성이 되어있지 않으므로
      // 조회해서 메뉴목록을 가져온다.
      List sess_main_menu = null;

      if ("USR".equals(contentsmanVO.getMu_gub()) && "CDIDX00022".equals(mu_lang)) {
        if ("CDIDX00002".equals(mu_site))
          sess_main_menu =
              (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MAIN_MENU");
        else if ("CDIDX00005".equals(mu_site))
          sess_main_menu =
              (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_WOMEN_MENU");
        else if ("CDIDX00003".equals(mu_site))
          sess_main_menu =
              (List) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_MBL_MENU");
      }

      if (sess_main_menu == null) {
        SysmenuVO srchmenuVO = new SysmenuVO();
        srchmenuVO.setMu_gub("USR");
        srchmenuVO.setMu_site(mu_site);
        srchmenuVO.setMu_lang(mu_lang);

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


    ContentsmanVO resultVO = contentsmanService.selectContentsman(contentsmanVO);

    if (resultVO == null)
      throw new CmmnException(MessageHelper
          .getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST")/*
                                                                  * 요청하신 컨텐츠가 존재하지 않습니다 .
                                                                  */);

    model.addAttribute("contentsmanVO", resultVO);

    // 첨부파일 목록 가져오기
    AtchfileVO fileVO = new AtchfileVO();
    fileVO.setAtckey_1st(EgovProperties.CONTENTS_UPLOAD_KEY);
    fileVO.setAtckey_2nd(contentsmanVO.getUcont_id());
    fileVO.setAtckey_3rd(contentsmanVO.getUcont_version());
    List fileList = atchfileService.selectAtchfileList(fileVO);

    model.addAttribute("atchfileList", fileList);
    model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());

    return returnUrl;
  }

  /**
   * 컨텐츠 조회.
   * 
   * @param contentsmanVO : 조회할 정보
   * @exception Exception
   */
  @RequestMapping("/contentsBoard")
  public String contentsBoard(@ModelAttribute("contentsmanVO") ContentsmanVO contentsmanVO,
      HttpServletRequest request, ModelMap model) throws Exception {


    String returnUrl = "/contents/contentsView";
    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;

    return returnUrl;
  }

  /**
   * 내용 미리보기
   * 
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/contPreview")
  public String contPreview(HttpServletRequest request, ModelMap model) throws Exception {

    String content = request.getParameter("previewContent");
    String css = request.getParameter("previewCss");

    TagFree tagFree = new TagFree();
    content = tagFree.submit(content, "temp");

    model.addAttribute("content", content);
    model.addAttribute("css", css);
    return "/metsys/contentsmanPreview";
  }
}
