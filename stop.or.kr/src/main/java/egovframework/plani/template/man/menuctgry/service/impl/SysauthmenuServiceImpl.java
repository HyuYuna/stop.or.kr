package egovframework.plani.template.man.menuctgry.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.menuctgry.dao.SysauthmenuDAO;
import egovframework.plani.template.man.menuctgry.service.SysauthmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("sysauthmenuService")
public class SysauthmenuServiceImpl extends EgovAbstractServiceImpl implements SysauthmenuService {

  /** SysauthmenuDAO */
  @Resource(name = "sysauthmenuDAO")
  private SysauthmenuDAO sysauthmenuDAO;

  /**
   * 권한별 메뉴 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer insertSysauthmenu(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthmenuDAO.insertSysauthmenu(vo);
  }

  /**
   * 권한별 메뉴 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateSysauthmenu(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    sysauthmenuDAO.updateSysauthmenu(vo);
  }

  /**
   * 권한별 메뉴 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSysauthmenuByAuthcd(SysauthVO vo) throws Exception {
    // TODO Auto-generated method stub
    sysauthmenuDAO.deleteSysauthmenuByAuthcd(vo);
  }

  /**
   * 권한별 메뉴 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSysauthmenuByMenuidx(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    sysauthmenuDAO.deleteSysauthmenuByMenuidx(vo);
  }

  /**
   * 권한별 메뉴 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public SysmenuVO selectSysauthmenu(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthmenuDAO.selectSysauthmenu(vo);
  }

  /**
   * 권한별 메뉴 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectSysauthmenuList(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthmenuDAO.selectSysauthmenuList(vo);
  }

  /**
   * 권한별 메뉴목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectSysauthmenuListTotCnt(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthmenuDAO.selectSysauthmenuListTotCnt(vo);
  }

  /**
   * 권한별 메뉴 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List xlsSysauthmenuList(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthmenuDAO.xlsSysauthmenuList(vo);
  }

}

