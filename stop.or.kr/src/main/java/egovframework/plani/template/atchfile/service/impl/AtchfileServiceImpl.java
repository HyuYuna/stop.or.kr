package egovframework.plani.template.atchfile.service.impl;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.renderable.ParameterBlock;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.plani.template.atchfile.dao.AtchfileDAO;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("atchfileService")
public class AtchfileServiceImpl extends EgovAbstractServiceImpl implements AtchfileService {

  /** AtchfileDAO */
  @Resource(name = "atchfileDAO")
  private AtchfileDAO atchfileDAO;

  /**
   * 파일첨부정보 을/를 등록한다. 실제파일을 같이 삭제하기 위해 delete query의 in 구문을 사용하지 않음.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer insertAtchfile(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub

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

  /**
   * 파일첨부정보 을/를 등록한다. 실제파일을 같이 삭제하기 위해 delete query의 in 구문을 사용하지 않음.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void insertAtchThumb(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    atchfileDAO.insertAtchThumb(vo);
  }


  /**
   * 첨부파일 을/를 삭제한다.(하나만 삭제; 썸네일이 있을 경우 썸네일과 함께 삭제한다.)
   * 
   * @param vo - 삭제할 조건이 담긴 VO <brd_id, cont_idx, atch_idx 가 설정되어야 한다.>
   * @exception Exception
   */
  @Override
  public void deleteAtchFilePair(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub

    List pair = atchfileDAO.selectAtchfilePair(vo);

    for (int i = 0; i < pair.size(); i++) {
      AtchfileVO delVO = (AtchfileVO) pair.get(i);

      deleteAtchFileOnDisk(delVO);

      // DB상의 Thumnail 정보도 같이 삭제된다
      atchfileDAO.deleteAtchOnefile(delVO);
    }


  }

  /**
   * 첨부파일 을/를 삭제한다.(하나만 삭제)
   * 
   * @param vo - 삭제할 조건이 담긴 VO <vchkcode 가 설정되어야 한다.>
   * @exception Exception
   */
  @Override
  public void deleteAtchOnefileByVchkcode(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub

    AtchfileVO searchVO = atchfileDAO.selectAtchfileByVchkcode(vo);
    List pair = atchfileDAO.selectAtchfilePair(searchVO);

    for (int i = 0; i < pair.size(); i++) {
      AtchfileVO delVO = (AtchfileVO) pair.get(i);

      deleteAtchFileOnDisk(delVO);

      // DB상의 Thumnail 정보도 같이 삭제된다
      atchfileDAO.deleteAtchOnefile(delVO);
    }
  }

  /**
   * 첨부파일 을/를 삭제한다.(한 게시판에 포함된 파일들을 모두 삭제한다.)
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoardAtchfiles(AtchfileVO vo) throws Exception {
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st(vo.getAtckey_1st());
    atchfileDAO.deleteBoardAtchfiles(fvo);
  }

  /**
   * 첨부파일 을/를 삭제한다.(한 게시물에 포함된 파일들을 모두 삭제한다.) 실제파일을 같이 삭제하기 위해 delete query의 in 구문을 사용하지 않음.
   * 
   * @param vo - 삭제할 조건이 담긴 VO <brd_id와 cont_idx가 설정되어야 한다.>
   * @exception Exception
   */
  @Override
  public void deleteAtchfiles(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 첨부파일 목록 가져오기..
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st(vo.getAtckey_1st());
    fvo.setAtckey_2nd(vo.getAtckey_2nd());
    fvo.setAtckey_3rd(vo.getAtckey_3rd());
    List filelist = selectAtchfileList(fvo);

    for (int i = 0; i < filelist.size(); i++) {
      fvo = (AtchfileVO) filelist.get(i);

      // 파일 정보와 함께 실제 파일도 삭제한다.
      deleteAtchFilePair(fvo);
      atchfileDAO.deleteAtchOnefile(fvo);
    }

  }

