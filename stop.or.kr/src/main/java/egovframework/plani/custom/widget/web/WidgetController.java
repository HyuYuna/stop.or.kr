package egovframework.plani.custom.widget.web;

import java.util.Calendar;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;
import twitter4j.auth.Authorization;
import twitter4j.auth.NullAuthorization;
import egovframework.plani.custom.man.company.service.CompanyService;
import egovframework.plani.custom.man.company.vo.CompanyVO;
import egovframework.plani.custom.man.schedule.service.ScheduleService;
import egovframework.plani.custom.man.schedule.vo.ScheduleVO;
import egovframework.plani.template.brdartcl.service.BoardarticleService;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.man.metsys.service.AnnouncementDataService;
import egovframework.plani.template.man.metsys.service.AnnouncementGroupService;
import egovframework.plani.template.man.metsys.vo.AnnouncementDataVO;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;
import egovframework.plani.template.man.popup.service.PopupService;
import egovframework.plani.template.man.popup.vo.PopupVO;
import egovframework.plani.template.multicms.service.MultiCmsService;
import egovframework.plani.template.multicms.vo.MultiCmsVO;


@Controller
// @RequestMapping("/widgets")
public class WidgetController {

  /** PopupService */
  @Resource(name = "popupService")
  protected PopupService popupService;
  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  private BoardinfoService boardinfoService;
  /** BoardarticleService */
  @Resource(name = "boardarticleService")
  private BoardarticleService boardarticleService;
  /** ScheduleService */
  @Resource(name = "scheduleService")
  private ScheduleService scheduleService;
  /** CompanyService */
  @Resource(name = "companyService")
  private CompanyService companyService;

  /** multiCmsService */
  @Resource(name = "multiCmsService")
  private MultiCmsService multiCmsService;

  /** 공고 Service */
  @Resource(name = "announcementDataService")
  private AnnouncementDataService announcementDataService;

  /** 공고 그룹 Service */
  @Resource(name = "announcementGroupService")
  private AnnouncementGroupService announcementGroupService;

  /**
   * 일정 위젯
   * 
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/widgets/schedule")
  public String schedule(HttpServletRequest request, Model model) throws Exception {

    String srch_mu_lang = request.getParameter("srch_mu_lang");
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;
    String lang = "kor";

    // 메인 스케쥴 정보 조회
    ScheduleVO schVO = new ScheduleVO();

    Calendar cal = Calendar.getInstance(); // 현재시간

    int YEAR = cal.get(Calendar.YEAR);

    int MON = cal.get(Calendar.MONTH) + 1;

    int DAY = cal.get(Calendar.DATE);

    int DAYOFWEEK = cal.get(Calendar.DAY_OF_WEEK) - 1;

    String[] weekDay = {"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};

    String today = weekDay[DAYOFWEEK];

    schVO.setMu_lang(srch_mu_lang);

    schVO.setS_date(YEAR + "-" + MON + "-" + DAY);

    List schlist = scheduleService.selectTodayScheduleList(schVO);

    String S_MON = String.format("%02d", MON);

    model.addAttribute("schlist", schlist);
    model.addAttribute("yoil", today);
    model.addAttribute("day", DAY);
    model.addAttribute("yearmonth", S_MON + "," + YEAR);
    // 일

    // 연도와 월

    if ("CDIDX00022".equals(srch_mu_lang) == false) {
      lang = "eng";
    }

    return "/custom/widget/" + lang + "/schlist";
  }


  /**
   * 다운 레이어팝업 위젯
   * 
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/widgets/download_popup")
  public String download_popup(HttpServletRequest request, Model model) throws Exception {
    model.addAttribute("d_vchkcode", request.getParameter("d_vchkcode"));
    model.addAttribute("d_div", request.getParameter("div"));
    model.addAttribute("seq", request.getParameter("seq"));
    return "/custom/widget/kor/download_popup";
  }


  /**
   * 다운 레이어팝업 위젯 액션
   * 
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/widgets/pdownload")
  @ResponseBody
  public Object pdownload(@Valid CompanyVO companyVO, BindingResult result,
      HttpServletRequest request, Model model) throws Exception {

    String info = request.getParameter("d_vchkcode");

    ResponseResultHelper responseResultHelper = new ResponseResultHelper(request, "/");

    //if (request.getParameter("company_type").equals("2")) {
      // 폼 유효성 검사
      if (result.hasErrors()) {
        return responseResultHelper.validation(result);
      }
      companyVO.setVchkcode(info);
      // 디비 저장시키기
      companyService.insertCompany(companyVO);
    //}


    return responseResultHelper.success(null, "완료되었습니다.", null, info);
  }

  @RequestMapping("/widgets/announcement")
  public String announcement(@ModelAttribute("announcmentvo") AnnouncementDataVO announcmentvo,
      HttpServletRequest request, Model model) throws Exception {

    String group_id = announcmentvo.getGroup_id();
    String menu_nix = request.getParameter("menu_nix");
    String article_cnt = request.getParameter("article_cnt");
    String language =
        request.getParameter("language") != null ? request.getParameter("language") : "kor";

    AnnouncementGroupVO groupvo = new AnnouncementGroupVO();

    groupvo.setGroup_id(group_id);

    AnnouncementGroupVO group = announcementGroupService.selectAnnouncementGroup(groupvo);

    List noticelist = null;

    if (group != null) {
      AnnouncementDataVO datavo = new AnnouncementDataVO();
      datavo.setGroup_id(group.getGroup_id());
      datavo.setRecordCountPerPage(Integer.parseInt(article_cnt));
      noticelist = announcementDataService.selectAnnouncementDataList(datavo);

      model.addAttribute("resultList", noticelist);

    }

    model.addAttribute("menu_nix", menu_nix);

    return "/custom/widget/" + language + "/announcement";
  }

  /**
   * 팝업 위젯
   * 
   * @param request
   * @param model
   * @exception Exception
   */
  // @RequestMapping("/widgets/popup")
  public String popup(HttpServletRequest request, Model model) throws Exception {
    String returnUrl = "/widgets/popup";


    String conditaion = request.getParameter("conditaion");

    System.out.println(conditaion);

    // 메인 팝업창 정보 조회
    PopupVO popVO = new PopupVO();
    popVO.setPop_type("W");
    List popupList = popupService.selectValidPopupList(popVO);

    System.out.println("popup List size : " + popupList.size());
    model.addAttribute("popupList", popupList);
    return returnUrl;

  }

