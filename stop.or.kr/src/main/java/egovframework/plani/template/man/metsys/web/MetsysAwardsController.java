package egovframework.plani.template.man.metsys.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import egovframework.plani.custom.form.validator.groups.ValidationAdminCreate;
import egovframework.plani.custom.form.validator.groups.ValidationAdminModify;
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
import egovframework.plani.template.man.metsys.service.AwardsDataService;
import egovframework.plani.template.man.metsys.service.AwardsGroupService;
import egovframework.plani.template.man.metsys.vo.AwardsDataVO;
import egovframework.plani.template.man.metsys.vo.AwardsGroupVO;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/metsys")
public class MetsysAwardsController {

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** SyscodeService */
  @Resource(name = "syscodeService")
  private SyscodeService syscodeService;

  /** ????????? ?????? Service */
  @Resource(name = "awardsGroupService")
  private AwardsGroupService awardsGroupService;

  /** ????????? Service */
  @Resource(name = "awardsDataService")
  private AwardsDataService awardsDataService;

  @Resource
  private CrudTemplate crudTemplate;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** ????????? ??? */
  public final static String ATTACH_AWARDS_KEY = "AWARDS";
  /** ????????? ??? */
  public final static String ATTACH_AWARDS_THUMBNAIL_KEY = "AWARDS_THUMBNAIL";


  /**
   * ????????? ?????? ??????
   * 
   * @param awardsGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/awardsGroupList", method = RequestMethod.GET)
  public String awardsSetupList(@ModelAttribute("awardsGroupVO") final AwardsGroupVO awardsGroupVO,
      HttpServletRequest request, Model model) throws Exception {

    awardsGroupVO.setPageUnit(20);

    // ????????? ?????? ??????
    crudTemplate.pagingList(request, model, awardsGroupVO, new CrudStrategy<AwardsGroupVO>() {
      @Override
      public int totalCount() throws Exception {
        return awardsGroupService.selectAwardsGroupListTotalCount(awardsGroupVO);
      }

      @Override
      public List<AwardsGroupVO> pagingList() throws Exception {
        return awardsGroupService.selectAwardsGroupList(awardsGroupVO);
      }
    });

    return "/metsys/awardsGroupList";
  }

  /**
   * ????????? ?????? ??????/?????? ???
   * 
   * @param awardsGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/awardsGroupForm")
  public String awardsGroupForm(@ModelAttribute("awardsGroupVO") AwardsGroupVO awardsGroupVO,
      HttpServletRequest request, Model model) throws Exception {
    awardsGroupFormProc(request, model, awardsGroupVO);
    return "/metsys/awardsGroupForm";
  }

  /**
   * ????????? ?????? ??????
   * 
   * @param awardsGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/awardsGroupForm", method = RequestMethod.POST)
  @ResponseBody
  public Object awardsGroupForm(@Valid AwardsGroupVO awardsGroupVO, BindingResult result,
      HttpServletRequest request, Model model) throws Exception {

    boolean isModify = awardsGroupFormProc(request, model, awardsGroupVO);

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/awardsGroupForm");
    // ????????? ??????
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }
    // ?????? ????????? ??????
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // ?????????
    awardsGroupVO.setModifier(sessionUserData.getUser_id());

    if (isModify == true) {
      awardsGroupService.updateAwardsGroup(awardsGroupVO);
    } else {
      // ?????????
      awardsGroupVO.setWriter(sessionUserData.getUser_id());
      awardsGroupService.insertAwardsGroup(awardsGroupVO);
    }

    // ??????
    return responseResultHelper.success(null, null,
        CommonUtil.getUrl("/metsys/awardsGroupList.do", "id=", true), null);
  }

  /**
   * ????????? ?????? ??????/?????? ??????
   * 
   * @param request
   * @param model
   * @param awardsGroupVO
   * @return
   * @throws Exception
   */
  private boolean awardsGroupFormProc(HttpServletRequest request, Model model,
      AwardsGroupVO awardsGroupVO) throws Exception {
    String id = request.getParameter("id");
    boolean isModify = false;
    if (StringUtils.isEmpty(id) == true) {
      // ?????? ??????
    } else {
      // ??????
      isModify = true;
      // ????????? ??????
      awardsGroupVO.setGroup_id(id);
      AwardsGroupVO resultVO = awardsGroupService.selectAwardsGroup(awardsGroupVO);
      if (resultVO == null) {
        throw new CmmnException(
            MessageHelper.getMessage("THE-CONTENT-YOU-REQUESTED-DOES-NOT-EXIST"));
      }
      model.addAttribute("awardsGroupVO", resultVO);
    }
    model.addAttribute("isModify", isModify);
    return isModify;
  }

