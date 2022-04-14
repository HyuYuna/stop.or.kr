package egovframework.plani.template.brdartcl.service;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;

/**
 * 개별 게시판에 대한 CRUD를 처리한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.service] [BoardarticleService.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:58:32
 * @version : 1.0
 */
public interface BoardarticleService {

  /**
   * 게시판을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertBoardarticle(BoardarticleVO vo) throws Exception;

  /**
   * 게시판을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateBoardarticle(BoardarticleVO vo) throws Exception;

  /**
   * 게시판을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoard(BoardarticleVO vo) throws Exception;

  /**
   * 게시판을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteBoardarticle(BoardarticleVO vo) throws Exception;

  /**
   * 게시판 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public BoardarticleVO selectBoardarticle(BoardarticleVO vo) throws Exception;

  /**
   * 현재 게시물의 같은 그룹내에 특정사용자가 작성한 글이 있는지 확인
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardarticleGrpwriterCnt(BoardarticleVO vo) throws Exception;

  /**
   * 게시판 항목을 상세조회한다.(비밀번호)
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public BoardarticleVO selectBoardarticlePwd(BoardarticleVO vo) throws Exception;

  /**
   * 메인화면 표시용 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectBoardarticleMainList(BoardarticleVO vo) throws Exception;

  /**
   * 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectBoardarticleList(BoardarticleVO vo) throws Exception;


  /**
   * 게시판 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardarticleListTotCnt(BoardarticleVO vo) throws Exception;

  /**
   * 게시판 조회수 등 을/를 수정한다.
   * 
   * @param boardhitsVO : 수정할 정보
   * @exception Exception
   */
  public void updateBoardxcount(BoardarticleVO vo) throws Exception;

  /**
   * 글 (그룹 포함) 을/를 삭제한다. 글을 삭제했을때, 그 답글과 댓글을 함께 삭제한다.
   * 
   * @param boardarticleVO : 삭제할 정보
   * @exception Exception
   */
  public void deleteBoardarticlegroup(BoardarticleVO vo) throws Exception;

  /**
   * 통합검색 조회한다.
   * 
   * @param boardarticleVO : 조회할 정보
   * @exception Exception
   */
  public List selectTotalSearchList(BoardarticleVO vo) throws Exception;


  /**
   * 익명게시판의 경우 최근 1분이내에 등록한글이 있는지 검사한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardarticleAnonimChk(BoardarticleVO vo) throws Exception;
}

