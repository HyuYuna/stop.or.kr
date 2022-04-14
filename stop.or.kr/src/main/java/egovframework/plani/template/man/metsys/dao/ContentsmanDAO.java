package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.ContentsmanVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 컨텐츠에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.metsys.dao] [ContentsmanDAO.java]
 *
 */
@Mapper
public interface ContentsmanDAO {

  /**
   * 컨텐츠 관리을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return String
   * @exception Exception
   */
  public Integer insertContentsman(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리 을/를 등록한다. (새로운 버전으로 등록)
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertContentsmanNewver(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateContentsman(ContentsmanVO vo) throws Exception;


  /**
   * 컨텐츠 관리을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateContentsmanMenunix(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateContentsmanMenunixNull(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteContentsman(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return ContentsmanVO
   * @exception Exception
   */
  public ContentsmanVO selectContentsman(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectContentsmanList(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리 목록(메뉴연결목록)을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectContentsmanmenuList(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectContentsmanRefmenuList(ContentsmanVO vo) throws Exception;

  /**
   * 버전을 복원할때 삭제하기 위해 상위버전을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectContentsmanRestorelist(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠 관리목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectContentsmanListTotCnt(ContentsmanVO vo) throws Exception;

  /**
   * 컨텐츠의 버전을 복원한다
   * 
   * @param contentsmanVO : 복원할 정보
   * @exception Exception
   */
  public void restoreContentsman(ContentsmanVO vo) throws Exception;

}
