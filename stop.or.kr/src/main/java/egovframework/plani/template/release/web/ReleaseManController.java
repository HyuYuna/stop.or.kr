package egovframework.plani.template.release.web;

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
import egovframework.plani.template.release.service.ReleaseService;
import egovframework.plani.template.release.vo.ReleaseVO;


/**
 * 정보공개 컨트롤러
 * 
 * 
 *
 */
@Controller
@RequestMapping("/metsys/release")
public class ReleaseManController {


  /** ReleaseService */
  @Resource(name = "releaseService")
  private ReleaseService releaseService;

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
   * @param releaseVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/releaseManList")
  public String releaseManList(@ModelAttribute("releaseVO") final ReleaseVO releaseVO,
      HttpServletRequest request, Model model) throws Exception {

    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    List releaseNoticeList = releaseService.selectNoticeReleaseList(releaseVO);

    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, releaseVO, new CrudStrategy<ReleaseVO>() {
      @Override
      public int totalCount() throws Exception {
        return releaseService.selectReleaseListTotCnt(releaseVO);
      }

      @Override
      public List<ReleaseVO> pagingList() throws Exception {
        return releaseService.selectReleaseList(releaseVO);
      }
    });


    model.addAttribute("releaseNotice", releaseNoticeList);
    model.addAttribute("pageIndex", releaseVO.getPageIndex());



    // 관리자 로그 저장 C/R/U/D L : 목록
    manlogService.insertManlog(request, "REL_MAN", "정보공개목록관리", "정보공개목록 목록조회", "L");



    return "/metsys/release/releaseManList";
  }



  /**
   * 관리자폼화면
   * 
   * @param releaseVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/releaseForm", method = RequestMethod.GET)
  public String releaseForm(@ModelAttribute("releaseVO") ReleaseVO releaseVO,
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
      fVo.setAtckey_1st("RELEASE");
      fVo.setAtckey_2nd(seq);
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);


      releaseVO.setRel_seq(Integer.parseInt(seq));
      model.addAttribute("releaseVO", releaseService.selectRelease(releaseVO));

    }


    return "/metsys/release/releaseForm";
  }



  /**
   * 정보공개목록 저장 로직
   * 
   * @param releaseVO
   * @param result
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/releaseSave", method = RequestMethod.POST)
  @ResponseBody
  public Object releaseSave(@Valid ReleaseVO releaseVO, BindingResult result,
      HttpServletRequest request) throws Exception {

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/release/releaseForm");


    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");

    int seq = Integer.parseInt(request.getParameter("rel_seq"));
    int idx = 0;
    if (seq > 0) {
      // 수정
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "REL_MAN", "정보공개목록 관리",
          "정보공개 수정 [" + releaseVO.getRel_title() + "]", "U");
      releaseService.updateRelease(releaseVO);
      idx = seq;
    } else {
      // 생성
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "REL_MAN", "정보공개목록 관리",
          "정보공개 생성 [" + releaseVO.getRel_title() + "]", "C");

      releaseService.insertRelease(releaseVO);
      idx = releaseVO.getRel_seq();
    }

    return responseResultHelper.success(null, null,
        "/metsys/release/releaseManList.do?srch_menu_nix=" + srch_menu_nix, releaseVO);

  }

  /**
   * 정보공개목록 삭제
   * 
   * @param releaseVO
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/deleteRelease", method = RequestMethod.GET)
  @ResponseBody
  public Object deleteRelease(ReleaseVO releaseVO, HttpServletRequest request) throws Exception {

    int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
    if (userlv > 100) {
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
    }

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/release/releaseForm");

    String srch_menu_nix =
        request.getParameter("srch_menu_nix") == null ? "" : request.getParameter("srch_menu_nix");

    int seq = Integer.parseInt(request.getParameter("seq"));
    if (seq > 0) {
      // 삭제
      // 관리자 로그 저장 C/R/U/D L : 생성
      manlogService.insertManlog(request, "REL_MAN", "정보공개목록 관리",
          "정보공개 삭제 [" + releaseVO.getRel_seq() + "]", "D");
      releaseVO.setRel_seq(seq);
      releaseService.deleteRelease(releaseVO);
    }

    return responseResultHelper.success(null, null,
        "/metsys/release/releaseManList.do?srch_menu_nix=" + srch_menu_nix, null);

    // return "/metsys/release/releaseManList.do?srch_menu_nix=Q67T24ks";
  }


}
