package egovframework.plani.template.brdartcl.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.brdartcl.dao.BoardthmDAO;
import egovframework.plani.template.brdartcl.service.BoardreplyService;
import egovframework.plani.template.brdartcl.service.BoardthmService;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;
import egovframework.plani.template.brdartcl.vo.BoardthmVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 * 썸네일 게시판 CRUD처리
 * 
 * @author 플랜아이
 * @interface BoardthmServiceImpl
 */



@Service("boardthmService")
public class BoardthmServiceImpl extends EgovAbstractServiceImpl implements BoardthmService {

  /** BoardthmDAO */
  @Resource(name = "boardthmDAO")
  private BoardthmDAO boardthmDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /** BoardreplyService */
  @Resource(name = "boardreplyService")
  private BoardreplyService boardreplyService;


  /**
   * 썸네일게시판을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public Integer insertBoardthm(BoardthmVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardthmDAO.insertBoardthm(vo);
  }

  /**
   * 썸네일게시판을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateBoardthm(BoardthmVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardthmDAO.updateBoardthm(vo);
  }

  /**
   * 썸네일게시판을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoardthm(BoardthmVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 게시물의 첨부파일을 모두 삭제하기..
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st(vo.getBrd_id());
    fvo.setAtckey_2nd(new Integer(vo.getCont_idx()).toString());
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);

    boardthmDAO.deleteBoardthm(vo);
  }

  /**
   * 썸네일게시판항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public BoardthmVO selectBoardthm(BoardthmVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardthmDAO.selectBoardthm(vo);
  }

  /**
   * 썸네일게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectBoardthmList(BoardthmVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardthmDAO.selectBoardthmList(vo);
  }

  /**
   * 썸네일게시판목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectBoardthmListTotCnt(BoardthmVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardthmDAO.selectBoardthmListTotCnt(vo);
  }

  @Override
  public void updateBoardxcount(BoardthmVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardthmDAO.updateBoardxcount(vo);
  }


  /**
   * 글 (그룹 포함) 을/를 삭제한다. 글을 삭제했을때, 그 댓글 및 첨부파일을 함께 삭제한다. 첨부파일 목록도 삭제한다.
   * 
   * @param boardarticleVO : 삭제할 정보
   * @exception Exception
   */
  @Override
  public void deleteBoardthmgroup(BoardthmVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 게시물의 첨부파일을 모두 삭제하기..
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st(vo.getBrd_id());
    fvo.setAtckey_2nd(vo.getCont_idx() + "");
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);

    // 게시물에 입력된 댓글도 모두 삭제한다.
    BoardreplyVO rvo = new BoardreplyVO();
    rvo.setTbl_nm(vo.getTbl_nm());
    rvo.setBrd_id(vo.getBrd_id());
    rvo.setCont_idx(vo.getCont_idx());
    boardreplyService.deleteBoardreplyByCont(rvo);

    // 게시물 삭제하기
    boardthmDAO.deleteBoardthm(vo);
  }

}