  /**
   * 파일첨부정보 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public AtchfileVO selectAtchfile(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    return atchfileDAO.selectAtchfile(vo);
  }


  /**
   * 파일첨부정보 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectAtchfileList(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    return atchfileDAO.selectAtchfileList(vo);
  }

  /**
   * 파일첨부정보목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectAtchfileListTotCnt(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    return atchfileDAO.selectAtchfileListTotCnt(vo);
  }

  /**
   * 관리자가 컨텐츠관리등에서 사용할 목적으로 첨부파일관리에서 첨부한 파일을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectCustomAtchfileList(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    return atchfileDAO.selectCustomAtchfileList(vo);
  }


  /**
   * 관리자가 컨텐츠관리등에서 사용할 목적으로 첨부파일관리에서 첨부한 파일목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectCustomAtchfileListTotCnt(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    return atchfileDAO.selectCustomAtchfileListTotCnt(vo);
  }

  /**
   * 관리자가 컨텐츠관리등에서 사용할 목적으로 첨부파일관리에서 첨부를 하기 위한 키값을 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectMaxAtchkey2nd(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    return atchfileDAO.selectMaxAtchkey2nd(vo);
  }

  /**
   * 컨텐츠 등록시 이전버전의 첨부파일을 카피해서 새로운 버전을 만든다.
   * 
   * @param old_ - 이전버전의 첨부파일 조회 조건이 담긴 VO
   * @param new_cont_idx - 카피할 cont_idx
   * @throws Exception
   */
  @Override
  public void insertAndCopyfiles(AtchfileVO old_, int new_cont_idx) throws Exception {
    List oldlist = selectAtchfileList(old_);

    String uploadbase = EgovProperties.GLOBALS_FILEUPLOAD_PATH;
    String uploadDir = "";

    for (int i = 0; i < oldlist.size(); i++) {
      AtchfileVO nvo = (AtchfileVO) oldlist.get(i);

      // 새로 저장할 파일명 설정(구버전과 같은 이름으로 저장하면 버전을 복원할때 같이 삭제될 수 있다.)
      String newfile = generateSaveFileName(nvo.getFext());

      // 구버전 파일 읽기
      uploadDir = uploadbase + nvo.getFpath();
      File file = new File(uploadDir + "/" + nvo.getFname());

      if (file.exists()) {
        FileInputStream fi = new FileInputStream(file);
        FileOutputStream fo = new FileOutputStream(uploadDir + "/" + newfile);
        FileCopyUtils.copy(fi, fo);
        fi.close();
        fo.close();
      }

      nvo.setFname(newfile);
      nvo.setAtckey_3rd(new_cont_idx);
      nvo.setVchkcode(EgovWebUtil.generateIDString("", 12));
      this.insertAtchfile(nvo);
    }

  }

  @Override
  public AtchfileVO selectAtchfileByVchkcode(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    return atchfileDAO.selectAtchfileByVchkcode(vo);
  }

