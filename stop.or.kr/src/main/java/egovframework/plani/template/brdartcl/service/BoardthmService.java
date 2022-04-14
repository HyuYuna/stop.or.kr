package egovframework.plani.template.brdartcl.service;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardthmVO;

/**
 * 썸네일 게시판 CRUD처리
 * 
 * @author 플랜아이
 * @interface BoardthmService
 */


public interface BoardthmService {

  /**
   * 썸네일게시판을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertBoardthm(BoardthmVO vo) throws Exception;

  /**
   * 썸네일게시판을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateBoardthm(BoardthmVO vo) throws Exception;

  /**
   * 썸네일게시판을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoardthm(BoardthmVO vo) throws Exception;

  /**
   * 썸네일게시판 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public BoardthmVO selectBoardthm(BoardthmVO vo) throws Exception;

  /**
   * 썸네일게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectBoardthmList(BoardthmVO vo) throws Exception;

  /**
   * 썸네일게시판 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardthmListTotCnt(BoardthmVO vo) throws Exception;


  /**
   * 게시판 조회수 등 을/를 수정한다.
   * 
   * @param boardhitsVO : 수정할 정보
   * @exception Exception
   */
  public void updateBoardxcount(BoardthmVO vo) throws Exception;



  /**
   * 글 (그룹 포함) 을/를 삭제한다. 글을 삭제했을때, 그 댓글 및 첨부파일을 함께 삭제한다.
   * 
   * @param boardarticleVO : 삭제할 정보
   * @exception Exception
   */
  public void deleteBoardthmgroup(BoardthmVO vo) throws Exception;

}

