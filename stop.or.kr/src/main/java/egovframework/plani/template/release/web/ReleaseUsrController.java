package egovframework.plani.template.release.web;

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
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.release.service.ReleaseService;
import egovframework.plani.template.release.vo.ReleaseVO;


/**
 * 정보공개 컨트롤러 - 사용자
 * 
 * 
 *
 */
@Controller
@RequestMapping("/release")
public class ReleaseUsrController {


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
  @RequestMapping("/releaseUsrList")
  public String releaseManList(@ModelAttribute("releaseVO") final ReleaseVO releaseVO,
      HttpServletRequest request, Model model) throws Exception {



    List releaseNoticeList = releaseService.selectNoticeReleaseList(releaseVO);

    //사전공표목록 페이징X
    releaseVO.setPageUnit(50);
    
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
		manlogService.insertManlog(request, "REL_USR", "정보공개목록-사용자", "정보공개목록 목록조회", "L");



    return "/release/releaseUsrList";
  }

	@RequestMapping("/releaseUsrView")
	public String releaseManView(@ModelAttribute("releaseVO") final ReleaseVO releaseVO, HttpServletRequest request,
			Model model) throws Exception {

		String seq = request.getParameter("rel_seq");
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

		return "/release/releaseUsrView";
	}

	/**
	   * 관리자 목록
	   * 
	   * @param releaseVO
	   * @param request
	   * @param model
	   * @return
	   * @throws Exception
	   */
	  @RequestMapping("/releaseUsrListBefore")
	  public String releaseListBefore(@ModelAttribute("releaseVO") final ReleaseVO releaseVO,
	      HttpServletRequest request, Model model) throws Exception {

		  releaseVO.setReleaseBefore("Y");

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
			manlogService.insertManlog(request, "REL_USR", "이전정보공개목록-사용자", "이전정보공개목록 목록조회", "L");



	    return "/release/releaseUsrListBefore";
	  }
}
