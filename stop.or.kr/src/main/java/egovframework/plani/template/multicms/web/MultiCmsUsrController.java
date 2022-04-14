package egovframework.plani.template.multicms.web;

import java.util.Arrays;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.multicms.service.MultiCmsService;
import egovframework.plani.template.multicms.vo.MultiCmsVO;


/**
 * 게시물 컨트롤러 - 사용자
 * 
 * 
 *
 */
@Controller
@RequestMapping("/multicms")
public class MultiCmsUsrController {


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
   * 목록
   * 
   * @param multiCmsVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/multiCmsUsrList")
  public String multiCmsUsrList(@ModelAttribute("multiCmsVO") final MultiCmsVO multiCmsVO,
      HttpServletRequest request, Model model) throws Exception {



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


    model.addAttribute("pageIndex", multiCmsVO.getPageIndex());



    return "/multicms/" + multiCmsVO.getMc_category() + "/multiCmsUsrList";
  }



}
