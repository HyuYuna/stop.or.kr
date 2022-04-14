package egovframework.plani.template.cardnews.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cardnews.service.CardNewsService;
import egovframework.plani.template.cardnews.vo.CardNewsVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;


/**
 * 카드뉴스 컨트롤러 - 사용자
 * 
 * 
 *
 */
@Controller
@RequestMapping("/cardnews")
public class CardNewsUsrController {


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
  @RequestMapping("/cardNewsUsrList")
  public String cardNewsUsrList(@ModelAttribute("cardNewsVO") final CardNewsVO cardNewsVO,
      HttpServletRequest request, Model model) throws Exception {



    List cardNewsNoticeList = cardNewsService.selectNoticeCardNewsList(cardNewsVO);

    cardNewsVO.setPageUnit(12);

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
		manlogService.insertManlog(request, "REL_USR", "카드뉴스목록-사용자", "카드뉴스목록 목록조회", "L");



    return "/cardnews/cardNewsUsrList";
  }


  @RequestMapping("/cardNewsUsrView")
  public String cardNewsUsrView(@ModelAttribute("cardNewsVO") CardNewsVO cardNewsVO,
      HttpServletRequest request, Model model) throws Exception {


    String pageIndex = request.getParameter("pageIndex");
    if (StringUtils.isEmpty(pageIndex) == false) {
      model.addAttribute("pageIndex", pageIndex);
    } else {
      model.addAttribute("pageIndex", 1);
    }

    String rn = request.getParameter("nownm");
    if (StringUtils.isEmpty(rn) == true) {
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);
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
      CardNewsVO resultVO = cardNewsService.selectCardNews(cardNewsVO);
      model.addAttribute("cardNewsVO", resultVO);

      // 조회수 업데이트
      cardNewsVO.setHits(resultVO.getHits() + 1);
      cardNewsService.updatecCardNewsCount(cardNewsVO);

    }

    // 하위 리스트 가져오기
    int firstIndex = Integer.parseInt(rn) > 4 ? Integer.parseInt(rn) - 4 : 0;
    cardNewsVO.setFirstIndex(firstIndex);
    cardNewsVO.setRecordCountPerPage(9);
    List underList = cardNewsService.selectCardNewsList(cardNewsVO);
    model.addAttribute("underList", underList);


    return "/cardnews/cardNewsUsrView";
  }



}
