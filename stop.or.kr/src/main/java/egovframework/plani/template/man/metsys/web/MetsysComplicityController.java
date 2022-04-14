package egovframework.plani.template.man.metsys.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.plani.custom.form.validator.groups.ValidationAdminComplicity;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CommonUtil;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.cmm.utils.UserInfoHelper;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.metsys.service.ComplicityService;
import egovframework.plani.template.man.metsys.vo.ComplicityItemVO;
import egovframework.plani.template.man.metsys.vo.ComplicityVO;

@Controller
@RequestMapping("/metsys")
public class MetsysComplicityController {

  @Resource(name = "complicityService")
  private ComplicityService complicityService;

  @Resource
  private CrudTemplate crudTemplate;

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;

  /**
   * 공모전 접수 목록
   * 
   * @param complicityVO
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/complicityList", method = RequestMethod.GET)
  public String complicityList(
      @ModelAttribute("complicityItemVO") final ComplicityItemVO complicityItemVO,
      HttpServletRequest request, Model model) throws Exception {

    Map<String, String> searchCondition = new LinkedHashMap<String, String>();
    searchCondition.put("", "전체");
    searchCondition.put("1", "접수번호");
    searchCondition.put("2", "글쓴이");
    searchCondition.put("3", "이메일");
    searchCondition.put("4", "연락처");
    searchCondition.put("6", "상태");
    searchCondition.put("5", "결과");
    model.addAttribute("searchCondition", searchCondition);

    complicityItemVO.setPageUnit(20);

    // 검색 조건
    final ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setSdate(complicityItemVO.getSdate());
    complicityVO.setEdate(complicityItemVO.getEdate());
    complicityVO.setSearchCondition(complicityItemVO.getSearchCondition());
    complicityVO.setSearchKeyword(complicityItemVO.getSearchKeyword());

    // 페이징 목록 처리
    crudTemplate.pagingList(request, model, complicityItemVO, new CrudStrategy<ComplicityItemVO>() {
      @Override
      public int totalCount() throws Exception {
        return complicityService.selectComplicityItemListAllTotalCount(complicityVO);
      }

      @Override
      public List<ComplicityItemVO> pagingList() throws Exception {
        // 페이징 처리
        complicityVO.setFirstIndex(complicityItemVO.getFirstIndex());
        complicityVO.setRecordCountPerPage(complicityItemVO.getRecordCountPerPage());
        return complicityService.selectComplicityItemListAll(complicityVO);
      }
    });

    manlogService.insertManlog(request, "COMPLICITY", "공모전 접수목록 관리", "공모전 접수목록 조회", "L");
    return "/metsys/complicityList";
  }

  /**
   * 공모전 접수 파일 다운로드
   * 
   * @param complicityItemVO
   * @param request
   * @param response
   * @throws Exception
   */
  @RequestMapping("/complicityFileDownload")
  public void complicityFileDownload(
      @ModelAttribute("complicityItemVO") ComplicityItemVO complicityItemVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    // 검색 조건
    ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setSdate(complicityItemVO.getSdate());
    complicityVO.setEdate(complicityItemVO.getEdate());
    complicityVO.setSearchCondition(complicityItemVO.getSearchCondition());
    complicityVO.setSearchKeyword(complicityItemVO.getSearchKeyword());

    List<ComplicityItemVO> list = complicityService.getXlsList(complicityVO);

    String uploadDirByDate = "/complicity";
    String uploadbase = EgovProperties.GLOBALS_FILEUPLOAD_PATH;
    String uploadDir = uploadbase;
    uploadDir += uploadDirByDate;

    String zipFileName = uploadDir + "/" + System.currentTimeMillis() + ".zip";

    // System.out.println("zipFileName : " + zipFileName);
    ArrayList<String> fileList = new ArrayList<>();

    for (int i = 0; i < list.size(); i++) {
      AtchfileVO info = list.get(i).getAtchfileVO();
      fileList.add(uploadbase + info.getFpath() + "/" + info.getFname());
    }

    // System.out.println("list : " + fileList);

    String[] files = fileList.toArray(new String[fileList.size()]);
    // System.out.println(files);
    // String[] files = new String[3];
    // files[0] = uploadDir + "/20180806_2PV8m93DRK65.jpg";
    // files[1] = uploadDir + "/20180806_98w8871Dt0G8.jpg";
    // files[2] = uploadDir + "/20180806_EHw8001Luk5i.jpg";
    byte[] buf = new byte[4096];
    try {
      ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));
      for (int i = 0; i < files.length; i++) {
        FileInputStream in = new FileInputStream(files[i]);
        Path p = Paths.get(files[i]);
        String fileName = p.getFileName().toString();
        ZipEntry ze = new ZipEntry(fileName);
        out.putNextEntry(ze);
        int len;
        while ((len = in.read(buf)) > 0) {
          out.write(buf, 0, len);
        }
        out.closeEntry();
        in.close();
      }
      out.close();
    } catch (IOException e) {
      e.printStackTrace();
    }

    File zipFile = new File(zipFileName);
    // response.setContentType(getContentType());
    response.setContentLength((int) zipFile.length());

    String userAgent = request.getHeader("User-Agent");
    boolean ie = userAgent.indexOf("MSIE") > -1;
    String fileName = null;

    String orgFileName = "출품작_" + CommonUtil.getDate2String(new Date(), "yyyyMMddHHmm") + ".zip";

    if (ie) {
      fileName = URLEncoder.encode(orgFileName, "utf-8");
    } else {
      fileName = new String(orgFileName.getBytes("utf-8"), "iso-8859-1");
    }

    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
    response.setHeader("Content-Transfer-Encoding", "binary");
    OutputStream out = response.getOutputStream();

    FileInputStream fis2 = null;
    try {
      fis2 = new FileInputStream(zipFile);
      FileCopyUtils.copy(fis2, out);
    } finally {
      if (fis2 != null) {
        try {
          fis2.close();
        } catch (IOException ioe) {
        }
      }
      zipFile.delete();
    }
    out.flush();

  }

  @RequestMapping("/complicityXlsDownload")
  public void complicityXlsDownload(
      @ModelAttribute("complicityItemVO") ComplicityItemVO complicityItemVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList<HashMap<String, String>> colinfoList = new ArrayList<HashMap<String, String>>();

    String[][] col_name =
        { {"DATA_ID", "접수번호"}, {"NAME", "이름"}, {"TEL", "연락처"}, {"EMAIL", "이메일"}, {"AGE", "나이"},
            {"BELONG", "소속"}, {"ITEM_STATE", "접수상태"}, {"ITEM_DIVISION", "개인/팀"},
            {"ITEM_TARGET", "공모대상"}, {"ITEM_EXPLAIN", "작품설명"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap<String, String> ifmap = new HashMap<String, String>();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    // 검색 조건
    ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setSdate(complicityItemVO.getSdate());
    complicityVO.setEdate(complicityItemVO.getEdate());
    complicityVO.setSearchCondition(complicityItemVO.getSearchCondition());
    complicityVO.setSearchKeyword(complicityItemVO.getSearchKeyword());

    List<ComplicityItemVO> list = complicityService.getXlsList(complicityVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List<HashMap<String, String>> xlsList = new ArrayList<HashMap<String, String>>();
    for (int i = 0; i < list.size(); i++) {
      ComplicityItemVO vo = list.get(i);
      HashMap<String, String> rsmap = new HashMap<String, String>();
      rsmap.put("DATA_ID", vo.getData_id());
      rsmap.put("NAME", vo.getComplicityVO().getName());
      rsmap.put("TEL", vo.getComplicityVO().getTel());
      rsmap.put("EMAIL", vo.getComplicityVO().getEmail());
      rsmap.put("AGE", vo.getComplicityVO().getAge());
      rsmap.put("BELONG", vo.getComplicityVO().getBelong());
      rsmap.put("ITEM_STATE", CommonUtil.complicityState(vo.getItem_state()));
      rsmap.put("ITEM_DIVISION", CommonUtil.complicityDivision(vo.getItem_division()));
      rsmap.put("ITEM_TARGET", vo.getItem_target());
      rsmap.put("ITEM_EXPLAIN", vo.getItem_explain());
      xlsList.add(rsmap);
    }

    String fileName = "공모전접수목록";

    xlsDownUtil.ExcelWrite2(request, response, xlsList, colinfoList, fileName);
    
    manlogService.insertManlog(request, "COMPLICITY", "공모전 접수목록 관리", "공모전 접수목록 엑셀저장", "X");
    
  }

  @RequestMapping("/complicitySrvyXlsDownload")
  public void complicitySrvyXlsDownload(
      @ModelAttribute("complicityItemVO") ComplicityItemVO complicityItemVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList<HashMap<String, String>> colinfoList = new ArrayList<HashMap<String, String>>();

    String[][] col_name =
        { {"NAME", "이름"}, {"SEX", "성별"}, {"AGE", "연령대"}, {"CITY", "거주지"}, {"OFFLINE", "오프라인"},
            {"ONLINE", "온라인"}, {"ETC", "기타"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap<String, String> ifmap = new HashMap<String, String>();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    // 검색 조건
    ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setSdate(complicityItemVO.getSdate());
    complicityVO.setEdate(complicityItemVO.getEdate());
    // complicityVO.setSearchCondition(complicityItemVO.getSearchCondition());
    // complicityVO.setSearchKeyword(complicityItemVO.getSearchKeyword());

    List<ComplicityVO> list = complicityService.getSrvyXlsList(complicityVO);

    /************************************************************
     * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은 생략한다....
     ************************************************************/
    List<HashMap<String, String>> xlssrvyList = new ArrayList<HashMap<String, String>>();
    for (int i = 0; i < list.size(); i++) {
      ComplicityVO vo = list.get(i);
      HashMap<String, String> srvyrsmap = new HashMap<String, String>();
      vo.setSurvey_from(vo.getSurvey_from_string().split("\\|"));
      srvyrsmap.put("NAME", vo.getName());
      srvyrsmap.put("SEX", (vo.getSurvey_gender().equals("M")) ? "남" : "여");
      srvyrsmap.put("AGE", vo.getSurvey_age() + " 대");
      srvyrsmap.put("CITY", vo.getSurvey_city());
      srvyrsmap.put("OFFLINE", CommonUtil.complicityFromString(vo.getSurvey_from(), "off.*", ", "));
      srvyrsmap.put("ONLINE", CommonUtil.complicityFromString(vo.getSurvey_from(), "on.*", ", "));
      srvyrsmap.put("ETC", vo.getSurvey_etc());
      xlssrvyList.add(srvyrsmap);
    }
    System.out.println("xlssrvyListxlssrvyList" + xlssrvyList);
    String fileName = "공모전접수설문목록";

    xlsDownUtil.ExcelWrite2(request, response, xlssrvyList, colinfoList, fileName);
    
    manlogService.insertManlog(request, "COMPLICITY", "공모전 접수목록 관리", "공모전 접수설문목록 엑셀저장", "X");
    
  }

  /**
   * 공모전 접수 내역
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/complicityApplication", method = RequestMethod.GET)
  public String complicityApplication(@ModelAttribute("complicityVO") ComplicityVO complicityVO,
      HttpServletRequest request, Model model) throws Exception {

    // 이메일 선택
    ArrayList<String> emailSelectList = complicityService.getEmailSelectList();
    model.addAttribute("emailSelectList", emailSelectList);

    // 접수상태 선택
    Map<String, String> stateSelectList = complicityService.getStateSelectList();
    model.addAttribute("stateSelectList", stateSelectList);

    // 수상결과 선택
    ArrayList<String> awardSelectList = complicityService.getAwardSelectList();
    model.addAttribute("awardSelectList", awardSelectList);

    // 거주지 선택
    Map<String, String> citySelectList = complicityService.getCitySelectList();
    model.addAttribute("citySelectList", citySelectList);

    // 공모대상
    Map<String, String> targetSelectList = complicityService.getTargetSelectList();
    model.addAttribute("targetSelectList", targetSelectList);



    // // item info
    // ComplicityItemVO item = complicityService.selectComplicityItem(request.getParameter("id"));
    // System.out.println("item : " + item);

    // 공모전 기본정보확인
    String groupId = request.getParameter("group_id");
    if (StringUtils.isEmpty(groupId) == true) {
      throw new CmmnException("공모전 정보를 찾을수 없습니다.");
    }

    ComplicityVO complicity = complicityService.selectComplicity(groupId);
    // System.out.println("complicity : " + complicity);
    if (complicity == null) {
      throw new CmmnException("공모전 정보를 찾을수 없습니다.");
    }

    // 공모전 출품작 정보
    List<ComplicityItemVO> items = complicityService.selectComplicityItemGroupByList(complicity);
    // 출품작 정보 추가
    complicity.setItems(items);
    model.addAttribute("complicityVO", complicity);

    
    manlogService.insertManlog(request, "COMPLICITY", "공모전 접수목록 관리", "공모전 접수 상세조회", "R");
    
    return "/metsys/complicityApplication";
  }

  /**
   * 공모전 접수 내역 변경
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/complicityApplication", method = RequestMethod.POST)
  @ResponseBody
  public Object complicityApplication(
      @Validated(ValidationAdminComplicity.class) ComplicityVO complicityVO, BindingResult result,
      HttpServletRequest request, Model model) throws Exception {

    ResponseResultHelper responseResultHelper =
        new ResponseResultHelper(request, "/metsys/complicityApplication");

    // 유효성 검사
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    // 세션 사용자 정보
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // 수정자
    complicityVO.setModifier(sessionUserData.getUser_id());

    System.out.println("complicityVO : " + complicityVO.getItems());

    // 데이터 수정
    complicityService.updateComplicityItems(complicityVO);

    manlogService.insertManlog(request, "COMPLICITY", "공모전 접수목록 관리", "공모전 접수 내역 변경", "U");
    
    // 완료
    return responseResultHelper.success(null, null,
        CommonUtil.getUrl("/metsys/complicityApplication.do", "", true), null);
  }


  /**
   * 공모전 접수 내역 삭제
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/complicityDelete")
  public String complicityDelete(@ModelAttribute("complicityVO") ComplicityVO complicityVO,
      HttpServletRequest request, Model model) throws Exception {

    // // item info
    // ComplicityItemVO item = complicityService.selectComplicityItem(request.getParameter("id"));
    // System.out.println("item : " + item);

    // 공모전 기본정보확인
    String groupId = request.getParameter("group_id");
    if (StringUtils.isEmpty(groupId) == true) {
      throw new CmmnException("공모전 정보를 찾을수 없습니다.");
    }

    ComplicityVO complicity = complicityService.selectComplicity(groupId);
    // System.out.println("complicity : " + complicity);
    if (complicity == null) {
      throw new CmmnException("공모전 정보를 찾을수 없습니다.");
    }

    // 공모전 출품작 정보
    List<ComplicityItemVO> items = complicityService.selectComplicityItemGroupByList(complicity);
    // 출품작 정보 추가
    complicity.setItems(items);

    // 삭제
    complicityService.deleteComplicity(complicity);

    manlogService.insertManlog(request, "COMPLICITY", "공모전 접수목록 관리", "공모전 접수 내역 삭제", "D");

    return CommonUtil.getRedirectUrl("/metsys/complicityList.do", "group_id=&data_id=&pageIndex=",
        true);
  }
}
