package egovframework.plani.template.man.stat.service;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import egovframework.plani.template.man.stat.vo.CommstatVO;

/**
 * 통계에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.stat.service] [CommstatService.java]
 *
 */
public interface CommstatService {

  /**
   * 일반 통계데이터을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public void insertCommstat(HttpServletRequest request, String stat_key, String stat_key_nm,
      String referer);

  /**
   * 국가별 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatCountry(CommstatVO vo) throws Exception;

  /**
   * 도시별 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatCity(CommstatVO vo) throws Exception;

  /**
   * OS별 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatOS(CommstatVO vo) throws Exception;

  /**
   * 브라우저별 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatBrowser(CommstatVO vo) throws Exception;

  /**
   * 시간별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatVisitHourly(CommstatVO vo) throws Exception;

  /**
   * 날짜별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatVisitDaily(CommstatVO vo) throws Exception;

  /**
   * 월별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatVisitMonthly(CommstatVO vo) throws Exception;

  /**
   * 연도별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatVisitYearly(CommstatVO vo) throws Exception;

  /**
   * 로그 현황목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectCommstatList(CommstatVO vo) throws Exception;


  /**
   * 로그 현황목록 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectCommstatListTotCnt(CommstatVO vo) throws Exception;

  /**
   * 로그 현황목록을 조회한다. (엑셀저장용)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List xlsCommstatList(CommstatVO vo) throws Exception;

  /**
   * 총 접속 횟수 조회(일단위 검색)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CommstatVO
   * @exception Exception
   */
  public CommstatVO viewstatVisitDailyTotCnt(CommstatVO vo) throws Exception;

  /**
   * 총 접속 횟수 조회(월단위 검색)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CommstatVO
   * @exception Exception
   */
  public CommstatVO viewstatVisitMonthlyTotCnt(CommstatVO vo) throws Exception;

  /**
   * 총 접속 횟수 조회(년단위 검색)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CommstatVO
   * @exception Exception
   */
  public CommstatVO viewstatVisitYearlyTotCnt(CommstatVO vo) throws Exception;



  /**
   * 페이지별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List viewstatVisitPage(CommstatVO vo) throws Exception;


}
