package egovframework.plani.template.man.log.dao;

import java.util.List;
import egovframework.plani.template.man.log.vo.ManlogVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ManlogDAO {

  /**
   * 관리자로그을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertManlog(ManlogVO vo) throws Exception;

  /**
   * 관리자로그을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateManlog(ManlogVO vo) throws Exception;

  /**
   * 관리자로그을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteManlog(ManlogVO vo) throws Exception;

  /**
   * 관리자로그항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectManlogSearchKind(ManlogVO vo) throws Exception;

  /**
   * 관리자로그항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public ManlogVO selectManlog(ManlogVO vo) throws Exception;

  /**
   * 관리자로그 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectManlogList(ManlogVO vo) throws Exception;

  /**
   * 관리자로그목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectManlogListTotCnt(ManlogVO vo) throws Exception;

  /**
   * 관리자로그 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List xlsManlogList(ManlogVO vo) throws Exception;
}
