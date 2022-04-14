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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.custom.memsvc.service.MemberService;
import egovframework.plani.template.man.stat.service.CommstatService;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 관리자 페이지 액션 컨트롤
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.man.metsys.web] [EgovMetsysController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 8. 오후 5:07:57
 * @version : 1.0
 */
@Controller
@RequestMapping("/modedt")
public class ModedtController {


  /** CommstatService */
  @Resource(name = "commstatService")
  protected CommstatService commstatService;

  /** MemberService */
  @Resource(name = "memberService")
  MemberService memberService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /**
   * 데이터 입력 페이지.
   * 
   * @param model
   * @exception Exception
   */
  @RequestMapping("/datainsPage")
  public String datainsPage(Model model) throws Exception {

    return "/modedt/datainsPage";
  }


}
