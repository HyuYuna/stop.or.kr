package egovframework.plani.template.release.service;

import java.util.List;
import egovframework.plani.template.release.vo.ReleaseVO;

/**
 * 정보공개목록에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath]
 *
 */
public interface ReleaseService {

  /**
   * 정보공개데이터을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertRelease(ReleaseVO vo) throws Exception;

  /**
   * 정보공개데이터을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateRelease(ReleaseVO vo) throws Exception;

  /**
   * 정보공개데이터을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteRelease(ReleaseVO vo) throws Exception;

  /**
   * 정보공개데이터 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ReleaseVO
   * @exception Exception
   */
  public ReleaseVO selectRelease(ReleaseVO vo) throws Exception;


  /**
   * 정보공개데이터 항목을(공지) 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ReleaseVO
   * @exception Exception
   */
  public List selectNoticeReleaseList(ReleaseVO vo) throws Exception;



  /**
   * 정보공개데이터 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectReleaseList(ReleaseVO vo) throws Exception;

  /**
   * 정보공개데이터 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectReleaseListTotCnt(ReleaseVO vo) throws Exception;

}
