package egovframework.plani.template.atchfile.dao;

import java.util.List;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AtchfileDAO {

  /**
   * 파일첨부정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertAtchfile(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertAtchfileDrct(AtchfileVO vo) throws Exception;

  /**
   * 썸네일 첨부정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertAtchThumb(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer deleteBoardAtchfiles(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public int deleteAtchOnefile(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 을/를 삭제한다. (vchkcode 사용)
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public int deleteAtchOnefileByVchkcode(AtchfileVO vo) throws Exception;


  /**
   * 파일첨부정보 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public AtchfileVO selectAtchfile(AtchfileVO vo) throws Exception;


  /**
   * 파일첨부정보 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectAtchfilePair(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 항목을 상세조회 한다. (vchkcode로 조회)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public AtchfileVO selectAtchfileByVchkcode(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 항목을 상세조회 한다.
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
   * 파일첨부정보 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectAtchfileListWithThumb(AtchfileVO vo) throws Exception;

  /**
   * 파일첨부정보 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectAtchfileListTotCnt(AtchfileVO vo) throws Exception;


  /**
   * 파일첨부정보 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectAtchfileThmCnt(AtchfileVO vo) throws Exception;

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

  /**
   * 첨부파일 그룹 삭제
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public int deleteAtchGrpfile(AtchfileVO vo) throws Exception;
}

