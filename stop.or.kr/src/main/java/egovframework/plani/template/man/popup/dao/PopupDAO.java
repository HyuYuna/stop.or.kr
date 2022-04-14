package egovframework.plani.template.man.popup.dao;

import java.util.List;
import egovframework.plani.template.man.popup.vo.PopupVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 팝업에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.popup.dao] [PopupDAO.java]
 *
 */
@Mapper
public interface PopupDAO {

  /**
   * 팝업을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertPopup(PopupVO vo) throws Exception;

  /**
   * 팝업을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer updatePopup(PopupVO vo) throws Exception;

  /**
   * 팝업을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer deletePopup(PopupVO vo) throws Exception;

  /**
   * 팝업항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return PopupVO
   * @exception Exception
   */
  public PopupVO selectPopup(PopupVO vo) throws Exception;

  /**
   * 팝업 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectPopupList(PopupVO vo) throws Exception;

  /**
   * 팝업목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectPopupListTotCnt(PopupVO vo) throws Exception;

  /**
   * 정렬 순서를 바꿀 대상 조회
   * 
   * @param PopupVO
   * @return PopupVO
   * @exception Exception
   */
  public PopupVO selectTargetReplaced(PopupVO vo) throws Exception;

  /**
   * 정렬 순서 변경
   * 
   * @param PopupVO
   * @exception Exception
   */
  public int updatePopupSort(PopupVO vo) throws Exception;

  /**
   * 유효한 팝업 목록 조회
   * 
   * @param PopupVO
   * @return List
   * @exception Exception
   */
  public List selectValidPopupList(PopupVO vo) throws Exception;

  /**
   * 사용/미사용 toggle
   * 
   * @param seq
   * @exception Exception
   */
  public int updatePopupUseYn(String seq) throws Exception;
}
