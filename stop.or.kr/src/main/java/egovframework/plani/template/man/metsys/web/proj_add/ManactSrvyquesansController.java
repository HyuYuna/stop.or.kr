package egovframework.plani.template.man.metsys.web.proj_add;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.menuctgry.service.SyscodeService;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;
import egovframework.plani.template.survey.service.SrvypartService;
import egovframework.plani.template.survey.service.SrvyquesansService;
import egovframework.plani.template.survey.vo.SrvypartVO;
import egovframework.plani.template.survey.vo.SrvyquesansVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 설문질문 액션 컨트롤러
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.web.proj_add]
 *        [ManactSrvyquesansController.java]
 *
 */
@Controller
@RequestMapping("/manact/surveySrvyquesans")
public class ManactSrvyquesansController {

  /** SrvyquesansService */
  @Resource(name = "srvyquesansService")
  private SrvyquesansService srvyquesansService;

  /** SrvypartService */
  @Resource(name = "srvypartService")
  private SrvypartService srvypartService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** SyscodeService */
  @Resource(name = "syscodeService")
  protected SyscodeService syscodeService;

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  protected AtchfileService atchfileService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /**
   * 설문 질문 목록을 조회한다.
   * 
   * @param srvyquesansVO : 조회할 정보
   * @exception Exception
   */
  @RequestMapping("/srvyquesList")
  public String srvyquesList(@ModelAttribute("srvyquesansVO") SrvyquesansVO srvyquesansVO,
      HttpServletRequest request, Model model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    List srvyquesList = srvyquesansService.selectSrvyquesList(srvyquesansVO);
    model.addAttribute("resultList", srvyquesList);

    SrvypartVO partVO = new SrvypartVO();
    partVO.setSrvy_idx(srvyquesansVO.getSrvy_idx());
    partVO.setPart_idx(srvyquesansVO.getPart_idx());
    partVO = srvypartService.selectSrvypart(partVO);
    model.addAttribute("partVO", partVO);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYQUESANS_MAN", "설문 질문 / 답변관리", "설문 질문 / 답변 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/manact/surveySrvyquesans/srvyquesansList";

  }

  /**
   * 설문 질문 / 답변 목록을 조회한다.
   * 
   * @param srvyquesansVO : 조회할 정보
   * @param request
   * @param model
   * @return String : tiles
   * @exception Exception
   */
  @RequestMapping("/srvyquesansList")
  public String srvyquesansList(@ModelAttribute("srvyquesansVO") SrvyquesansVO srvyquesansVO,
      HttpServletRequest request, Model model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    List srvyquesansList = srvyquesansService.selectSrvyquesansList(srvyquesansVO);
    model.addAttribute("resultList", srvyquesansList);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYQUESANS_MAN", "설문 질문 / 답변관리", "설문 질문 / 답변 목록조회", "L");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/manact/surveySrvyquesans/srvyquesansList";

  }

