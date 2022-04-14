package egovframework.plani.template.man.metsys.web;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.metsys.service.AwardsDataService;
import egovframework.plani.template.man.metsys.service.AwardsGroupService;
import egovframework.plani.template.man.metsys.vo.AwardsDataVO;
import egovframework.plani.template.man.metsys.vo.AwardsGroupVO;

@Controller
@RequestMapping("/awards")
public class AwardsController {

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  /** 수상작 그룹 Service */
  @Resource(name = "awardsGroupService")
  private AwardsGroupService awardsGroupService;

  /** 수상작 Service */
  @Resource(name = "awardsDataService")
  private AwardsDataService awardsDataService;

  @Resource
  private CrudTemplate crudTemplate;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 수상작 리스트
   * 
   * @param awardsDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/list")
  public String list(@ModelAttribute("awardsDataVO") final AwardsDataVO awardsDataVO,
      HttpServletRequest request, Model model) throws Exception {

    // 그룹정보
    final AwardsGroupVO group = awardsGroupCheck(request);
    model.addAttribute("awardsGroupVO", group);
    awardsDataVO.setGroup_id(group.getGroup_id());

    // 공지리스트
    List awardsDataNoticeList = awardsDataService.selectAwardsDataNoticeList(awardsDataVO);
    model.addAttribute("awardsDataNoticeList", awardsDataNoticeList);

    awardsDataVO.setPageUnit(100);

    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, awardsDataVO, new CrudStrategy<AwardsDataVO>() {
      @Override
      public int totalCount() throws Exception {
        return awardsDataService.selectAwardsDataListTotalCount(awardsDataVO);
      }

      @Override
      public List<AwardsDataVO> pagingList() throws Exception {
        return awardsDataService.selectAwardsDataList(awardsDataVO);
      }
    });

    return "/awards/list";
  }

  /**
   * 수상작 상세보기
   * 
   * @param awardsDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/view", method = RequestMethod.GET)
  public String view(@ModelAttribute("awardsDataVO") AwardsDataVO awardsDataVO,
      HttpServletRequest request, Model model) throws Exception {

    // 그룹정보
    final AwardsGroupVO group = awardsGroupCheck(request);
    model.addAttribute("awardsGroupVO", group);

    // 공고 정보
    String id = request.getParameter("id");
    awardsDataVO.setData_id(Integer.parseInt(id));
    AwardsDataVO resultVO = awardsDataService.selectAwardsData(awardsDataVO);
    if (resultVO == null) {
      throw new CmmnException("정상적인 접근이 아닙니다.");
    }
    // System.out.println("vo : " + resultVO);
    model.addAttribute("awardsDataVO", resultVO);

    // 첨부파일
    AtchfileVO fVo = new AtchfileVO();
    fVo.setAtckey_1st(MetsysAwardsController.ATTACH_AWARDS_KEY);
    fVo.setAtckey_2nd(String.valueOf(awardsDataVO.getData_id()));
    fVo.setAtckey_3rd(1);

    List fileList = atchfileService.selectAtchfileList(fVo);
    model.addAttribute("atchfileList", fileList);

    return "/awards/view";
  }

  private AwardsGroupVO awardsGroupCheck(HttpServletRequest request) throws Exception {
    String groupId = request.getParameter("groupId");
    AwardsGroupVO awardsGroupVO = new AwardsGroupVO();
    awardsGroupVO.setGroup_id(groupId);
    AwardsGroupVO group = awardsGroupService.selectAwardsGroup(awardsGroupVO);
    if (group == null) {
      throw new CmmnException("그룹정보를 찾을수 없습니다.");
    }
    return group;
  }


}
