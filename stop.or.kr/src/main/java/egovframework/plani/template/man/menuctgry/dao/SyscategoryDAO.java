package egovframework.plani.template.man.menuctgry.dao;

import java.util.List;
import egovframework.plani.template.man.menuctgry.vo.SyscategoryVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface SyscategoryDAO {

  /**
   * 시스템 카테고리을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public int insertSyscategory(SyscategoryVO vo) throws Exception;

  /**
   * 시스템 카테고리을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSyscategory(SyscategoryVO vo) throws Exception;

  /**
   * 시스템 카테고리 순서 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSyscategoryOrderP(SyscategoryVO vo) throws Exception;

  /**
   * 시스템 카테고리 순서 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSyscategoryOrderM(SyscategoryVO vo) throws Exception;

  /**
   * 시스템 카테고리을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSyscategory(SyscategoryVO vo) throws Exception;

  /**
   * 시스템 카테고리항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public SyscategoryVO selectSyscategory(SyscategoryVO vo) throws Exception;

  /**
   * 시스템 카테고리 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSyscategoryList(SyscategoryVO vo) throws Exception;

  /**
   * 시스템 카테고리목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectSyscategoryListTotCnt(SyscategoryVO vo) throws Exception;

}
