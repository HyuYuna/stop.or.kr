package egovframework.plani.template.survey.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import egovframework.plani.template.survey.vo.SrvyquesansVO;

/**
 * 설문 질문/답변에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.service] [SrvyquesansService.java]
 *
 */

public interface SrvyquesansService {

  /**
   * 설문 질문 / 답변 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public void mergeSrvyquesans(HttpServletRequest request, SrvyquesansVO vo) throws Exception;


  /**
   * 설문 질문 / 답변 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSrvyquesans(SrvyquesansVO vo) throws Exception;


  /**
   * 설문 질문 / 답변 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSrvyquesansGroup(SrvyquesansVO vo) throws Exception;

  /**
   * 설문 질문 / 답변 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return SrvyquesansVO
   * @exception Exception
   */
  public SrvyquesansVO selectSrvyquesans(SrvyquesansVO vo) throws Exception;

  /**
   * 설문 질문 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectSrvyquesList(SrvyquesansVO vo) throws Exception;

  /**
   * 설문 질문 / 답변 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectSrvyquesansList(SrvyquesansVO vo) throws Exception;

  /**
   * 설문 질문 / 답변 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectSrvyquesansListTotCnt(SrvyquesansVO vo) throws Exception;

  /**
   * 설문 질문 / 답변 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List xlsSrvyquesansList(SrvyquesansVO vo) throws Exception;


  /**
   * 설문 결과를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectSrvyquesansResult(SrvyquesansVO vo) throws Exception;


  /**
   * 설문 질문 / 답변 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectXlsSrvyquesansList(SrvyquesansVO vo);
}
