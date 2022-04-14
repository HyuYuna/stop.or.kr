package egovframework.plani.template.brdartcl.service;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardrcmndVO;

/**
 * 게시물 추천/반대 기능처리
 * 
 * @author 플랜아이
 * @interface BoardrcmndService
 */

public interface BoardrcmndService {

  /**
   * 게시물 추천/반대을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertBoardrcmnd(BoardrcmndVO vo) throws Exception;

  /**
   * 게시물 추천/반대을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateBoardrcmnd(BoardrcmndVO vo) throws Exception;

  /**
   * 게시물 추천/반대을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoardrcmnd(BoardrcmndVO vo) throws Exception;

  /**
   * 게시물 추천/반대 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public BoardrcmndVO selectBoardrcmnd(BoardrcmndVO vo) throws Exception;

  /**
   * 게시물 추천/반대 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectBoardrcmndList(BoardrcmndVO vo) throws Exception;

  /**
   * 게시물 추천/반대 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardrcmndListTotCnt(BoardrcmndVO vo) throws Exception;

}

