package egovframework.plani.template.man.metsys.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.man.metsys.dao.AccessipDAO;
import egovframework.plani.template.man.metsys.service.AccessipService;
import egovframework.plani.template.man.metsys.vo.AccessipVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * IP관리에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.service.impl]
 *        [AccessipServiceImpl.java]
 *
 */
@Service("accessipService")
public class AccessipServiceImpl extends EgovAbstractServiceImpl implements AccessipService {

  /** AccessipDAO */
  @Resource(name = "accessipDAO")
  private AccessipDAO accessipDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 관리자 접근 IP 제한 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  @Override
  public Integer insertAccessip(AccessipVO vo) throws Exception {
    // TODO Auto-generated method stub
    return accessipDAO.insertAccessip(vo);
  }

  /**
   * 관리자 접근 IP 제한 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateAccessip(AccessipVO vo) throws Exception {
    // TODO Auto-generated method stub
    accessipDAO.updateAccessip(vo);
  }

  /**
   * 관리자 접근 IP 제한 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteAccessip(AccessipVO vo) throws Exception {
    // TODO Auto-generated method stub

    /*
     * // 첨부파일이 있는 경우 첨부파일을 모두 삭제하기.. AtchfileVO fileVO = new AtchfileVO();
     * fileVO.setAtckey_1st("BBB"); fileVO.setAtckey_2nd(new Integer(vo.get~~~).toString());
     * fileVO.setAtckey_3rd(1); atchfileService.deleteAtchfiles(fileVO);
     */

    accessipDAO.deleteAccessip(vo);
  }

  /**
   * 관리자 접근 IP 제한 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return AccessipVO
   * @exception Exception
   */
  @Override
  public AccessipVO selectAccessip(AccessipVO vo) throws Exception {
    // TODO Auto-generated method stub
    return accessipDAO.selectAccessip(vo);
  }

  /**
   * 관리자 접근 IP 제한 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectAccessipList(AccessipVO vo) throws Exception {
    // TODO Auto-generated method stub
    return accessipDAO.selectAccessipList(vo);
  }

  /**
   * 관리자 접근 IP 제한목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectAccessipListTotCnt(AccessipVO vo) throws Exception {
    // TODO Auto-generated method stub
    return accessipDAO.selectAccessipListTotCnt(vo);
  }

  /**
   * 관리자 접근 IP 제한 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 엑셀다운 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List xlsAccessipList(AccessipVO vo) throws Exception {
    // TODO Auto-generated method stub
    return accessipDAO.xlsAccessipList(vo);
  }

}
