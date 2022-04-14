package egovframework.plani.template.brdartcl.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.brdartcl.dao.BoarddryDAO;
import egovframework.plani.template.brdartcl.service.BoarddryService;
import egovframework.plani.template.brdartcl.vo.BoarddryVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 * 일정게시판 CRUD를 처리한다
 * 
 * @author 플랜아이
 * @class BoarddryServiceImpl
 */


@Service("boarddryService")
public class BoarddryServiceImpl extends EgovAbstractServiceImpl implements BoarddryService {

  /** BoarddryDAO */
  @Resource(name = "boarddryDAO")
  private BoarddryDAO boarddryDAO;

  /**
   * 일정 게시판 을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer insertBoarddry(BoarddryVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boarddryDAO.insertBoarddry(vo);
  }

  /**
   * 일정 게시판 을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateBoarddry(BoarddryVO vo) throws Exception {
    // TODO Auto-generated method stub
    boarddryDAO.updateBoarddry(vo);
  }

  /**
   * 일정 게시판 을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoarddry(BoarddryVO vo) throws Exception {
    // TODO Auto-generated method stub

    boarddryDAO.deleteBoarddry(vo);
  }

  /**
   * 일정 게시판 항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public BoarddryVO selectBoarddry(BoarddryVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boarddryDAO.selectBoarddry(vo);
  }

  /**
   * 일정 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectBoarddryList(BoarddryVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boarddryDAO.selectBoarddryList(vo);
  }

  /**
   * 일정 게시판목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectBoarddryListTotCnt(BoarddryVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boarddryDAO.selectBoarddryListTotCnt(vo);
  }

  /**
   * 일정 게시판 목록의 엑셀 다운로드를 처리한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List xlsBoarddryList(BoarddryVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boarddryDAO.xlsBoarddryList(vo);
  }

  /**
   * 메인화면용 일정 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectBoarddryMainList(BoarddryVO vo) throws Exception {
    return boarddryDAO.selectBoarddryMainList(vo);
  }
}

