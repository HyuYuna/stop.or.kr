/**
 * 
 */
package egovframework.plani.template.cmm.dao;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import com.ibatis.sqlmap.client.SqlMapClient;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * EgovComAbstractDAO.java 클래스
 * 
 * @author 서준식
 * @since 2011. 9. 23.
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 23.   서준식        최초 생성
 *      </pre>
 */
public abstract class EgovComAbstractDAO extends EgovAbstractDAO {

  Logger log = Logger.getLogger(this.getClass().getName());

  public EgovComAbstractDAO() {
    log.setLevel(Level.ALL);
  }

  @Resource(name = "egov.sqlMapClient")
  public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
    super.setSuperSqlMapClient(sqlMapClient);
  }


  /**
   * 입력 처리 SQL mapping 을 실행한다.
   * 
   * @param queryId - 입력 처리 SQL mapping 쿼리 ID
   * @param parameterObject - 입력 처리 SQL mapping 입력 데이터를 세팅한 파라메터 객체(보통 VO 또는 Map)
   * @return 입력 시 selectKey 를 사용하여 key 를 딴 경우 해당 key
   */
  @Override
  public Object insert(String queryId, Object parameterObject) {
    // log.log(Level.INFO, "################################ Sqlmap ID : " + queryId);
    return super.insert(queryId, parameterObject);
  }

  /**
   * 수정 처리 SQL mapping 을 실행한다.
   * 
   * @param queryId - 수정 처리 SQL mapping 쿼리 ID
   * @param parameterObject - 수정 처리 SQL mapping 입력 데이터(key 조건 및 변경 데이터)를 세팅한 파라메터 객체(보통 VO 또는 Map)
   * @return DBMS가 지원하는 경우 update 적용 결과 count
   */
  @Override
  public int update(String queryId, Object parameterObject) {
    // log.log(Level.INFO, "################################ Sqlmap ID : " + queryId);
    return super.update(queryId, parameterObject);
  }

  /**
   * 삭제 처리 SQL mapping 을 실행한다.
   * 
   * @param queryId - 삭제 처리 SQL mapping 쿼리 ID
   * @param parameterObject - 삭제 처리 SQL mapping 입력 데이터(일반적으로 key 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
   * @return DBMS가 지원하는 경우 delete 적용 결과 count
   */
  @Override
  public int delete(String queryId, Object parameterObject) {
    // log.log(Level.INFO, "################################ Sqlmap ID : " + queryId);
    return super.delete(queryId, parameterObject);
  }

  /**
   * pk 를 조건으로 한 단건조회 처리 SQL mapping 을 실행한다.
   * 
   * @param queryId - 단건 조회 처리 SQL mapping 쿼리 ID
   * @param parameterObject - 단건 조회 처리 SQL mapping 입력 데이터(key)를 세팅한 파라메터 객체(보통 VO 또는 Map)
   * @return 결과 객체 - SQL mapping 파일에서 지정한 resultClass/resultMap 에 의한 단일 결과 객체(보통 VO 또는 Map)
   */
  @Override
  public Object selectByPk(String queryId, Object parameterObject) {
    // log.log(Level.INFO, "################################ Sqlmap ID : " + queryId);
    return super.selectByPk(queryId, parameterObject);
  }

  /**
   * 리스트 조회 처리 SQL mapping 을 실행한다.
   * 
   * @param queryId - 리스트 조회 처리 SQL mapping 쿼리 ID
   * @param parameterObject - 리스트 조회 처리 SQL mapping 입력 데이터(조회 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
   * @return 결과 List 객체 - SQL mapping 파일에서 지정한 resultClass/resultMap 에 의한 결과 객체(보통 VO 또는 Map)의 List
   */
  @Override
  @SuppressWarnings("unchecked")
  public List list(String queryId, Object parameterObject) {
    // log.log(Level.INFO, "################################ Sqlmap ID : " + queryId);
    return super.list(queryId, parameterObject);
  }

  /**
   * 부분 범위 리스트 조회 처리 SQL mapping 을 실행한다. (부분 범위 - pageIndex 와 pageSize 기반으로 현재 부분 범위 조회를 위한
   * skipResults, maxResults 를 계산하여 ibatis 호출)
   * 
   * @param queryId - 리스트 조회 처리 SQL mapping 쿼리 ID
   * @param parameterObject - 리스트 조회 처리 SQL mapping 입력 데이터(조회 조건)를 세팅한 파라메터 객체(보통 VO 또는 Map)
   * @param pageIndex - 현재 페이지 번호
   * @param pageSize - 한 페이지 조회 수(pageSize)
   * @return 부분 범위 결과 List 객체 - SQL mapping 파일에서 지정한 resultClass/resultMap 에 의한 부분 범위 결과 객체(보통 VO 또는
   *         Map) List
   */
  @Override
  @SuppressWarnings("unchecked")
  public List listWithPaging(String queryId, Object parameterObject, int pageIndex, int pageSize) {
    // log.log(Level.INFO, "################################ Sqlmap ID : " + queryId);
    return super.listWithPaging(queryId, parameterObject, pageIndex, pageSize);
  }

}
