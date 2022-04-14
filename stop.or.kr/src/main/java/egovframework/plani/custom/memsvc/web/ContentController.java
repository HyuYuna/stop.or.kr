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
package egovframework.plani.custom.memsvc.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.brdartcl.service.BoardarticleService;
import egovframework.plani.template.brdartcl.service.BoarddryService;
import egovframework.plani.template.brdartcl.service.BoardfaqService;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.service.BoardthmService;
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.plani.template.man.popup.service.PopupService;
import egovframework.plani.template.man.popup.vo.PopupVO;
import egovframework.plani.template.man.stat.service.CommstatService;
import egovframework.plani.template.survey.service.SrvymainService;
import egovframework.plani.template.survey.vo.SrvymainVO;
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
@RequestMapping("/contents")
public class ContentController {

  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  protected BoardinfoService boardinfoService;

  /** BoardarticleService */
  @Resource(name = "boardarticleService")
  protected BoardarticleService boardarticleService;

  /** BoardfaqService */
  @Resource(name = "boardfaqService")
  protected BoardfaqService boardfaqService;

  /** BoarddryService */
  @Resource(name = "boarddryService")
  protected BoarddryService boarddryService;

  /** BoardthmService */
  @Resource(name = "boardthmService")
  protected BoardthmService boardthmService;

  /** PopupService */
  @Resource(name = "popupService")
  protected PopupService popupService;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  /** CommstatService */
  @Resource(name = "commstatService")
  protected CommstatService commstatService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;


  /** ContentsmanService */
  @Resource(name = "syscodeService")
  private SyscodeService syscodeService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** SrvymainService */
  @Resource(name = "srvymainService")
  private SrvymainService srvymainService;

