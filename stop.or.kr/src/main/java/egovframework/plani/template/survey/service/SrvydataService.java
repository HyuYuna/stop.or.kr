package egovframework.plani.template.survey.service;

import java.util.List;
import egovframework.plani.template.survey.vo.SrvydataVO;

/**
 * 설문 데이터에 관한 CRUD를 처리한다
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.service] [SrvydataService.java]
 *
 */
public interface SrvydataService {

  /**
   * 설문 데이터 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public void insertSrvydata(SrvydataVO vo) throws Exception;

  /**
   * 설문 데이터 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSrvydata(SrvydataVO vo) throws Exception;

  /**
   * 설문 데이터 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSrvydata(SrvydataVO vo) throws Exception;

  /**
   * 설문 데이터 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return SrvydataVO
   * @exception Exception
   */
  public SrvydataVO selectSrvydata(SrvydataVO vo) throws Exception;

  /**
   * 설문 데이터 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectSrvydataList(SrvydataVO vo) throws Exception;

  /**
   * 설문 데이터 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectSrvydataListTotCnt(SrvydataVO vo) throws Exception;

  /**
   * 설문 데이터 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List xlsSrvydataList(SrvydataVO vo) throws Exception;

  /**
   * 설문 데이터 키값 생성.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectSrvydataKey(SrvydataVO vo) throws Exception;

  /**
   * 설문 주관식 답변 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectSrvydataCont(SrvydataVO vo) throws Exception;

  /**
   * IP, 설문 번호 기준으로 갯수 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectSrvydataDupCnt(SrvydataVO vo) throws Exception;

}
