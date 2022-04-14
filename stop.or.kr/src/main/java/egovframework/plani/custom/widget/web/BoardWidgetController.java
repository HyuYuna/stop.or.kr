package egovframework.plani.custom.widget.web;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.plani.template.brdartcl.service.BoardarticleService;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.service.BoardthmService;
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.brdartcl.vo.BoardthmVO;
import egovframework.plani.template.webtoon.service.WebtoonCategoryService;
import egovframework.plani.template.webtoon.vo.WebtoonCategoryVO;
import egovframework.plani.template.cardnews.service.CardNewsService;
import egovframework.plani.template.cardnews.vo.CardNewsVO;

@Controller
public class BoardWidgetController {

  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  private BoardinfoService boardinfoService;
  /** BoardarticleService */
  @Resource(name = "boardarticleService")
  private BoardarticleService boardarticleService;

  /** BoardthmService */
  @Resource(name = "boardthmService")
  private BoardthmService boardthmService;
  
  @Resource(name = "webtoonCategoryService")
	private WebtoonCategoryService webtoonCategoryService;
  
  /** CardNewsService */
  @Resource(name = "cardNewsService")
  private CardNewsService cardNewsService;

  /**
   * 최근게시물 위젯 작업
   * 
   * @param boardarticleVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */

  @RequestMapping("/widgets/board")
  public String menu(@ModelAttribute("boardarticleVO") BoardarticleVO boardarticleVO,
      HttpServletRequest request, Model model) throws Exception {


    String brd_id = boardarticleVO.getBrd_id();
    String menu_nix = request.getParameter("menu_nix");
    String article_cnt = request.getParameter("article_cnt");
    String type = request.getParameter("type");
    String language = request.getParameter("language") != null ? request.getParameter("language") : "kor";
    String is_notice = request.getParameter("is_notice") != null ? request.getParameter("is_notice") : "N";//20200409 추가
    
    BoardinfoVO infoVO = new BoardinfoVO();
    infoVO.setBrd_id(brd_id);
    infoVO = boardinfoService.selectBoardinfo(infoVO);

    if (infoVO != null) {

      List noticeList = null;
      if (type == null) {
        type = "board";
        BoardarticleVO articleVO = new BoardarticleVO();
        articleVO.setBrd_id(infoVO.getBrd_id());
        articleVO.setTbl_nm(infoVO.getTbl_nm());
        articleVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
        articleVO.setIs_notice(is_notice);//20200409 추가
        noticeList = boardarticleService.selectBoardarticleList(articleVO);
      } else if (type.equals("board_2")) {
          BoardthmVO thmVO = new BoardthmVO();
          thmVO.setBrd_id(infoVO.getBrd_id());
          thmVO.setTbl_nm(infoVO.getTbl_nm());
          thmVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
          noticeList = boardthmService.selectBoardthmList(thmVO);
    } else if (type.equals("board_3")) {
    	BoardarticleVO articleVO = new BoardarticleVO();
        articleVO.setBrd_id(infoVO.getBrd_id());
        articleVO.setTbl_nm(infoVO.getTbl_nm());
        articleVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
        noticeList = boardarticleService.selectBoardarticleList(articleVO);
      } else if (type.equals("photo")) {

        BoardthmVO thmVO = new BoardthmVO();
        thmVO.setBrd_id(infoVO.getBrd_id());
        thmVO.setTbl_nm(infoVO.getTbl_nm());
        thmVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
        noticeList = boardthmService.selectBoardthmList(thmVO);

      } else if (type.equals("photo_1")) {

        BoardthmVO thmVO = new BoardthmVO();
        thmVO.setBrd_id(infoVO.getBrd_id());
        thmVO.setTbl_nm(infoVO.getTbl_nm());
        thmVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
        noticeList = boardthmService.selectBoardthmList(thmVO);

      } else if (type.equals("photo_2")) {

          BoardthmVO thmVO = new BoardthmVO();
          thmVO.setBrd_id(infoVO.getBrd_id());
          thmVO.setTbl_nm(infoVO.getTbl_nm());
          thmVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
          noticeList = boardthmService.selectBoardthmList(thmVO);

       } else if (type.equals("photo_3")) {

           BoardthmVO thmVO = new BoardthmVO();
           thmVO.setBrd_id(infoVO.getBrd_id());
           thmVO.setTbl_nm(infoVO.getTbl_nm());
           thmVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
           noticeList = boardthmService.selectBoardthmList(thmVO);

        }

      model.addAttribute("resultList", noticeList);

    }
    
    if (type.equals("webtoon")) {
    	List noticeList = null;
        WebtoonCategoryVO webtooncategoryVO = new  WebtoonCategoryVO();
        webtooncategoryVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
        noticeList = webtoonCategoryService.selectWebtoonCategoryList(webtooncategoryVO);
        model.addAttribute("resultList", noticeList);
    }
    
    if (type.equals("cardNews")) {
    	List noticeList = null;
    	CardNewsVO cardNewsVO = new  CardNewsVO();
    	cardNewsVO.setRecordCountPerPage(Integer.parseInt(article_cnt));
        noticeList = cardNewsService.selectCardNewsList(cardNewsVO);
        model.addAttribute("resultList", noticeList);
    }

  
  

    model.addAttribute("menu_nix", menu_nix);

    return "/custom/widget/" + language + "/" + type;
  }

}