  /** 파일 업로드 처리 (uploadfy 사용) */
  @Override
  public void uploadProc(HttpServletRequest request) throws Exception {
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    
    // 썸네일 생성 여부 [GNR : 일반, THM : 썸네일 생성]
    String fupgb = "GNR";

    if (isMultipart) {
      try {

        int sizeThreshold = 1024 * 1024; // 메모리에 읽어들일 버퍼의 크기이다. 전체 파일 크기가 아니다.
        String uploadtmp = EgovProperties.GLOBALS_FILEUPLOAD_PATH + "/tmp"; // 파일 임시 저장 디렉토리
        File tempDir = new File(uploadtmp);

        if (!tempDir.exists())
          tempDir.mkdirs();

        DiskFileItemFactory factory = new DiskFileItemFactory(sizeThreshold, tempDir);
        ServletFileUpload upload = new ServletFileUpload(factory);

        upload.setSizeMax(EgovProperties.GLOBAL_UPLOADSIZE_LIMIT);
        upload.setHeaderEncoding("UTF-8");

        AtchfileVO fileVO = new AtchfileVO();

        List items = upload.parseRequest(request);
        Iterator iter = items.iterator();
        while (iter.hasNext()) {
          FileItem item = (FileItem) iter.next();
          if (item.isFormField()) {        	  
            if ("UPLOAD_KEY_1".equals(item.getFieldName()))
              fileVO.setAtckey_1st(item.getString());

            else if ("UPLOAD_KEY_2".equals(item.getFieldName()))
              fileVO.setAtckey_2nd(item.getString());

            else if ("UPLOAD_KEY_3".equals(item.getFieldName()))
              fileVO.setAtckey_3rd(Integer.parseInt(item.getString()));

            else if ("UPLOAD_KEY_4".equals(item.getFieldName()))
              fupgb = item.getString();

          } else {
            String fieldName = item.getFieldName();
            String orgFileName = item.getName();
            String contentType = item.getContentType();
            boolean isInMemory = item.isInMemory();
            long sizeInBytes = item.getSize();
            
            // 전체 경로를 제외한 파일명만 추출하기	2020.331 추가
            String fileName = new File(item.getName()).getName();

            String uploadDirByDate = getUploadDirByDate();
            String uploadbase = EgovProperties.GLOBALS_FILEUPLOAD_PATH;

            // 컨텐츠관리에서 올라온 첨부파일은 한곳에 따로 모아 저장한다.
            String uploadDir = uploadbase;
            if (EgovProperties.CONTENTS_UPLOAD_KEY.equals(fileVO.getAtckey_1st())) {
              uploadDir += EgovProperties.CONTENTS_UPLOAD_DIR;
              fileVO.setFpath(EgovProperties.CONTENTS_UPLOAD_DIR);
            } else {
              uploadDir += uploadDirByDate;
              fileVO.setFpath(uploadDirByDate);
            }

             //System.out.println("################################" + uploadDir);
            File dir = new File(uploadDir);
            if (!dir.exists()) {
              dir.mkdirs();
            }

            // 파일 확장자 구하기
            String file_ext =
                orgFileName.substring(orgFileName.lastIndexOf(".") + 1, orgFileName.length());
            file_ext = file_ext.toLowerCase();

            // 허용된 파일 이외에는 첨부할 수 없음
            if ("gif|jpg|png|bmp|zip|xls|xlsx|ppt|pptx|doc|docx|txt|hwp|pdf|sav|dta|sd2"
                .indexOf(file_ext) < 0) {
              throw new CmmnException("첨부할 수 없는 파일 형식입니다.");
            }

            // 변경할 파일명
            String saveFileName = generateSaveFileName(file_ext);

            String uploadPath = uploadDir + "/" + saveFileName;
            File uploadFile = new File(uploadPath);

            fileVO.setFext(file_ext);
            fileVO.setFname(saveFileName);
            fileVO.setRname(fileName);
            fileVO.setSize_kb((int) ((double) sizeInBytes / 1024.0f));
            fileVO.setVchkcode(EgovWebUtil.generateIDString("", 12));

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

            item.write(uploadFile);
          
            if ("THM".equals(fupgb) && ("jpg".equals(file_ext) || "bmp".equals(file_ext)
                || "png".equals(file_ext) || "gif".equals(file_ext))) {
              // 이미지 게시판 업로드인 경우 첫번째 파일에 대한 썸네일을 생성한다.
              makeThumbnailAndInsert(uploadDir, fileVO);
            } else {
              // 일반 게시판 파일 업로드인 경우...
              insertAtchfile(fileVO);
            }
            
             //System.out.println("uploadFile : " + uploadPath);
          }
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
  }


  /** 파일 업로드 처리 (폼 파일필드 컨트롤 사용) */
  @Override
  public List uploadProcFormfiles(HttpServletRequest request, String key_1, String key_2, int key_3,
      String fupgb) throws Exception {
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
        List<MultipartFile> files = multipartRequest.getFiles("file_upload");
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
          String uploadDirByDate = getUploadDirByDate();
          String uploadbase = EgovProperties.GLOBALS_FILEUPLOAD_PATH;

          // 컨텐츠관리에서 올라온 첨부파일은 한곳에 따로 모아 저장한다.
          String uploadDir = uploadbase;
          if (EgovProperties.CONTENTS_UPLOAD_KEY.equals(fileVO.getAtckey_1st())) {
            uploadDir += EgovProperties.CONTENTS_UPLOAD_DIR;
            fileVO.setFpath(EgovProperties.CONTENTS_UPLOAD_DIR);
          } else {
            uploadDir += uploadDirByDate;
            fileVO.setFpath(uploadDirByDate);
          }

          File dir = new File(uploadDir);
          if (!dir.exists()) {
            dir.mkdirs();
          }

          // 파일 확장자 구하기
          String file_ext =
              orgFileName.substring(orgFileName.lastIndexOf(".") + 1, orgFileName.length());
          file_ext = file_ext.toLowerCase();

          // 허용된 파일 이외에는 첨부할 수 없음
          if ("gif|jpg|png|bmp|zip|xls|xlsx|ppt|pptx|doc|docx|txt|hwp|pdf|sav|dta|sd2"
              .indexOf(file_ext) < 0) {
            throw new CmmnException("첨부할 수 없는 파일 형식입니다.");
          }

          // 변경할 파일명
          String saveFileName = generateSaveFileName(file_ext);

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

          if ("THM".equals(fupgb) && ("jpg".equals(file_ext) || "bmp".equals(file_ext)
              || "png".equals(file_ext) || "gif".equals(file_ext))) {
            // 이미지 게시판 업로드인 경우 첫번째 파일에 대한 썸네일을 생성한다.
            makeThumbnailAndInsert(uploadDir, fileVO);
          } else {
            // 일반 게시판 파일 업로드인 경우...
            insertAtchfile(fileVO);
          }
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
  public List uploadProcFormfiles(HttpServletRequest request, String key_1, String key_2, int key_3,
      String fupgb, String name) throws Exception {

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
        List<MultipartFile> files = multipartRequest.getFiles(name);
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

          // 기존 첨부파일 삭제
          deleteAtchFilePair(fileVO);

          String orgFileName = file.getOriginalFilename();
          long sizeInBytes = file.getSize();
          String uploadDirByDate = getUploadDirByDate();
          String uploadbase = EgovProperties.GLOBALS_FILEUPLOAD_PATH;

          // 컨텐츠관리에서 올라온 첨부파일은 한곳에 따로 모아 저장한다.
          String uploadDir = uploadbase;
          if (EgovProperties.CONTENTS_UPLOAD_KEY.equals(fileVO.getAtckey_1st())) {
            uploadDir += EgovProperties.CONTENTS_UPLOAD_DIR;
            fileVO.setFpath(EgovProperties.CONTENTS_UPLOAD_DIR);
          } else {
            uploadDir += uploadDirByDate;
            fileVO.setFpath(uploadDirByDate);
          }

          File dir = new File(uploadDir);
          if (!dir.exists()) {
            dir.mkdirs();
          }

          // 파일 확장자 구하기
          String file_ext =
              orgFileName.substring(orgFileName.lastIndexOf(".") + 1, orgFileName.length());
          file_ext = file_ext.toLowerCase();

          // 허용된 파일 이외에는 첨부할 수 없음
          if ("gif|jpg|png|bmp|zip|xls|xlsx|ppt|pptx|doc|docx|txt|hwp|pdf|sav|dta|sd2"
              .indexOf(file_ext) < 0) {
            throw new CmmnException("첨부할 수 없는 파일 형식입니다.");
          }

          // 변경할 파일명
          String saveFileName = generateSaveFileName(file_ext);

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

          if ("THM".equals(fupgb) && ("jpg".equals(file_ext) || "bmp".equals(file_ext)
              || "png".equals(file_ext) || "gif".equals(file_ext))) {
            // 이미지 게시판 업로드인 경우 첫번째 파일에 대한 썸네일을 생성한다.
            makeThumbnailAndInsert(uploadDir, fileVO);
          } else {
            // 일반 게시판 파일 업로드인 경우...
            insertAtchfile(fileVO);
          }
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

  /**
   * 파일정보를 기준으로 존재하는 파일을 삭제한다.
   * 
   * @param vo
   */
  private void deleteAtchFileOnDisk(AtchfileVO vo) throws Exception {
    String path = EgovProperties.GLOBALS_FILEUPLOAD_PATH + vo.getFpath() + "/" + vo.getFname();
    File dfile = new File(path);

    if (dfile.exists())
      dfile.delete();
  }

  /**
   * 이미지파일의 썸네일을 생성하고 DB에 파일정보를 insert한다.
   * 
   * @param uploadDir
   * @param vo
   * @throws Exception
   */
  private void makeThumbnailAndInsert(String uploadDir, AtchfileVO vo) throws Exception {
    AtchfileVO thmvo = new AtchfileVO();

    ParameterBlock pb = new ParameterBlock();
    pb.add(uploadDir + "/" + vo.getFname());
    RenderedOp rOp = JAI.create("fileload", pb);

    // 불러온 이미지를 BuffedImage에 담는다.
    BufferedImage bi = rOp.getAsBufferedImage();

    int img_h = bi.getHeight();
    int img_w = bi.getWidth();

    // 이미지 width와 height를 설정한다.
    vo.setImg_height(img_h);
    vo.setImg_width(img_w);

    // 이미지를 Insert 한다.
    // uploadify 를 이용해서 업로드를 할때는 atckey_4th 값이 주어져 있지 않으므로(0) insert 하고난 다음 생성된 atckey_4th의 값이 리턴된다.
    // uploadify를 이용하지 않고 form file input을 이용해 업로드하는 경우에는 atckey_4th 값이 주어져 있으므로 insert 할 이미지의 섬네일이
    // 생성되어있는지 여부가 리턴된다. (1이면 생성된 경우, 0이면 생성되지 경우)
    // 따라서 uploadify 업로드인경우 리턴값이 1일때 썸네일을 생성하고,
    // form file input 업로드인 경우 리턴값이 0일때 썸네일을 생성한다 !!
    int thumcnt = insertAtchfile(vo);


    // 썸네일 생성
    {

      int thm_w = 386;
      int thm_h = 236;


      // 가로가 세로보다 더 큰 경우 가로를 240으로 맞추고 가로세로 비율을 곱해준다.
      if (img_w > img_h) {
        thm_w = 386;
        //thm_h = Math.round(220 * ((float) img_h / img_w));
        thm_h = Math.round((float) img_h * thm_w / img_w);
      }

      // 세로가 가로보다 더 큰 경우 세로를 240으로 맞추고 가로세로 비율을 곱해준다.
      else {
        thm_h = 236;
        //thm_w = Math.round(310 * ((float) img_w / img_h));
        thm_w = Math.round((float) thm_h * img_w / img_h);
      }


      // 이미지 버퍼 생성, 버퍼의 사이즈는 120 * 120으로 설정.
      BufferedImage thumb = new BufferedImage(thm_w, thm_h, BufferedImage.TYPE_INT_RGB);

      // 버퍼사이즈 120 * 120 으로 맞춰 그린다
      Graphics2D g = thumb.createGraphics();
      g.drawImage(bi, 0, 0, thm_w, thm_h, null);

      String thumbname = generateSaveFileName("jpg");

      String thumbdir = uploadDir + "/thumb";
      File fthm = new File(thumbdir);

      if (!fthm.exists())
        fthm.mkdirs();


      /* 출력할 위치와 파일이름을 설정하고 섬네일 이미지를 생성한다. 저장하는 타입을 jpg로 설정. */
      File file = new File(fthm + "/" + thumbname);
      ImageIO.write(thumb, "jpg", file);

      thmvo.setAtckey_1st(vo.getAtckey_1st());
      thmvo.setAtckey_2nd(vo.getAtckey_2nd());
      thmvo.setAtckey_3rd(vo.getAtckey_3rd());
      thmvo.setAtckey_4th(thumcnt);
      thmvo.setFext("jpg");
      thmvo.setFname(thumbname);
      thmvo.setFpath(vo.getFpath() + "/thumb");
      thmvo.setRname(thumbname);
      thmvo.setIs_thumb("Y");


      // 이미지 width와 height를 설정한다.
      thmvo.setImg_height(thm_h);
      thmvo.setImg_width(thm_w);
      thmvo.setVchkcode(EgovWebUtil.generateIDString("", 12));

      insertAtchThumb(thmvo);
    }
  }



  /**
   * 일자에 따른 파일 저장 경로를 구함
   * 
   * @return
   */
  private static String getUploadDirByDate() {

    SimpleDateFormat sm = new SimpleDateFormat("/yyyy/MM");

    return sm.format(new Date());

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

  /**
   * 파일첨부정보 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public AtchfileVO selectAtchfileByFilename(AtchfileVO vo) throws Exception {
    // TODO Auto-generated method stub
    return atchfileDAO.selectAtchfileByFilename(vo);
  }

  @Override
  public int deleteAtchGrpfile(AtchfileVO vo) throws Exception {
    return atchfileDAO.deleteAtchGrpfile(vo);
  }

}
