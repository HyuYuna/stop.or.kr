package egovframework.plani.template.man.popup.web;

import java.text.NumberFormat;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.pagination.PlaniPaginationInfo;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.popup.service.PopupService;
import egovframework.plani.template.man.popup.vo.PopupVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 팝업 액션 컨트롤러
 * 
 * @class [ContextPath] [egovframework.plani.template.man.popup.web] [PopupController.java]
 *
 */
@Controller
@RequestMapping("/popup")
public class PopupController {

  /** PopupService */
  @Resource(name = "popupService")
  private PopupService popupService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  /**
   * 액션 설명
   * 
   * @param param 파라미터 설명 VO
   * @return return value 설명
   * @exception Exception
   */
  @RequestMapping("/movePopupBase")
  public String movePopupBase(@ModelAttribute("popupVO") PopupVO popupVO, Model model)
      throws Exception {

    return "/popup/popupBase";
  }

  /**
   * 목록을 조회한다.
   * 
   * @param popupVO : 등록할 정보가 담긴 VO
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/popupList")
  public String popupList(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request,
      Model model) throws Exception {


    /** pageing setting */
    PlaniPaginationInfo paginationInfo = new PlaniPaginationInfo();
    paginationInfo.setContextPath(request.getContextPath());
    paginationInfo.setCurrentPageNo(popupVO.getPageIndex());
    paginationInfo.setRecordCountPerPage(propertiesService.getInt("pageUnit"));
    paginationInfo.setPageSize(propertiesService.getInt("pageSize"));

    popupVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    popupVO.setLastIndex(paginationInfo.getLastRecordIndex());
    popupVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    List popList = popupService.selectPopupList(popupVO);
    model.addAttribute("resultList", popList);

    int totCnt = popupService.selectPopupListTotCnt(popupVO);
    paginationInfo.setTotalRecordCount(totCnt);
    model.addAttribute("paginationInfo", paginationInfo);

