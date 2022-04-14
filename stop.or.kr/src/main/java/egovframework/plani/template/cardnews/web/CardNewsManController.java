package egovframework.plani.template.cardnews.web;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cardnews.service.CardNewsService;
import egovframework.plani.template.cardnews.vo.CardNewsVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.man.log.service.ManlogService;


/**
 * 카드뉴스 컨트롤러
 * 
 * 
 *
 */
@Controller
@RequestMapping("/metsys/cardnews")
public class CardNewsManController {


  /** CardNewsService */
  @Resource(name = "cardNewsService")
  private CardNewsService cardNewsService;

  @Resource(name = "manlogService")
  private ManlogService manlogService;

  @Resource
  private CrudTemplate crudTemplate;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;


  /**
   * 관리자 목록
   * 
   * @param cardNewsVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/cardNewsManList")
  public String cardNewsManList(@ModelAttribute("cardNewsVO") final CardNewsVO cardNewsVO,
      HttpServletRequest request, Model model) throws Exception {


    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    List cardNewsNoticeList = cardNewsService.selectNoticeCardNewsList(cardNewsVO);

    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, cardNewsVO, new CrudStrategy<CardNewsVO>() {
      @Override
      public int totalCount() throws Exception {
        return cardNewsService.selectCardNewsListTotCnt(cardNewsVO);
      }

      @Override
      public List<CardNewsVO> pagingList() throws Exception {
        return cardNewsService.selectCardNewsList(cardNewsVO);
      }
    });


    model.addAttribute("cardNewsNoticeList", cardNewsNoticeList);
    model.addAttribute("pageIndex", cardNewsVO.getPageIndex());



    // 관리자 로그 저장 C/R/U/D L : 목록
    manlogService.insertManlog(request, "CN_MAN", "카드뉴스목록관리", "카드뉴스목록 목록조회", "L");


    return "/metsys/cardnews/cardNewsManList";
  }



  /**
   * 관리자폼화면
   * 
   * @param cardNewsVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/cardNewsForm", method = RequestMethod.GET)
  public String cardNewsForm(@ModelAttribute("cardNewsVO") CardNewsVO cardNewsVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    String pageIndex = request.getParameter("pageIndex");
    if (StringUtils.isEmpty(pageIndex) == false) {
      model.addAttribute("pageIndex", pageIndex);
    } else {
      model.addAttribute("pageIndex", 1);
    }


    String seq = request.getParameter("seq");
    if (StringUtils.isEmpty(seq) == false) {


      // 첨부파일
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st("CARD_NEWS");
      fVo.setAtckey_2nd(seq);
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);


      cardNewsVO.setCn_seq(Integer.parseInt(seq));
      model.addAttribute("cardNewsVO", cardNewsService.selectCardNews(cardNewsVO));

    }


    return "/metsys/cardnews/cardNewsForm";
  }



  /**
   * 카드뉴스목록 저장 로직
   * 
   * @param cardNewsVO
   * @param result
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/cardNewsSave", method = RequestMethod.POST)
  @ResponseBody
  public Object cardNewsSave(@Valid CardNewsVO cardNewsVO, BindingResult result,
      HttpServletRequest request) throws Exception {

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/cardnews/cardNewsForm");


    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");

    int seq = Integer.parseInt(request.getParameter("cn_seq"));
    int idx = 0;
    if (seq > 0) {
      // 수정
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "CN_MAN", "카드뉴스목록 관리",
          "카드뉴스 수정 [" + cardNewsVO.getCn_title() + "]", "U");
      cardNewsService.updateCardNews(cardNewsVO);
      idx = seq;
    } else {
      // 생성
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "CN_MAN", "카드뉴스목록 관리",
          "카드뉴스 생성 [" + cardNewsVO.getCn_title() + "]", "C");

      cardNewsService.insertCardNews(cardNewsVO);
      idx = cardNewsVO.getCn_seq();
    }

    return responseResultHelper.success(null, null,
        "/metsys/cardnews/cardNewsManList.do?srch_menu_nix=" + srch_menu_nix, cardNewsVO);

  }

  /**
   * 카드뉴스목록 삭제
   * 
   * @param cardNewsVO
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/deleteCardNews", method = RequestMethod.GET)
  @ResponseBody
  public Object deleteCardNews(CardNewsVO cardNewsVO, HttpServletRequest request) throws Exception {

    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/cardnews/cardNewsForm");

    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");

    int seq = Integer.parseInt(request.getParameter("seq"));
    if (seq > 0) {
      // 삭제
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "CN_MAN", "카드뉴스목록 관리",
          "카드뉴스 삭제 [" + cardNewsVO.getCn_seq() + "]", "D");
      cardNewsVO.setCn_seq(seq);
      cardNewsService.deleteCardNews(cardNewsVO);
    }

    return responseResultHelper.success(null, null,
        "/metsys/cardnews/cardNewsManList.do?srch_menu_nix=" + srch_menu_nix, null);

    // return "/metsys/cardnews/cardNewsManList.do?srch_menu_nix=Q67T24ks";
  }


}
