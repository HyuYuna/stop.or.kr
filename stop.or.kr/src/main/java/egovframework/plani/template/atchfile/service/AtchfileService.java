package egovframework.plani.template.atchfile.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import egovframework.plani.template.atchfile.vo.AtchfileVO;

/**
 * 첨부파일 서비스
 * 
 * @author 플랜아이
 */

public interface AtchfileService {

  /**
   * 파일첨부정보 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertAtchfile(AtchfileVO vo) throws Exception;

  /**
   * 썸네일첨부정보 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public void insertAtchThumb(AtchfileVO vo) throws Exception;

  /**
   * 첨부파일 을/를 삭제한다.(하나만 삭제; 썸네일이 있을 경우 썸네일과 함께 삭제한다.)
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteAtchFilePair(AtchfileVO vo) throws Exception;

  /**
   * 첨부파일 을/를 삭제한다.(한 게시판에 포함된 파일들을 모두 삭제한다.)
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoardAtchfiles(AtchfileVO vo) throws Exception;


  /**
   * 첨부파일 을/를 삭제한다.(한 게시물에 포함된 파일들을 모두 삭제한다.)
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteAtchfiles(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public AtchfileVO selectAtchfile(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public AtchfileVO selectAtchfileByFilename(AtchfileVO vo) throws Exception;


  /**
   * 파일첨부정보 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectAtchfileList(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectAtchfileListTotCnt(AtchfileVO vo) throws Exception;

  /**
   * 관리자가 컨텐츠관리등에서 사용할 목적으로 첨부파일관리에서 첨부한 파일을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectCustomAtchfileList(AtchfileVO vo) throws Exception;


  /**
   * 관리자가 컨텐츠관리등에서 사용할 목적으로 첨부파일관리에서 첨부한 파일목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectCustomAtchfileListTotCnt(AtchfileVO vo) throws Exception;

  /**
   * 관리자가 컨텐츠관리등에서 사용할 목적으로 첨부파일관리에서 첨부를 하기 위한 키값을 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectMaxAtchkey2nd(AtchfileVO vo) throws Exception;

  /** Uploadify를 이용한 파일 업로드 처리 */
  public void uploadProc(HttpServletRequest request) throws Exception;

  /** (폼 파일 컨트롤 사용) 이용한 파일 업로드 처리 */
  public List uploadProcFormfiles(HttpServletRequest request, String key_1, String key_2, int key_3,
      String fupgb) throws Exception;

  public List uploadProcFormfiles(HttpServletRequest request, String key_1, String key_2, int key_3,
      String fupgb, String name) throws Exception;


  /**
   * 컨텐츠 등록시 이전버전의 첨부파일을 카피해서 새로운 버전을 만든다.
   * 
   * @param old_ - 이전버전의 첨부파일 조회 조건이 담긴 VO
   * @param new_cont_idx - 카피할 cont_idx
   * @throws Exception
   */
  public void insertAndCopyfiles(AtchfileVO old_, int new_cont_idx) throws Exception;

  /**
   * 파일첨부정보 항목을 상세조회 한다. (vchkcode로 조회)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public AtchfileVO selectAtchfileByVchkcode(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 을/를 삭제한다. (vchkcode 사용)
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteAtchOnefileByVchkcode(AtchfileVO vo) throws Exception;

  /**
   * 첨부파일 그룹 삭제
   * 
   * @param vo
   * @throws Exception
   */
  public int deleteAtchGrpfile(AtchfileVO vo) throws Exception;
}

