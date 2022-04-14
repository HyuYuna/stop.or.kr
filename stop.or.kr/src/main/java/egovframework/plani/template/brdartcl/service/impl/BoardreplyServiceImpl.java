package egovframework.plani.template.brdartcl.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.brdartcl.dao.BoardreplyDAO;
import egovframework.plani.template.brdartcl.service.BoardreplyService;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 게시물 댓글 기능 CRUD처리
 * 
 * @author 플랜아이
 * @interface BoardreplyServiceImpl
 */

@Service("boardreplyService")
public class BoardreplyServiceImpl extends EgovAbstractServiceImpl implements BoardreplyService {

  /** BoardreplyDAO */
  @Resource(name = "boardreplyDAO")
  private BoardreplyDAO boardreplyDAO;

  /**
   * 댓글을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer insertBoardreply(BoardreplyVO vo) throws Exception {
    // TODO Auto-generated method stub
    vo.setBrd_pwd(EgovFileScrty.encryptPassword(vo.getBrd_pwd()));
    return boardreplyDAO.insertBoardreply(vo);
  }

  /**
   * 댓글 테이블을/를 생성한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer createBoardReplyTable(BoardreplyVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardreplyDAO.createBoardReplyTable(vo);
  }

  /**
   * 댓글을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateBoardreply(BoardreplyVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardreplyDAO.updateBoardreply(vo);
  }

  /**
   * 한 게시판의 댓글을/를 모두 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoard(BoardreplyVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardreplyDAO.deleteBoard(vo);
  }

  /**
   * 댓글을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoardreply(BoardreplyVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardreplyDAO.deleteBoardreply(vo);
  }


  /**
   * 한 게시글에 입력된 댓글을 모두 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoardreplyByCont(BoardreplyVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardreplyDAO.deleteBoardreplyByCont(vo);
  }

  /**
   * 댓글항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public BoardreplyVO selectBoardreply(BoardreplyVO vo) throws Exception {
    // TODO Auto-generated method stub
    vo.setBrd_pwd_chk(EgovFileScrty.encryptPassword(vo.getBrd_pwd_chk()));
    return boardreplyDAO.selectBoardreply(vo);
  }

  /**
   * 댓글 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectBoardreplyList(BoardreplyVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardreplyDAO.selectBoardreplyList(vo);
  }


}

