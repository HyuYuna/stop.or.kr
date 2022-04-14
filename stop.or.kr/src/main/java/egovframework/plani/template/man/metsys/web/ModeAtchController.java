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
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 기타 관리(팝업존, 프로젝트명, 로고 관리 등) 액션 컨트롤
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.man.metsys.web] [EgovModeecController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 8. 오후 5:08:30
 * @version : 1.0
 */
@Controller
@RequestMapping("/modeatch")
public class ModeAtchController {


  /** AtchfileService */
  @Resource(name = "atchfileService")
  protected AtchfileService atchfileService;

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

  /**
   * 컨텐츠페이지 등에 링크시키기 위해 사용자가 추가한 첨부파일 목록을 보여줌
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/customAtchPage")
  public String customAtchPage(HttpServletRequest request,
      @ModelAttribute("atchfileVO") AtchfileVO atchfileVO, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    /** pageing setting */
    PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
    paginationInfo.setContextPath(request.getContextPath());
    paginationInfo.setCurrentPageNo(atchfileVO.getPageIndex());
    paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

    atchfileVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    atchfileVO.setLastIndex(paginationInfo.getLastRecordIndex());
    atchfileVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    atchfileVO.setAtckey_1st("CUST_ATCH");
    List resultList = atchfileService.selectCustomAtchfileList(atchfileVO);
    int totCnt = atchfileService.selectCustomAtchfileListTotCnt(atchfileVO);

    int maxcustkey = atchfileService.selectMaxAtchkey2nd(atchfileVO);

    paginationInfo.setTotalRecordCount(totCnt);

    model.addAttribute("resultList", resultList);
    model.addAttribute("paginationInfo", paginationInfo);
    model.addAttribute("maxcustkey", maxcustkey);

    NumberFormat nf = NumberFormat.getInstance();
    model.addAttribute("curPage", nf.format(paginationInfo.getCurrentPageNo()));
    model.addAttribute("totCnt", nf.format(totCnt));
    model.addAttribute("totPage", nf.format(paginationInfo.getTotalPageCount()));


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "ATCH_MAN", "첨부파일관리", "첨부파일 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "/modeatch/customAtchPage";
  }



}