  /**
   * 컨텐츠 메인화면 처리 (처음 접속 페이지)
   * 
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/siteMain")
  public String siteMain(HttpServletRequest request, Model model, HttpServletResponse response,
      SessionLocaleResolver sessionLocaleResolver) throws Exception {

    // 디폴트 언어 설정
    MessageHelper.checkDefaultLocale();

    // ## TPCODE : TPAGE0018 : 메인페이지(Action) ##

    long start = System.currentTimeMillis();

    String returnUrl = "/contents/mainView";
    String ext = EgovWebUtil.getExtension(request.getRequestURI());


    String srch_mu_lang = request.getParameter("srch_mu_lang");    
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    String srch_mu_site = request.getParameter("srch_mu_site");
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;

    if ("CDIDX00005".equals(srch_mu_site) == true)
      returnUrl = "/women" + returnUrl;

    // try {
    // // 국문
    // if ("CDIDX00022".equals(srch_mu_lang)) {
    // // 대표웹
    // if ("CDIDX00002".equals(srch_mu_site)) {
    // // 메인 팝업창 정보 조회
    // PopupVO popVO = new PopupVO();
    // popVO.setPop_type("W");
    // List popupList = popupService.selectValidPopupList(popVO);
    //
    // // 메인 팝업존 정보 조회
    // popVO.setPop_type("Z");
    // List popzoneList = popupService.selectValidPopupList(popVO);
    //
    //
    // ///////////////////////////////////////////////////////////////////
    // // 메인화면 설문조사 조회 Start
    // SrvymainVO srvyVO = new SrvymainVO();
    // srvyVO.setSrch_srvy_act_yn("Y");
    // List srvyList = srvymainService.selectSrvymainList(srvyVO);
    //
    // // 유효한 설문조사가 있을 경우
    // // 팝업과 팝업존(설정에 따라)에 추가한다.
    // if (srvyList != null) {
    // /*
    // * 현재 테스트단계에서 팝업이 표시되면 안되므로 주석처리 한다. 이 for 문의 주석만 제거하면 정상동작함.
    // */
    // for (int i = 0; i < srvyList.size(); i++) {
    // srvyVO = (SrvymainVO) srvyList.get(i);
    //
    // // 팝업창인 경우 팝업창에 추가
    // if ("W".equals(srvyVO.getSrvy_pop_type())) {
    // if (popupList == null)
    // popupList = new ArrayList<PopupVO>();
    // PopupVO tppopVO = new PopupVO();
    // tppopVO.setPop_title(srvyVO.getSrvy_nm());
    // tppopVO.setPop_type(srvyVO.getSrvy_pop_type());
    // tppopVO.setPop_from(srvyVO.getSrvy_start());
    // tppopVO.setPop_to(srvyVO.getSrvy_end());
    // tppopVO.setPop_w(srvyVO.getSrvy_w());
    // tppopVO.setPop_h(srvyVO.getSrvy_h());
    // tppopVO.setPop_x(srvyVO.getSrvy_x());
    // tppopVO.setPop_y(srvyVO.getSrvy_y());
    // tppopVO.setPop_content(srvyVO.getSrvy_nm());
    // tppopVO.setPop_alt(srvyVO.getSrvy_nm());
    // tppopVO.setPop_target("_blank");
    // tppopVO.setPop_link(request.getContextPath()
    // + "/usract/surveySrvydata/srvydataList.do?srvy_idx=" + srvyVO.getSrvy_idx());
    // tppopVO.setVchkcode(srvyVO.getVchkcode());
    // popupList.add(popupList.size(), tppopVO);
    // }
    // // 팝업존인 경우 팝업존에 추가
    // else {
    // if (popzoneList == null)
    // popzoneList = new ArrayList<PopupVO>();
    // PopupVO tppopVO = new PopupVO();
    // tppopVO.setPop_title(srvyVO.getSrvy_nm());
    // tppopVO.setPop_type(srvyVO.getSrvy_pop_type());
    // tppopVO.setPop_from(srvyVO.getSrvy_start());
    // tppopVO.setPop_to(srvyVO.getSrvy_end());
    // tppopVO.setPop_alt(srvyVO.getSrvy_nm());
    // tppopVO.setPop_target("_blank");
    // tppopVO.setPop_link(request.getContextPath()
    // + "/usract/surveySrvydata/srvydataList.do?srvy_idx=" + srvyVO.getSrvy_idx());
    // tppopVO.setVchkcode(srvyVO.getVchkcode());
    // popzoneList.add(popzoneList.size(), tppopVO);
    // }
    //
    // }
    // }
    //
    // // 메인화면 설문조사 조회 End
    // ///////////////////////////////////////////////////////////////////
    //
    //
    // model.addAttribute("popupList", popupList);
    // model.addAttribute("popzoneList", popzoneList);
    //
    // // 메인 팝업 정보 조회
    // /*
    // * PopupVO popVO = new PopupVO(); popVO.setPop_type("W"); List popupList =
    // * popupService.selectValidPopupList(popVO); model.addAttribute("popupList", popupList);
    // *
    // * // 메인 비주얼 정보 조회 popVO.setPop_type("V"); List visualList =
    // * popupService.selectValidPopupList(popVO); model.addAttribute("visualList", visualList);
    // *
    // * // 메인 배너 정보 조회 popVO.setPop_type("R"); List bannerList =
    // * popupService.selectValidPopupList(popVO); model.addAttribute("bannerList", bannerList);
    // */
    //
    // ///////////////////////////////////////////////////////////////////
    // // 메인화면 공지사항 게시판 조회 Start
    //
    // BoardinfoVO infoVO = new BoardinfoVO();
    // infoVO.setBrd_id("BDIDX_0YJ6f709w971Jyj929j3vU");
    // infoVO = boardinfoService.selectBoardinfo(infoVO);
    //
    // if (infoVO != null) {
    // BoardarticleVO articleVO = new BoardarticleVO();
    // articleVO.setBrd_id(infoVO.getBrd_id());
    // articleVO.setTbl_nm(infoVO.getTbl_nm());
    // articleVO.setRecordCountPerPage(4);
    //
    // // 공지사항
    // articleVO.setSrch_ctgry_idx("CTIDX00002");
    // List noticeList = boardarticleService.selectBoardarticleList(articleVO);
    // model.addAttribute("noticeList", noticeList);
    // model.addAttribute("noticeCnt", (noticeList == null) ? 0 : noticeList.size());
    //
    // // 업데이트
    // articleVO.setSrch_ctgry_idx("CTIDX00003");
    // List updList = boardarticleService.selectBoardarticleList(articleVO);
    // model.addAttribute("updList", updList);
    // model.addAttribute("updListCnt", (updList == null) ? 0 : updList.size());
    // }
    // // 메인화면 공지사항 게시판 조회 Start
    // ///////////////////////////////////////////////////////////////////
    //
    // }
    // // 모바일
    // if ("CDIDX00003".equals(srch_mu_site)) {
    //
    //
    // }
    //
    // }
    //
    // 영문
    if ("CDIDX00023".equals(srch_mu_lang)) {
      // 2018-05-01(pigcos) : 다국어처리 추가
      returnUrl = "/eng/contents/mainView";
    }
    //
    //
    // } catch (Exception e) {
    // // 메인페이지 이기때문에 에러가 발생되더라도 그냥 넘어가야 한다.
    // e.printStackTrace();
    // }
    //
    // // 모바일 처리
    // if ("mdo".equals(ext))
    // returnUrl = "/mbl" + returnUrl;

