package egovframework.plani.template.man.metsys.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.google.common.base.Joiner;
import egovframework.plani.template.atchfile.dao.AtchfileDAO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.man.metsys.dao.ComplicityDAO;
import egovframework.plani.template.man.metsys.dao.ComplicityItemDAO;
import egovframework.plani.template.man.metsys.service.ComplicityService;
import egovframework.plani.template.man.metsys.vo.ComplicityItemVO;
import egovframework.plani.template.man.metsys.vo.ComplicityVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("complicityService")
public class ComplicityServiceImpl extends EgovAbstractServiceImpl implements ComplicityService {

  /** 공모전 기본정보 */
  @Resource(name = "complicityDAO")
  private ComplicityDAO complicityDAO;

  /** 공모전 출품작 정보 */
  @Resource(name = "complicityItemDAO")
  private ComplicityItemDAO complicityItemDAO;

  /** AtchfileDAO */
  @Resource(name = "atchfileDAO")
  private AtchfileDAO atchfileDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  private static final String ATTACH_COMPLICITY_KEY = "USR_COMPLICITY";

  /**
   * 이메일 선택 리스트
   */
  @Override
  public ArrayList<String> getEmailSelectList() throws Exception {
    ArrayList<String> emailSelectList = new ArrayList<String>();
    emailSelectList.add("nate.com");
    emailSelectList.add("naver.com");
    emailSelectList.add("gmail.com");
    emailSelectList.add("hanmil.net");
    emailSelectList.add("hotmail.com");
    emailSelectList.add("korea.com");
    emailSelectList.add("yahoo.com");
    return emailSelectList;
  }

  @Override
  public Map<String, String> getStateSelectList() throws Exception {
    Map<String, String> state = new LinkedHashMap<String, String>();
    state.put("0", "접수대기");
    state.put("1", "접수완료");
    state.put("9", "접수반려");
    return state;
  }

  /**
   * 수상결과
   */
  @Override
  public ArrayList<String> getAwardSelectList() throws Exception {
    ArrayList<String> awardSelectList = new ArrayList<String>();
    awardSelectList.add("대상");
    awardSelectList.add("금상");
    awardSelectList.add("은상");
    awardSelectList.add("동상");
    awardSelectList.add("참가상");
    return awardSelectList;
  }

  /**
   * 거주지 선택 리스트
   */
  @Override
  public Map<String, String> getCitySelectList() throws Exception {
    Map<String, String> city = new LinkedHashMap<String, String>();
    city.put("서울", "서울");
    city.put("경기", "경기");
    city.put("인천", "인천");
    city.put("부산", "부산");
    city.put("대전", "대전");
    city.put("광주", "광주");
    city.put("대구", "대구");
    city.put("경남", "경남");
    city.put("경북", "경북");
    city.put("전남", "전남");
    city.put("전북", "전북");
    city.put("충남", "충남");
    city.put("충북", "충북");
    city.put("강원", "강원");
    city.put("제주", "제주");
    city.put("해외", "해외");

    return city;
  }

  /**
   * 공모대상
   */
  @Override
  public Map<String, String> getTargetSelectList() throws Exception {
    Map<String, String> target = new LinkedHashMap<String, String>();
    target.put("수기(에세이)", "수기(에세이)");
    target.put("포스터", "포스터");
    target.put("캘리그라피", "캘리그라피");
    target.put("표어(슬로건)", "표어(슬로건)");
    target.put("이모티콘", "이모티콘");
    target.put("스티커", "스티커");
    target.put("웹툰", "웹툰");
    target.put("사진", "사진");
    target.put("UCC", "UCC");
    target.put("기타", "기타");
    return target;
  }

  /**
   * 공모전 기본정보 저장
   */
  @Override
  public Integer insertComplicity(ComplicityVO vo) throws Exception {
    // 전화번호
    if (StringUtils.isEmpty(vo.getTel_1()) == false && StringUtils.isEmpty(vo.getTel_2()) == false
        && StringUtils.isEmpty(vo.getTel_3()) == false) {
      vo.setTel(vo.getTel_1() + "-" + vo.getTel_2() + "-" + vo.getTel_3());
    } else {
      vo.setTel("");
    }
    // 이메일
    if (StringUtils.isEmpty(vo.getEmail_id()) == false
        && StringUtils.isEmpty(vo.getEmail_host()) == false) {
      vo.setEmail(vo.getEmail_id() + "@" + vo.getEmail_host());
    } else {
      vo.setEmail("");
    }
    // 설문조사 성별
    if (StringUtils.isEmpty(vo.getSurvey_gender()) == true) {
      vo.setSurvey_gender("M");
    }
    // 설문조사 연령대
    if (StringUtils.isEmpty(vo.getSurvey_age()) == true) {
      vo.setSurvey_age("10");
    }
    // 설문조사 알게된 경로
    // if (StringUtils.isEmpty(vo.getSurvey_from_string()) == false) {
    if (vo.getSurvey_from() != null && vo.getSurvey_from().length > 0) {
      String from = Joiner.on("|").join(vo.getSurvey_from());
      // System.out.println("from : " + from);
      vo.setSurvey_from_string(from);
    } else {
      vo.setSurvey_from_string("");
    }
    return complicityDAO.insertComplicity(vo);
  }

