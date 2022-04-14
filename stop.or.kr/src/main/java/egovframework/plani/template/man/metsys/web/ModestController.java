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
 * 통계페이지 액션 컨트롤
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.man.metsys.web] [EgovModestController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 8. 오후 5:09:28
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
   * 통계 메인화면 처리 (처음 접속 페이지)
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/modestPage")
  public String modestPage(@ModelAttribute("commstatVO") CommstatVO vo, HttpServletRequest request,
      Model model) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "STAT_MAN", "통계관리", "통계 목록조회", "L");
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


    // 월별 통계인 경우
    if ("DD".equals(vo.getDate_choice())) {
      List dailyList = commstatService.viewstatVisitDaily(vo);
      model.addAttribute("dailyList", dailyList);
      model.addAttribute("contactInfo", commstatService.viewstatVisitDailyTotCnt(vo));
    }

    // 월별 통계인 경우
    else if ("MM".equals(vo.getDate_choice())) {
      List monthlyList = commstatService.viewstatVisitMonthly(vo);
      model.addAttribute("monthlyList", monthlyList);
      model.addAttribute("contactInfo", commstatService.viewstatVisitMonthlyTotCnt(vo));
    }

    // 연도별 통계인 경우
    else if ("YY".equals(vo.getDate_choice())) {
      List yearlyList = commstatService.viewstatVisitYearly(vo);
      model.addAttribute("yearlyList", yearlyList);
      model.addAttribute("contactInfo", commstatService.viewstatVisitYearlyTotCnt(vo));
    }

    return "/modest/modestPage";
  }

  /**
   * 접속별 통계 엑셀 다운
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
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = { {"RN", "순번"}, {"KEY", "월"}, {"VALUE", "합계"}};

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
    // 월별 통계인 경우
    if ("DD".equals(vo.getDate_choice())) {
      xlsList = commstatService.viewstatVisitDaily(vo);
      cntvo = commstatService.viewstatVisitDailyTotCnt(vo);
    }

    // 월별 통계인 경우
    else if ("MM".equals(vo.getDate_choice())) {
      xlsList = commstatService.viewstatVisitMonthly(vo);
      cntvo = commstatService.viewstatVisitMonthlyTotCnt(vo);
    }

    // 연도별 통계인 경우
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

    String fileName = "접속별 통계";

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "STAT_MAN", "통계관리", "접속별통계 엑셀다운", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    xlsDownUtil.ExcelWrite(response, clist, colinfoList, fileName);

  }

  /**
   * 통계 (페이지별 통계) 처리
   * 
   * @param searchVO 목록 조회조건 정보가 담긴 VO
   * @param model
   * @return "/cnslreq/cnslreqStep01"
   * @exception Exception
   */
  @RequestMapping("/modestpgPage")
  public String modestpgPage(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, Model model) throws Exception {


    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "STAT_MAN", "통계관리", "통계 목록조회", "L");
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
   * 페이지별 통계 엑셀 다운
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
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = { {"RN", "순번"}, {"NAME", "페이지명"}, {"VALUE", "합계"}};

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

    String fileName = "페이지별 통계";

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "STAT_MAN", "통계관리", "페이지별통계 엑셀다운", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    xlsDownUtil.ExcelWrite(response, clist, colinfoList, fileName);

  }


  /**
   * 국가별 통계
   * 
   * @param vo 목록 조회조건 정보가 담긴 VO
   * @param model
   * @exception Exception
   */
  @RequestMapping("/viewstatCountry")
  public void viewstatCountry(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List chartList = commstatService.viewstatCountry(vo);
    PieChartUtil chart = new PieChartUtil(response, chartList);

    chart.setChartTitle("국가별 통계");
    chart.setRangeTitle("방문수");
    chart.setChartWidth(380);
    chart.setChartHeight(360);

    chart.genChartAsStream();


  }

  /**
   * 도시별 통계
   * 
   * @param vo 목록 조회조건 정보가 담긴 VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatCity")
  public void viewstatCity(@ModelAttribute("commstatVO") CommstatVO vo, HttpServletRequest request,
      HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List chartList = commstatService.viewstatCity(vo);
    PieChartUtil chart = new PieChartUtil(response, chartList);

    chart.setChartTitle("도시별 통계");
    chart.setRangeTitle("방문수");
    chart.setChartWidth(380);
    chart.setChartHeight(360);

    chart.genChartAsStream();


  }

  /**
   * OS별 통계
   * 
   * @param vo 목록 조회조건 정보가 담긴 VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatOS")
  public void viewstatOS(@ModelAttribute("commstatVO") CommstatVO vo, HttpServletRequest request,
      HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List chartList = commstatService.viewstatOS(vo);
    PieChartUtil chart = new PieChartUtil(response, chartList);

    chart.setChartTitle("O/S별 통계");
    chart.setRangeTitle("방문수");
    chart.setChartWidth(380);
    chart.setChartHeight(360);

    chart.genChartAsStream();


  }

  /**
   * 브라우저별 통계
   * 
   * @param vo 목록 조회조건 정보가 담긴 VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatBrowser")
  public void viewstatBrowser(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List chartList = commstatService.viewstatBrowser(vo);
    PieChartUtil chart = new PieChartUtil(response, chartList);

    chart.setChartTitle("브라우저별 통계");
    chart.setRangeTitle("방문수");
    chart.setChartWidth(380);
    chart.setChartHeight(360);

    chart.genChartAsStream();


  }


  /**
   * 시간별 접속 통계
   * 
   * @param vo 목록 조회조건 정보가 담긴 VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatVisitHourly")
  public void viewstatVisitHourly(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List chartList = commstatService.viewstatVisitHourly(vo);
    BarChartUtil chart = new BarChartUtil(response, chartList);

    chart.setChartTitle("시간별 접속 통계");
    chart.setRangeTitle("방문수");
    chart.setChartWidth(800);
    chart.setChartHeight(500);

    chart.genChartAsStream();
  }


  /**
   * 날짜별 접속 통계
   * 
   * @param vo 목록 조회조건 정보가 담긴 VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatVisitDaily")
  public void viewstatVisitDaily(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List chartList = commstatService.viewstatVisitDaily(vo);
    LineChartUtil chart = new LineChartUtil(response, chartList);

    chart.setChartTitle("일자별 접속 통계");
    chart.setRangeTitle("방문수");
    chart.setChartWidth(800);
    chart.setChartHeight(500);

    chart.genChartAsStream();
  }

  /**
   * 월별 접속 통계
   * 
   * @param vo 목록 조회조건 정보가 담긴 VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatVisitMonthly")
  public void viewstatVisitMonthly(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List chartList = commstatService.viewstatVisitMonthly(vo);
    LineChartUtil chart = new LineChartUtil(response, chartList);

    chart.setChartTitle("월별 접속 통계");
    chart.setRangeTitle("방문수");
    chart.setChartWidth(700);
    chart.setChartHeight(500);

    chart.genChartAsStream();
  }

  /**
   * 연도별 접속 통계
   * 
   * @param vo 목록 조회조건 정보가 담긴 VO
   * @param model
   * @exception Exception
   */

  @RequestMapping("/viewstatVisitYearly")
  public void viewstatVisitYearly(@ModelAttribute("commstatVO") CommstatVO vo,
      HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

    int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    List chartList = commstatService.viewstatVisitYearly(vo);
    LineChartUtil chart = new LineChartUtil(response, chartList);

    chart.setChartTitle("연도별 접속 통계");
    chart.setRangeTitle("방문수");
    chart.setChartWidth(700);
    chart.setChartHeight(500);

    chart.genChartAsStream();
  }


}