  /**
   * ????????? ?????? ??????
   * 
   * @param awardsGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/awardsGroupDelete")
  public String awardsGroupDelete(@ModelAttribute("awardsGroupVO") AwardsGroupVO awardsGroupVO,
      HttpServletRequest request, Model model) throws Exception {
    String id = request.getParameter("id");
    AwardsGroupVO resultVO = null;
    if (StringUtils.isEmpty(id) == false) {
      // ????????? ??????
      awardsGroupVO.setGroup_id(id);
      resultVO = awardsGroupService.selectAwardsGroup(awardsGroupVO);
    }
    // ????????? ??????
    if (resultVO == null) {
      throw new CmmnException("??????????????? ????????? ????????? ????????????.");
    }

    // System.out.println("awardsGroupVO : " + resultVO);

    // ????????? ?????? ?????????
    List<AwardsDataVO> dataRow = awardsDataService.selectAwardsDataAllList(awardsGroupVO);

    // ????????? ????????? ???????????? ??????
    for (int i = 0; i < dataRow.size(); i++) {
      AwardsDataVO data = dataRow.get(i);

      // ?????? ??????
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st(ATTACH_AWARDS_KEY);
      fVo.setAtckey_2nd(String.valueOf(data.getData_id()));
      fVo.setAtckey_3rd(1);

      // ?????? ???????????? ??? ?????????????????? ?????? ??????
      atchfileService.deleteAtchfiles(fVo);
    }

    // ????????? ?????? ????????? ??????
    awardsDataService.deleteAwardsDataAll(resultVO);

    // ???????????? ??????
    awardsGroupService.deleteAwardsGroup(resultVO);
    return CommonUtil.getRedirectUrl("/metsys/awardsGroupList.do", "id=", true);
  }

  /**
   * ????????? ?????????
   * 
   * @param awardsDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/awardsDataList")
  public String awardsDataList(@ModelAttribute("awardsDataVO") final AwardsDataVO awardsDataVO,
      HttpServletRequest request, Model model) throws Exception {
    // ????????????
    final AwardsGroupVO group = awardsGroupCheck(request);
    model.addAttribute("awardsGroupVO", group);
    awardsDataVO.setGroup_id(group.getGroup_id());

    // ???????????????
    List awardsDataNoticeList = awardsDataService.selectAwardsDataNoticeList(awardsDataVO);
    model.addAttribute("awardsDataNoticeList", awardsDataNoticeList);

    awardsDataVO.setPageUnit(20);


    // ????????? ?????? ??????
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

    return "/metsys/awardsDataList";
  }

  /**
   * ????????? ??????/?????? ???
   * 
   * @param awardsDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/awardsDataForm", method = RequestMethod.GET)
  public String awardsDataForm(@ModelAttribute("awardsDataVO") AwardsDataVO awardsDataVO,
      HttpServletRequest request, Model model) throws Exception {

    awardsDataFormProc(request, model, awardsDataVO);

    Map<String, String> awardsSelectList = awardsDataService.getAwardsSelectList();
    model.addAttribute("awardsSelectList", awardsSelectList);

    return "/metsys/awardsDataForm";
  }

  /**
   * ????????? ??????
   * 
   * @param awardsDataVO
   * @param result
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/awardsDataForm", method = RequestMethod.POST)
  @ResponseBody
  public Object awardsDataForm(@Validated(ValidationAdminCreate.class) AwardsDataVO awardsDataVO,
      BindingResult result, HttpServletRequest request, Model model) throws Exception {
    return save(awardsDataVO, result, request, model);
  }

  /**
   * ????????? ??????
   * 
   * @param awardsDataVO
   * @param result
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/awardsDataModify", method = RequestMethod.POST)
  @ResponseBody
  public Object awardsDataModify(@Validated(ValidationAdminModify.class) AwardsDataVO awardsDataVO,
      BindingResult result, HttpServletRequest request, Model model) throws Exception {
    return save(awardsDataVO, result, request, model);
  }


  private Object save(AwardsDataVO awardsDataVO, BindingResult result, HttpServletRequest request,
      Model model) throws Exception {
    boolean isModify = awardsDataFormProc(request, model, awardsDataVO);

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/awardsDataForm");

    // ????????? ??????
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    // ?????? ????????? ??????
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // ?????????
    awardsDataVO.setModifier(sessionUserData.getUser_id());

    // ?????? ??????, ????????? ??????
    if (StringUtils.isEmpty(awardsDataVO.getDate_start()) == true
        || StringUtils.isEmpty(awardsDataVO.getDate_end()) == true) {
      awardsDataVO.setDate_start(null);
      awardsDataVO.setDate_end(null);
    }

    String message;
    String returnUrl;

    if (isModify == true) {
      // ????????? ??????
      awardsDataService.updateAwardsData(awardsDataVO);
      message = "?????????????????????.";
      returnUrl = CommonUtil.getUrl("/metsys/awardsDataForm.do", "", true);

    } else {
      // ????????? ??????
      // ?????????
      awardsDataVO.setWriter(sessionUserData.getUser_id());
      awardsDataService.insertAwardsData(awardsDataVO);
      message = "?????????????????????.";
      returnUrl = CommonUtil.getUrl("/metsys/awardsDataList.do", "id=", true);
    }

    // ???????????? ??????
    atchfileService.uploadProcFormfiles(request, ATTACH_AWARDS_THUMBNAIL_KEY,
        String.valueOf(awardsDataVO.getData_id()), 1, "IMG", "thumbnail");


    // ??????
    return responseResultHelper.success(null, null, returnUrl, awardsDataVO);
  }

  /**
   * ????????? ?????? ??????
   * 
   * @param request
   * @return
   * @throws Exception
   */
  private AwardsGroupVO awardsGroupCheck(HttpServletRequest request) throws Exception {
    String groupId = request.getParameter("groupId");
    AwardsGroupVO awardsGroupVO = new AwardsGroupVO();
    awardsGroupVO.setGroup_id(groupId);
    AwardsGroupVO group = awardsGroupService.selectAwardsGroup(awardsGroupVO);
    if (group == null) {
      throw new CmmnException("??????????????? ????????? ????????????.");
    }
    return group;
  }

