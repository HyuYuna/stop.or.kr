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
import egovframework.plani.template.webtoon.service.WebtoonService;
import egovframework.plani.template.webtoon.vo.WebtoonCategoryVO;
import egovframework.plani.template.webtoon.vo.WebtoonVO;


/**
 * 웹툰 컨트롤러
 * 
 * 
 *
 */
@Controller
@RequestMapping("/metsys/webtoon")
public class WebtoonManController {

  @Resource(name = "webtoonCategoryService")
  private WebtoonCategoryService webtoonCategoryService;

  @Resource(name = "webtoonService")
  private WebtoonService webtoonService;

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
  @RequestMapping("/webtoonManList")
  public String webtoonManList(@ModelAttribute("webtoonVO") final WebtoonVO webtoonVO,
      HttpServletRequest request, Model model) throws Exception {


    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    webtoonVO.setSrch_mu_gub("MAN");

    List webtoonNoticeList = webtoonService.selectNoticeWebtoonList(webtoonVO);

    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, webtoonVO, new CrudStrategy<WebtoonVO>() {
      @Override
      public int totalCount() throws Exception {
        return webtoonService.selectWebtoonListTotCnt(webtoonVO);
      }

      @Override
      public List<WebtoonVO> pagingList() throws Exception {
        return webtoonService.selectWebtoonList(webtoonVO);
      }
    });

    WebtoonCategoryVO wcvo = new WebtoonCategoryVO();
    wcvo.setSrch_mu_gub("CAT");
    List webtooncategorylist = webtoonCategoryService.selectWebtoonCategoryList(wcvo);

    model.addAttribute("webtoonNoticeList", webtoonNoticeList);
    model.addAttribute("pageIndex", webtoonVO.getPageIndex());
    model.addAttribute("webtooncategorylist", webtooncategorylist);


    // 관리자 로그 저장 C/R/U/D L : 목록
    manlogService.insertManlog(request, "WT_MAN", "웹툰관리", "웹툰 목록조회", "L");


    return "/metsys/webtoon/webtoonManList";
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
  @RequestMapping(value = "/webtoonForm", method = RequestMethod.GET)
  public String webtoonForm(@ModelAttribute("webtoonVO") WebtoonVO webtoonVO,
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
      fVo.setAtckey_1st("WEBTOON");
      fVo.setAtckey_2nd(seq);
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);


      webtoonVO.setCn_seq(Integer.parseInt(seq));
      model.addAttribute("webtoonVO", webtoonService.selectWebtoon(webtoonVO));

    }

    WebtoonCategoryVO wcvo = new WebtoonCategoryVO();
    wcvo.setSrch_mu_gub("CAT");
    List webtooncategorylist = webtoonCategoryService.selectWebtoonCategoryList(wcvo);
    model.addAttribute("webtooncategorylist", webtooncategorylist);

    return "/metsys/webtoon/webtoonForm";
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
  @RequestMapping(value = "/webtoonSave", method = RequestMethod.POST)
  @ResponseBody
  public Object webtoonSave(@Valid WebtoonVO webtoonVO, BindingResult result,
      HttpServletRequest request) throws Exception {

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/webtoon/webtoonForm");


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
      manlogService.insertManlog(request, "WT_MAN", "웹툰관리", "웹툰 수정 [" + webtoonVO.getCn_title()
          + "]", "U");
      webtoonService.updateWebtoon(webtoonVO);
      idx = seq;
    } else {
      // 생성
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "WT_MAN", "웹툰관리", "웹툰 생성 [" + webtoonVO.getCn_title()
          + "]", "C");

      webtoonService.insertWebtoon(webtoonVO);
      idx = webtoonVO.getCn_seq();
    }

    return responseResultHelper.success(null, null,
        "/metsys/webtoon/webtoonManList.do?srch_menu_nix=" + srch_menu_nix, webtoonVO);

  }

  /**
   * 카드뉴스목록 삭제
   * 
   * @param webtoonVO
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/deletewebtoon", method = RequestMethod.GET)
  @ResponseBody
  public Object deletewebtoon(WebtoonVO webtoonVO, HttpServletRequest request) throws Exception {

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
      manlogService.insertManlog(request, "WT_MAN", "웹툰관리",
          "웹툰 삭제 [" + webtoonVO.getCn_seq() + "]", "D");
      webtoonVO.setCn_seq(seq);
      webtoonService.deleteWebtoon(webtoonVO);
    }

    return responseResultHelper.success(null, null,
        "/metsys/webtoon/webtoonManList.do?srch_menu_nix=" + srch_menu_nix, null);

    // return "/metsys/cardnews/cardNewsManList.do?srch_menu_nix=Q67T24ks";
  }


}
