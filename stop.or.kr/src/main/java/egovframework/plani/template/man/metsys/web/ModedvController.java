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

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CodeGenerater;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.vo.GenActfilesVO;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.metsys.service.TablecrudService;
import egovframework.plani.template.man.metsys.vo.GlobalpropsVO;
import egovframework.plani.template.man.metsys.vo.TablecrudVO;
import egovframework.plani.template.man.stat.service.CommstatService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 개발자 모드 액션 컨트롤
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.man.metsys.web] [EgovModedevController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 8. 오후 5:05:48
 * @version : 1.0
 */
@Controller
@RequestMapping("/modedv")
public class ModedvController {

  /** CommstatService */
  @Resource(name = "commstatService")
  protected CommstatService commstatService;

  /** TablecrudService */
  @Resource(name = "tablecrudService")
  private TablecrudService tablecrudService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;


  /**
   * 개발모드 메인화면 처리
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/modedvPage")
  public String modedvPage(HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    model.addAttribute("dbtype", dbtype.toLowerCase());

    return "/metsys/modedvPage";
  }



  /**
   * 액션추가 처리
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/generateActfiles")
  @ResponseBody
  public String generateActfiles(@ModelAttribute("genactfilesVO") GenActfilesVO genactfilesVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    TablecrudVO tbcrudVO = new TablecrudVO();
    List tablecrudList = null;

    if ("".equals(genactfilesVO.getBaseacttable())) {
      tablecrudList = new ArrayList();
    } else {
      String owner = EgovProperties.getProperty("Globals.UserName");
      tbcrudVO.setOwner(owner);
      tbcrudVO.setTable_name(genactfilesVO.getBaseacttable());
      tablecrudList = tablecrudService.selectTablecolList(tbcrudVO);
    }


    CodeGenerater codegen = new CodeGenerater(genactfilesVO, tablecrudList);
    codegen.genereateSrcAll();

    return "SUCCESS";
  }

  /**
   * 사용자페이지추가 처리
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/generateUserpagefiles")
  @ResponseBody
  public String generateUserpagefiles(@ModelAttribute("genactfilesVO") GenActfilesVO genactfilesVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    TablecrudVO tbcrudVO = new TablecrudVO();
    List tablecrudList = null;

    if ("".equals(genactfilesVO.getBaseacttable())) {
      tablecrudList = new ArrayList();
    } else {
      String owner = EgovProperties.getProperty("Globals.UserName");
      tbcrudVO.setOwner(owner);
      tbcrudVO.setTable_name(genactfilesVO.getBaseacttable());
      tablecrudList = tablecrudService.selectTablecolList(tbcrudVO);
    }


    CodeGenerater codegen = new CodeGenerater(genactfilesVO, tablecrudList);
    codegen.genereateUserpageAll();

    return "SUCCESS";
  }

  /**
   * 관리자 페이지 추가 처리
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/generateManpagefiles")
  @ResponseBody
  public String generateManpagefiles(@ModelAttribute("genactfilesVO") GenActfilesVO genactfilesVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    TablecrudVO tbcrudVO = new TablecrudVO();
    List tablecrudList = null;

    if ("".equals(genactfilesVO.getBaseacttable())) {
      tablecrudList = new ArrayList();
    } else {
      String owner = EgovProperties.getProperty("Globals.UserName");
      tbcrudVO.setOwner(owner);
      tbcrudVO.setTable_name(genactfilesVO.getBaseacttable());
      tablecrudList = tablecrudService.selectTablecolList(tbcrudVO);
    }

    CodeGenerater codegen = new CodeGenerater(genactfilesVO, tablecrudList);
    codegen.genereateManpageAll();

    return "SUCCESS";
  }

  /**
   * 액션 삭제 처리
   * 
   * @param searchVO 목록 삭제조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/rmvActfiles")
  @ResponseBody
  public String rmvActfiles(@ModelAttribute("genactfilesVO") GenActfilesVO genactfilesVO,
      HttpServletRequest request, Model model) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    CodeGenerater codegen = new CodeGenerater(genactfilesVO, null);
    codegen.deleteAll();

    return "SUCCESS";
  }



  /**
   * Global property 설정
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/setGlobalprops")
  @ResponseBody
  public String setGlobalprops(@ModelAttribute("globalpropsVO") GlobalpropsVO globalpropsVO,
      HttpServletRequest request, Model model) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    /*
     * EgovProperties.setProperty("Globals.prjtnm", globalpropsVO.getPrjt_nm());
     * EgovProperties.setProperty("Globals.javaprjt", globalpropsVO.getJavaprjt());
     * EgovProperties.setProperty("Globals.workspacePath", globalpropsVO.getWorkspace());
     * EgovProperties.setProperty("Globals.copyright", globalpropsVO.getCopyright());
     * EgovProperties.setProperty("Globals.fileUploadPath", globalpropsVO.getUploaddir());
     */
    return "SUCCESS";
  }


  /**
   * 테이블 목록을 조회한다.
   * 
   * @param TablecrudVO : 등록할 정보가 담긴 VO
   * @return "/metsys/TablecrudList"
   * @exception Exception
   */
  @RequestMapping("/selectTableList")
  @ResponseBody
  public List selectTableList(@ModelAttribute("TablecrudVO") TablecrudVO tablecrudVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    String owner = EgovProperties.getProperty("Globals.UserName");
    tablecrudVO.setOwner(owner);

    // CMS외에 추가된 테이블 접두어
    tablecrudVO.setTable_prefix_01("TBZ_");
    List tablecrudList = tablecrudService.selectTableList(tablecrudVO);
    // model.addAttribute("tableList", tablecrudList);

    return tablecrudList;

  }

  /**
   * 테이블 컬럼 목록을 조회한다.
   * 
   * @param TablecrudVO : 등록할 정보가 담긴 VO
   * @return "/metsys/TablecrudList"
   * @exception Exception
   */
  @RequestMapping("/selectTablecolList")
  @ResponseBody
  public List selectTablecolList(@ModelAttribute("TablecrudVO") TablecrudVO tablecrudVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    String owner = EgovProperties.getProperty("Globals.UserName");
    tablecrudVO.setOwner(owner);

    List tablecrudList = tablecrudService.selectTablecolList(tablecrudVO);
    // model.addAttribute("colList", tablecrudList);

    return tablecrudList;

  }


}
