package egovframework.plani.template.man.log.service.impl;

import java.sql.SQLException;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.IpInfoDbClient;
import egovframework.plani.template.man.log.dao.ManlogDAO;
import egovframework.plani.template.man.log.service.ManlogService;
import egovframework.plani.template.man.log.vo.ManlogVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("manlogService")
public class ManlogServiceImpl extends EgovAbstractServiceImpl implements ManlogService {

  /** ManlogDAO */
  @Resource(name = "manlogDAO")
  private ManlogDAO manlogDAO;

  private IpInfoDbClient ipInfoDbClient = null;

  public ManlogServiceImpl() {
    ipInfoDbClient = new IpInfoDbClient();
  }

  /**
   * 관리자로그 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void insertManlog(HttpServletRequest request, String log_key, String log_key_nm,
      String log_key_dest, String log_job_gb) throws Exception {
    // TODO Auto-generated method stub

    ManlogVO vo = new ManlogVO();

    try {
      vo.setLog_uid((String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_ID"));

      if ("planidev".equals(vo.getLog_uid()) == false) {
        vo.setLog_key(log_key);
        vo.setLog_key_nm(log_key_nm);
        vo.setLog_key_dest(log_key_dest);
        vo.setLog_job_gb(log_job_gb);
        String ip = EgovWebUtil.getRemoteAddr(request);
        ipInfoDbClient.getIpInfoDb(ip);
        vo.setLog_raddr(EgovFileScrty.encode(ip));

        // 120초 이내에 동일한 "목록"이나 "상세내용"을 조회한 기록이 있으면 재기록 하지 않는다.
        // ex) 목록 -> 상세보기 -> 목록일 경우 중복기록되는 문제
        // ex) 페이징처리된 목록의 페이지를 클릭해도 중복기록되는 문제
        if ("L".equals(log_job_gb) || "R".equals(log_job_gb)) {
          int cnt = manlogDAO.selectManlogSearchKind(vo);
          if (cnt == 0)
            manlogDAO.insertManlog(vo);
        } else
          manlogDAO.insertManlog(vo);
      }


    } catch (SQLException se) {
      se.printStackTrace();
    } catch (Exception e) {
      e.printStackTrace();
    }

  }

  /**
   * 관리자로그 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateManlog(ManlogVO vo) throws Exception {
    // TODO Auto-generated method stub
    manlogDAO.updateManlog(vo);
  }

  /**
   * 관리자로그 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteManlog(ManlogVO vo) throws Exception {
    // TODO Auto-generated method stub
    manlogDAO.deleteManlog(vo);
  }

  /**
   * 관리자로그 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public ManlogVO selectManlog(ManlogVO vo) throws Exception {
    // TODO Auto-generated method stub
    return manlogDAO.selectManlog(vo);
  }

  /**
   * 관리자로그 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectManlogList(ManlogVO vo) throws Exception {
    // TODO Auto-generated method stub
    return manlogDAO.selectManlogList(vo);
  }

  /**
   * 관리자로그목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectManlogListTotCnt(ManlogVO vo) throws Exception {
    // TODO Auto-generated method stub
    return manlogDAO.selectManlogListTotCnt(vo);
  }

  /**
   * 관리자로그 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List xlsManlogList(ManlogVO vo) throws Exception {
    // TODO Auto-generated method stub
    return manlogDAO.xlsManlogList(vo);
  }

}

