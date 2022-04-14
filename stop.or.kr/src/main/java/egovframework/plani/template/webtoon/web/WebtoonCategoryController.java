package egovframework.plani.template.webtoon.web;

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
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.webtoon.service.WebtoonCategoryService;
import egovframework.plani.template.webtoon.vo.WebtoonCategoryVO;


@Controller
@RequestMapping("/metsys/webtooncategory")
public class WebtoonCategoryController {


  @Resource(name = "webtoonCategoryService")
  private WebtoonCategoryService webtoonCategoryService;

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
   * @param webtoonVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/webtooncategoryManList")
  public String webtooncategoryManList(
      @ModelAttribute("webtooncategoryVO") final WebtoonCategoryVO webtooncategoryVO,
      HttpServletRequest request, Model model) throws Exception {


    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, webtooncategoryVO,
        new CrudStrategy<WebtoonCategoryVO>() {
          @Override
          public int totalCount() throws Exception {
            return webtoonCategoryService.selectWebtoonCategoryListTotCnt(webtooncategoryVO);
          }

          @Override
          public List<WebtoonCategoryVO> pagingList() throws Exception {
            return webtoonCategoryService.selectWebtoonCategoryList(webtooncategoryVO);
          }
        });

    model.addAttribute("pageIndex", webtooncategoryVO.getPageIndex());



    // 관리자 로그 저장 C/R/U/D L : 목록
    manlogService.insertManlog(request, "WT_CATE_MAN", "웹툰카테고리관리", "웹툰카테고리조회", "L");


    return "/metsys/webtooncategory/webtoonCategoryManList";
  }


  /**
   * 관리자폼화면
   * 
   * @param webtoonVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/webtooncategoryForm", method = RequestMethod.GET)
  public String webtooncategoryForm(
      @ModelAttribute("webtooncategoryVO") WebtoonCategoryVO webtooncategoryVO,
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
      fVo.setAtckey_1st("WEBTOON_THUMBNAIL");
      fVo.setAtckey_2nd(seq);
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);


      webtooncategoryVO.setCn_seq(Integer.parseInt(seq));
      model.addAttribute("webtooncategoryVO",
          webtoonCategoryService.selectWebtoonCategory(webtooncategoryVO));

    }


    return "/metsys/webtooncategory/webtoonCategoryForm";
  }

  /**
   * 카드뉴스목록 저장 로직
   * 
   * @param webtoonVO
   * @param result
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/webtooncategorySave", method = RequestMethod.POST)
  @ResponseBody
  public Object webtooncategorySave(@Valid WebtoonCategoryVO webtooncategoryVO,
      BindingResult result, HttpServletRequest request) throws Exception {

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/webtoon/webtoonCategoryForm");


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
      manlogService.insertManlog(request, "WT_CATE_MAN", "웹툰카테고리관리", "웹툰카테고리수정 ["
          + webtooncategoryVO.getCn_title() + "]", "U");
      webtoonCategoryService.updateWebtoonCategory(webtooncategoryVO);
      idx = seq;
    } else {
      // 생성
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "WT_CATE_MAN", "웹툰카테고리관리", "웹툰카테고리생성 ["
          + webtooncategoryVO.getCn_title() + "]", "C");

      webtoonCategoryService.insertWebtoonCategory(webtooncategoryVO);
      idx = webtooncategoryVO.getCn_seq();
    }


    // 첨부파일 처리
    atchfileService.uploadProcFormfiles(request, "WEBTOON_THUMBNAIL",
        String.valueOf(webtooncategoryVO.getCn_seq()), 1, "IMG", "thumbnail");


    return responseResultHelper.success(null, null,
        "/metsys/webtooncategory/webtooncategoryManList.do?srch_menu_nix=" + srch_menu_nix,
        webtooncategoryVO);

  }



  /**
   * 카드뉴스목록 삭제
   * 
   * @param webtoonVO
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/deletewebtooncategory", method = RequestMethod.GET)
  @ResponseBody
  public Object deletewebtooncategory(WebtoonCategoryVO webtooncategoryVO,
      HttpServletRequest request) throws Exception {

    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/webtoon/webtoonForm");

    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");

    int seq = Integer.parseInt(request.getParameter("seq"));
    if (seq > 0) {
      // 삭제
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "WT_CATE_MAN", "웹툰카테고리관리", "웹툰카테고리삭제 ["
          + webtooncategoryVO.getCn_seq() + "]", "D");
      webtooncategoryVO.setCn_seq(seq);

      // 첨부파일
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st("WEBTOON_THUMBNAIL");
      fVo.setAtckey_2nd(String.valueOf(webtooncategoryVO.getCn_seq()));
      fVo.setAtckey_3rd(1);
      atchfileService.deleteAtchfiles(fVo);
      // 그 밑에 해당되는 게시글 전체 삭제
      webtoonCategoryService.deleteWebtoonAll(webtooncategoryVO);
      // 카테고리삭제
      webtoonCategoryService.deleteWebtoonCategory(webtooncategoryVO);
    }

    return responseResultHelper.success(null, null,
        "/metsys/webtooncategory/webtooncategoryManList.do?srch_menu_nix=" + srch_menu_nix, null);

    // return "/metsys/cardnews/cardNewsManList.do?srch_menu_nix=Q67T24ks";
  }



}
