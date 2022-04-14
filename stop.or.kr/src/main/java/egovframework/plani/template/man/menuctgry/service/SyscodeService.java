package egovframework.plani.template.man.menuctgry.service;

import java.util.List;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;

public interface SyscodeService {

  /**
   * 코드 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public int insertSyscode(SyscodeVO vo) throws Exception;

  /**
   * 코드 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSyscode(SyscodeVO vo) throws Exception;

  /**
   * 코드 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSyscode(SyscodeVO vo) throws Exception;

  /**
   * 코드 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public SyscodeVO selectSyscode(SyscodeVO vo) throws Exception;

  /**
   * 코드 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSyscodeList(SyscodeVO vo) throws Exception;

  /**
   * 코드 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectSyscodeListTotCnt(SyscodeVO vo) throws Exception;

  /**
   * 코드 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List xlsSyscodeList(SyscodeVO vo) throws Exception;

}
