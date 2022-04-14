package egovframework.plani.template.man.menuctgry.dao;

import java.util.List;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface SysmenuDAO {

  /**
   * 시스템 메뉴을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public int insertSysmenu(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSysmenu(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSysmenuLink(SysmenuVO vo) throws Exception;


  /**
   * 시스템 메뉴순서를 한꺼번에 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSysmenuOrdPlus(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴순서를 한꺼번에 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSysmenuOrdMinus(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSysmenuUsetab(SysmenuVO vo) throws Exception;

  /**
   * 시스템메뉴의 사용여부를 수정한다. 상위메뉴의 사용여부가 수정되면 하위메뉴도 같이 수정된다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateUseynWithSubLevel(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSysmenu(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public SysmenuVO selectSysmenu(SysmenuVO vo) throws Exception;

  /**
   * 특정 메뉴의 상위메뉴를 상세조회 한다.
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
   * 메뉴관리 - 메뉴 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSysmenumanList(SysmenuVO vo) throws Exception;

  /**
   * 특정 메뉴와 같은 레벨의 서브메뉴 목록을 조회한다..
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSubmenuList(SysmenuVO vo) throws Exception;

  public List selectSysmenuListSub(SysmenuVO vo) throws Exception;

  /**
   * 시스템 메뉴목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectSysmenuListTotCnt(SysmenuVO vo) throws Exception;

}
