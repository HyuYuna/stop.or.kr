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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.stat.service.CommstatService;
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
@RequestMapping("/modeec")
public class ModeecController {


  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /** CommstatService */
  @Resource(name = "commstatService")
  protected CommstatService commstatService;


  /**
   * 기타관리 메인 페이지 처리
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/metsys/modeecPage"
   * @exception Exception
   */
  @RequestMapping("/modeecPage")
  public String modeecPage(HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    return "/modeec/modeecPage";
  }



  /**
   * 기타관리 메뉴 관리 처리
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/modeec/modeecPage"
   * @exception Exception
   */
  @RequestMapping("/menuPage")
  public String menuPage(HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    return "/modeec/menuPage";
  }



  /**
   * 기타관리 카테고리 관리 처리
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/modeec/modeecPage"
   * @exception Exception
   */
  @RequestMapping("/ctgryPage")
  public String ctgryPage(HttpServletRequest request, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    return "/modeec/ctgryPage";
  }

}
