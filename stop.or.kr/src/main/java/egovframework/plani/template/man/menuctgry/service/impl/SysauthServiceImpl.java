package egovframework.plani.template.man.menuctgry.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.menuctgry.dao.SysauthDAO;
import egovframework.plani.template.man.menuctgry.service.SysauthService;
import egovframework.plani.template.man.menuctgry.service.SysauthmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("sysauthService")
public class SysauthServiceImpl extends EgovAbstractServiceImpl implements SysauthService {

  /** SysauthDAO */
  @Resource(name = "sysauthDAO")
  private SysauthDAO sysauthDAO;

  /** SysauthmenuService */
  @Resource(name = "sysauthmenuService")
  private SysauthmenuService sysauthmenuService;

  /**
   * 시스템 권한 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int insertSysauth(SysauthVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 새로운 auth_lv 를 설정하기 위해 상위 권한그룹의 auth_lv 값이 필요하다.
    // 새로 추가되는 권한의 auth_lv은 같은 권한그룹내의 max(auth_lv) + 1 이다.
    // 다만 같은 권한그룹내에 추가된 권한이 없을때는 상위 권한그룹의 auth_lv 값에 +1 한다.
    SysauthVO upauth = new SysauthVO();
    upauth.setAuth_cd(vo.getUp_auth_cd());
    upauth = sysauthDAO.selectSysauth(upauth);

    vo.setAuth_lv(upauth.getAuth_lv());
    return sysauthDAO.insertSysauth(vo);
  }

  /**
   * 시스템 권한 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateSysauth(SysauthVO vo) throws Exception {
    // TODO Auto-generated method stub
    sysauthDAO.updateSysauth(vo);
  }

  /**
   * 시스템 권한 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSysauth(SysauthVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 권한이 삭제될때 메뉴권한도 같이 삭제한다.
    sysauthmenuService.deleteSysauthmenuByAuthcd(vo);

    sysauthDAO.deleteSysauth(vo);
  }

  /**
   * 시스템 권한 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public SysauthVO selectSysauth(SysauthVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthDAO.selectSysauth(vo);
  }

  /**
   * 시스템 권한 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectSysauthList(SysauthVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthDAO.selectSysauthList(vo);
  }


  /**
   * 시스템 권한목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectSysauthListTotCnt(SysauthVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthDAO.selectSysauthListTotCnt(vo);
  }


  /**
   * 시스템 권한 상위목록(권한그룹)을 제외한 하위목록만 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectSysauthSubList() throws Exception {
    // TODO Auto-generated method stub
    return sysauthDAO.selectSysauthSubList();
  }

  /**
   * 시스템 권한 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List xlsSysauthList(SysauthVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysauthDAO.xlsSysauthList(vo);
  }

}
