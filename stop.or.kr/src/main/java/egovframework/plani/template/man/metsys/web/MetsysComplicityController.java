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
   * ????????? ?????? ??????
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
    searchCondition.put("", "??????");
    searchCondition.put("1", "????????????");
    searchCondition.put("2", "?????????");
    searchCondition.put("3", "?????????");
    searchCondition.put("4", "?????????");
    searchCondition.put("6", "??????");
    searchCondition.put("5", "??????");
    model.addAttribute("searchCondition", searchCondition);

    complicityItemVO.setPageUnit(20);

    // ?????? ??????
    final ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setSdate(complicityItemVO.getSdate());
    complicityVO.setEdate(complicityItemVO.getEdate());
    complicityVO.setSearchCondition(complicityItemVO.getSearchCondition());
    complicityVO.setSearchKeyword(complicityItemVO.getSearchKeyword());

    // ????????? ?????? ??????
    crudTemplate.pagingList(request, model, complicityItemVO, new CrudStrategy<ComplicityItemVO>() {
      @Override
      public int totalCount() throws Exception {
        return complicityService.selectComplicityItemListAllTotalCount(complicityVO);
      }

      @Override
      public List<ComplicityItemVO> pagingList() throws Exception {
        // ????????? ??????
        complicityVO.setFirstIndex(complicityItemVO.getFirstIndex());
        complicityVO.setRecordCountPerPage(complicityItemVO.getRecordCountPerPage());
        return complicityService.selectComplicityItemListAll(complicityVO);
      }
    });

    manlogService.insertManlog(request, "COMPLICITY", "????????? ???????????? ??????", "????????? ???????????? ??????", "L");
    return "/metsys/complicityList";
  }

  /**
   * ????????? ?????? ?????? ????????????
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

    // ?????? ??????
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

    String orgFileName = "?????????_" + CommonUtil.getDate2String(new Date(), "yyyyMMddHHmm") + ".zip";

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
        { {"DATA_ID", "????????????"}, {"NAME", "??????"}, {"TEL", "?????????"}, {"EMAIL", "?????????"}, {"AGE", "??????"},
            {"BELONG", "??????"}, {"ITEM_STATE", "????????????"}, {"ITEM_DIVISION", "??????/???"},
            {"ITEM_TARGET", "????????????"}, {"ITEM_EXPLAIN", "????????????"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap<String, String> ifmap = new HashMap<String, String>();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    // ?????? ??????
    ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setSdate(complicityItemVO.getSdate());
    complicityVO.setEdate(complicityItemVO.getEdate());
    complicityVO.setSearchCondition(complicityItemVO.getSearchCondition());
    complicityVO.setSearchKeyword(complicityItemVO.getSearchKeyword());

    List<ComplicityItemVO> list = complicityService.getXlsList(complicityVO);

    /************************************************************
     * ?????? ????????? ????????? ????????? ????????? ??? ???????????? ???????????? ????????????. ????????? ???????????? ?????? ??????(????????? ???????????? ??????) ???????????? ????????????....
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

    String fileName = "?????????????????????";

    xlsDownUtil.ExcelWrite2(request, response, xlsList, colinfoList, fileName);
    
    manlogService.insertManlog(request, "COMPLICITY", "????????? ???????????? ??????", "????????? ???????????? ????????????", "X");
    
  }

  @RequestMapping("/complicitySrvyXlsDownload")
  public void complicitySrvyXlsDownload(
      @ModelAttribute("complicityItemVO") ComplicityItemVO complicityItemVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
    ArrayList<HashMap<String, String>> colinfoList = new ArrayList<HashMap<String, String>>();

    String[][] col_name =
        { {"NAME", "??????"}, {"SEX", "??????"}, {"AGE", "?????????"}, {"CITY", "?????????"}, {"OFFLINE", "????????????"},
            {"ONLINE", "?????????"}, {"ETC", "??????"}};

    for (int i = 0; i < col_name.length; i++) {
      HashMap<String, String> ifmap = new HashMap<String, String>();
      ifmap.put("COL_NAME", col_name[i][0]);
      ifmap.put("COL_INFO", col_name[i][1]);
      colinfoList.add(ifmap);
    }

    // ?????? ??????
    ComplicityVO complicityVO = new ComplicityVO();
    complicityVO.setSdate(complicityItemVO.getSdate());
    complicityVO.setEdate(complicityItemVO.getEdate());
    // complicityVO.setSearchCondition(complicityItemVO.getSearchCondition());
    // complicityVO.setSearchKeyword(complicityItemVO.getSearchKeyword());

    List<ComplicityVO> list = complicityService.getSrvyXlsList(complicityVO);

    /************************************************************
     * ?????? ????????? ????????? ????????? ????????? ??? ???????????? ???????????? ????????????. ????????? ???????????? ?????? ??????(????????? ???????????? ??????) ???????????? ????????????....
     ************************************************************/
    List<HashMap<String, String>> xlssrvyList = new ArrayList<HashMap<String, String>>();
    for (int i = 0; i < list.size(); i++) {
      ComplicityVO vo = list.get(i);
      HashMap<String, String> srvyrsmap = new HashMap<String, String>();
      vo.setSurvey_from(vo.getSurvey_from_string().split("\\|"));
      srvyrsmap.put("NAME", vo.getName());
      srvyrsmap.put("SEX", (vo.getSurvey_gender().equals("M")) ? "???" : "???");
      srvyrsmap.put("AGE", vo.getSurvey_age() + " ???");
      srvyrsmap.put("CITY", vo.getSurvey_city());
      srvyrsmap.put("OFFLINE", CommonUtil.complicityFromString(vo.getSurvey_from(), "off.*", ", "));
      srvyrsmap.put("ONLINE", CommonUtil.complicityFromString(vo.getSurvey_from(), "on.*", ", "));
      srvyrsmap.put("ETC", vo.getSurvey_etc());
      xlssrvyList.add(srvyrsmap);
    }
    System.out.println("xlssrvyListxlssrvyList" + xlssrvyList);
    String fileName = "???????????????????????????";

    xlsDownUtil.ExcelWrite2(request, response, xlssrvyList, colinfoList, fileName);
    
    manlogService.insertManlog(request, "COMPLICITY", "????????? ???????????? ??????", "????????? ?????????????????? ????????????", "X");
    
  }

  /**
   * ????????? ?????? ??????
   * 
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/complicityApplication", method = RequestMethod.GET)
  public String complicityApplication(@ModelAttribute("complicityVO") ComplicityVO complicityVO,
      HttpServletRequest request, Model model) throws Exception {

    // ????????? ??????
    ArrayList<String> emailSelectList = complicityService.getEmailSelectList();
    model.addAttribute("emailSelectList", emailSelectList);

    // ???????????? ??????
    Map<String, String> stateSelectList = complicityService.getStateSelectList();
    model.addAttribute("stateSelectList", stateSelectList);

    // ???????????? ??????
    ArrayList<String> awardSelectList = complicityService.getAwardSelectList();
    model.addAttribute("awardSelectList", awardSelectList);

    // ????????? ??????
    Map<String, String> citySelectList = complicityService.getCitySelectList();
    model.addAttribute("citySelectList", citySelectList);

    // ????????????
    Map<String, String> targetSelectList = complicityService.getTargetSelectList();
    model.addAttribute("targetSelectList", targetSelectList);



    // // item info
    // ComplicityItemVO item = complicityService.selectComplicityItem(request.getParameter("id"));
    // System.out.println("item : " + item);

    // ????????? ??????????????????
    String groupId = request.getParameter("group_id");
    if (StringUtils.isEmpty(groupId) == true) {
      throw new CmmnException("????????? ????????? ????????? ????????????.");
    }

    ComplicityVO complicity = complicityService.selectComplicity(groupId);
    // System.out.println("complicity : " + complicity);
    if (complicity == null) {
      throw new CmmnException("????????? ????????? ????????? ????????????.");
    }

    // ????????? ????????? ??????
    List<ComplicityItemVO> items = complicityService.selectComplicityItemGroupByList(complicity);
    // ????????? ?????? ??????
    complicity.setItems(items);
    model.addAttribute("complicityVO", complicity);

    
    manlogService.insertManlog(request, "COMPLICITY", "????????? ???????????? ??????", "????????? ?????? ????????????", "R");
    
    return "/metsys/complicityApplication";
  }

  /**
   * ????????? ?????? ?????? ??????
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

    // ????????? ??????
    if (result.hasErrors()) {
      return responseResultHelper.validation(result);
    }

    // ?????? ????????? ??????
    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    // ?????????
    complicityVO.setModifier(sessionUserData.getUser_id());

    System.out.println("complicityVO : " + complicityVO.getItems());

    // ????????? ??????
    complicityService.updateComplicityItems(complicityVO);

    manlogService.insertManlog(request, "COMPLICITY", "????????? ???????????? ??????", "????????? ?????? ?????? ??????", "U");
    
    // ??????
    return responseResultHelper.success(null, null,
        CommonUtil.getUrl("/metsys/complicityApplication.do", "", true), null);
  }


  /**
   * ????????? ?????? ?????? ??????
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

    // ????????? ??????????????????
    String groupId = request.getParameter("group_id");
    if (StringUtils.isEmpty(groupId) == true) {
      throw new CmmnException("????????? ????????? ????????? ????????????.");
    }

    ComplicityVO complicity = complicityService.selectComplicity(groupId);
    // System.out.println("complicity : " + complicity);
    if (complicity == null) {
      throw new CmmnException("????????? ????????? ????????? ????????????.");
    }

    // ????????? ????????? ??????
    List<ComplicityItemVO> items = complicityService.selectComplicityItemGroupByList(complicity);
    // ????????? ?????? ??????
    complicity.setItems(items);

    // ??????
    complicityService.deleteComplicity(complicity);

    manlogService.insertManlog(request, "COMPLICITY", "????????? ???????????? ??????", "????????? ?????? ?????? ??????", "D");

    return CommonUtil.getRedirectUrl("/metsys/complicityList.do", "group_id=&data_id=&pageIndex=",
        true);
  }
}