  /**
   * ????????? ??????/?????? ??????
   * 
   * @param request
   * @param model
   * @param awardsDataVO
   * @return
   * @throws Exception
   */
  private boolean awardsDataFormProc(HttpServletRequest request, Model model,
      AwardsDataVO awardsDataVO) throws Exception {

    // ??????????????? ??????
    AwardsGroupVO group = awardsGroupCheck(request);
    awardsDataVO.setGroup_id(group.getGroup_id());

    // ????????????
    model.addAttribute("awardsGroupVO", group);

    // ????????? ??????
    String id = request.getParameter("id");
    boolean isModify = false;
    if (StringUtils.isEmpty(id) == true) {
      // ?????? ??????
    } else {
      // ??????
      isModify = true;
      // ????????? ??????
      awardsDataVO.setData_id(Integer.parseInt(id));
      AwardsDataVO resultVO = awardsDataService.selectAwardsData(awardsDataVO);
      if (resultVO == null) {
        throw new CmmnException("???????????? ????????? ????????????.");
      }
      // System.out.println("vo : " + resultVO);
      model.addAttribute("awardsDataVO", resultVO);

      // ????????? ?????????
      AtchfileVO thumbNailVO = new AtchfileVO();
      thumbNailVO.setAtckey_1st(ATTACH_AWARDS_THUMBNAIL_KEY);
      thumbNailVO.setAtckey_2nd(String.valueOf(awardsDataVO.getData_id()));
      thumbNailVO.setAtckey_3rd(1);
      List thumbNailList = atchfileService.selectAtchfileList(thumbNailVO);
      model.addAttribute("thumbNailList", thumbNailList);

      // ????????????
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st(ATTACH_AWARDS_KEY);
      fVo.setAtckey_2nd(String.valueOf(awardsDataVO.getData_id()));
      fVo.setAtckey_3rd(1);

      List fileList = atchfileService.selectAtchfileList(fVo);
      model.addAttribute("atchfileList", fileList);
    }

    model.addAttribute("isModify", isModify);
    return isModify;
  }

  /**
   * ????????? ?????? ??????
   * 
   * @param awardsDataVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/awardsDataDelete")
  public String awardsDataDelete(@ModelAttribute("awardsDataVO") AwardsDataVO awardsDataVO,
      HttpServletRequest request, Model model) throws Exception {

    // ??????????????? ??????
    awardsGroupCheck(request);

    // ????????? ??????
    AwardsDataVO resultVO = null;
    String id = request.getParameter("id");
    if (StringUtils.isEmpty(id) == false) {
      awardsDataVO.setData_id(Integer.parseInt(id));
      resultVO = awardsDataService.selectAwardsData(awardsDataVO);
    }

    // ????????? ??????
    if (resultVO == null) {
      throw new CmmnException("???????????? ????????? ????????????.");
    }

    // ????????? ????????? ??????
    AtchfileVO thumbnailVo = new AtchfileVO();
    thumbnailVo.setAtckey_1st(ATTACH_AWARDS_THUMBNAIL_KEY);
    thumbnailVo.setAtckey_2nd(String.valueOf(awardsDataVO.getData_id()));
    thumbnailVo.setAtckey_3rd(1);

    // ?????? ???????????? ??? ?????????????????? ?????? ??????
    atchfileService.deleteAtchfiles(thumbnailVo);

    // ?????? ?????? ??????
    AtchfileVO fVo = new AtchfileVO();
    fVo.setAtckey_1st(ATTACH_AWARDS_KEY);
    fVo.setAtckey_2nd(String.valueOf(awardsDataVO.getData_id()));
    fVo.setAtckey_3rd(1);

    // ?????? ???????????? ??? ?????????????????? ?????? ??????
    atchfileService.deleteAtchfiles(fVo);

    // ????????? ??????
    awardsDataService.deleteAwardsData(resultVO);

    return CommonUtil.getRedirectUrl("/metsys/awardsDataList.do", "id=&pageIndex=", true);
  }

  /**
   * ????????? ?????? ?????? JSON ?????????
   * 
   * @param awardsGroupVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/awardsGroupListJson", method = RequestMethod.POST)
  @ResponseBody
  public List awardsGroupListJson(@ModelAttribute("awardsGroupVO") AwardsGroupVO awardsGroupVO,
      HttpServletRequest request, Model model) throws Exception {
    List awardsGroupList = awardsGroupService.selectAwardsGroupListAll();
    return awardsGroupList;
  }

}


