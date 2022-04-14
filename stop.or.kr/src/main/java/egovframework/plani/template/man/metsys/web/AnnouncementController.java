package egovframework.plani.template.man.metsys.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nhncorp.lucy.security.xss.XssSaxFilter;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.metsys.service.AnnouncementDataService;
import egovframework.plani.template.man.metsys.service.AnnouncementGroupService;
import egovframework.plani.template.man.metsys.vo.AnnouncementDataVO;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;
import egovframework.dev.cmm.util.StringUtil;;

@Controller
@RequestMapping("/announcement")
public class AnnouncementController {

  /** SysmenuService */
  @Resource(name = "sysmenuService")
  private SysmenuService sysmenuService;

  /** 공고 그룹 Service */
  @Resource(name = "announcementGroupService")
  private AnnouncementGroupService announcementGroupService;

  /** 공고 Service */
  @Resource(name = "announcementDataService")
  private AnnouncementDataService announcementDataService;

  @Resource
  private CrudTemplate crudTemplate;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 공고 리스트
   * 
   * @param announcementDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/list")
  public String list(
      @ModelAttribute("announcementDataVO") final AnnouncementDataVO announcementDataVO,
      HttpServletRequest request, Model model) throws Exception {

    // 그룹정보
    final AnnouncementGroupVO group = announcementGroupCheck(request);
    model.addAttribute("announcementGroupVO", group);
    announcementDataVO.setGroup_id(group.getGroup_id());

    // 공지리스트
    List announcementDataNoticeList =
        announcementDataService.selectAnnouncementDataNoticeList(announcementDataVO);
    model.addAttribute("announcementDataNoticeList", announcementDataNoticeList);

    announcementDataVO.setPageUnit(15);
    
    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, announcementDataVO,
        new CrudStrategy<AnnouncementDataVO>() {
          @Override
          public int totalCount() throws Exception {
            return announcementDataService.selectAnnouncementDataListTotalCount(announcementDataVO);
          }

          @Override
          public List<AnnouncementDataVO> pagingList() throws Exception {
        	  List announcementDataList =
        		        announcementDataService.selectAnnouncementDataList(announcementDataVO);
            return announcementDataService.selectAnnouncementDataList(announcementDataVO);
          }
        });

    return "/announcement/list";
  }

  /**
   * 공고 상세보기
   * 
   * @param announcementDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/view", method = RequestMethod.GET)
  public String view(@ModelAttribute("announcementDataVO") AnnouncementDataVO announcementDataVO,
      HttpServletRequest request, Model model) throws Exception {

    // 그룹정보
    final AnnouncementGroupVO group = announcementGroupCheck(request);
    model.addAttribute("announcementGroupVO", group);

    // 공고 정보
    String id = request.getParameter("id");
    announcementDataVO.setData_id(Integer.parseInt(id));
    AnnouncementDataVO resultVO =
        announcementDataService.selectAnnouncementData(announcementDataVO);
    if (resultVO == null) {
      throw new CmmnException("정상적인 접근이 아닙니다.");
    }
    // System.out.println("vo : " + resultVO);
    model.addAttribute("announcementDataVO", resultVO);

    // 첨부파일
    AtchfileVO fVo = new AtchfileVO();
    fVo.setAtckey_1st(MetsysAnnouncementController.ATTACH_ANNOUNCEMENT_KEY);
    fVo.setAtckey_2nd(String.valueOf(announcementDataVO.getData_id()));
    fVo.setAtckey_3rd(1);

    List fileList = atchfileService.selectAtchfileList(fVo);
    model.addAttribute("atchfileList", fileList);

    return "/announcement/view";
  }

  private AnnouncementGroupVO announcementGroupCheck(HttpServletRequest request) throws Exception {
	  String groupId = request.getParameter("groupId");
	  
	  XssSaxFilter filter = XssSaxFilter.getInstance("lucy-xss.xml");//20191108 취약점 조치 추가
	  groupId = filter.doFilter(groupId);
	 
    AnnouncementGroupVO announcementGroupVO = new AnnouncementGroupVO();
    announcementGroupVO.setGroup_id(groupId);
    AnnouncementGroupVO group =
        announcementGroupService.selectAnnouncementGroup(announcementGroupVO);
    if (group == null) {
      throw new CmmnException("그룹정보를 찾을수 없습니다.");
    }
    return group;
  }


}
