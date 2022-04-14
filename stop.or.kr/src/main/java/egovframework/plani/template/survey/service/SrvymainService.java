package egovframework.plani.template.survey.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import egovframework.plani.template.survey.vo.SrvymainVO;

/**
 * 설문 메인에 관한 CRUD를 처리한다
 * 
 * @class [ContextPath] [egovframework.plani.template.survey.service] [SrvymainService.java]
 *
 */
public interface SrvymainService {

  /**
   * 설문 메인 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @param request
   * @return Integer
   * @exception Exception
   */
  public Integer insertSrvymain(HttpServletRequest request, SrvymainVO vo) throws Exception;

  /**
   * 설문 메인 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @param request
   * @exception Exception
   */
  public void updateSrvymain(HttpServletRequest request, SrvymainVO vo) throws Exception;

  /**
   * 설문 메인 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSrvymain(SrvymainVO vo) throws Exception;

  /**
   * 설문 메인 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return SrvymainVO
   * @exception Exception
   */
  public SrvymainVO selectSrvymain(SrvymainVO vo) throws Exception;

  /**
   * 설문 메인 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectSrvymainList(SrvymainVO vo) throws Exception;

  /**
   * 설문 메인 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectSrvymainListTotCnt(SrvymainVO vo) throws Exception;

  /**
   * 설문 메인 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List xlsSrvymainList(SrvymainVO vo) throws Exception;

}
