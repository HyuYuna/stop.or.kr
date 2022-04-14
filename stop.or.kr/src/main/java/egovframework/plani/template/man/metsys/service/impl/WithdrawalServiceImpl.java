package egovframework.plani.template.man.metsys.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.metsys.dao.WithdrawalDAO;
import egovframework.plani.template.man.metsys.service.WithdrawalService;
import egovframework.plani.template.man.metsys.vo.WithdrawalVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 회원 탈퇴에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.service.impl]
 *        [WithdrawalServiceImpl.java]
 *
 */
@Service("withdrawalService")
public class WithdrawalServiceImpl extends EgovAbstractServiceImpl implements WithdrawalService {

  /** WithdrawalDAO */
  @Resource(name = "withdrawalDAO")
  private WithdrawalDAO withdrawalDAO;

  /**
   * 탈퇴회원정보 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  @Override
  public Integer insertWithdrawal(WithdrawalVO vo) throws Exception {
    // TODO Auto-generated method stub
    return withdrawalDAO.insertWithdrawal(vo);
  }

  /**
   * 탈퇴회원정보 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateWithdrawal(WithdrawalVO vo) throws Exception {
    // TODO Auto-generated method stub
    withdrawalDAO.updateWithdrawal(vo);
  }

  /**
   * 탈퇴회원정보 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteWithdrawal(WithdrawalVO vo) throws Exception {
    // TODO Auto-generated method stub
    withdrawalDAO.deleteWithdrawal(vo);
  }

  /**
   * 탈퇴회원정보 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return WithdrawalVO
   * @exception Exception
   */
  @Override
  public WithdrawalVO selectWithdrawal(WithdrawalVO vo) throws Exception {
    // TODO Auto-generated method stub
    return withdrawalDAO.selectWithdrawal(vo);
  }

  /**
   * 탈퇴회원정보 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectWithdrawalList(WithdrawalVO vo) throws Exception {
    // TODO Auto-generated method stub
    return withdrawalDAO.selectWithdrawalList(vo);
  }

  /**
   * 탈퇴회원정보목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectWithdrawalListTotCnt(WithdrawalVO vo) throws Exception {
    // TODO Auto-generated method stub
    return withdrawalDAO.selectWithdrawalListTotCnt(vo);
  }

  /**
   * 탈퇴회원정보 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List xlsWithdrawalList(WithdrawalVO vo) throws Exception {
    // TODO Auto-generated method stub
    return withdrawalDAO.xlsWithdrawalList(vo);
  }

}
