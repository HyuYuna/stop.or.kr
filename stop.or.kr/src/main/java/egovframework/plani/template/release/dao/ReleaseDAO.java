package egovframework.plani.template.release.dao;

import java.util.List;
import egovframework.plani.template.release.vo.ReleaseVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 정보공개목록데이터에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath]
 *
 */
@Mapper
public interface ReleaseDAO {

  /**
   * 정보공개목록데이터을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertRelease(ReleaseVO vo) throws Exception;

  /**
   * 정보공개목록데이터을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer updateRelease(ReleaseVO vo) throws Exception;

  /**
   * 정보공개목록데이터을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer deleteRelease(ReleaseVO vo) throws Exception;

  /**
   * 정보공개목록데이터항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ReleaseDAO
   * @exception Exception
   */
  public ReleaseVO selectRelease(ReleaseVO vo) throws Exception;


  /**
   * 정보공개목록데이터항목을(공지) 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ReleaseDAO
   * @exception Exception
   */
  public List selectNoticeReleaseList(ReleaseVO vo) throws Exception;



  /**
   * 정보공개목록데이터 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectReleaseList(ReleaseVO vo) throws Exception;

  /**
   * 정보공개목록데이터목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectReleaseListTotCnt(ReleaseVO vo) throws Exception;


}
