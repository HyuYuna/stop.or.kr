package egovframework.plani.template.man.metsys.service;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.WithdrawalVO;

/**
 * 탈퇴회원정보에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.service] [WithdrawalService.java]
 *
 */
public interface WithdrawalService {

  /**
   * 탈퇴회원정보 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @param Integer
   * @exception Exception
   */
  public Integer insertWithdrawal(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateWithdrawal(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteWithdrawal(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return WithdrawalVO
   * @exception Exception
   */
  public WithdrawalVO selectWithdrawal(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectWithdrawalList(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectWithdrawalListTotCnt(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 엑셀다운 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List xlsWithdrawalList(WithdrawalVO vo) throws Exception;

}