    NumberFormat nf = NumberFormat.getInstance();
    model.addAttribute("curPage", nf.format(paginationInfo.getCurrentPageNo()));
    model.addAttribute("totCnt", nf.format(totCnt));
    model.addAttribute("totPage", nf.format(paginationInfo.getTotalPageCount()));

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "PP_MAN", "팝업관리", "팝업 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "/popup/popupList";
  }

  /**
   * 항목을 상세 조회한다.
   * 
   * @param popupVO : 조회할 정보
   * @param request
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/popupView")
  public String popupView(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request,
      ModelMap model) throws Exception {

    int seq = popupVO.getPop_seq();

    if (seq > 0) {
      PopupVO resultVO = popupService.selectPopup(popupVO);

      if (popupVO == null)
        throw new CmmnException(MessageHelper.getMessage("DATA-DOES-NOT-EXIST")/* 존재하지 않는 데이터입니다. */);

      resultVO.setSrch_menu_nix(popupVO.getSrch_menu_nix());
      resultVO.setSeltab_idx(popupVO.getSeltab_idx());
      resultVO.setEdomweivgp(popupVO.getEdomweivgp());
      resultVO.setPageIndex(popupVO.getPageIndex());

      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st("POPUP");
      fVo.setAtckey_2nd(new Integer(seq).toString());
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);

      model.addAttribute("popupVO", resultVO);
      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "PP_MAN", "팝업관리", "팝업 상세조회 [" + popupVO.getPop_title()
          + "]", "R");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////

    } else {
      throw new CmmnException(MessageHelper.getMessage("REQUIRED-PARAMETER-DOES-NOT-EXIST")/*
                                                                                            * 필수
                                                                                            * 파라미터가
                                                                                            * 존재하지
                                                                                            * 않습니다.
                                                                                            */);
    }


    return "/popup/popupView";
  }

  /**
   * 등록/수정 폼
   * 
   * @param popupVO
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/popupWrite")
  public String popupWrite(@ModelAttribute("popupVO") PopupVO popupVO, ModelMap model)
      throws Exception {

    int seq = popupVO.getPop_seq();
    String formMode;

    // 등록
    if ("A".equals(popupVO.getEdomweivgp())) {

    } else {
      PopupVO resultVO = popupService.selectPopup(popupVO);

      resultVO.setSrch_menu_nix(popupVO.getSrch_menu_nix());
      resultVO.setSeltab_idx(popupVO.getSeltab_idx());
      resultVO.setEdomweivgp(popupVO.getEdomweivgp());
      resultVO.setPageIndex(popupVO.getPageIndex());

      if (popupVO == null)
        throw new CmmnException(MessageHelper.getMessage("DATA-DOES-NOT-EXIST")/* 존재하지 않는 데이터입니다. */);

      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st("POPUP");
      fVo.setAtckey_2nd(new Integer(seq).toString());
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);
      model.addAttribute("popupVO", resultVO);
    }


    return "/popup/popupWrite";
  }

  /**
   * 항목을 추가한다.
   * 
   * @param popupVO : 추가할 정보
   * @param request
   * @return "/popup/popupView?ret_='id값'"
   * @exception Exception
   */
  @RequestMapping("/addPopup")
  @ResponseBody
  public String addPopup(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request)
      throws Exception {

    String ret_ = "";

    try {

      if (popupVO.getPop_title() == null || popupVO.getPop_title().equals(""))
        throw new AjaxException(MessageHelper.getMessage("PLEASE-ENTER-A-TITLE")/* 팝업 제목을 입력하여 주십시오. */);
      if (popupVO.getPop_type() == null || popupVO.getPop_type().equals(""))
        throw new AjaxException(MessageHelper.getMessage("PLEASE-SELECT-A-POPUP-TYPE")/*
                                                                                       * 팝업 구분을 선택하여
                                                                                       * 주십시오.
                                                                                       */);

      if ("W".equals(popupVO.getPop_type())) {
        if (popupVO.getPop_from() == null || popupVO.getPop_from().equals(""))
          throw new AjaxException(MessageHelper.getMessage("PLEASE-ENTER-THE-START-DATE")/*
                                                                                          * 팝업 게시
                                                                                          * 시작일을
                                                                                          * 입력하여
                                                                                          * 주십시오.
                                                                                          */);
        if (popupVO.getPop_to() == null || popupVO.getPop_to().equals(""))
          throw new AjaxException(MessageHelper.getMessage("PLEASE-ENTER-THE-END-DATE")/*
                                                                                        * 팝업 게시 시작일을
                                                                                        * 입력하여 주십시오.
                                                                                        */);
      }

      popupService.insertPopup(popupVO);

      int seq = popupVO.getPop_seq();
      ret_ += seq;

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "PP_MAN", "팝업관리", "팝업 추가 [" + popupVO.getPop_title()
          + "]", "C");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////


    } catch (Exception e) {
      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);

    }

    return ret_;
  }


  /**
   * 항목을 수정한다.
   * 
   * @param popupVO : 수정할 정보
   * @parm request
   * @return seq[id값]
   * @exception Exception
   */
  @RequestMapping("/mdfPopup")
  @ResponseBody
  public String mdfPopup(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request)
      throws Exception {

    String seq = new Integer(popupVO.getPop_seq()).toString();

    try {

      if (seq.equals("0"))
        throw new AjaxException(MessageHelper.getMessage("ARTICLE-NUMBER-IS-MISSING")/*
                                                                                      * 게시물 번호가
                                                                                      * 필요합니다.
                                                                                      */);

      PopupVO resultVo = new PopupVO();
      resultVo.setPop_seq(popupVO.getPop_seq());
      resultVo = popupService.selectPopup(resultVo);
      if (resultVo == null)
        throw new AjaxException(MessageHelper.getMessage("DATA-DOES-NOT-EXIST")/* 존재하지 않는 데이터입니다. */);

      popupService.updatePopup(popupVO);


      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "PP_MAN", "팝업관리", "팝업 변경 [" + resultVo.getPop_title()
          + "]", "U");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////



    } catch (Exception e) {

      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }
    return seq;

  }


  /**
   * 항목을 삭제한다.
   * 
   * @param popupVO : 삭제할 정보
   * @param request
   * @return redirect[srch_menu_nix='메뉴코드명',pageIndex='현재페이지']
   * @exception Exception
   */
  @RequestMapping("/rmvPopup")
  public String rmvPopup(@ModelAttribute("popupVO") PopupVO popupVO, HttpServletRequest request,
      ModelMap model) throws Exception {

    popupService.deletePopup(popupVO);
    model.addAttribute("resultVO", popupVO);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    PopupVO resultVO = popupService.selectPopup(popupVO);
    manlogService.insertManlog(request, "PP_MAN", "팝업관리",
        "팝업 변경 [" + (resultVO == null ? popupVO.getPop_title() : resultVO.getPop_title()) + "]",
        "U");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    return "redirect:/popup/popupList.do?srch_menu_nix=" + popupVO.getSrch_menu_nix()
        + "&seltab_idx=" + popupVO.getSeltab_idx() + "&"
        + popupVO.getUrlParams().replaceAll("&amp;", "&");
  }

  /**
   * 순서를 정렬한다. 목록에서의 기본 정렬이 pop_sort desc 이므로 이에 맞추어 작업해야 합니다.
   * 
   * @param PopupVO
   * @param model
   * @return redirect[srch_menu_nix='메뉴코드명',pageIndex='현재페이지']
   * @exception Exception
   */
  @RequestMapping("/sortPopup")
  public String sortPopup(@ModelAttribute("popupVO") PopupVO popupVO, ModelMap model)
      throws Exception {
    if (popupVO.getPop_seq() < 1)
      throw new Exception(MessageHelper.getMessage("SEQ-IS-MISSING")/* seq 누락 */);
    if (popupVO.getSort_dir() == null
        || (!popupVO.getSort_dir().equals("up") && !popupVO.getSort_dir().equals("down")))
      throw new Exception("정렬 방향 값(dir)은 [up | down]만 가능합니다.");
    popupService.sortPopup(popupVO);

    return "redirect:/popup/popupList.do?srch_menu_nix=" + popupVO.getSrch_menu_nix()
        + "&seltab_idx=" + popupVO.getSeltab_idx() + "&"
        + popupVO.getUrlParams().replaceAll("&amp;", "&");
  }

  /**
   * 사용/미사용 toggle
   * 
   * @param PopupVO
   * @param model
   * @return redirect[srch_menu_nix='메뉴코드명',pageIndex='현재페이지']
   * @exception Exception
   */
  @RequestMapping("/popupToggleUse")
  public String popupToggleUse(@ModelAttribute("popupVo") PopupVO popupVO, ModelMap model)
      throws Exception {
    String seq;
    if (popupVO.getPop_seq() < 1)
      throw new Exception(MessageHelper.getMessage("SEQ-IS-MISSING")/* seq 누락 */);
    seq = new Integer(popupVO.getPop_seq()).toString();


    popupService.updatePopupUseYn(seq);

    return "redirect:/popup/popupList.do?srch_menu_nix=" + popupVO.getSrch_menu_nix()
        + "&seltab_idx=" + popupVO.getSeltab_idx() + "&"
        + popupVO.getUrlParams().replaceAll("&amp;", "&");
  }

  /**
   * 팝업 및 팝업존 샘플 표시
   * 
   * @param model
   * @return tiles
   * @exception Exception
   */
  @RequestMapping("/showPopup")
  public String showPopup(ModelMap model) throws Exception {


    return "/popup/showPopup";
  }
}
