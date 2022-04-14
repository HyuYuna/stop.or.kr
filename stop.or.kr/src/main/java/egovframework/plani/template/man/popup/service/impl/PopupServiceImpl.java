package egovframework.plani.template.man.popup.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.man.popup.dao.PopupDAO;
import egovframework.plani.template.man.popup.service.PopupService;
import egovframework.plani.template.man.popup.vo.PopupVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 팝업에 관한 CURD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.man.popup.service.impl]
 *        [PopupServiceImpl.java]
 *
 */
@Service("popupService")
public class PopupServiceImpl extends EgovAbstractServiceImpl implements PopupService {

  /** PopupDAO */
  @Resource(name = "popupDAO")
  private PopupDAO popupDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 팝업을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  @Override
  public Integer insertPopup(PopupVO vo) throws Exception {
    // TODO Auto-generated method stub
    return popupDAO.insertPopup(vo);
  }

  /**
   * 팝업을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updatePopup(PopupVO vo) throws Exception {
    // TODO Auto-generated method stub
    popupDAO.updatePopup(vo);
  }

  /**
   * 팝업을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deletePopup(PopupVO vo) throws Exception {
    // TODO Auto-generated method stub

    // TODO: 첨부파일 전체 삭제
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st("POPUP");
    fvo.setAtckey_2nd(new Integer(vo.getPop_seq()).toString());
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);

    popupDAO.deletePopup(vo);
  }

  /**
   * 팝업항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return PopupVO
   * @exception Exception
   */
  @Override
  public PopupVO selectPopup(PopupVO vo) throws Exception {
    // TODO Auto-generated method stub
    return popupDAO.selectPopup(vo);
  }

  /**
   * 팝업 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectPopupList(PopupVO vo) throws Exception {
    // TODO Auto-generated method stub
    return popupDAO.selectPopupList(vo);
  }

  /**
   * 팝업목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectPopupListTotCnt(PopupVO vo) throws Exception {
    // TODO Auto-generated method stub
    return popupDAO.selectPopupListTotCnt(vo);
  }

  /**
   * 정렬 순서를 변경
   * 
   * @param PopupVO
   * @exception Exception
   */
  @Override
  public void sortPopup(PopupVO vo) throws Exception {

    // 맞바꿀 대상 조회
    PopupVO target = popupDAO.selectTargetReplaced(vo);

    // 더이상 이동 불가
    if (target == null) {
    } else {
      PopupVO curr = popupDAO.selectPopup(vo);
      PopupVO tmp = new PopupVO();

      // 대상 변경
      tmp.setPop_seq(target.getPop_seq());
      tmp.setPop_sort(curr.getPop_sort());
      popupDAO.updatePopupSort(tmp);

      // 선택건 변경
      tmp.setPop_seq(curr.getPop_seq());
      tmp.setPop_sort(target.getPop_sort());
      popupDAO.updatePopupSort(tmp);
    }
  }

  /**
   * 유효한 팝업 목록 조회
   * 
   * @param PopupVO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectValidPopupList(PopupVO vo) throws Exception {
    List popList = null;

    popList = popupDAO.selectValidPopupList(vo);

    return popList;
  }

  /**
   * 사용/미사용 toggle
   * 
   * @param seq
   * @exception Exception
   */
  @Override
  public void updatePopupUseYn(String seq) throws Exception {
    popupDAO.updatePopupUseYn(seq);
  }
}