  /**
   * 공모전 출품작 정보 저장
   */
  @Override
  public Integer insertComplicityItem(ComplicityItemVO vo) throws Exception {
    return complicityItemDAO.insertComplicityItem(vo);
  }

  /**
   * 공모전 출품작 정보들 저장
   */
  @Override
  public Boolean insertComplicityItems(HttpServletRequest request, ComplicityVO vo)
      throws Exception {
    for (int i = 0; i < vo.getItems().size(); i++) {
      ComplicityItemVO item = vo.getItems().get(i);
      // group id
      item.setGroup_id(vo.getGroup_id());
      // 상태
      item.setItem_state(1);// 0:접수대기, 1:접수완료, 2:접수반려
      // 수상내역
      item.setItem_awards("");
      insertComplicityItem(item);

      // System.out.println("INSERT : " + item);

      // 파일 업로드
      uploadFile(request, ATTACH_COMPLICITY_KEY, String.valueOf(item.getData_id()), 1, "items[" + i
          + "].item_file", "gif|png|jpg|bmp", item.getData_id());


    }
    return true;
  }

  @Override
  public Boolean updateComplicityItems(ComplicityVO vo) throws Exception {
    for (int i = 0; i < vo.getItems().size(); i++) {
      ComplicityItemVO item = vo.getItems().get(i);
      item.setModifier(vo.getModifier());
      complicityItemDAO.updateComplicityItem(item);
    }
    return true;
  }

  /**
   * 일자에 따른 저장 파일명을 Random하게 생성함...
   * 
   * @return
   */
  private static String generateSaveFileName(String ext) {
    SimpleDateFormat sm = new SimpleDateFormat("yyyyMMdd");
    return sm.format(new Date()) + "_" + EgovWebUtil.generateIDString("", 12) + "." + ext;
  }


  public Integer insertAtchfile(AtchfileVO vo) throws Exception {
    int retval = 0;
    if ("N".equals(vo.getIs_thumb())) {
      if (vo.getAtckey_4th() == 0)
        retval = atchfileDAO.insertAtchfile(vo);
      else {
        atchfileDAO.insertAtchfileDrct(vo);
        retval = vo.getAtckey_4th();
      }
      vo.setAtckey_4th(0);
    } else {
      atchfileDAO.insertAtchThumb(vo);
      retval = atchfileDAO.selectAtchfileThmCnt(vo);
    }
    return retval;
  }