  /**
   * 설문 질문 / 답변 항목 상세조회 페이지 이동.
   * 
   * @param srvyquesansVO : 조회할 정보
   * @param request
   * @param model
   * @return String : tiles
   * @exception Exception
   */
  @RequestMapping("/srvyquesansView")
  public String srvyquesansView(@ModelAttribute("srvyquesansVO") SrvyquesansVO srvyquesansVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    if ("M".equals(srvyquesansVO.getEdomweivgp())) {

      // 질문/답변 목록 조회
      List quesansList = srvyquesansService.selectSrvyquesansList(srvyquesansVO);
      model.addAttribute("quesansList", quesansList);


      // 첨부파일 목록 가져오기
      AtchfileVO fileVO = new AtchfileVO();
      fileVO.setAtckey_1st("SRVY_QUESANS");
      fileVO.setAtckey_2nd(new Integer(srvyquesansVO.getSrvy_idx()).toString());
      fileVO.setAtckey_3rd(srvyquesansVO.getQues_idx());
      List fileList = atchfileService.selectAtchfileList(fileVO);

      model.addAttribute("atchfileList", fileList);
      model.addAttribute("atchfileListCount", fileList == null ? 0 : fileList.size());

    }


    // 질문타입 코드 조회
    SyscodeVO codeVO = new SyscodeVO();
    codeVO.setUp_code_idx("CDIDX00081");

    List questypecode = syscodeService.selectSyscodeList(codeVO);
    model.addAttribute("questypecode", questypecode);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYQUESANS_MAN", "설문 질문 / 답변관리",
        "설문 질문 / 답변 상세조회 " + "[" + srvyquesansVO.getQuesans_cont() + "]", "R");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "/manact/surveySrvyquesans/srvyquesansWrite";
  }



  /**
   * 설문 질문 / 답변 항목을 추가한다.
   * 
   * @param srvyquesansVO : 추가할 정보
   * @param request
   * @param model
   * @return String : redirect[srch_menu_nix='메뉴 코드명',pageIndex='현재
   *         페이지',srvy_idx='설문번호',part_idx='파트번호',srvy_act_yn='설문활성화여부']
   * @exception Exception
   */
  @RequestMapping("/addSrvyquesans")
  public String addSrvyquesans(@ModelAttribute("srvyquesansVO") SrvyquesansVO srvyquesansVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    MemberVO user = (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    srvyquesansVO.setWriter(user.getUser_id());
    srvyquesansService.mergeSrvyquesans(request, srvyquesansVO);


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYQUESANS_MAN", "설문 질문 / 답변관리",
        "설문 질문 / 답변 추가 " + "[" + srvyquesansVO.getQuesans_cont() + "]", "C");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    return "redirect:/manact/surveySrvyquesans/srvyquesList.do?srch_menu_nix="
        + srvyquesansVO.getSrch_menu_nix() + "&pageIndex=" + srvyquesansVO.getPageIndex()
        + "&srvy_idx=" + srvyquesansVO.getSrvy_idx() + "&part_idx=" + srvyquesansVO.getPart_idx()
        + "&srvy_act_yn=" + srvyquesansVO.getSrvy_act_yn();
  }

  /**
   * 설문 질문 / 답변 항목을 삭제한다.
   * 
   * @param srvyquesansVO : 삭제할 정보
   * @param request
   * @param model
   * @return String : redirect[srch_menu_nix='메뉴 코드명',pageIndex='현재
   *         페이지',srvy_idx='설문번호',part_idx='파트번호',srvy_act_yn='설문활성화여부']
   * @exception Exception
   */
  @RequestMapping("/rmvSrvyquesans")
  public String rmvSrvyquesans(@ModelAttribute("srvyquesansVO") SrvyquesansVO srvyquesansVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);


    SrvyquesansVO resultVO = srvyquesansService.selectSrvyquesans(srvyquesansVO);
    if (resultVO != null) {
      if ("Q".equals(resultVO.getQuesans_type()))
        srvyquesansService.deleteSrvyquesansGroup(srvyquesansVO);
      else {
        srvyquesansVO.setAns_ord(resultVO.getAns_ord());
        srvyquesansService.deleteSrvyquesans(srvyquesansVO);
      }

      // ////////////////////////////////////////////////////////////////////////////////////////////
      //
      // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
      manlogService.insertManlog(request, "SRVYQUESANS_MAN", "설문 질문 / 답변관리",
          "설문 질문 / 답변 삭제 " + "[" + resultVO.getQuesans_cont() + "]", "D");
      //
      // ////////////////////////////////////////////////////////////////////////////////////////////
    }



    return "redirect:/manact/surveySrvyquesans/srvyquesList.do?srch_menu_nix="
        + srvyquesansVO.getSrch_menu_nix() + "&pageIndex=" + srvyquesansVO.getPageIndex()
        + "&srvy_idx=" + srvyquesansVO.getSrvy_idx() + "&part_idx=" + srvyquesansVO.getPart_idx()
        + "&srvy_act_yn=" + srvyquesansVO.getSrvy_act_yn();


  }

  /**
   * 설문 질문 / 답변 항목을 수정한다.
   * 
   * @param srvyquesansVO : 수정할 정보
   * @exception Exception
   */
  @RequestMapping("/mdfSrvyquesans")
  public String mdfSrvyquesans(@ModelAttribute("srvyquesansVO") SrvyquesansVO srvyquesansVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    srvyquesansVO.setModifier(tmpmemVO.getUser_id());
    srvyquesansService.mergeSrvyquesans(request, srvyquesansVO);

    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYQUESANS_MAN", "설문 질문 / 답변관리",
        "설문 질문 / 답변 수정 " + "[" + srvyquesansVO.getQuesans_cont() + "]", "U");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////


    // 아래 리다이렉트 파라미터에 키값이 더 추가되어야 함.
    return "redirect:/manact/surveySrvyquesans/srvyquesansView.do?srch_menu_nix="
        + srvyquesansVO.getSrch_menu_nix() + "&edomweivgp=M&pageIndex="
        + srvyquesansVO.getPageIndex() + "&srvy_idx=" + srvyquesansVO.getSrvy_idx() + "&part_idx="
        + srvyquesansVO.getPart_idx() + "&ques_idx=" + srvyquesansVO.getQues_idx() + "&srvy_act_yn="
        + srvyquesansVO.getSrvy_act_yn();

  }

  /**
   * 설문 질문 / 답변 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param srvyquesansVO : 엑셀 다운 받을 정보
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsSrvyquesansSave")
  public void xlsSrvyquesansSave(@ModelAttribute("srvyquesansVO") SrvyquesansVO srvyquesansVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    MemberVO tmpmemVO =
        (MemberVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_INFO");
    if (tmpmemVO.getUser_auth_lv() > 100)
      throw new CmmnException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList colinfoList = new ArrayList();

    String[][] col_name = {{"RN", "순번"}, {"QUES_IDX", "질문 번호"},
        {"QUESANS_IDX", "질문내 질문 답변 번호 (설문결과 저장시에는 이값을 참조하지 않는다.. 답변값이 중간에 삭제될 수 있기 때문)"},
        {"SRVY_IDX", "설문조사 번호"}, {"PART_IDX", "파트 번호"}, {"QUESANS_TYPE", "질문 / 답변 구분"},
        {"QUESANS_CONT", "질문 / 답변 내용"}, {"QUES_TYPE", "질문 타입"},
        {"ANS_NEED_SPL", "보충답변 (Ex: 기타) 필요여부"},
        {"ANS_ORD", "답변 번호 (중요! - 답변의 순서는 이 값에 의해 정해지며, 설문 결과 저장시 이 값을 참조한다..)"}, {"WRITER", "작성자"},
        {"WDT", "작성일"}, {"MODIFIER", "수정자"}, {"MDT", "수정일"}

    };

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List srvyquesansOrgList = srvyquesansService.xlsSrvyquesansList(srvyquesansVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List srvyquesansXlsList = new ArrayList();
    for (int i = 0; i < srvyquesansOrgList.size(); i++) {
      SrvyquesansVO vo = (SrvyquesansVO) srvyquesansOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("QUES_IDX", vo.getQues_idx());
      rsmap.put("QUESANS_IDX", vo.getQuesans_idx());
      rsmap.put("SRVY_IDX", vo.getSrvy_idx());
      rsmap.put("PART_IDX", vo.getPart_idx());
      rsmap.put("QUESANS_TYPE", vo.getQuesans_type());
      rsmap.put("QUESANS_CONT", vo.getQuesans_cont());
      rsmap.put("QUES_TYPE", vo.getQues_type());
      rsmap.put("ANS_NEED_SPL", vo.getAns_need_spl());
      rsmap.put("ANS_ORD", vo.getAns_ord());
      rsmap.put("WRITER", vo.getWriter());
      rsmap.put("WDT", vo.getWdt());
      rsmap.put("MODIFIER", vo.getModifier());
      rsmap.put("MDT", vo.getMdt());


      srvyquesansXlsList.add(rsmap);
    }


    // ////////////////////////////////////////////////////////////////////////////////////////////
    //
    // 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
    manlogService.insertManlog(request, "SRVYQUESANS_MAN", "설문 질문 / 답변관리", "설문 질문 / 답변 엑셀저장", "X");
    //
    // ////////////////////////////////////////////////////////////////////////////////////////////

    String fileName = "설문 질문 / 답변";
    xlsDownUtil.ExcelWrite(response, srvyquesansXlsList, colinfoList, fileName);
  }


}
