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

  /** 업로드 키 */
  public final static String ATTACH_ANNOUNCEMENT_KEY = "ANNOUNCEMENT";

  /**
   * 공고 그룹 목록
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

    // 페이징 목록 처리
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

    // 사이트구분 코드 조회
    SyscodeVO codeVO = new SyscodeVO();
    codeVO.setUse_yn("Y");
    codeVO.setUp_code_idx("CDIDX00001");
    List sitecode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("sitecode", sitecode);

    // 언어구분 코드 조회
    codeVO.setUp_code_idx("CDIDX00021");
    List langcode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("langcode", langcode);

    return "/metsys/announcementGroupList";
  }

  /**
   * 공고 그룹 등록/수정 폼
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
   * 공고 그룹 수정
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
    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }
    // 세션 사용자 정보
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // 수정자
    announcementGroupVO.setModifier(sessionUserData.getUser_id());

    if (isModify == true) {
      announcementGroupService.updateAnnouncementGroup(announcementGroupVO);
    } else {
      // 등록자
      announcementGroupVO.setWriter(sessionUserData.getUser_id());
      announcementGroupService.insertAnnouncementGroup(announcementGroupVO);
    }

    // 완료
    return responseResultHelper.success(null, null,
        CommonUtil.getUrl("/metsys/announcementGroupList.do", "id=", true), null);
  }

  /**
   * 공고 그룹 등록/수정 처리
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
      // 신규 등록
    } else {
      // 수정
      isModify = true;
      // 데이터 검색
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
   * 공고 그룹 삭제
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
      // 데이터 검색
      announcementGroupVO.setGroup_id(id);
      resultVO = announcementGroupService.selectAnnouncementGroup(announcementGroupVO);
    }
    // 데이터 체크
    if (resultVO == null) {
      throw new CmmnException("공고그룹 정보를 찾을수 없습니다.");
    }

    // System.out.println("announcementGroupVO : " + resultVO);

    // 공고 그룹 데이터
    List<AnnouncementDataVO> dataRow =
        announcementDataService.selectAnnouncementDataAllList(announcementGroupVO);

    // 공고 데이터 첨부파일 검색
    for (int i = 0; i < dataRow.size(); i++) {
      AnnouncementDataVO data = dataRow.get(i);

      // 첨부 파일
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st(ATTACH_ANNOUNCEMENT_KEY);
      fVo.setAtckey_2nd(String.valueOf(data.getData_id()));
      fVo.setAtckey_3rd(1);

      // 실제 첨부파일 및 데이터베이스 정보 삭제
      atchfileService.deleteAtchfiles(fVo);
    }

    // 공고 그룹 데이터 삭제
    announcementDataService.deleteAnnouncementDataAll(resultVO);

    // 그룹정보 삭제
    announcementGroupService.deleteAnnouncementGroup(resultVO);
    return CommonUtil.getRedirectUrl("/metsys/announcementGroupList.do", "id=", true);
  }

  /**
   * 공고 리스트
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
    // 그룹정보
    final AnnouncementGroupVO group = announcementGroupCheck(request);
    model.addAttribute("announcementGroupVO", group);
    announcementDataVO.setGroup_id(group.getGroup_id());

    // 공지리스트
    List announcementDataNoticeList =
        announcementDataService.selectAnnouncementDataNoticeList(announcementDataVO);
    model.addAttribute("announcementDataNoticeList", announcementDataNoticeList);

    announcementDataVO.setPageUnit(5);

    System.out.println(announcementDataVO);

    // 페이징 목록 처리
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
   * 공고 등록/수정 폼
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
   * 공고 등록/수정
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

    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    // 세션 사용자 정보
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // 수정자
    announcementDataVO.setModifier(sessionUserData.getUser_id());

    // 게시 시작, 종료일 체크
    if (StringUtils.isEmpty(announcementDataVO.getDate_start()) == true
        || StringUtils.isEmpty(announcementDataVO.getDate_end()) == true) {
      announcementDataVO.setDate_start(null);
      announcementDataVO.setDate_end(null);
    }

    String message;
    String returnUrl;

    if (isModify == true) {
      // 공고 수정
      announcementDataService.updateAnnouncementData(announcementDataVO);
      message = "수정되었습니다.";
      returnUrl = CommonUtil.getUrl("/metsys/announcementDataForm.do", "", true);

    } else {
      // 공고 등록
      // 등록자
      announcementDataVO.setWriter(sessionUserData.getUser_id());
      announcementDataService.insertAnnouncementData(announcementDataVO);
      message = "등록되었습니다.";
      returnUrl = CommonUtil.getUrl("/metsys/announcementDataList.do", "id=", true);
    }

    // 완료
    return responseResultHelper.success(null, null, returnUrl, announcementDataVO);
  }

  /**
   * 공고 그룹 체크
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
      throw new CmmnException("그룹정보를 찾을수 없습니다.");
    }
    return group;
  }

  /**
   * 공고 등록/수정 처리
   * 
   * @param request
   * @param model
   * @param announcementDataVO
   * @return
   * @throws Exception
   */
  private boolean announcementDataFormProc(HttpServletRequest request, Model model,
      AnnouncementDataVO announcementDataVO) throws Exception {

    // 그룹아이디 체크
    AnnouncementGroupVO group = announcementGroupCheck(request);
    announcementDataVO.setGroup_id(group.getGroup_id());

    // 그룹정보
    model.addAttribute("announcementGroupVO", group);

    // 공고 확인
    String id = request.getParameter("id");
    boolean isModify = false;
    if (StringUtils.isEmpty(id) == true) {
      // 신규 등록
    } else {
      // 수정
      isModify = true;
      // 데이터 검색
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
   * 공고 개별 삭제
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

    // 그룹아이디 체크
    announcementGroupCheck(request);

    // 데이터 검색
    AnnouncementDataVO resultVO = null;
    String id = request.getParameter("id");
    if (StringUtils.isEmpty(id) == false) {
      announcementDataVO.setData_id(Integer.parseInt(id));
      resultVO = announcementDataService.selectAnnouncementData(announcementDataVO);
    }

    // 데이터 체크
    if (resultVO == null) {
      throw new CmmnException("정상적인 접근이 아닙니다.");
    }

    // 첨부 파일 삭제
    AtchfileVO fVo = new AtchfileVO();
    fVo.setAtckey_1st(ATTACH_ANNOUNCEMENT_KEY);
    fVo.setAtckey_2nd(String.valueOf(announcementDataVO.getData_id()));
    fVo.setAtckey_3rd(1);

    // 실제 첨부파일 및 데이터베이스 정보 삭제
    atchfileService.deleteAtchfiles(fVo);

    // 데이터 삭제
    announcementDataService.deleteAnnouncementData(resultVO);

    return CommonUtil.getRedirectUrl("/metsys/announcementDataList.do", "id=&pageIndex=", true);
  }

  /**
   * 관리자 메뉴 연동 JSON 리스트
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


