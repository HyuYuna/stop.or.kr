package egovframework.plani.template.man.menuctgry.dao;

import java.util.List;
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface SysauthDAO {

  /**
   * 시스템 권한을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public int insertSysauth(SysauthVO vo) throws Exception;

  /**
   * 시스템 권한을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSysauth(SysauthVO vo) throws Exception;

  /**
   * 시스템 권한을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSysauth(SysauthVO vo) throws Exception;

  /**
   * 시스템 권한항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public SysauthVO selectSysauth(SysauthVO vo) throws Exception;

  /**
   * 시스템 권한 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSysauthList(SysauthVO vo) throws Exception;

  /**
   * 시스템 권한목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectSysauthListTotCnt(SysauthVO vo) throws Exception;

  /**
   * 시스템 권한 상위목록(권한그룹)을 제외한 하위목록만 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectSysauthSubList() throws Exception;

  /**
   * 시스템 권한 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List xlsSysauthList(SysauthVO vo) throws Exception;
}