  /** 파일 업로드 처리 (폼 파일필드 컨트롤 사용) */
  public List uploadFile(HttpServletRequest request, String key_1, String key_2, int key_3,
      String uploadKey, String allowExt, String newFileName) throws Exception {
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    // 썸네일 생성 여부 [GNR : 일반, THM : 썸네일 생성]
    ArrayList linklist = new ArrayList();

    if (isMultipart) {
      try {

        int sizeThreshold = 1024 * 1024; // 메모리에 읽어들일 버퍼의 크기이다. 전체 파일 크기가 아니다.
        String uploadtmp = EgovProperties.GLOBALS_FILEUPLOAD_PATH + "/tmp"; // 파일 임시 저장 디렉토리
        File tempDir = new File(uploadtmp);

        if (!tempDir.exists())
          tempDir.mkdirs();


        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; // 다중파일
                                                                                              // 업로드
        List<MultipartFile> files = multipartRequest.getFiles(uploadKey);
        AtchfileVO fileVO = new AtchfileVO();
        fileVO.setAtckey_1st(key_1);
        fileVO.setAtckey_2nd(key_2);

        for (int i = 0; i < files.size(); i++) {
          if (key_3 == 0) {
            fileVO.setAtckey_3rd(i + 1);
            fileVO.setAtckey_4th(0);
          } else {
            fileVO.setAtckey_3rd(key_3);
            fileVO.setAtckey_4th(i + 1);
          }

          MultipartFile file = files.get(i);
          if (file.getSize() == 0) {
            linklist.add(i, "");
            continue;
          }

          String orgFileName = file.getOriginalFilename();
          long sizeInBytes = file.getSize();
          String uploadDirByDate = "/complicity";
          String uploadbase = EgovProperties.GLOBALS_FILEUPLOAD_PATH;
          String uploadDir = uploadbase;
          uploadDir += uploadDirByDate;
          fileVO.setFpath(uploadDirByDate);

          File dir = new File(uploadDir);
          if (!dir.exists()) {
            dir.mkdirs();
          }

          // 파일 확장자 구하기
          String file_ext =
              orgFileName.substring(orgFileName.lastIndexOf(".") + 1, orgFileName.length());
          file_ext = file_ext.toLowerCase();

          // 허용된 파일 이외에는 첨부할 수 없음
          if (allowExt.indexOf(file_ext) < 0) {
            throw new CmmnException("첨부할 수 없는 파일 형식입니다.");
          }

          // 변경할 파일명
          // String saveFileName = generateSaveFileName(file_ext);
          String saveFileName = newFileName + "." + file_ext;

          String uploadPath = uploadDir + "/" + saveFileName;
          File uploadFile = new File(uploadPath);

          fileVO.setFext(file_ext);
          fileVO.setFname(saveFileName);
          fileVO.setRname(orgFileName);
          fileVO.setSize_kb((int) ((double) sizeInBytes / 1024.0f));
          String vchkcode = EgovWebUtil.generateIDString("", 12);
          fileVO.setVchkcode(vchkcode);

          int dup = 0;
          // 파일명이 존재하는 경우 '_Index' 를 붙인다.
          while (uploadFile.exists()) {
            String dupName = orgFileName.substring(0, saveFileName.lastIndexOf("."));
            dupName += ("_" + dup);
            dupName += orgFileName.substring(orgFileName.lastIndexOf("."), saveFileName.length());
            dup++;
            uploadPath = uploadDir + "/" + dupName;
            uploadFile = new File(uploadPath);
          }

          file.transferTo(uploadFile);

          // 일반 게시판 파일 업로드인 경우...
          insertAtchfile(fileVO);
          linklist.add(i, key_1 + "&" + key_2 + "&" + key_3 + "&" + (i + 1) + "&" + vchkcode + "&"
              + file_ext + "&" + orgFileName);
        }
      } catch (FileUploadException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      } catch (IOException e) {
        e.printStackTrace();
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    return linklist;
  }

  @Override
  public Integer selectComplicityByEmailCount(ComplicityVO vo) throws Exception {
    return complicityDAO.selectComplicityByEmailCount(vo);
  }

  @Override
  public List selectComplicityItemGroupList(ComplicityVO vo) throws Exception {
    return complicityItemDAO.selectComplicityItemGroupList(vo);
  }

  @Override
  public Integer selectComplicityItemListAllTotalCount(ComplicityVO vo) throws Exception {
    return complicityItemDAO.selectComplicityItemListAllTotalCount(vo);
  }

  @Override
  public List<ComplicityItemVO> selectComplicityItemListAll(ComplicityVO vo) throws Exception {
    return complicityItemDAO.selectComplicityItemListAll(vo);
  }

  @Override
  public List<ComplicityItemVO> getXlsList(ComplicityVO vo) throws Exception {
    return complicityItemDAO.getXlsList(vo);
  }

  @Override
  public ComplicityVO selectComplicity(String group_id) throws Exception {
    ComplicityVO result = complicityDAO.selectComplicity(group_id);
    String[] tel = result.getTel().split("-");
    // 연락처
    if (tel.length == 3) {
      result.setTel_1(tel[0]);
      result.setTel_2(tel[1]);
      result.setTel_3(tel[2]);
    }
    // 이메일
    String[] email = result.getEmail().split("@");
    if (email.length == 2) {
      result.setEmail_id(email[0]);
      result.setEmail_host(email[1]);
    }
    // 공모전 경로
    if (StringUtils.isEmpty(result.getSurvey_from_string()) == false) {
      result.setSurvey_from(result.getSurvey_from_string().split("\\|"));
    }
    return result;
    // return complicityDAO.selectComplicity(group_id);
  }

  @Override
  public ComplicityItemVO selectComplicityItem(String data_id) throws Exception {
    return complicityItemDAO.selectComplicityItem(data_id);
  }

  @Override
  public List<ComplicityItemVO> selectComplicityItemGroupByList(ComplicityVO vo) throws Exception {
    return complicityItemDAO.selectComplicityItemGroupByList(vo);
  }

  @Override
  public Boolean deleteComplicity(ComplicityVO vo) throws Exception {

    for (int i = 0; i < vo.getItems().size(); i++) {
      ComplicityItemVO item = vo.getItems().get(i);
      // 첨부파일 삭제
      System.out.println("item : " + item);
      // 첨부 파일
      AtchfileVO fVo = new AtchfileVO();
      fVo.setAtckey_1st(ATTACH_COMPLICITY_KEY);
      fVo.setAtckey_2nd(String.valueOf(item.getData_id()));
      fVo.setAtckey_3rd(1);

      // 실제 첨부파일 및 데이터베이스 정보 삭제
      atchfileService.deleteAtchfiles(fVo);
    }
    // 아이템삭제
    complicityItemDAO.deleteComplicityItemByGroupId(vo.getGroup_id());

    // 기본정보삭제
    complicityDAO.deleteComplicity(vo.getGroup_id());
    return true;
  }

  @Override
  public List<ComplicityVO> getSrvyXlsList(ComplicityVO vo) throws Exception {
    // TODO Auto-generated method stub
    return complicityItemDAO.getSrvyXlsList(vo);
  }



}
