package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.WithdrawalVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 회원탈퇴에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.dao] [WithdrawalDAO.java]
 *
 */

@Mapper
public interface WithdrawalDAO {

  /**
   * 탈퇴회원정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertWithdrawal(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateWithdrawal(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteWithdrawal(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보항목을 상세조회 한다.
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
   * 탈퇴회원정보목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectWithdrawalListTotCnt(WithdrawalVO vo) throws Exception;

  /**
   * 탈퇴회원정보 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List xlsWithdrawalList(WithdrawalVO vo) throws Exception;

}
