package egovframework.plani.template.survey.dao;


import java.util.List;
import egovframework.plani.template.survey.vo.SrvypartVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 설문 파트에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.dao] [SrvypartDAO.java]
 *
 */
@Mapper
public interface SrvypartDAO {

  /**
   * 설문 파트을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer mergeSrvypart(SrvypartVO vo) throws Exception;

  /**
   * 설문 파트을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertSrvypart(SrvypartVO vo) throws Exception;

  /**
   * 설문 파트을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSrvypart(SrvypartVO vo) throws Exception;

  /**
   * 설문 파트을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSrvypart(SrvypartVO vo) throws Exception;

  /**
   * 설문 파트항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return SrvypartVO
   * @exception Exception
   */
  public SrvypartVO selectSrvypart(SrvypartVO vo) throws Exception;

  /**
   * 설문 파트 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectSrvypartList(SrvypartVO vo) throws Exception;

  /**
   * 설문 챕터목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectSrvypartListTotCnt(SrvypartVO vo) throws Exception;

  /**
   * 설문 파트 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List xlsSrvypartList(SrvypartVO vo) throws Exception;

}
