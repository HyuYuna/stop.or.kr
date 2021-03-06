package egovframework.plani.template.man.metsys.web;

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
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CommonUtil;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.cmm.utils.UserInfoHelper;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;
import egovframework.plani.template.man.metsys.service.AnnouncementDataService;
import egovframework.plani.template.man.metsys.service.AnnouncementGroupService;
import egovframework.plani.template.man.metsys.vo.AnnouncementDataVO;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/metsys")
public class MetsysAnnouncementController {

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** SyscodeService */
  @Resource(name = "syscodeService")
  private SyscodeService syscodeService;

  /** ?????? ?????? Service */
  @Resource(name = "announcementGroupService")
  private AnnouncementGroupService announcementGroupService;

  /** ?????? Service */
  @Resource(name = "announcementDataService")
  private AnnouncementDataService announcementDataService;

  @Resource
  private CrudTemplate crudTemplate;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** ????????? ??? */
  public final static String ATTACH_ANNOUNCEMENT_KEY = "ANNOUNCEMENT";

  /**
   * ?????? ?????? ??????
   * 
   * @param announcementGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/announcementGroupList", method = RequestMethod.GET)
  public String announcementSetupList(
      @ModelAttribute("announcementGroupVO") final AnnouncementGroupVO announcementGroupVO,
      HttpServletRequest request, Model model) throws Exception {

    String mu_site = announcementGroupVO.getSrch_mu_site();
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    announcementGroupVO.setSrch_mu_site(mu_site);

    String mu_lang = announcementGroupVO.getSrch_mu_lang();
    mu_lang = (mu_lang == null || "".equals(mu_lang)) ? "CDIDX00022" : mu_lang;
    announcementGroupVO.setSrch_mu_lang(mu_lang);

    announcementGroupVO.setPageUnit(5);

    // ????????? ?????? ??????
    crudTemplate.pagingList(request, model, announcementGroupVO,
        new CrudStrategy<AnnouncementGroupVO>() {
          @Override
          public int totalCount() throws Exception {
            return announcementGroupService
                .selectAnnouncementGroupListTotalCount(announcementGroupVO);
          }

          @Override
          public List<AnnouncementGroupVO> pagingList() throws Exception {
            return announcementGroupService.selectAnnouncementGroupList(announcementGroupVO);
          }
        });

    // ??????????????? ?????? ??????
    SyscodeVO codeVO = new SyscodeVO();
    codeVO.setUse_yn("Y");
    codeVO.setUp_code_idx("CDIDX00001");
    List sitecode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("sitecode", sitecode);

    // ???????????? ?????? ??????
    codeVO.setUp_code_idx("CDIDX00021");
    List langcode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("langcode", langcode);

    return "/metsys/announcementGroupList";
  }

  /**
   * ?????? ?????? ??????/?????? ???
   * 
   * @param announcementGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/announcementGroupForm")
  public String announcementGroupForm(
      @ModelAttribute("announcementGroupVO") AnnouncementGroupVO announcementGroupVO,
      HttpServletRequest request, Model model) throws Exception {
    announcementGroupFormProc(request, model, announcementGroupVO);
    return "/metsys/announcementGroupForm";
  }

  /**
   * ?????? ?????? ??????
   * 
   * @param announcementGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/announcementGroupForm", method = RequestMethod.POST)
  @ResponseBody
  public Object announcementGroupForm(@Valid AnnouncementGroupVO announcementGroupVO,
      BindingResult result, HttpServletRequest request, Model model) throws Exception {

    boolean isModify = announcementGroupFormProc(request, model, announcementGroupVO);

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/announcementGroupForm");
    // ????????? ??????
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }
    // ?????? ????????? ??????
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // ?????????
    announcementGroupVO.setModifier(sessionUserData.getUser_id());

    if (isModify == true) {
      announcementGroupService.updateAnnouncementGroup(announcementGroupVO);
    } else {
      // ?????????
      announcementGroupVO.setWriter(sessionUserData.getUser_id());
      announcementGroupService.insertAnnouncementGroup(announcementGroupVO);
    }

    // ??????
    return responseResultHelper.success(null, null,
        CommonUtil.getUrl("/metsys/announcementGroupList.do", "id=", true), null);
  }

  /**
   * ?????? ?????? ??????/?????? ??????
   * 
   * @param request
   * @param model
   * @param announcementGroupVO
   * @return
   * @throws Exception
   */
  private boolean announcementGroupFormProc(HttpServletRequest request, Model model,
      AnnouncementGroupVO announcementGroupVO) throws Exception {
    String id = request.getParameter("id");
    boolean isModify = false;
    if (StringUtils.isEmpty(id) == true) {
      // ?????? ??????
    } else {
      // ??????
      isModify = true;
      // ????????? ??????
      announcementGroupVO.setGroup_id(id);
      AnnouncementGroupVO resultVO =
          announcementGroupService.selectAnnouncementGroup(announcementGroupVO);
      if (resultVO == null) {
        throw new CmmnException(
            MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST"));
      }
      model.addAttribute("announcementGroupVO", resultVO);
    }
    model.addAttribute("isModify", isModify);
    return isModify;
  }

  /**
   * ?????? ?????? ??????
   * 
   * @param announcementGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/announcementGroupDelete")
  public String announcementGroupDelete(
      @ModelAttribute("announcementGroupVO") AnnouncementGroupVO announcementGroupVO,
      HttpServletRequest request, Model model) throws Exception {
    String id = request.getParameter("id");
    AnnouncementGroupVO resultVO = null;
    if (StringUtils.isEmpty(id) == false) {
      // ????????? ??????
      announcementGroupVO.setGroup_id(id);
      resultVO = announcementGroupService.selectAnnouncementGroup(announcementGroupVO);
    }
    // ????????? ??????
    if (resultVO == null) {
      throw new CmmnException("???????????? ????????? ????????? ????????????.");
    }

    // System.out.println("announcementGroupVO : " + resultVO);

    // ?????? ?????? ?????????
    List<AnnouncementDataVO> dataRow =
        announcementDataService.selectAnnouncementDataAllList(announcementGroupVO);

    // ?????? ????????? ???????????? ??????
    for (int i = 0; i < dataRow.size(); i++) {
      AnnouncementDataVO data = dataRow.get(i);

      // ?????? ??????
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st(ATTACH_ANNOUNCEMENT_KEY);
      fVo.setAtckey_2nd(String.valueOf(data.getData_id()));
      fVo.setAtckey_3rd(1);

      // ?????? ???????????? ??? ?????????????????? ?????? ??????
      atchfileService.deleteAtchfiles(fVo);
    }

    // ?????? ?????? ????????? ??????
    announcementDataService.deleteAnnouncementDataAll(resultVO);

    // ???????????? ??????
    announcementGroupService.deleteAnnouncementGroup(resultVO);
    return CommonUtil.getRedirectUrl("/metsys/announcementGroupList.do", "id=", true);
  }

  /**
   * ?????? ?????????
   * 
   * @param announcementDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/announcementDataList")
  public String announcementDataList(
      @ModelAttribute("announcementDataVO") final AnnouncementDataVO announcementDataVO,
      HttpServletRequest request, Model model) throws Exception {
    // ????????????
    final AnnouncementGroupVO group = announcementGroupCheck(request);
    model.addAttribute("announcementGroupVO", group);
    announcementDataVO.setGroup_id(group.getGroup_id());

    // ???????????????
    List announcementDataNoticeList =
        announcementDataService.selectAnnouncementDataNoticeList(announcementDataVO);
    model.addAttribute("announcementDataNoticeList", announcementDataNoticeList);

    announcementDataVO.setPageUnit(5);

    System.out.println(announcementDataVO);

    // ????????? ?????? ??????
    crudTemplate.pagingList(request, model, announcementDataVO,
        new CrudStrategy<AnnouncementDataVO>() {
          @Override
          public int totalCount() throws Exception {
            return announcementDataService.selectAnnouncementDataListTotalCount(announcementDataVO);
          }

          @Override
          public List<AnnouncementDataVO> pagingList() throws Exception {
            return announcementDataService.selectAnnouncementDataList(announcementDataVO);
          }
        });

    return "/metsys/announcementDataList";
  }

  /**
   * ?????? ??????/?????? ???
   * 
   * @param announcementDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/announcementDataForm", method = RequestMethod.GET)
  public String announcementDataForm(
      @ModelAttribute("announcementDataVO") AnnouncementDataVO announcementDataVO,
      HttpServletRequest request, Model model) throws Exception {
    announcementDataFormProc(request, model, announcementDataVO);
    return "/metsys/announcementDataForm";
  }

  /**
   * ?????? ??????/??????
   * 
   * @param announcementDataVO
   * @param result
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/announcementDataForm", method = RequestMethod.POST)
  @ResponseBody
  public Object announcementDataForm(@Valid AnnouncementDataVO announcementDataVO,
      BindingResult result, HttpServletRequest request, Model model) throws Exception {

    boolean isModify = announcementDataFormProc(request, model, announcementDataVO);

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/announcementDataForm");

    // ????????? ??????
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    // ?????? ????????? ??????
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // ?????????
    announcementDataVO.setModifier(sessionUserData.getUser_id());

    // ?????? ??????, ????????? ??????
    if (StringUtils.isEmpty(announcementDataVO.getDate_start()) == true
        || StringUtils.isEmpty(announcementDataVO.getDate_end()) == true) {
      announcementDataVO.setDate_start(null);
      announcementDataVO.setDate_end(null);
    }

    String message;
    String returnUrl;

    if (isModify == true) {
      // ?????? ??????
      announcementDataService.updateAnnouncementData(announcementDataVO);
      message = "?????????????????????.";
      returnUrl = CommonUtil.getUrl("/metsys/announcementDataForm.do", "", true);

    } else {
      // ?????? ??????
      // ?????????
      announcementDataVO.setWriter(sessionUserData.getUser_id());
      announcementDataService.insertAnnouncementData(announcementDataVO);
      message = "?????????????????????.";
      returnUrl = CommonUtil.getUrl("/metsys/announcementDataList.do", "id=", true);
    }

    // ??????
    return responseResultHelper.success(null, null, returnUrl, announcementDataVO);
  }

  /**
   * ?????? ?????? ??????
   * 
   * @param request
   * @return
   * @throws Exception
   */
  private AnnouncementGroupVO announcementGroupCheck(HttpServletRequest request) throws Exception {
    String groupId = request.getParameter("groupId");
    AnnouncementGroupVO announcementGroupVO = new AnnouncementGroupVO();
    announcementGroupVO.setGroup_id(groupId);
    AnnouncementGroupVO group =
        announcementGroupService.selectAnnouncementGroup(announcementGroupVO);
    if (group == null) {
      throw new CmmnException("??????????????? ????????? ????????????.");
    }
    return group;
  }

  /**
   * ?????? ??????/?????? ??????
   * 
   * @param request
   * @param model
   * @param announcementDataVO
   * @return
   * @throws Exception
   */
  private boolean announcementDataFormProc(HttpServletRequest request, Model model,
      AnnouncementDataVO announcementDataVO) throws Exception {

    // ??????????????? ??????
    AnnouncementGroupVO group = announcementGroupCheck(request);
    announcementDataVO.setGroup_id(group.getGroup_id());

    // ????????????
    model.addAttribute("announcementGroupVO", group);

    // ?????? ??????
    String id = request.getParameter("id");
    boolean isModify = false;
    if (StringUtils.isEmpty(id) == true) {
      // ?????? ??????
    } else {
      // ??????
      isModify = true;
      // ????????? ??????
      announcementDataVO.setData_id(Integer.parseInt(id));
      AnnouncementDataVO resultVO =
          announcementDataService.selectAnnouncementData(announcementDataVO);
      if (resultVO == null) {
        throw new CmmnException("???????????? ????????? ????????????.");
      }
      // System.out.println("vo : " + resultVO);
      model.addAttribute("announcementDataVO", resultVO);

      // ????????????
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st(ATTACH_ANNOUNCEMENT_KEY);
      fVo.setAtckey_2nd(String.valueOf(announcementDataVO.getData_id()));
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);
    }

    model.addAttribute("isModify", isModify);
    return isModify;
  }

