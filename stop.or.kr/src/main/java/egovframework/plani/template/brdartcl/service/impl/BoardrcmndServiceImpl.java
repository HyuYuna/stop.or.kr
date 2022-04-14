package egovframework.plani.template.brdartcl.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.brdartcl.dao.BoardrcmndDAO;
import egovframework.plani.template.brdartcl.service.BoardrcmndService;
import egovframework.plani.template.brdartcl.vo.BoardrcmndVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 게시물 추천/반대 기능처리
 * 
 * @author 플랜아이
 * @interface BoardrcmndServiceImpl
 */

@Service("boardrcmndService")
public class BoardrcmndServiceImpl extends EgovAbstractServiceImpl implements BoardrcmndService {

  /** BoardrcmndDAO */
  @Resource(name = "boardrcmndDAO")
  private BoardrcmndDAO boardrcmndDAO;

  /**
   * 게시물 추천/반대을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer insertBoardrcmnd(BoardrcmndVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardrcmndDAO.insertBoardrcmnd(vo);
  }

  /**
   * 게시물 추천/반대을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateBoardrcmnd(BoardrcmndVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardrcmndDAO.updateBoardrcmnd(vo);
  }

  /**
   * 게시물 추천/반대을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoardrcmnd(BoardrcmndVO vo) throws Exception {
    // TODO Auto-generated method stub

    boardrcmndDAO.deleteBoardrcmnd(vo);
  }

  /**
   * 게시물 추천/반대항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public BoardrcmndVO selectBoardrcmnd(BoardrcmndVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardrcmndDAO.selectBoardrcmnd(vo);
  }

  /**
   * 게시물 추천/반대 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectBoardrcmndList(BoardrcmndVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardrcmndDAO.selectBoardrcmndList(vo);
  }

  /**
   * 게시물 추천/반대목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectBoardrcmndListTotCnt(BoardrcmndVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardrcmndDAO.selectBoardrcmndListTotCnt(vo);
  }

}

