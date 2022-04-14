package egovframework.plani.template.multicms.dao;

import java.util.List;
import egovframework.plani.template.multicms.vo.MultiCmsVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 게시물목록데이터에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath]
 *
 */
@Mapper
public interface MultiCmsDAO {

  /**
   * 게시물목록데이터을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertMultiCms(MultiCmsVO vo) throws Exception;

  /**
   * 게시물목록데이터을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer updateMultiCms(MultiCmsVO vo) throws Exception;

  /**
   * 게시물목록데이터을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer deleteMultiCms(MultiCmsVO vo) throws Exception;

  /**
   * 게시물목록데이터항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ReleaseDAO
   * @exception Exception
   */
  public MultiCmsVO selectMultiCms(MultiCmsVO vo) throws Exception;


  /**
   * 게시물목록데이터 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectMultiCmsList(MultiCmsVO vo) throws Exception;

  /**
   * 게시물목록데이터목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectMultiCmsListTotCnt(MultiCmsVO vo) throws Exception;


}
