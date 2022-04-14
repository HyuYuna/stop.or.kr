package egovframework.plani.template.man.menuctgry.service;

import java.util.List;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

public interface SysmenuService {

  /**
   * 시스템 메뉴을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public String insertSysmenu(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSysmenu(SysmenuVO vo) throws Exception;


  /**
   * 시스템 메뉴을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSysmenu(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public SysmenuVO selectSysmenu(SysmenuVO vo) throws Exception;

  /**
   * 특정 메뉴의 상위 메뉴를 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public SysmenuVO selectSysupmenu(SysmenuVO vo) throws Exception;

  /**
   * 메뉴구성 - 시스템 메뉴 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSysmenuList(SysmenuVO vo) throws Exception;

  /**
   * 메뉴관리 - 시스템 메뉴 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSysmenumanList(SysmenuVO vo) throws Exception;

  /**
   * 특정 메뉴와 같은 레벨의 서브메뉴 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSubmenuList(SysmenuVO vo) throws Exception;

  public List selectSysmenuListSub(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectSysmenuListTotCnt(SysmenuVO vo) throws Exception;

}
