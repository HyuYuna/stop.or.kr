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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ibm.icu.util.Calendar;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.chart.BarChartUtil;
import egovframework.plani.template.cmm.utils.chart.LineChartUtil;
import egovframework.plani.template.cmm.utils.chart.PieChartUtil;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.stat.service.CommstatService;
import egovframework.plani.template.man.stat.vo.CommstatVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * ??????????????? ?????? ?????????
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.man.metsys.web] [EgovModestController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 8. ?????? 5:09:28
 * @version : 1.0
 */
@Controller
@RequestMapping("/modest")
public class ModestController {


  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;


  @Resource(name = "commstatService")
  private CommstatService commstatService;

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  /**
   * ?????? ???????????? ?????? (?????? ?????? ?????????)
   * 
   * @param searchVO ?????? ???????????? ????????? ?????? VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/modestPage")
  public String modestPage(@ModelAttribute("commstatVO") CommstatVO vo, HttpServletRequest request,
      Model model) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // ????????? ?????? ?????? C/R/U/D L : ?????? X : ????????????
    manlogService.insertManlog(request, "STAT_MAN", "????????????", "?????? ????????????", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    EgovWebUtil.printRequestInfomation(request);

    if (vo.getSrchFromDT() == null || "".equals(vo.getSrchFromDT())) {
      Calendar car = Calendar.getInstance();
      SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
      vo.setSrchToDT(sf.format(car.getTime()));
      car.add(Calendar.MONTH, -1);
      vo.setSrchFromDT(sf.format(car.getTime()));

      if ("MM".equals(vo.getDate_choice())) {
        vo.setSrchFromDT(vo.getSrchFromDT().substring(0, 6));
        vo.setSrchToDT(vo.getSrchToDT().substring(0, 6));
      } else if ("YY".equals(vo.getDate_choice())) {
        vo.setSrchFromDT(vo.getSrchFromDT().substring(0, 4));
        vo.setSrchToDT(vo.getSrchToDT().substring(0, 4));
      }
    }

    List countryList = commstatService.viewstatCountry(vo);
    model.addAttribute("countryList", countryList);

    List cityList = commstatService.viewstatCity(vo);
    model.addAttribute("cityList", cityList);

    List osList = commstatService.viewstatOS(vo);
    model.addAttribute("osList", osList);

    List browserList = commstatService.viewstatBrowser(vo);
    model.addAttribute("browserList", browserList);

    List hourlyList = commstatService.viewstatVisitHourly(vo);
    model.addAttribute("hourlyList", hourlyList);


    // ?????? ????????? ??????
    if ("DD".equals(vo.getDate_choice())) {
      List dailyList = commstatService.viewstatVisitDaily(vo);
      model.addAttribute("dailyList", dailyList);
      model.addAttribute("contactInfo", commstatService.viewstatVisitDailyTotCnt(vo));
    }

    // ?????? ????????? ??????
    else if ("MM".equals(vo.getDate_choice())) {
      List monthlyList = commstatService.viewstatVisitMonthly(vo);
      model.addAttribute("monthlyList", monthlyList);
      model.addAttribute("contactInfo", commstatService.viewstatVisitMonthlyTotCnt(vo));
    }

    // ????????? ????????? ??????
    else if ("YY".equals(vo.getDate_choice())) {
      List yearlyList = commstatService.viewstatVisitYearly(vo);
      model.addAttribute("yearlyList", yearlyList);
      model.addAttribute("contactInfo", commstatService.viewstatVisitYearlyTotCnt(vo));
    }

    return "/modest/modestPage";
  }

  /**
   * ????????? ?????? ?????? ??????
   * 
   * @param vo
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/xlsModestPageList")
  public void xlsModestPageList(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);


    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = { {"RN", "??????"}, {"KEY", "???"}, {"VALUE", "??????"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }



    EgovWebUtil.printRequestInfomation(request);

    if (vo.getSrchFromDT() == null || "".equals(vo.getSrchFromDT())) {
      Calendar car = Calendar.getInstance();
      SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
      vo.setSrchToDT(sf.format(car.getTime()));
      car.add(Calendar.MONTH, -1);
      vo.setSrchFromDT(sf.format(car.getTime()));

      if ("MM".equals(vo.getDate_choice())) {
        vo.setSrchFromDT(vo.getSrchFromDT().substring(0, 6));
        vo.setSrchToDT(vo.getSrchToDT().substring(0, 6));
      } else if ("YY".equals(vo.getDate_choice())) {
        vo.setSrchFromDT(vo.getSrchFromDT().substring(0, 4));
        vo.setSrchToDT(vo.getSrchToDT().substring(0, 4));
      }
    }

    // List countryList = commstatService.viewstatCountry(vo);
    // model.addAttribute("countryList", countryList);
    //
    // List cityList = commstatService.viewstatCity(vo);
    // model.addAttribute("cityList", cityList);
    //
    // List osList = commstatService.viewstatOS(vo);
    // model.addAttribute("osList", osList);
    //
    // List browserList = commstatService.viewstatBrowser(vo);
    // model.addAttribute("browserList", browserList);
    //
    // List hourlyList = commstatService.viewstatVisitHourly(vo);
    // model.addAttribute("hourlyList", hourlyList);


    CommstatVO cntvo = new CommstatVO();
    List xlsList = new ArrayList();
    List clist = new ArrayList();
    // ?????? ????????? ??????
    if ("DD".equals(vo.getDate_choice())) {
      xlsList = commstatService.viewstatVisitDaily(vo);
      cntvo = commstatService.viewstatVisitDailyTotCnt(vo);
    }

    // ?????? ????????? ??????
    else if ("MM".equals(vo.getDate_choice())) {
      xlsList = commstatService.viewstatVisitMonthly(vo);
      cntvo = commstatService.viewstatVisitMonthlyTotCnt(vo);
    }

    // ????????? ????????? ??????
    else if ("YY".equals(vo.getDate_choice())) {
      xlsList = commstatService.viewstatVisitYearly(vo);;
      cntvo = commstatService.viewstatVisitYearlyTotCnt(vo);
    }
    for (int i = 0; i < xlsList.size(); i++) {
      CommstatVO cvo = (CommstatVO) xlsList.get(i);
      HashMap rsmap = new HashMap();
      rsmap.put("RN", cvo.getRn());
      rsmap.put("KEY", cvo.getChartdata_key());
      rsmap.put("VALUE", cvo.getChartdata_val());
      clist.add(rsmap);
    }

    String fileName = "????????? ??????";

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // ????????? ?????? ?????? C/R/U/D L : ?????? X : ????????????
    manlogService.insertManlog(request, "STAT_MAN", "????????????", "??????????????? ????????????", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    xlsDownUtil.ExcelWrite(response, clist, colinfoList, fileName);

  }

  /**
   * ?????? (???????????? ??????) ??????
   * 
   * @param searchVO ?????? ???????????? ????????? ?????? VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/modestpgPage")
  public String modestpgPage(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, Model model) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // ????????? ?????? ?????? C/R/U/D L : ?????? X : ????????????
    manlogService.insertManlog(request, "STAT_MAN", "????????????", "?????? ????????????", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    EgovWebUtil.printRequestInfomation(request);

    if (vo.getSrchFromDT() == null || "".equals(vo.getSrchFromDT())) {
      Calendar car = Calendar.getInstance();
      SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
      vo.setSrchToDT(sf.format(car.getTime()));
      car.add(Calendar.MONTH, -1);
      vo.setSrchFromDT(sf.format(car.getTime()));
    }

    List pageList = commstatService.viewstatVisitPage(vo);
    model.addAttribute("pageList", pageList);

    return "/modest/modestpgPage";
  }

  /**
   * ???????????? ?????? ?????? ??????
   * 
   * @param vo
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/xlsModestpgPageList")
  public void xlsModestpgPageList(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);


    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = { {"RN", "??????"}, {"NAME", "????????????"}, {"VALUE", "??????"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }



    EgovWebUtil.printRequestInfomation(request);

    if (vo.getSrchFromDT() == null || "".equals(vo.getSrchFromDT())) {
      Calendar car = Calendar.getInstance();
      SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
      vo.setSrchToDT(sf.format(car.getTime()));
      car.add(Calendar.MONTH, -1);
      vo.setSrchFromDT(sf.format(car.getTime()));
    }

    List pageList = commstatService.viewstatVisitPage(vo);
    List clist = new ArrayList();

    for (int i = 0; i < pageList.size(); i++) {
      CommstatVO cvo = (CommstatVO) pageList.get(i);
      HashMap rsmap = new HashMap();
      rsmap.put("RN", cvo.getRn());
      rsmap.put("NAME", cvo.getChartdata_key());
      rsmap.put("VALUE", cvo.getChartdata_val());
      clist.add(rsmap);
    }

    String fileName = "???????????? ??????";

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // ????????? ?????? ?????? C/R/U/D L : ?????? X : ????????????
    manlogService.insertManlog(request, "STAT_MAN", "????????????", "?????????????????? ????????????", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    xlsDownUtil.ExcelWrite(response, clist, colinfoList, fileName);

  }


  /**
   * ????????? ??????
   * 
   * @param vo ?????? ???????????? ????????? ?????? VO
   * @param model
   * @exception Exception
   */
  @RequestMapping("/viewstatCountry")
  public void viewstatCountry(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    List chartList = commstatService.viewstatCountry(vo);
    PieChartUtil chart = new PieChartUtil(response, chartList);

    chart.setChartTitle("????????? ??????");
    chart.setRangeTitle("?????????");
    chart.setChartWidth(380);
    chart.setChartHeight(360);

    chart.genChartAsStream();


  }

  /**
   * ????????? ??????
   * 
   * @param vo ?????? ???????????? ????????? ?????? VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatCity")
  public void viewstatCity(@ModelAttribute("commstatVO") CommstatVO vo, HttpServletRequest request,
      HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    List chartList = commstatService.viewstatCity(vo);
    PieChartUtil chart = new PieChartUtil(response, chartList);

    chart.setChartTitle("????????? ??????");
    chart.setRangeTitle("?????????");
    chart.setChartWidth(380);
    chart.setChartHeight(360);

    chart.genChartAsStream();


  }

  /**
   * OS??? ??????
   * 
   * @param vo ?????? ???????????? ????????? ?????? VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatOS")
  public void viewstatOS(@ModelAttribute("commstatVO") CommstatVO vo, HttpServletRequest request,
      HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    List chartList = commstatService.viewstatOS(vo);
    PieChartUtil chart = new PieChartUtil(response, chartList);

    chart.setChartTitle("O/S??? ??????");
    chart.setRangeTitle("?????????");
    chart.setChartWidth(380);
    chart.setChartHeight(360);

    chart.genChartAsStream();


  }

  /**
   * ??????????????? ??????
   * 
   * @param vo ?????? ???????????? ????????? ?????? VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatBrowser")
  public void viewstatBrowser(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    List chartList = commstatService.viewstatBrowser(vo);
    PieChartUtil chart = new PieChartUtil(response, chartList);

    chart.setChartTitle("??????????????? ??????");
    chart.setRangeTitle("?????????");
    chart.setChartWidth(380);
    chart.setChartHeight(360);

    chart.genChartAsStream();


  }


  /**
   * ????????? ?????? ??????
   * 
   * @param vo ?????? ???????????? ????????? ?????? VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatVisitHourly")
  public void viewstatVisitHourly(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    List chartList = commstatService.viewstatVisitHourly(vo);
    BarChartUtil chart = new BarChartUtil(response, chartList);

    chart.setChartTitle("????????? ?????? ??????");
    chart.setRangeTitle("?????????");
    chart.setChartWidth(800);
    chart.setChartHeight(500);

    chart.genChartAsStream();
  }


  /**
   * ????????? ?????? ??????
   * 
   * @param vo ?????? ???????????? ????????? ?????? VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatVisitDaily")
  public void viewstatVisitDaily(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    List chartList = commstatService.viewstatVisitDaily(vo);
    LineChartUtil chart = new LineChartUtil(response, chartList);

    chart.setChartTitle("????????? ?????? ??????");
    chart.setRangeTitle("?????????");
    chart.setChartWidth(800);
    chart.setChartHeight(500);

    chart.genChartAsStream();
  }

  /**
   * ?????? ?????? ??????
   * 
   * @param vo ?????? ???????????? ????????? ?????? VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatVisitMonthly")
  public void viewstatVisitMonthly(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    List chartList = commstatService.viewstatVisitMonthly(vo);
    LineChartUtil chart = new LineChartUtil(response, chartList);

    chart.setChartTitle("?????? ?????? ??????");
    chart.setRangeTitle("?????????");
    chart.setChartWidth(700);
    chart.setChartHeight(500);

    chart.genChartAsStream();
  }

  /**
   * ????????? ?????? ??????
   * 
   * @param vo ?????? ???????????? ????????? ?????? VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatVisitYearly")
  public void viewstatVisitYearly(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* ????????? ???????????????. */);

    List chartList = commstatService.viewstatVisitYearly(vo);
    LineChartUtil chart = new LineChartUtil(response, chartList);

    chart.setChartTitle("????????? ?????? ??????");
    chart.setRangeTitle("?????????");
    chart.setChartWidth(700);
    chart.setChartHeight(500);

    chart.genChartAsStream();
  }


}
