package egovframework.plani.template.brdartcl.dao;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 개별 게시판에 대한 CRUD를 처리한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.dao] [BoardarticleDAO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:59:00
 * @version : 1.0
 */
@Mapper
public interface BoardarticleDAO {

  /**
   * 게시판을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertBoardarticle(BoardarticleVO vo) throws Exception;

  /**
   * 댓글 등록을 위해 그룹 순서 을/를 수정한다.
   * 
   * @param boardarticlereplyVO : 수정할 정보
   * @exception Exception
   */
  public void updateBoardarticlereply(BoardarticleVO vo) throws Exception;


  /**
   * 게시판을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateBoardarticle(BoardarticleVO vo) throws Exception;

  /**
   * 게시판전체을/를 삭제한다.
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
   * 게시판항목을 상세조회 한다.
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
   * 게시판항목을 상세조회 한다.
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
   * 게시판목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardarticleListTotCnt(BoardarticleVO vo) throws Exception;

  /**
   * 게시판 조회수등 을/를 수정한다.
   * 
   * @param boardhitsVO : 수정할 정보
   * @exception Exception
   */
  public void updateBoardxcount(BoardarticleVO vo) throws Exception;

  /**
   * 선택된 글과 답글 목록 을/를 조회한다.
   * 
   * @param boardarticleVO : 조회할 정보
   * @exception Exception
   */
  public List selectBoardarticlegroupList(BoardarticleVO vo) throws Exception;

  /**
   * 통합검색 조회한다.
   * 
   * @param boardarticleVO : 조회할 정보
   * @exception Exception
   */
  public List selectTotalSearchList(BoardarticleVO vo) throws Exception;

  /**
   * 익명게시판의 경우 최근 1분이내에 등록한 글이 있는지 검사한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectBoardarticleAnonimChk(BoardarticleVO vo) throws Exception;

}

