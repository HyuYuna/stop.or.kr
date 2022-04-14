package egovframework.plani.template.brdartcl.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.brdartcl.dao.BoardarticleDAO;
import egovframework.plani.template.brdartcl.service.BoardarticleService;
import egovframework.plani.template.brdartcl.service.BoardreplyService;
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;
import egovframework.plani.template.cmm.utils.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 개별 게시판에 대한 CRUD를 처리한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.service.impl] [BoardarticleServiceImpl.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:58:54
 * @version : 1.0
 */
@Service("boardarticleService")
public class BoardarticleServiceImpl extends EgovAbstractServiceImpl
    implements BoardarticleService {

  /** BoardarticleDAO */
  @Resource(name = "boardarticleDAO")
  private BoardarticleDAO boardarticleDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** BoardreplyService */
  @Resource(name = "boardreplyService")
  private BoardreplyService boardreplyService;


  /**
   * 게시판을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer insertBoardarticle(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 답글인 경우 처리
    if (vo.getEdomweivgp().equals("P")) {
      boardarticleDAO.updateBoardarticlereply(vo);
    }

    // 사용자 비밀번호있는 게시판 처리
    if ("Y".equals(vo.getIs_scrt())) {
      if (!vo.getEdomweivgp().equals("P"))
        vo.setAdd_info_04(EgovFileScrty.encryptPassword(vo.getAdd_info_04()));
    }

    return boardarticleDAO.insertBoardarticle(vo);
  }

  /**
   * 게시판을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateBoardarticle(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub

    if ("Y".equals(vo.getIs_scrt())) {
      vo.setAdd_info_04(EgovFileScrty.encryptPassword(vo.getAdd_info_04()));
    }

    boardarticleDAO.updateBoardarticle(vo);
  }

  /**
   * 게시판 전체 게시글을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoard(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 게시판의 첨부파일을 모두 삭제하기..
    AtchfileVO fileVO = new AtchfileVO();
    fileVO.setAtckey_1st(vo.getBrd_id());
    atchfileService.deleteBoardAtchfiles(fileVO);

    // 게시판의 댓글을 모두 삭제하기..
    BoardreplyVO replyVO = new BoardreplyVO();
    replyVO.setBrd_id(vo.getBrd_id());
    boardreplyService.deleteBoard(replyVO);

    boardarticleDAO.deleteBoard(vo);
  }

  /**
   * 게시판을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoardarticle(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 게시물의 첨부파일을 모두 삭제하기..
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st(vo.getBrd_id());
    fvo.setAtckey_2nd(new Integer(vo.getCont_idx()).toString());
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);

    // 게시물의 댓글을 모두 삭제하기..
    BoardreplyVO replyVO = new BoardreplyVO();
    replyVO.setBrd_id(vo.getBrd_id());
    replyVO.setCont_idx(vo.getCont_idx());
    boardreplyService.deleteBoardreplyByCont(replyVO);

    boardarticleDAO.deleteBoardarticle(vo);
  }

  /**
   * 게시판항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public BoardarticleVO selectBoardarticle(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardarticleDAO.selectBoardarticle(vo);
  }

  /**
   * 현재 게시물의 같은 그룹내에 특정사용자가 작성한 글이 있는지 확인
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectBoardarticleGrpwriterCnt(BoardarticleVO vo) throws Exception {
    return boardarticleDAO.selectBoardarticleGrpwriterCnt(vo);
  }


  /**
   * 게시판항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public BoardarticleVO selectBoardarticlePwd(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub
    vo.setAdd_info_04(EgovFileScrty.encryptPassword(vo.getAdd_info_04()));
    return boardarticleDAO.selectBoardarticlePwd(vo);
  }

  /**
   * 메인화면 표시용 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectBoardarticleMainList(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardarticleDAO.selectBoardarticleMainList(vo);
  }

  /**
   * 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectBoardarticleList(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardarticleDAO.selectBoardarticleList(vo);
  }

  /**
   * 게시판목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectBoardarticleListTotCnt(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardarticleDAO.selectBoardarticleListTotCnt(vo);
  }

  /**
   * 게시판 조회수 등 을/를 수정한다.
   * 
   * @param boardhitsVO : 수정할 정보
   * @exception Exception
   */
  @Override
  public void updateBoardxcount(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardarticleDAO.updateBoardxcount(vo);
  }

  /**
   * 글 (그룹 포함) 을/를 삭제한다. 글을 삭제했을때, 그 답글과 댓글을 함께 삭제한다. 첨부파일 목록도 삭제한다.
   * 
   * @param boardarticleVO : 삭제할 정보
   * @exception Exception
   */
  @Override
  public void deleteBoardarticlegroup(BoardarticleVO vo) throws Exception {
    // TODO Auto-generated method stub

    List grplist = boardarticleDAO.selectBoardarticlegroupList(vo);

    for (int i = 0; i < grplist.size(); i++) {
      BoardarticleVO dvo = (BoardarticleVO) grplist.get(i);
      dvo.setTbl_nm(vo.getTbl_nm());

      // 게시물의 첨부파일을 모두 삭제하기..
      AtchfileVO fvo = new AtchfileVO();
      fvo.setAtckey_1st(vo.getBrd_id());
      fvo.setAtckey_2nd(dvo.getCont_idx() + "");
      fvo.setAtckey_3rd(1);
      atchfileService.deleteAtchfiles(fvo);

      // 게시물에 입력된 댓글도 모두 삭제한다.
      BoardreplyVO rvo = new BoardreplyVO();
      rvo.setTbl_nm(vo.getTbl_nm());
      rvo.setBrd_id(vo.getBrd_id());
      rvo.setCont_idx(dvo.getCont_idx());
      boardreplyService.deleteBoardreplyByCont(rvo);

      // 게시물 삭제하기
      boardarticleDAO.deleteBoardarticle(dvo);
    }
  }


  /**
   * 통합검색 조회한다.
   * 
   * @param boardarticleVO : 조회할 정보
   * @exception Exception
   */
  @Override
  public List selectTotalSearchList(BoardarticleVO vo) throws Exception {
    return boardarticleDAO.selectTotalSearchList(vo);
  }


  /**
   * 익명게시판의 경우 최근 1분이내에 등록한글이 있는지 검사한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectBoardarticleAnonimChk(BoardarticleVO vo) throws Exception {
    return boardarticleDAO.selectBoardarticleAnonimChk(vo);
  }
}