  /**
   * 게시판 위젯
   * 
   * @param request
   * @param model
   * @exception Exception
   */

  // @RequestMapping("/board")
  public String board(HttpServletRequest request, Model model) throws Exception {
    String returnUrl = "/widgets/board";

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
      return returnUrl;

    }
    return returnUrl;
  }


  /**
   * 멀티cms 위젯
   * 
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/widgets/multiCms")
  public String multiCms(HttpServletRequest request, Model model) throws Exception {

    String category = request.getParameter("category");
    String lang = request.getParameter("language");

    MultiCmsVO multiCmsVO = new MultiCmsVO();
    multiCmsVO.setMc_category(category);
    multiCmsVO.setRecordCountPerPage(2);
    List result = multiCmsService.selectMultiCmsList(multiCmsVO);

    model.addAttribute("multiCmsList", result);


    return "/custom/widget/" + lang + "/multiCms";
  }



  /**
   * 
   * 트위터 가져오기 위젯
   * 
   * @param ar
   * @param request
   * @param model
   * @return
   */
  @RequestMapping("/widgets/twitter")
  public String twitter(String ar[], HttpServletRequest request, Model model) {
    try {



      AccessToken accesstoken =
          new AccessToken("1856022236-QCPhtUiXswHi0KlGMgQ2JKBgaIAkCAzKFwI4no5",
              "kFzZhPiti4pcUi3Un65FRieRLa01y3zcPJnL2ND3Zf4G1");
      Twitter twitter = TwitterFactory.getSingleton();

      Authorization auth = twitter.getAuthorization();
      if (auth instanceof NullAuthorization) {
        twitter.setOAuthConsumer("GoSiXVR7gIgGaGe1fj7sA",
            "hLqKRfQqAWRDJYNO9YdkfUSBaChJ3faLISeOtaZjJg");
        twitter.setOAuthAccessToken(accesstoken);
      }


      User user = twitter.verifyCredentials();
      Paging page = new Paging(1, 5);
      List<Status> list = twitter.getUserTimeline(page);
      model.addAttribute("user", user);
      model.addAttribute("twitterList", list);


    } catch (Exception e) {
      e.printStackTrace();
    }

    return "/custom/widget/eng/twitter";
  }

}
