package egovframework.plani.template.brdartcl.service;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardfaqVO;

/**
 * 개별 게시판에 대한 CRUD를 처리한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.service] [BoardfaqService.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:58:32
 * @version : 1.0
 */
public interface BoardfaqService {

  /**
   * 게시판을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertBoardfaq(BoardfaqVO vo) throws Exception;

  /**
   * 게시판을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateBoardfaq(BoardfaqVO vo) throws Exception;

  /**
   * 게시판을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoardfaq(BoardfaqVO vo) throws Exception;

  /**
   * 게시판 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public BoardfaqVO selectBoardfaq(BoardfaqVO vo) throws Exception;

  /**
   * 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectBoardfaqList(BoardfaqVO vo) throws Exception;

  /**
   * 게시판 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardfaqListTotCnt(BoardfaqVO vo) throws Exception;

  /**
   * 게시판 조회수 등 을/를 수정한다.
   * 
   * @param boardhitsVO : 수정할 정보
   * @exception Exception
   */
  public void updateBoardxcount(BoardfaqVO vo) throws Exception;

  /**
   * 글 (그룹 포함) 을/를 삭제한다. 글을 삭제했을때, 그 답글과 댓글을 함께 삭제한다.
   * 
   * @param boardfaqVO : 삭제할 정보
   * @exception Exception
   */
  public void deleteBoardfaqgroup(BoardfaqVO vo) throws Exception;


}