  /**
   * ?????? ?????? ??????
   * 
   * @param announcementDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/announcementDataDelete")
  public String announcementDataDelete(
      @ModelAttribute("announcementDataVO") AnnouncementDataVO announcementDataVO,
      HttpServletRequest request, Model model) throws Exception {

    // ??????????????? ??????
    announcementGroupCheck(request);

    // ????????? ??????
    AnnouncementDataVO resultVO = null;
    String id = request.getParameter("id");
    if (StringUtils.isEmpty(id) == false) {
      announcementDataVO.setData_id(Integer.parseInt(id));
      resultVO = announcementDataService.selectAnnouncementData(announcementDataVO);
    }

    // ????????? ??????
    if (resultVO == null) {
      throw new CmmnException("???????????? ????????? ????????????.");
    }

    // ?????? ?????? ??????
    AtchfileVO fVo = new AtchfileVO();
    fVo.setAtckey_1st(ATTACH_ANNOUNCEMENT_KEY);
    fVo.setAtckey_2nd(String.valueOf(announcementDataVO.getData_id()));
    fVo.setAtckey_3rd(1);

    // ?????? ???????????? ??? ?????????????????? ?????? ??????
    atchfileService.deleteAtchfiles(fVo);

    // ????????? ??????
    announcementDataService.deleteAnnouncementData(resultVO);

    return CommonUtil.getRedirectUrl("/metsys/announcementDataList.do", "id=&pageIndex=", true);
  }

  /**
   * ????????? ?????? ?????? JSON ?????????
   * 
   * @param announcementGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/announcementGroupListJson", method = RequestMethod.POST)
  @ResponseBody
  public List announcementGroupListJson(
      @ModelAttribute("announcementGroupVO") AnnouncementGroupVO announcementGroupVO,
      HttpServletRequest request, Model model) throws Exception {
    List announcementGroupList = announcementGroupService.selectAnnouncementGroupListAll();
    return announcementGroupList;
  }

}


