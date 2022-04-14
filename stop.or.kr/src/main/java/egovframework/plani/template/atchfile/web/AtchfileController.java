package egovframework.plani.template.atchfile.web;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovFileDownUtil;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 첨부파일 정보 컨트롤러;
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.atchfile.web] [AtchfileController.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 22. 오후 3:23:11
 * @version : 1.0
 */

@Controller
@RequestMapping("/atchfile")
public class AtchfileController {

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** EgovPropertyService */
  @Resource(name = "propertiesService")
  protected EgovPropertyService propertiesService;

  /** Validator */
  @Resource(name = "beanValidator")
  protected DefaultBeanValidator beanValidator;

  /**
   * 뷰페이지 호출
   * 
   * @param param 파라미터 설명 VO
   * @return return value 설명
   * @exception Exception
   * @return '/atchfile/atchfileBase'
   */
  @RequestMapping("/moveAtchfileBase")
  public String moveAtchfileBase(@ModelAttribute("atchfileVO") AtchfileVO atchfileVO, Model model)
      throws Exception {

    return "/atchfile/atchfileBase";

  }

  /**
   * 목록을 조회한다.
   * 
   * @param atchfileVO : 조회할 정보
   * @return "/atchfile/atchfileList"
   * @exception Exception
   */
  @RequestMapping("/atchfileList")
  public String atchfileList(@ModelAttribute("atchfileVO") AtchfileVO atchfileVO, Model model)
      throws Exception {

    List atchfileList = atchfileService.selectAtchfileList(atchfileVO);
    model.addAttribute("resultList", atchfileList);

    int totCnt = atchfileService.selectAtchfileListTotCnt(atchfileVO);

    return "/atchfile/atchfileList";

  }

  /**
   * 항목을 상세 조회한다.
   * 
   * @param atchfileVO : 조회할 정보
   * @return "/atchfile/atchfileView"
   * @exception Exception
   */
  @RequestMapping("/atchfileView")
  public String atchfileView(@ModelAttribute("atchfileVO") AtchfileVO atchfileVO, ModelMap model)
      throws Exception {

    /*
     * AtchfileVO resultVO = atchfileService.selectAtchfile(atchfileVO);
     * model.addAttribute("resultVO", resultVO);
     */

    return "/atchfile/atchfileView";
  }


  /**
   * 항목을 추가한다.
   * 
   * @param atchfileVO : 추가할 정보
   * @return "/atchfile/atchfileView"
   * @exception Exception
   */
  @RequestMapping("/addAtchfile")
  public String addAtchfile(@ModelAttribute("atchfileVO") AtchfileVO atchfileVO, ModelMap model)
      throws Exception {

    atchfileService.insertAtchfile(atchfileVO);
    // model.addAttribute("resultVO", atchfileVO);

    return "redirect:/atchfile/selectAtchfileView.do";
  }

  /**
   * 항목을 삭제한다.
   * 
   * @param atchfileVO : 삭제할 정보
   * @return "SUCCESS"
   * @exception Exception
   */
  @RequestMapping("/rmvAtchOnefile")
  @ResponseBody
  public String rmvAtchOnefile(@ModelAttribute("atchfileVO") AtchfileVO atchfileVO, ModelMap model)
      throws Exception {


    // vchkcode 값으로만 파일을 찾음
    if (atchfileVO.getAtckey_1st() == null || "".equals(atchfileVO.getAtckey_1st())) {
      atchfileService.deleteAtchOnefileByVchkcode(atchfileVO);
    }

    // 키값을 모두 가지고 찾음.
    else {
      atchfileService.deleteAtchFilePair(atchfileVO);
    }

    return "SUCCESS";
  }


  /**
   * 파일 다운로드 요청을 처리한다.
   * 
   * @param commandMap
   * @param request
   * @param response
   * @throws Exception
   */
  @RequestMapping("/downloadAtchfile")
  public void downloadAtchfile(@ModelAttribute("atchfileVO") AtchfileVO atchfileVO,
      HttpServletRequest request, HttpServletResponse response) throws Exception {

    String storePath = EgovProperties.GLOBALS_FILEUPLOAD_PATH;

    if (atchfileVO.getVchkcode() == null || "".equals(atchfileVO.getVchkcode()))
      throw new CmmnException(MessageHelper.getMessage("FILE-NOT-FOUND") /* 파일을 조회할 수 없습니다 */);

    // vchkcode 값으로만 파일을 찾음
    if (atchfileVO.getAtckey_1st() == null || "".equals(atchfileVO.getAtckey_1st())) {
      AtchfileVO fvo = atchfileService.selectAtchfileByVchkcode(atchfileVO);
      String fname = fvo.getFname();
      String rname = fvo.getRname();
      String fpath = storePath + fvo.getFpath();

      EgovFileDownUtil fdownUtil = new EgovFileDownUtil();

      fdownUtil.cvplFileDownload(fpath, fname, rname, request, response);
    }

    // 키값을 모두 가지고 찾음.
    else {
      AtchfileVO fvo = atchfileService.selectAtchfile(atchfileVO);
      String fname = fvo.getFname();
      String rname = fvo.getRname();
      String fpath = storePath + fvo.getFpath();
      EgovFileDownUtil fdownUtil = new EgovFileDownUtil();

      fdownUtil.cvplFileDownload(fpath, fname, rname, request, response);
    }


  }



  /**
   * 이미지 파일을 아웃풋스트림으로 읽어서 저장할때 사용.
   * 
   * 
   * @param fvo
   * @param request
   * @param response
   * @param model
   * @throws Exception
   */
  @RequestMapping("/imageAtchfile")
  public void imageAtchfile(@ModelAttribute("atchfileVO") AtchfileVO fvo,
      HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

    File f = null;
    BufferedInputStream in = null;
    BufferedOutputStream out = null;
    String mimetype = "image/jpeg";
    int fSize = 0;

    try {
      if (fvo == null)
        throw new Exception(MessageHelper.getMessage("MISSING-PARAMETER")/* 파라미터 누락. */);

      String atckey_1st = fvo.getAtckey_1st();
      String atckey_2nd = fvo.getAtckey_2nd();
      int atckey_3rd = fvo.getAtckey_3rd();
      int atckey_4th = fvo.getAtckey_4th();
      String vchkcode = fvo.getVchkcode();

      if (vchkcode == null || "".equals(vchkcode))
        throw new Exception(MessageHelper.getMessage("MISSING-PARAMETER")/* 파라미터 누락. */);

      // vchkcode 값으로만 파일을 찾음
      if (atckey_1st == null || "".equals(atckey_1st))
        fvo = atchfileService.selectAtchfileByVchkcode(fvo);

      else
        fvo = atchfileService.selectAtchfile(fvo);

      if (fvo == null)
        throw new Exception(
            MessageHelper.getMessage("FILE-INFORMATION-DOES-NOT-EXIST")/* 파일정보가 존재하지 않습니다. */);

      String storePath = EgovProperties.GLOBALS_FILEUPLOAD_PATH;
      String subPath = fvo.getFpath() + "/";
      String realFileName = fvo.getFname();

      f = new File(storePath + subPath);
      if (!f.isDirectory())
        throw new CmmnException(MessageHelper
            .getMessage("TEH-FILE-DIRECTORY-IS-NOT-VALID")/* 파일이 저장된 디렉토리가 유효하지 않습니다. */);

      f = new File(storePath + subPath, realFileName);
      if (!f.isFile())
        throw new CmmnException(
            MessageHelper.getMessage("TEH-FILE-IS-NOT-VALID")/* 파일이 유효하지 않습니다. */);

      fSize = (int) f.length();
      if (fSize < 0)
        throw new CmmnException(
            MessageHelper.getMessage("THE-SIZE-OF-THE-FILE-IS-ZERO")/* 파일의 크기가 0입니다. */);

      String ext = fvo.getFext();
      if (!(ext.equals("jpg") || ext.equals("gif") || ext.equals("png") || ext.equals("bmp")
          || ext.equals("JPG") || ext.equals("GIF") || ext.equals("PNG") || ext.equals("BMP")))
        throw new CmmnException(
            MessageHelper.getMessage("IT-IS-NOT-IMAGE-FILE")/* 이미지 파일이 아닙니다. */);

      mimetype = "image/" + ext;
    } catch (Exception e) {
      // NO IMAGE 표시
      System.out.println(e.getMessage());
      mimetype = "image/jpeg";
      f = new File(request.getSession().getServletContext().getRealPath("/images/template/cmm")
          + "/height_noimg.gif");
      fSize = (int) f.length();
    }

    try {
      response.setContentType(mimetype);
      response.setContentLength(fSize);

      in = new BufferedInputStream(new FileInputStream(f));
      out = new BufferedOutputStream(response.getOutputStream());

      FileCopyUtils.copy(in, out);
      out.flush();
    } finally {
      if (in != null) {
        try {
          in.close();
        } catch (Exception ignore) {
          ignore.printStackTrace();
        }
      }

      if (out != null) {
        try {
          out.close();
        } catch (Exception ignore) {
          ignore.printStackTrace();
        }
      }
    }
  }



  /**
   * 이미지 파일을 아웃풋스트림으로 읽어서 저장할때 사용. (파일 일련번호가 아니라 이름으로 검색)
   * 
   * @param fvo
   * @param request
   * @param response
   * @param model
   * @throws Exception
   */
  @RequestMapping("/imageAtchfileByFilename")
  public void imageAtchfileByFilename(@ModelAttribute("atchfileVO") AtchfileVO fvo,
      HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

    File f = null;
    BufferedInputStream in = null;
    BufferedOutputStream out = null;
    String mimetype = "image/jpeg";
    int fSize = 0;
    try {
      if (fvo == null)
        throw new Exception(MessageHelper.getMessage("MISSING-PARAMETER")/* 파라미터 누락. */);

      String atckey_1st = fvo.getAtckey_1st();
      String atckey_2nd = fvo.getAtckey_2nd();

      String rname = EgovWebUtil.UTF8Decode(fvo.getRname());
      if (atckey_1st == null || atckey_1st.equals("") || atckey_2nd == null || atckey_2nd.equals("")
          || rname.equals(""))
        throw new Exception(MessageHelper.getMessage("MISSING-PARAMETER")/* 파라미터 누락. */);

      fvo.setRname(rname);
      fvo = atchfileService.selectAtchfileByFilename(fvo);
      if (fvo == null)
        throw new CmmnException(
            MessageHelper.getMessage("FILE-INFORMATION-DOES-NOT-EXIST")/* 파일정보가 존재하지 않습니다. */);

      String storePath = EgovProperties.GLOBALS_FILEUPLOAD_PATH;
      String subPath = fvo.getFpath() + "/";
      String realFileName = fvo.getFname();

      f = new File(storePath + subPath);
      if (!f.isDirectory())
        throw new CmmnException(MessageHelper
            .getMessage("TEH-FILE-DIRECTORY-IS-NOT-VALID")/* 파일이 저장된 디렉토리가 유효하지 않습니다. */);

      f = new File(storePath + subPath, realFileName);
      if (!f.isFile())
        throw new CmmnException(
            MessageHelper.getMessage("TEH-FILE-IS-NOT-VALID")/* 파일이 유효하지 않습니다. */);

      fSize = (int) f.length();
      if (fSize < 0)
        throw new CmmnException(
            MessageHelper.getMessage("THE-SIZE-OF-THE-FILE-IS-ZERO")/* 파일의 크기가 0입니다. */);

      String ext = realFileName.substring(realFileName.lastIndexOf(".") + 1).toLowerCase();
      if (!(ext.equals("jpg") || ext.equals("gif") || ext.equals("png") || ext.equals("bmp")))
        throw new Exception(MessageHelper.getMessage("IT-IS-NOT-IMAGE-FILE")/* 이미지 파일이 아닙니다. */);

      mimetype = "image/" + ext;
    } catch (Exception e) {
      // NO IMAGE 표시
      System.out.println(e.getMessage());
      mimetype = "image/jpeg";
      f = new File(request.getSession().getServletContext().getRealPath("/images/template/cmm")
          + "/height_noimg.gif");

      fSize = (int) f.length();
    }

    try {
      response.setContentType(mimetype);
      response.setContentLength(fSize);

      in = new BufferedInputStream(new FileInputStream(f));
      out = new BufferedOutputStream(response.getOutputStream());

      FileCopyUtils.copy(in, out);
      out.flush();
    } finally {
      if (in != null) {
        try {
          in.close();
        } catch (Exception ignore) {
          ignore.printStackTrace();
        }
      }

      if (out != null) {
        try {
          out.close();
        } catch (Exception ignore) {
          ignore.printStackTrace();
        }
      }
    }
  }



  /**
   * 바이너리 파일을 아웃풋스트림으로 읽어서 저장할때 사용.
   * 
   * @param fvo
   * @param request
   * @param response
   * @param model
   * @throws Exception
   */
  @RequestMapping("/binaryAtchfile")
  public void binaryAtchfile(@ModelAttribute("atchfileVO") AtchfileVO fvo,
      HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

    File f = null;
    BufferedInputStream in = null;
    BufferedOutputStream out = null;
    String mimetype = "";
    int fSize = 0;
    try {
      if (fvo == null)
        throw new Exception(MessageHelper.getMessage("MISSING-PARAMETER")/* 파라미터 누락. */);

      String atckey_1st = fvo.getAtckey_1st();
      String atckey_2nd = fvo.getAtckey_2nd();
      int atckey_3rd = fvo.getAtckey_3rd();
      int atckey_4th = fvo.getAtckey_4th();
      String vchkcode = fvo.getVchkcode();

      if (vchkcode == null || "".equals(vchkcode))
        throw new Exception(MessageHelper.getMessage("MISSING-PARAMETER")/* 파라미터 누락. */);

      // vchkcode 값으로만 파일을 찾음
      if (atckey_1st == null || "".equals(atckey_1st))
        fvo = atchfileService.selectAtchfileByVchkcode(fvo);

      else
        fvo = atchfileService.selectAtchfile(fvo);

      if (fvo == null)
        throw new CmmnException(
            MessageHelper.getMessage("FILE-INFORMATION-DOES-NOT-EXIST")/* 파일정보가 존재하지 않습니다. */);

      String storePath = EgovProperties.GLOBALS_FILEUPLOAD_PATH;
      String subPath = fvo.getFpath() + "/";
      String realFileName = fvo.getFname();

      f = new File(storePath + subPath);
      if (!f.isDirectory())
        throw new Exception(MessageHelper
            .getMessage("TEH-FILE-DIRECTORY-IS-NOT-VALID")/* 파일이 저장된 디렉토리가 유효하지 않습니다. */);

      f = new File(storePath + subPath, realFileName);
      if (!f.isFile())
        throw new Exception(MessageHelper.getMessage("TEH-FILE-IS-NOT-VALID")/* 파일이 유효하지 않습니다. */);

      fSize = (int) f.length();
      if (fSize < 0)
        throw new Exception(
            MessageHelper.getMessage("THE-SIZE-OF-THE-FILE-IS-ZERO")/* 파일의 크기가 0입니다. */);

      mimetype = "image/" + fvo.getFext();

      response.setContentType("application/octet-stream");
      response.setHeader("Content-disposition",
          "attachment;filename=" + java.net.URLEncoder.encode(fvo.getRname(), "UTF-8"));
      response.addHeader("Content-description", "EventAttendees");
      response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
      response.setContentLength(fSize);

      in = new BufferedInputStream(new FileInputStream(f));
      out = new BufferedOutputStream(response.getOutputStream());

      FileCopyUtils.copy(in, out);
      out.flush();
    } finally {
      if (in != null) {
        try {
          in.close();
        } catch (Exception ignore) {
          ignore.printStackTrace();
        }
      }

      if (out != null) {
        try {
          out.close();
        } catch (Exception ignore) {
          ignore.printStackTrace();
        }
      }
    }
  }



  /**
   * 다음에디터 (또는 다른에디터에서도 사용할 수 있음) 에서 본문에 추가할 이미지를 파일첨부 외에 직접 첨부하는 경우 이미지를 지정된 장소에 업로드한다
   * 
   * @param atchfileVO
   * @param request
   * @param model
   * @return '/template/cmmn/editorcallback/file_uploader'
   * @throws Exception
   */
  @RequestMapping("/atchDirectImage")
  public String atchDirectImage(@ModelAttribute("atchfileVO") AtchfileVO atchfileVO,
      HttpServletRequest request, Model model) throws Exception {


    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    // 썸네일 생성 여부 [GNR : 일반, THM : 썸네일 생성]
    ArrayList linklist = new ArrayList();

    if (isMultipart) {
      try {

        int sizeThreshold = 1024 * 1024; // 메모리에 읽어들일 버퍼의 크기이다. 전체 파일 크기가 아니다.

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; // 다중파일
                                                                                              // 업로드
        List<MultipartFile> files = multipartRequest.getFiles("file_upload");

        for (int i = 0; i < files.size(); i++) {
          MultipartFile mulfile = files.get(i);
          if (mulfile.getSize() == 0) {
            continue;
          }

          String orgFileName = mulfile.getOriginalFilename();
          long sizeInBytes = mulfile.getSize();

          // 파일 확장자 구하기
          String file_ext =
              orgFileName.substring(orgFileName.lastIndexOf(".") + 1, orgFileName.length());
          file_ext = file_ext.toLowerCase();

          // 허용된 파일 이외에는 첨부할 수 없음
          if ("gif|jpg|png|bmp|zip|xls|xlsx|ppt|pptx|doc|docx|txt|hwp|pdf|sav|dta|sd2"
              .indexOf(file_ext) < 0) {
            throw new CmmnException(
                MessageHelper.getMessage("NOT-ALLOWED-FILE-TYPE")/* 첨부할 수 없는 파일 형식입니다. */);
          }

          // String dftFilePath =
          // request.getSession().getServletContext().getRealPath("/data/upload/");

          // 파일업로드 디렉터리로 변경 : pigcos(2018-08-31)
          String dftFilePath = EgovProperties.GLOBALS_FILEUPLOAD_PATH + "/data/upload";

          // 파일 기본경로 _ 상세경로
          String filePath = dftFilePath + File.separator + "planiupload" + File.separator;
          File file = new File(filePath);
          if (!file.exists()) {
            file.mkdirs();
          }
          String realFileNm = "";
          SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
          String today = formatter.format(new java.util.Date());
          realFileNm = today + UUID.randomUUID().toString()
              + orgFileName.substring(orgFileName.lastIndexOf("."));

          ///////////////// 서버에 파일쓰기 /////////////////
          int dup = 0;
          // 파일명이 존재하는 경우 '_Index' 를 붙인다.
          File uploadFile = new File(filePath + realFileNm);
          mulfile.transferTo(uploadFile);
          ///////////////// 서버에 파일쓰기 /////////////////

          // String fullpath =
          // request.getRequestURL().indexOf("https://") < 0 ? "http://" : "https://";
          // fullpath += request.getServerName();
          // fullpath += request.getServerPort() == 80 || request.getServerPort() == 443 ? ""
          // : ":" + request.getServerPort();
          // fullpath += request.getContextPath();
          // fullpath += "/data/upload/planiupload/";

          // fullpath 도메인 정보 제거 : pigcos(2018-08-31)
          String fullpath = "/data/upload/planiupload/";

          // 썸네일 생성
          {

            ParameterBlock pb = new ParameterBlock();
            pb.add(filePath + realFileNm);
            RenderedOp rOp = JAI.create("fileload", pb);

            // 불러온 이미지를 BuffedImage에 담는다.
            BufferedImage bi = rOp.getAsBufferedImage();


            int img_h = bi.getHeight();
            int img_w = bi.getWidth();

            int thm_w = 220;
            int thm_h = 310;


            // 가로가 세로보다 더 큰 경우 가로를 240으로 맞추고 가로세로 비율을 곱해준다.
            if (img_w > img_h) {
              thm_w = 220;
              thm_h = Math.round(220 * ((float) img_h / img_w));
            }

            // 세로가 가로보다 더 큰 경우 세로를 240으로 맞추고 가로세로 비율을 곱해준다.
            else {
              thm_h = 310;
              thm_w = Math.round(310 * ((float) img_w / img_h));
            }


            // 이미지 버퍼 생성, 버퍼의 사이즈는 120 * 120으로 설정.
            BufferedImage thumb = new BufferedImage(thm_w, thm_h, BufferedImage.TYPE_INT_RGB);

            // 버퍼사이즈 120 * 120 으로 맞춰 그린다
            Graphics2D g = thumb.createGraphics();
            g.drawImage(bi, 0, 0, thm_w, thm_h, null);

            String thumbdir = filePath + "/thumb";
            File fthm = new File(thumbdir);

            if (!fthm.exists())
              fthm.mkdirs();

            /* 출력할 위치와 파일이름을 설정하고 섬네일 이미지를 생성한다. 저장하는 타입을 jpg로 설정. */
            File thmfile = new File(fthm + "/" + realFileNm);
            //ImageIO.write(thumb, "jpg", thmfile);
            ImageIO.write(thumb, "png", thmfile);//20200416 저장타입을 png로 수정

          }

          model.addAttribute("filePath", fullpath + realFileNm);
          model.addAttribute("fileName", realFileNm);
          model.addAttribute("fileSize", sizeInBytes);

        }


      } catch (Exception e) {
        e.printStackTrace();
      }


    }

    return "/template/cmmn/editorcallback/file_uploader";
  }



}


