package egovframework.plani.template.man.stat.service.impl;

import java.sql.SQLException;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.IpInfoDbClient;
import egovframework.plani.template.man.stat.dao.CommstatDAO;
import egovframework.plani.template.man.stat.service.CommstatService;
import egovframework.plani.template.man.stat.vo.CommstatVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 통계에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.stat.service.impl]
 *        [CommstatServiceImpl.java]
 *
 */
@Service("commstatService")
public class CommstatServiceImpl extends EgovAbstractServiceImpl implements CommstatService {

  /** CommstatDAO */
  @Resource(name = "commstatDAO")
  private CommstatDAO commstatDAO;

  private IpInfoDbClient ipInfoDbClient = null;

  public CommstatServiceImpl() {
    ipInfoDbClient = new IpInfoDbClient();
  }

  /**
   * 일반 통계데이터을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void insertCommstat(HttpServletRequest request, String stat_key, String stat_key_nm,
      String referer) {
    // TODO Auto-generated method stub

    CommstatVO vo = new CommstatVO();

    try {

      vo.setStat_key(stat_key);
      vo.setStat_sessid((String) EgovSessionCookieUtil
          .getSessionAttribute(request, "SESS_STAT_KEY"));

      // MAIN인 경우 같은 세션에서 이미 기록된 통계는 CONTACT_CNT을 수정한다.
      int cnt = commstatDAO.selectCommstatCnt(vo);
      if (cnt == 0) {
        vo.setStat_uid((String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID"));
        vo.setStat_key_nm(stat_key_nm);
        String ip = EgovWebUtil.getRemoteAddr(request);
        ipInfoDbClient.getIpInfoDb(ip);

        vo.setStat_bw(EgovWebUtil.getRemoteBrowser(request));
        vo.setStat_os(EgovWebUtil.getRemoteOS(request));
        vo.setStat_referer(referer);
        vo.setStat_raddr(EgovFileScrty.encode(ip));

        vo.setStat_city(ipInfoDbClient.getCityName());
        vo.setStat_nat(ipInfoDbClient.getCountryName());
        vo.setStat_nat_cd(ipInfoDbClient.getCountryCode());
        commstatDAO.insertCommstat(vo);
      } else {
        commstatDAO.updateCommstatContactCnt(vo);
      }
    } catch (SQLException se) {
      se.printStackTrace();
    } catch (Exception e) {
      e.printStackTrace();
    }

  }

  /**
   * 국가별 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatCountry(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatCountry(vo);
  }

  /**
   * 도시별 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatCity(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatCity(vo);
  }

  /**
   * OS별 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatOS(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatOS(vo);
  }

  /**
   * 브라우저별 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatBrowser(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatBrowser(vo);
  }

  /**
   * 시간별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatVisitHourly(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatVisitHourly(vo);
  }

  /**
   * 날짜별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatVisitDaily(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatVisitDaily(vo);
  }

  /**
   * 월별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatVisitMonthly(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatVisitMonthly(vo);
  }

  /**
   * 연도별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatVisitYearly(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatVisitYearly(vo);
  }


  /**
   * 로그 현황목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectCommstatList(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.selectCommstatList(vo);
  }


  /**
   * 로그 현황목록 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectCommstatListTotCnt(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.selectCommstatListTotCnt(vo);
  }

  /**
   * 로그 현황목록을 조회한다. (엑셀저장용)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List xlsCommstatList(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.xlsCommstatList(vo);
  }

  /**
   * 총 접속 횟수 조회(일단위 검색)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CommstatVO
   * @exception Exception
   */
  @Override
  public CommstatVO viewstatVisitDailyTotCnt(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatVisitDailyTotCnt(vo);
  }

  /**
   * 총 접속 횟수 조회(월단위 검색)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CommstatVO
   * @exception Exception
   */
  @Override
  public CommstatVO viewstatVisitMonthlyTotCnt(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatVisitMonthlyTotCnt(vo);
  }

  /**
   * 총 접속 횟수 조회(년단위 검색)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CommstatVO
   * @exception Exception
   */
  @Override
  public CommstatVO viewstatVisitYearlyTotCnt(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatVisitYearlyTotCnt(vo);
  }


  /**
   * 페이지별 접속 통계 데이터를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List viewstatVisitPage(CommstatVO vo) throws Exception {
    // TODO Auto-generated method stub
    return commstatDAO.viewstatVisitPage(vo);
  }
}
