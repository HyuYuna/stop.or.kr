package egovframework.plani.template.brdartcl.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.template.brdartcl.service.BoarddryService;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.vo.BoarddryVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.exceptions.AjaxException;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.TransLunarSolar;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
@RequestMapping("/brddry")
public class BoarddryController {

  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  private BoardinfoService boardinfoService;

  /** BoarddryService */
  @Resource(name = "boarddryService")
  private BoarddryService boarddryService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;


  /**
   * 일정 게시판 목록을 조회한다.
   * 
   * @param boarddryVO : 조회할 정보
   * @param request
   * @param model
   * @exception Exception
   * @return '/brddry/boarddryList'
   */
  @RequestMapping("/boarddryList")
  public String boarddryList(HttpServletRequest request,
      @ModelAttribute("boarddryVO") BoarddryVO boarddryVO, Model model) throws Exception {

    // boarddryVO.setRsv_gb("CDIDX00122");
    String srch_menu_nix = boarddryVO.getSrch_menu_nix();

    Calendar cal = Calendar.getInstance();
    int YEAR =
        (boarddryVO.getSrchcalYr() == null || "".equals(boarddryVO.getSrchcalYr())) ? cal
            .get(Calendar.YEAR) : Integer.parseInt(boarddryVO.getSrchcalYr()); // 현재 년도
    int MON =
        (boarddryVO.getSrchcalMon() == null || "".equals(boarddryVO.getSrchcalMon())) ? cal
            .get(Calendar.MONTH) + 1 : Integer.parseInt(boarddryVO.getSrchcalMon()); // 현재 월

    model.addAttribute("SYEAR", YEAR);
    model.addAttribute("SMON", MON);


    if (srch_menu_nix.startsWith("794x409U") || srch_menu_nix.startsWith("wZ311Dfx")
        || srch_menu_nix.startsWith("IR3T73EE")) {
      return "/metsys/brddry/boarddryList";
    } else {
      return "/brddry/boarddryList";
    }


  }

