package egovframework.plani.template.brdartcl.service;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;

/**
 * 게시물 댓글 기능 CRUD처리
 * 
 * @author 플랜아이
 * @interface BoardreplyService
 */

public interface BoardreplyService {

  /**
   * 댓글을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertBoardreply(BoardreplyVO vo) throws Exception;


  /**
   * 댓글 테이블을/를 생성한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer createBoardReplyTable(BoardreplyVO vo) throws Exception;

  /**
   * 댓글을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateBoardreply(BoardreplyVO vo) throws Exception;

  /**
   * 한 게시판의 댓글을/를 모두 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoard(BoardreplyVO vo) throws Exception;

  /**
   * 댓글을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoardreply(BoardreplyVO vo) throws Exception;

  /**
   * 한 게시글에 입력된 댓글을 모두 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoardreplyByCont(BoardreplyVO vo) throws Exception;

  /**
   * 댓글 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public BoardreplyVO selectBoardreply(BoardreplyVO vo) throws Exception;

  /**
   * 댓글 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectBoardreplyList(BoardreplyVO vo) throws Exception;


}

