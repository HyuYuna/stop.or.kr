package egovframework.plani.template.multicms.web;

import java.util.Arrays;
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
import egovframework.plani.template.multicms.service.MultiCmsService;
import egovframework.plani.template.multicms.vo.MultiCmsVO;

/**
 * 게시물 컨트롤러
 * 
 * 
 *
 */
@Controller
@RequestMapping("/metsys/multicms")
public class MultiCmsManController {


  /** multiCmsService */
  @Resource(name = "multiCmsService")
  private MultiCmsService multiCmsService;

  @Resource(name = "manlogService")
  private ManlogService manlogService;

  @Resource
  private CrudTemplate crudTemplate;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;


  /**
   * 권한체크, category 설정 및 확인
   * 
   * @param request
   * @param multiCmsVO
   * @return
   * @throws Exception
   */
  public MultiCmsVO permitCheck(HttpServletRequest request, MultiCmsVO multiCmsVO)
      throws Exception {

    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    /**
     * pp -정기간행물 , pd -발간자료 , ck -캠페인킷
     */
    String[] categoryList = {"pp", "pd", "ck", "wp"};
    String category = request.getParameter("category");

    if (category != null && Arrays.asList(categoryList).contains(category) == true) {
      multiCmsVO.setMc_category(category);
    } else {
      throw new CmmnException(
          MessageHelper.getMessage("REQUIRED-VALUE-IS-MISSING")/* 필수 입력값이 누락되었습니다. */);
    }


    return multiCmsVO;
  }


  /**
   * 관리자 목록
   * 
   * @param multiCmsVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */

  @RequestMapping("/multiCmsManList")
  public String multiCmsManList(@ModelAttribute("MultiCmsVO") final MultiCmsVO multiCmsVO,
      HttpServletRequest request, Model model) throws Exception {


    // 권한체크, category 설정 및 확인
    permitCheck(request, multiCmsVO);


    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, multiCmsVO, new CrudStrategy<MultiCmsVO>() {

      @Override
      public int totalCount() throws Exception {
        return multiCmsService.selectMultiCmsListTotCnt(multiCmsVO);
      }

      @Override
      public List<MultiCmsVO> pagingList() throws Exception {
        return multiCmsService.selectMultiCmsList(multiCmsVO);
      }
    });

    model.addAttribute("multiCmsVO", multiCmsVO);
    model.addAttribute("pageIndex", multiCmsVO.getPageIndex());



    // 관리자 로그 저장 C/R/U/D L : 목록
    // manlogService.insertManlog(request, "MULTI_MAN", "게시물목록관리", "정기간행물 목록조회", "L");



    return "/metsys/" + multiCmsVO.getMc_category() + "/multiCmsManList";
  }



  /**
   * 관리자폼화면
   * 
   * @param multiCmsVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/multiCmsForm", method = RequestMethod.GET)
  public String multiCmsForm(@ModelAttribute("multiCmsVO") MultiCmsVO multiCmsVO,
      HttpServletRequest request, Model model) throws Exception {

    // 권한체크, category 설정 및 확인
    permitCheck(request, multiCmsVO);

    String pageIndex = request.getParameter("pageIndex");
    if (StringUtils.isEmpty(pageIndex) == false) {
      model.addAttribute("pageIndex", pageIndex);
    } else {
      model.addAttribute("pageIndex", 1);
    }


    String seq = request.getParameter("seq");
    if (StringUtils.isEmpty(seq) == false) {


      // 첨부파일 - 이미지
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st("MULTI_CMS");
      fVo.setAtckey_2nd(seq);
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);

      // 첨부파일 - 파일
      AtchfileVO fVo_f = new AtchfileVO();
      fVo_f.setAtckey_1st("MULTI_CMS");
      fVo_f.setAtckey_2nd(seq);
      fVo_f.setAtckey_3rd(2);

      List fileList_f = atchfileService.selectAtchfileList(fVo_f);
      model.addAttribute("atchfileList_f", fileList_f);


      multiCmsVO.setMc_seq(Integer.parseInt(seq));
      model.addAttribute("multiCmsVO", multiCmsService.selectMultiCms(multiCmsVO));

    }


    return "/metsys/" + multiCmsVO.getMc_category() + "/multiCmsForm";
  }



  /**
   * 게시물목록 저장 로직
   * 
   * @param multiCmsVO
   * @param result
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/multiCmsSave", method = RequestMethod.POST)
  @ResponseBody
  public Object multiCmsSave(@Valid MultiCmsVO multiCmsVO, BindingResult result,
      HttpServletRequest request) throws Exception {

    // 권한체크, category 설정 및 확인
    permitCheck(request, multiCmsVO);
    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/multicms/multiCmsForm");


    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");

    int seq = Integer.parseInt(request.getParameter("mc_seq"));
    int idx = 0;
    if (seq > 0) {
      // 수정
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "MC_MAN", "게시물목록 관리",
          "게시물 수정 [" + multiCmsVO.getMc_title() + "]", "U");
      multiCmsService.updateMultiCms(multiCmsVO);
      idx = seq;
    } else {
      // 생성
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "MC_MAN", "게시물목록 관리",
          "게시물 생성 [" + multiCmsVO.getMc_title() + "]", "C");

      multiCmsService.insertMultiCms(multiCmsVO);
      idx = multiCmsVO.getMc_seq();
    }


    return responseResultHelper.success(null, null, "/metsys/multicms/multiCmsManList.do?category="
        + multiCmsVO.getMc_category() + "&srch_menu_nix=" + srch_menu_nix, multiCmsVO);

  }

  /**
   * 게시물목록 삭제
   * 
   * @param multiCmsVO
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/deleteMultiCms", method = RequestMethod.GET)
  @ResponseBody
  public Object deleteMultiCms(MultiCmsVO multiCmsVO, HttpServletRequest request) throws Exception {

    // 권한체크, category 설정 및 확인
    permitCheck(request, multiCmsVO);

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/multicms/multiCmsForm");

    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");

    int seq = Integer.parseInt(request.getParameter("seq"));
    if (seq > 0) {
      // 삭제
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "MC_MAN", "게시물목록 관리",
          "게시물 삭제 [" + multiCmsVO.getMc_seq() + "]", "D");
      multiCmsVO.setMc_seq(seq);
      multiCmsService.deleteMultiCms(multiCmsVO);
    }

    return responseResultHelper.success(null, null, "/metsys/multicms/multiCmsManList.do?category="
        + multiCmsVO.getMc_category() + "&srch_menu_nix=" + srch_menu_nix, null);


  }


}