  /**
   * 주요일정에 표시하기 위한 정보를 조회
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/loadScheduleJson")
  @ResponseBody
  public Map loadScheduleJson(HttpServletRequest request, Model model) throws Exception {

    Map dtmap = new HashMap();

    Calendar cal = Calendar.getInstance();

    int YEAR =
        (request.getParameter("srchcalYr") == null || "".equals(request.getParameter("srchcalYr"))) ? cal
            .get(Calendar.YEAR) : Integer.parseInt(request.getParameter("srchcalYr")); // 현재 년도
    int MON =
        (request.getParameter("srchcalMon") == null || ""
            .equals(request.getParameter("srchcalMon"))) ? cal.get(Calendar.MONTH) + 1 : Integer
            .parseInt(request.getParameter("srchcalMon")); // 현재 월
    int DAY =
        (request.getParameter("srchcalDay") == null || ""
            .equals(request.getParameter("srchcalDay"))) ? 0 : Integer.parseInt(request
            .getParameter("srchcalDay")); // 현재 월
    int CURDAY = -99; // 현재 날짜


    if (YEAR == cal.get(Calendar.YEAR) && MON == cal.get(Calendar.MONTH) + 1) {
      CURDAY = cal.get(Calendar.DATE); // 현재 날짜
    }

    cal.set(Calendar.YEAR, YEAR); // 입력받은 연도로 셋팅
    cal.set(Calendar.MONTH, MON - 1); // 입력받은 월로 셋팅
    cal.set(Calendar.DAY_OF_MONTH, 1); // 1일로 셋팅한 후
    int DOW = cal.get(Calendar.DAY_OF_WEEK) - 1; // 1일의 요일을 구함 (Zero base)
    int DCNT = cal.getActualMaximum(Calendar.DATE); // 현재월의 날짜 수

    dtmap.put("ST_YEAR", YEAR);
    dtmap.put("ST_MON", MON);
    dtmap.put("ST_CURDAY", CURDAY);
    dtmap.put("ST_DCNT", DCNT);
    dtmap.put("ST_DOW", DOW);


    // 일정 게시판 정보 조회
    BoardinfoVO infoVO = new BoardinfoVO();
    infoVO.setBrd_id("BDIDX_9tAmZ5x0kM2z7FXtr5NRTI");
    infoVO = boardinfoService.selectBoardinfo(infoVO);
    System.out.println("infoVO" + infoVO.getBrd_gb());
    if ("CDIDX00045".equals(infoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    // 일정 게시판 목록 조회
    if (infoVO != null) {
      BoarddryVO dryVO = new BoarddryVO();
      dryVO.setFirstIndex(0);
      dryVO.setRecordCountPerPage(100);
      dryVO.setBrd_id(infoVO.getBrd_id());
      dryVO.setTbl_nm(infoVO.getTbl_nm());

      // TODO : 조건에 기간설정 들어가야 함..
      dryVO.setSrchFromDT(Integer.toString(YEAR) + EgovWebUtil.getZerofillStr(MON, 2) + "01");
      dryVO.setSrchToDT(Integer.toString(YEAR) + EgovWebUtil.getZerofillStr(MON, 2)
          + EgovWebUtil.getZerofillStr(DCNT, 2));

      if (DAY > 0) {
        dryVO.setSrchFromDT(Integer.toString(YEAR) + EgovWebUtil.getZerofillStr(MON, 2)
            + EgovWebUtil.getZerofillStr(DAY, 2));
        dryVO.setSrchToDT(Integer.toString(YEAR) + EgovWebUtil.getZerofillStr(MON, 2)
            + EgovWebUtil.getZerofillStr(DAY, 2));
      }

      List dryList = boarddryService.selectBoarddryList(dryVO);
      dtmap.put("schList", dryList);

    }

    return dtmap;
  }


  /**
   * 일정 게시판 목록을 조회한다.
   * 
   * @param boarddryVO : 조회할 정보
   * @exception Exception
   */
  @RequestMapping("/boarddryJsonList")
  @ResponseBody
  public List boarddryJsonList(HttpServletRequest request,
      @ModelAttribute("boarddryVO") BoarddryVO boarddryVO, Model model) throws Exception {

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);
    }

    if ("D".equals(brdinfoVO.getBrd_gb()) == false)
      throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    boarddryVO.setTbl_nm(brdinfoVO.getTbl_nm());
    List boarddryList = boarddryService.selectBoarddryList(boarddryVO);


    return boarddryList;

  }



  /**
   * 양력 / 음력 일정을 변환하여 반환한다.
   * 
   * @param boarddryVO : 조회할 정보
   * @param request
   * @param model
   * @exception Exception
   */
  @RequestMapping("/holidaySolarJsonList")
  @ResponseBody
  public List holidaySolarJsonList(HttpServletRequest request,
      @ModelAttribute("boarddryVO") BoarddryVO boarddryVO, Model model) throws Exception {

    List<Object> retlist = new ArrayList<Object>();

    TransLunarSolar transLS = new TransLunarSolar();

    Calendar cal = Calendar.getInstance();
    String searchYr = request.getParameter("searchYr");
    searchYr = (searchYr == null || "".equals(searchYr)) ? cal.get(cal.YEAR) + "" : searchYr;

    String selnal = transLS.fromLunar(searchYr + "0101");
    String budda = transLS.fromLunar(searchYr + "0408");
    String chooseok = transLS.fromLunar(searchYr + "0815");

    selnal = selnal.substring(0, 4) + "-" + selnal.substring(4, 6) + "-" + selnal.substring(6, 8);
    budda = budda.substring(0, 4) + "-" + budda.substring(4, 6) + "-" + budda.substring(6, 8);
    chooseok =
        chooseok.substring(0, 4) + "-" + chooseok.substring(4, 6) + "-" + chooseok.substring(6, 8);

    retlist.add(selnal); // 설날
    retlist.add(budda); // 석가탄신일
    retlist.add(chooseok); // 추석

    // System.out.println(selnal);

    return retlist;
  }

  /**
   * 일정 게시판 항목을 상세 조회한다.
   * 
   * @param boarddryVO : 조회할 정보
   * @param request
   * @param model
   * @exception Exception
   * @return '/brddry/boarddryView'
   */
  @RequestMapping("/boarddryView")
  public String boarddryView(@ModelAttribute("boarddryVO") BoarddryVO boarddryVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    String srch_menu_nix = boarddryVO.getSrch_menu_nix();

    BoardinfoVO brdinfoVO =
        (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
    if (brdinfoVO == null) {
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);
    }

    if ("D".equals(brdinfoVO.getBrd_gb()) == false)
      throw new CmmnException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                       * 정상적인 요청이
                                                                                       * 아닙니다.
                                                                                       */);

    if (boarddryVO.getEdomweivgp().equals("A")) {
      if (boarddryVO.getSrch_menu_nix().contains("h92HwHjt")) {
        return "/metsys/boarddryWrite";
      } else {
        return "/brddry/boarddryWrite";
      }
    } else {

      BoarddryVO resultVO = boarddryService.selectBoarddry(boarddryVO);
      resultVO.setTbl_nm(boarddryVO.getTbl_nm());
      resultVO.setEdomweivgp(boarddryVO.getEdomweivgp());
      resultVO.setSrch_menu_nix(boarddryVO.getSrch_menu_nix());
      resultVO.setModeV(boarddryVO.getModeV());
      model.addAttribute("boarddryVO", resultVO);

      if (srch_menu_nix.startsWith("794x409U") || srch_menu_nix.startsWith("wZ311Dfx")
          || srch_menu_nix.startsWith("IR3T73EE")) {
        return "/metsys/brddry/boarddryView";
      } else {
        return "/brddry/boarddryView";
      }
    }


  }


  /**
   * 일정 게시판 항목을 추가한다.
   * 
   * @param boarddryVO : 추가할 정보
   * @param request
   * @param model
   * @exception Exception
   * @return 'SUCCESS'
   */
  @RequestMapping("/addBoarddry")
  @ResponseBody
  public String addBoarddry(@ModelAttribute("boarddryVO") BoarddryVO boarddryVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 1000)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
      if (brdinfoVO == null) {
        throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                         * 정상적인 요청이
                                                                                         * 아닙니다.
                                                                                         */);
      }

      if ("D".equals(brdinfoVO.getBrd_gb()) == false)
        throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                         * 정상적인 요청이
                                                                                         * 아닙니다.
                                                                                         */);

      String writer = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      boarddryVO.setWriter(writer);
      boarddryVO.setAllday_yn("N");
      boarddryVO.setRepeat_yn("N");
      boarddryVO.setHoliday_yn("N");
      int key = boarddryService.insertBoarddry(boarddryVO);

    } catch (Exception e) {

      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return "SUCCESS";
  }

  /**
   * 일정 게시판 항목을 삭제한다.
   * 
   * @param boarddryVO : 삭제할 정보
   * @param request
   * @param model
   * @exception Exception
   * @return 'SUCCESS'
   */
  @RequestMapping("/rmvBoarddry")
  @ResponseBody
  public String rmvBoarddry(@ModelAttribute("boarddryVO") BoarddryVO boarddryVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 1000)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
      if (brdinfoVO == null) {
        throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                         * 정상적인 요청이
                                                                                         * 아닙니다.
                                                                                         */);
      }

      if ("D".equals(brdinfoVO.getBrd_gb()) == false)
        throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                         * 정상적인 요청이
                                                                                         * 아닙니다.
                                                                                         */);


      // ////////////////////////////////////////////////////////////////
      // 삭제 권한 체크 Start

      BoarddryVO compVO = boarddryService.selectBoarddry(boarddryVO);

      if (compVO == null)
        throw new AjaxException(MessageHelper.getMessage("CAN-NOT-FIND-DATA-TO-DELETE")/*
                                                                                        * 삭제할 데이터를
                                                                                        * 찾을 수 없습니다.
                                                                                        */);

      // 관리자가 아니고, 해당글을 작성한 사람이 아닌 경우 글을 삭제할 수 없다.
      if (userlv > 1000
          && !compVO.getWriter().equals(
              EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID")))
        throw new AjaxException(
            MessageHelper.getMessage("YOU-DO-NOT-HAVE-PERMISSION-TO-DELETE-THE-POST")/*
                                                                                      * 게시글을 삭제할 권한이
                                                                                      * 없습니다.
                                                                                      */);

      // 삭제 권한 체크 End
      // ////////////////////////////////////////////////////////////////


      boarddryService.deleteBoarddry(boarddryVO);
      // model.addAttribute("resultVO", boarddryVO);
    } catch (Exception e) {

      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return "SUCCESS";
  }

  /**
   * 일정 게시판 항목을 수정한다.
   * 
   * @param boarddryVO : 수정할 정보
   * @param request
   * @param model
   * @exception Exception
   * @return 'SUCCESS'
   */
  @RequestMapping("/mdfBoarddry")
  @ResponseBody
  public String mdfBoarddry(@ModelAttribute("boarddryVO") BoarddryVO boarddryVO,
      HttpServletRequest request, ModelMap model) throws Exception {

    try {

      int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
      if (userlv > 1000)
        throw new AjaxException(MessageHelper.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

      BoardinfoVO brdinfoVO =
          (BoardinfoVO) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_BRD_INFO");
      if (brdinfoVO == null) {
        throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                         * 정상적인 요청이
                                                                                         * 아닙니다.
                                                                                         */);
      }

      if ("D".equals(brdinfoVO.getBrd_gb()) == false)
        throw new AjaxException(MessageHelper.getMessage("THIS-IS-NOT-A-NORMAL-REQUEST")/*
                                                                                         * 정상적인 요청이
                                                                                         * 아닙니다.
                                                                                         */);

      String modifier = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID");
      boarddryVO.setModifier(modifier);
      boarddryVO.setAllday_yn("N");
      boarddryVO.setRepeat_yn("N");
      boarddryVO.setHoliday_yn("N");
      boarddryService.updateBoarddry(boarddryVO);
      // model.addAttribute("resultVO", boarddryVO);
    } catch (Exception e) {

      e.printStackTrace();
      if (e instanceof AjaxException)
        throw e;
      else
        throw new AjaxException(e.getClass().getName(), null, e);
    }

    return "SUCCESS";
  }

  /**
   * 일정 게시판 목록의 엑셀 다운로드 요청을 처리한다.
   * 
   * @param boarddryVO : 수정할 정보
   * @param request
   * @param response
   * @exception Exception
   */
  @RequestMapping("/xlsBoarddrySave")
  public void xlsBoarddrySave(@ModelAttribute("boarddryVO") BoarddryVO boarddryVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList<Object> colinfoList = new ArrayList<Object>();

    String[][] col_name =
        { {"RN", "순번"}, {"BRD_ID", "게시판 번호"}, {"CONT_IDX", "게시판 순번"}, {"SUBJECT", "제목"},
            {"BRD_CONT", "내용"}, {"WRITER", "작성자"}, {"WDT", "작성일"}, {"MODIFIER", "수정자"},
            {"MDT", "수정일"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap ifmap = new HashMap();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    List boarddryOrgList = boarddryService.xlsBoarddryList(boarddryVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List<Object> boarddryXlsList = new ArrayList<Object>();
    for (int i = 0; i < boarddryOrgList.size(); i++) {
      BoarddryVO vo = (BoarddryVO) boarddryOrgList.get(i);

      HashMap rsmap = new HashMap();
      rsmap.put("RN", vo.getRn());
      rsmap.put("BRD_ID", vo.getBrd_id());
      rsmap.put("CONT_IDX", vo.getCont_idx());
      rsmap.put("SUBJECT", vo.getSubject());
      rsmap.put("BRD_CONT", vo.getBrd_cont());
      rsmap.put("WRITER", vo.getWriter());
      rsmap.put("WDT", vo.getWdt());
      rsmap.put("MODIFIER", vo.getModifier());
      rsmap.put("MDT", vo.getMdt());

      boarddryXlsList.add(rsmap);
    }

    String fileName = "일정 게시판";
    xlsDownUtil.ExcelWrite(response, boarddryXlsList, colinfoList, fileName);
  }


}
