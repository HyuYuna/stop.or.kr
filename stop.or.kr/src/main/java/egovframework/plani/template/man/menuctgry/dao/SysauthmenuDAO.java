package egovframework.plani.template.man.menuctgry.dao;

import java.util.List;
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface SysauthmenuDAO {

  /**
   * 권한별 메뉴을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertSysauthmenu(SysmenuVO vo) throws Exception;

  /**
   * 권한별 메뉴을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSysauthmenu(SysmenuVO vo) throws Exception;

  /**
   * 권한별 메뉴을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSysauthmenuByAuthcd(SysauthVO vo) throws Exception;

  /**
   * 권한별 메뉴을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSysauthmenuByMenuidx(SysmenuVO vo) throws Exception;

  /**
   * 권한별 메뉴항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public SysmenuVO selectSysauthmenu(SysmenuVO vo) throws Exception;

  /**
   * 권한별 메뉴 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSysauthmenuList(SysmenuVO vo) throws Exception;

  /**
   * 권한별 메뉴목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectSysauthmenuListTotCnt(SysmenuVO vo) throws Exception;

  /**
   * 권한별 메뉴 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List xlsSysauthmenuList(SysmenuVO vo) throws Exception;

}