    // 2018-05-01(pigcos) : 다국어처리로 주석
    // else if ("CDIDX00022".equals(srch_mu_lang) == false)
    // returnUrl = "/" + srch_mu_lang.toLowerCase() + returnUrl;


    return returnUrl;
  }

  /**
   * 공모전 메인
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/complicityMain")
  public String complicityMain(HttpServletRequest request, Model model) throws Exception {
    return "/complicity/contents/mainView";
  }


  /**
   * 메인 통계 저장의 비동기 처리
   * 
   * @param request
   * @param model
   * @exception Exception
   * @return 'SUCCESS'
   */
  @RequestMapping("/siteMainstatWrite")
  @ResponseBody
  public String siteMainstatWrite(HttpServletRequest request, Model model) throws Exception {

    String stat_key = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_STAT_KEY");

    if (stat_key == null || "".equals(stat_key))
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_STAT_KEY",
          EgovWebUtil.generateIDString("", 64));

    // //////////////////////////////////////////////////////////////////
    //
    // 통계 저장
    String referer = request.getParameter("referer");
    referer = (referer == null) ? "" : referer;
    referer = EgovWebUtil.UTF8Decode(referer);
    commstatService.insertCommstat(request, "MAIN",
        MessageHelper.getMessage("CONTENT.MAIN-PAGE")/* 메인페이지 */, referer);
    //
    // //////////////////////////////////////////////////////////////////

    return "SUCCESS";
  }


  /**
   * 메뉴별 통계 저장의 비동기 처리
   * 
   * @param request
   * @param model
   * @exception Exception
   * @return 'SUCCESS'
   */
  @RequestMapping("/sitePagestatWrite")
  @ResponseBody
  public String sitePagestatWrite(HttpServletRequest request, Model model) throws Exception {

    String stat_key = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_STAT_KEY");

    if (stat_key == null || "".equals(stat_key))
      EgovSessionCookieUtil.setSessionAttribute(request, "SESS_STAT_KEY",
          EgovWebUtil.generateIDString("", 64));

    String srch_menu_nix = request.getParameter("srch_menu_nix");
    /*
     * List sess_main_menu = (List) EgovSessionCookieUtil.getSessionAttribute(request,
     * "SESS_MAIN_MENU");
     */

    SysmenuVO sysmenuVO = new SysmenuVO();

    String ext = EgovWebUtil.getExtension(request.getRequestURI());


    String srch_mu_lang = request.getParameter("srch_mu_lang");
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;
    srch_mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_lang);//20191108 취약점 조치 추가

    String srch_mu_site = request.getParameter("srch_mu_site");
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;
    srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가

    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null) {
      auth_cd = "G0001";
    }
    sysmenuVO.setAuth_cd(auth_cd);
    sysmenuVO.setSrch_mu_site(srch_mu_site);
    sysmenuVO.setSrch_mu_lang(srch_mu_lang);

    List sess_main_menu = sysmenuService.selectSysmenuList(sysmenuVO);
    if (srch_menu_nix != null && sess_main_menu != null && sess_main_menu.size() != 0) {

      for (int i = 0; i < sess_main_menu.size(); i++) {
        SysmenuVO menuVO = (SysmenuVO) sess_main_menu.get(i);
        if (menuVO.getMenu_nix().equals(srch_menu_nix)) {
          // 통계저장 하지 않을 페이지 추가 "menu_nix|menu_nix" 형식으로
          if ("i7h9oY4t|D21u7peL|4B9Y010C|xvpC9AqQ".indexOf(menuVO.getMenu_nix()) >= 0) {
            break;
          }

          // //////////////////////////////////////////////////////////////////
          //
          // 통계 저장
          String referer = request.getParameter("referer");
          referer = (referer == null) ? "" : referer;
          referer = EgovWebUtil.UTF8Decode(referer);
          commstatService.insertCommstat(request, menuVO.getMenu_nix(), menuVO.getMenu_nm(),
              referer);
          //
          // //////////////////////////////////////////////////////////////////
          break;
        }
      }

    }

    return "SUCCESS";
  }



  /**
   * 컨텐츠 메인화면 처리 (처음 접속 페이지)
   * 
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/siteMain2")
  public String siteMain2(HttpServletRequest request, Model model) throws Exception {

    // ## TPCODE : TPAGE0018 : 메인페이지(Action) ##

    long start = System.currentTimeMillis();

    String returnUrl = "/contents/mainView2";
    String ext = EgovWebUtil.getExtension(request.getRequestURI());


    String srch_mu_lang = request.getParameter("srch_mu_lang");
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    String srch_mu_site = request.getParameter("srch_mu_site");
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;

    try {
      // 국문
      if ("CDIDX00022".equals(srch_mu_lang)) {
        // 대표웹
        if ("CDIDX00002".equals(srch_mu_site)) {
          // 메인 팝업창 정보 조회
          PopupVO popVO = new PopupVO();
          popVO.setPop_type("W");
          List popupList = popupService.selectValidPopupList(popVO);

          // 메인 팝업존 정보 조회
          popVO.setPop_type("Z");
          List popzoneList = popupService.selectValidPopupList(popVO);


          // /////////////////////////////////////////////////////////////////
          // 메인화면 설문조사 조회 Start
          SrvymainVO srvyVO = new SrvymainVO();
          srvyVO.setSrch_srvy_act_yn("Y");
          List srvyList = srvymainService.selectSrvymainList(srvyVO);

          // 유효한 설문조사가 있을 경우
          // 팝업과 팝업존(설정에 따라)에 추가한다.
          if (srvyList != null) {
            /*
             * 현재 테스트단계에서 팝업이 표시되면 안되므로 주석처리 한다. 이 for 문의 주석만 제거하면 정상동작함.
             */
            for (int i = 0; i < srvyList.size(); i++) {
              srvyVO = (SrvymainVO) srvyList.get(i);

              // 팝업창인 경우 팝업창에 추가
              if ("W".equals(srvyVO.getSrvy_pop_type())) {
                if (popupList == null)
                  popupList = new ArrayList<PopupVO>();
                PopupVO tppopVO = new PopupVO();
                tppopVO.setPop_title(srvyVO.getSrvy_nm());
                tppopVO.setPop_type(srvyVO.getSrvy_pop_type());
                tppopVO.setPop_from(srvyVO.getSrvy_start());
                tppopVO.setPop_to(srvyVO.getSrvy_end());
                tppopVO.setPop_w(srvyVO.getSrvy_w());
                tppopVO.setPop_h(srvyVO.getSrvy_h());
                tppopVO.setPop_x(srvyVO.getSrvy_x());
                tppopVO.setPop_y(srvyVO.getSrvy_y());
                tppopVO.setPop_content(srvyVO.getSrvy_nm());
                tppopVO.setPop_alt(srvyVO.getSrvy_nm());
                tppopVO.setPop_target("_blank");
                tppopVO.setPop_link(request.getContextPath()
                    + "/usract/surveySrvydata/srvydataList.do?srvy_idx=" + srvyVO.getSrvy_idx());
                tppopVO.setVchkcode(srvyVO.getVchkcode());
                popupList.add(popupList.size(), tppopVO);
              }
              // 팝업존인 경우 팝업존에 추가
              else {
                if (popzoneList == null)
                  popzoneList = new ArrayList<PopupVO>();
                PopupVO tppopVO = new PopupVO();
                tppopVO.setPop_title(srvyVO.getSrvy_nm());
                tppopVO.setPop_type(srvyVO.getSrvy_pop_type());
                tppopVO.setPop_from(srvyVO.getSrvy_start());
                tppopVO.setPop_to(srvyVO.getSrvy_end());
                tppopVO.setPop_alt(srvyVO.getSrvy_nm());
                tppopVO.setPop_target("_blank");
                tppopVO.setPop_link(request.getContextPath()
                    + "/usract/surveySrvydata/srvydataList.do?srvy_idx=" + srvyVO.getSrvy_idx());
                tppopVO.setVchkcode(srvyVO.getVchkcode());
                popzoneList.add(popzoneList.size(), tppopVO);
              }

            }
          }

          // 메인화면 설문조사 조회 End
          // /////////////////////////////////////////////////////////////////


          model.addAttribute("popupList", popupList);
          model.addAttribute("popzoneList", popzoneList);

          // 메인 팝업 정보 조회
          /*
           * PopupVO popVO = new PopupVO(); popVO.setPop_type("W"); List popupList =
           * popupService.selectValidPopupList(popVO); model.addAttribute("popupList", popupList);
           * 
           * // 메인 비주얼 정보 조회 popVO.setPop_type("V"); List visualList =
           * popupService.selectValidPopupList(popVO); model.addAttribute("visualList", visualList);
           * 
           * // 메인 배너 정보 조회 popVO.setPop_type("R"); List bannerList =
           * popupService.selectValidPopupList(popVO); model.addAttribute("bannerList", bannerList);
           */

          // /////////////////////////////////////////////////////////////////
          // 메인화면 공지사항 게시판 조회 Start

          BoardinfoVO infoVO = new BoardinfoVO();
          infoVO.setBrd_id("BDIDX_0YJ6f709w971Jyj929j3vU");
          infoVO = boardinfoService.selectBoardinfo(infoVO);

          if (infoVO != null) {
            BoardarticleVO articleVO = new BoardarticleVO();
            articleVO.setBrd_id(infoVO.getBrd_id());
            articleVO.setTbl_nm(infoVO.getTbl_nm());
            articleVO.setRecordCountPerPage(4);

            // 공지사항
            articleVO.setSrch_ctgry_idx("CTIDX00002");
            List noticeList = boardarticleService.selectBoardarticleList(articleVO);
            model.addAttribute("noticeList", noticeList);
            model.addAttribute("noticeCnt", (noticeList == null) ? 0 : noticeList.size());

            // 업데이트
            articleVO.setSrch_ctgry_idx("CTIDX00003");
            List updList = boardarticleService.selectBoardarticleList(articleVO);
            model.addAttribute("updList", updList);
            model.addAttribute("updListCnt", (updList == null) ? 0 : updList.size());
          }
          // 메인화면 공지사항 게시판 조회 Start
          // /////////////////////////////////////////////////////////////////

        }
        // 모바일
        if ("CDIDX00003".equals(srch_mu_site)) {


        }

      }

      // 영문
      else if ("CDIDX00023".equals(srch_mu_lang)) {
        // 2018-05-01(pigcos) : 다국어처리 추가
        returnUrl = "/contents/mainView";
      }


    } catch (Exception e) {
      // 메인페이지 이기때문에 에러가 발생되더라도 그냥 넘어가야 한다.
      e.printStackTrace();
    }

    // 모바일 처리
    if ("mdo".equals(ext))
      returnUrl = "/mbl" + returnUrl;

    // 2018-05-01(pigcos) : 다국어처리로 주석
    // else if ("CDIDX00022".equals(srch_mu_lang) == false)
    // returnUrl = "/" + srch_mu_lang.toLowerCase() + returnUrl;



    return returnUrl;
  }

  /**
   * 메인화면 주요일정에 표시하기 위한 정보를 조회
   * 
   * @param request
   * @param response
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/loadNoticeJsonList")
  @ResponseBody
  public Map loadNoticeJsonList(HttpServletRequest request, HttpServletResponse response,
      Model model) throws Exception {

    // /////////////////////////////////////////////////////////////////
    // 공지사항 조회 Start

    Map noticeMap = new HashMap();

    try {
      BoardinfoVO infoVO = new BoardinfoVO();
      infoVO.setBrd_id("BDIDX_kY41262l4229Z0bP48EXdw");
      infoVO = boardinfoService.selectBoardinfo(infoVO);
      List<BoardarticleVO> noticeList = null;
      if (infoVO != null) {
        BoardarticleVO articleVO = new BoardarticleVO();
        articleVO.setFirstIndex(0);
        articleVO.setRecordCountPerPage(3);
        articleVO.setBrd_id(infoVO.getBrd_id());
        articleVO.setTbl_nm(infoVO.getTbl_nm());
        String srch_ctgry_idx =
            request.getParameter("srch_ctgry_idx") == null ? "" : request
                .getParameter("srch_ctgry_idx");
        articleVO.setSrch_ctgry_idx(srch_ctgry_idx);
        noticeList = boardarticleService.selectBoardarticleList(articleVO);

        noticeMap.put("noticeMap", noticeList);
      }
      // 공지사항 조회 End
      // /////////////////////////////////////////////////////////////////

      return noticeMap;
    } catch (Exception e) {
      e.printStackTrace();

      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    } finally {

    }
  }

  /**
   * 컨텐츠 메인화면 처리 (처음 접속 페이지)
   * 
   * @param boardarticleVO 정보가 담긴 VO
   * @param request
   * @param model
   * @exception Exception
   * @return '/contents/mainSearch'
   */
  @RequestMapping("/mainTotalSearch")
  public String mainTotalSearch(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
      HttpServletRequest request, Model model) throws Exception {

    List<BoardinfoVO> boardList = new ArrayList<BoardinfoVO>();
    List<BoardinfoVO> boardListCont = new ArrayList<BoardinfoVO>();
    List<BoardinfoVO> boardListCms = new ArrayList<BoardinfoVO>();
    List<BoardarticleVO> resultList = null;
    List<BoardarticleVO> resultListCont = null;
    List<BoardarticleVO> resultListCms = null;


    String mu_lang =
        request.getParameter("srch_mu_lang") == null ? "CDIDX00022" : request
            .getParameter("srch_mu_lang");

    if (boardarticleVO.getSearchCondition() == null
        || "".equals(boardarticleVO.getSearchCondition()))
      boardarticleVO.setSearchCondition("SC_ALL");


    if (!(boardarticleVO.getSearchKeyword() == null || "".equals(boardarticleVO.getSearchKeyword()))) {
    	boardarticleVO.setSearchType("BRD");
    	resultList = boardarticleService.selectTotalSearchList(boardarticleVO);


      HashMap<String, String> hMap = new HashMap<String, String>();
      int searchCount = 0;


        // 결과가 게시판별로 혼합되어있기때문에
        // 결과가 있는 게시판 목록을 따로 추출하고
        // 각 게시판별로 검색결과가 몇건인지를 구한다.
        for (int i = 0; i < resultList.size(); i++) {

          BoardarticleVO baVO = resultList.get(i);

          if (hMap.get(baVO.getBrd_id()) == null) {
            if (searchCount > 0 && boardList.size() > 0) {
              BoardinfoVO lastVO = boardList.get(boardList.size() - 1);
              lastVO.setSearchCount(searchCount);
            }

            searchCount = 0;
            hMap.put(baVO.getBrd_id(), "");
            BoardinfoVO bfVO = new BoardinfoVO();
            bfVO.setBrd_id(baVO.getBrd_id());
            bfVO.setBrd_nm(baVO.getBrd_nm());
            boardList.add(bfVO);
          }

          searchCount++;
        }

        if (searchCount > 0 && boardList.size() > 0) {
          BoardinfoVO lastVO = boardList.get(boardList.size() - 1);
          lastVO.setSearchCount(searchCount);
        }


        boardarticleVO.setSearchType("CONT");
    	resultListCont = boardarticleService.selectTotalSearchList(boardarticleVO);
        if (resultListCont.size() > 0) {
          BoardinfoVO bfVO = new BoardinfoVO();
          bfVO.setBrd_id("USR_CONT");
          bfVO.setBrd_nm("웹문서");
          bfVO.setSearchCount(resultListCont.size());
          boardListCont.add(bfVO);
        }

        boardarticleVO.setSearchType("CMS");
    	resultListCms = boardarticleService.selectTotalSearchList(boardarticleVO);
        if (resultListCms.size() > 0) {
        	searchCount = 0;
          for (int i = 0; i < resultListCms.size(); i++) {

            BoardarticleVO baVO = resultListCms.get(i);
            if (hMap.get(baVO.getBrd_id()) == null) {
              if (searchCount > 0 && resultListCms.size() > 0) {
                BoardinfoVO lastVO = boardListCms.get(boardListCms.size() - 1);
                lastVO.setSearchCount(searchCount);
              }

              searchCount = 0;
              hMap.put(baVO.getBrd_id(), "");
              BoardinfoVO bfVO = new BoardinfoVO();
              bfVO.setBrd_id(baVO.getBrd_id());
              bfVO.setBrd_nm(baVO.getBrd_nm());
              boardListCms.add(bfVO);
            }

            searchCount++;
          }

          if (searchCount > 0 && boardListCms.size() > 0) {
            BoardinfoVO lastVO = boardListCms.get(boardListCms.size() - 1);
            lastVO.setSearchCount(searchCount);
          }


      }
      model.addAttribute("boardList", boardList);
      model.addAttribute("boardListCont", boardListCont);
      model.addAttribute("boardListCms", boardListCms);
      model.addAttribute("resultList", resultList);
      model.addAttribute("resultListCont", resultListCont);
      model.addAttribute("resultListCms", resultListCms);
    }
    
    int resultListCnt=resultList == null ? 0 : resultList.size();
    int resultListContCnt=resultListCont == null ? 0 : resultListCont.size();
    int resultListCmsCnt=resultListCms == null ? 0 : resultListCms.size();

    model.addAttribute("resultListCnt", resultListCnt+resultListContCnt+resultListCmsCnt);

    String returnUrl = "/contents/mainSearch";

    if (boardarticleVO.getSrch_mu_site().equals("CDIDX00005")) {
      returnUrl = "/contents/womenSearch";
    } else {

      if ("CDIDX00023".equals(mu_lang)) {
        returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
      }

    }

    return returnUrl;
  }
  @RequestMapping("/mainTotalSearch_20200409")
  public String mainTotalSearch_20200409(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
      HttpServletRequest request, Model model) throws Exception {

    List<BoardinfoVO> boardList = new ArrayList<BoardinfoVO>();
    List<BoardarticleVO> resultList = null;


    String mu_lang =
        request.getParameter("srch_mu_lang") == null ? "CDIDX00022" : request
            .getParameter("srch_mu_lang");

    if (boardarticleVO.getSearchType() == null || "".equals(boardarticleVO.getSearchType()))
      boardarticleVO.setSearchType("BRD");

    if (boardarticleVO.getSearchCondition() == null
        || "".equals(boardarticleVO.getSearchCondition()))
      boardarticleVO.setSearchCondition("SC_ALL");


    if (!(boardarticleVO.getSearchKeyword() == null || "".equals(boardarticleVO.getSearchKeyword()))) {
      resultList = boardarticleService.selectTotalSearchList(boardarticleVO);


      HashMap<String, String> hMap = new HashMap<String, String>();
      int searchCount = 0;


      if ("BRD".equals(boardarticleVO.getSearchType())) { // 게시판
        // 결과가 게시판별로 혼합되어있기때문에
        // 결과가 있는 게시판 목록을 따로 추출하고
        // 각 게시판별로 검색결과가 몇건인지를 구한다.
        for (int i = 0; i < resultList.size(); i++) {

          BoardarticleVO baVO = resultList.get(i);

          if (hMap.get(baVO.getBrd_id()) == null) {
            if (searchCount > 0 && boardList.size() > 0) {
              BoardinfoVO lastVO = boardList.get(boardList.size() - 1);
              lastVO.setSearchCount(searchCount);
            }

            searchCount = 0;
            hMap.put(baVO.getBrd_id(), "");
            BoardinfoVO bfVO = new BoardinfoVO();
            bfVO.setBrd_id(baVO.getBrd_id());
            bfVO.setBrd_nm(baVO.getBrd_nm());
            boardList.add(bfVO);
          }

          searchCount++;
        }

        if (searchCount > 0 && boardList.size() > 0) {
          BoardinfoVO lastVO = boardList.get(boardList.size() - 1);
          lastVO.setSearchCount(searchCount);
        }


      } else if ("CONT".equals(boardarticleVO.getSearchType())) { // 컨텐츠
        if (resultList.size() > 0) {
          BoardinfoVO bfVO = new BoardinfoVO();
          bfVO.setBrd_id("USR_CONT");
          bfVO.setBrd_nm("웹문서");
          bfVO.setSearchCount(resultList.size());
          boardList.add(bfVO);
        }
      } else { // CMS
        if (resultList.size() > 0) {

          for (int i = 0; i < resultList.size(); i++) {

            BoardarticleVO baVO = resultList.get(i);
            if (hMap.get(baVO.getBrd_id()) == null) {
              if (searchCount > 0 && boardList.size() > 0) {
                BoardinfoVO lastVO = boardList.get(boardList.size() - 1);
                lastVO.setSearchCount(searchCount);
              }

              searchCount = 0;
              hMap.put(baVO.getBrd_id(), "");
              BoardinfoVO bfVO = new BoardinfoVO();
              bfVO.setBrd_id(baVO.getBrd_id());
              bfVO.setBrd_nm(baVO.getBrd_nm());
              boardList.add(bfVO);
            }

            searchCount++;
          }

          if (searchCount > 0 && boardList.size() > 0) {
            BoardinfoVO lastVO = boardList.get(boardList.size() - 1);
            lastVO.setSearchCount(searchCount);
          }

          // BoardinfoVO bfVO = new BoardinfoVO();
          // bfVO.setBrd_id("USR_CMS");
          // bfVO.setBrd_nm("CMS");
          // bfVO.setSearchCount(resultList.size());
          // boardList.add(bfVO);

        }
      }
      model.addAttribute("boardList", boardList);
      model.addAttribute("resultList", resultList);
    }

    model.addAttribute("resultListCnt", resultList == null ? 0 : resultList.size());

    String returnUrl = "/contents/mainSearch";

    if (boardarticleVO.getSrch_mu_site().equals("CDIDX00005")) {
      returnUrl = "/contents/womenSearch";
    } else {

      if ("CDIDX00023".equals(mu_lang)) {
        returnUrl = "/" + mu_lang.toLowerCase() + returnUrl;
      }

    }

    return returnUrl;
  }

  /**
   * 사이트맵으로 이동.
   * 
   * @param request
   * @exception Exception
   */
  @RequestMapping("/siteMapView")
  public String siteMapView(HttpServletRequest request, ModelMap model) throws Exception {


    String srch_menu_nix = request.getParameter("srch_menu_nix");
    String srch_mu_site = request.getParameter("srch_mu_site");
    String ext = EgovWebUtil.getExtension(request.getRequestURI());
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;
    String mu_lang =
        request.getParameter("srch_mu_lang") == null ? "CDIDX00022" : request
            .getParameter("srch_mu_lang");


    SysmenuVO menuVO = new SysmenuVO();

    menuVO.setUse_yn("Y");
    menuVO.setMu_gub("USR");
    menuVO.setMu_site(srch_mu_site);
    menuVO.setMu_lang(mu_lang);

    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null)
      auth_cd = "G0001";

    menuVO.setAuth_cd(auth_cd);

    List<SysmenuVO> sysmenuList = sysmenuService.selectSysmenuList(menuVO);

    String dbtype = EgovProperties.getProperty("Globals.DbType");

    if ("mysql".equals(dbtype)) {
      EgovWebUtil.getLeveldList(sysmenuList, null, 1, new Integer(1));
    }

    model.addAttribute("sysmenuList", sysmenuList);


    /* 현재메뉴 */
    menuVO.setSrch_menu_nix(srch_menu_nix);

    menuVO = sysmenuService.selectSysmenu(menuVO);

    if (menuVO == null)
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

    model.addAttribute("nowMenuVO", menuVO);


    if ("CDIDX00022".equals(mu_lang))
      return "/contents/sitemapView";
    else
      return "/lang/contents/sitemapView";
  }


}
