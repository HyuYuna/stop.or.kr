package egovframework.plani.template.brdartcl.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.brdartcl.dao.BoardfaqDAO;
import egovframework.plani.template.brdartcl.service.BoardfaqService;
import egovframework.plani.template.brdartcl.service.BoardreplyService;
import egovframework.plani.template.brdartcl.vo.BoardfaqVO;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 개별 게시판에 대한 CRUD를 처리한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.brdartcl.service.impl] [BoardfaqServiceImpl.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오후 5:58:54
 * @version : 1.0
 */
@Service("boardfaqService")
public class BoardfaqServiceImpl extends EgovAbstractServiceImpl implements BoardfaqService {

  /** BoardfaqDAO */
  @Resource(name = "boardfaqDAO")
  private BoardfaqDAO boardfaqDAO;

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
  public Integer insertBoardfaq(BoardfaqVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 답글인 경우 처리
    if (vo.getEdomweivgp().equals("P")) {
      boardfaqDAO.updateBoardfaqreply(vo);
    }

    return boardfaqDAO.insertBoardfaq(vo);
  }

  /**
   * 게시판을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateBoardfaq(BoardfaqVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardfaqDAO.updateBoardfaq(vo);
  }

  /**
   * 게시판을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteBoardfaq(BoardfaqVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 게시물의 첨부파일을 모두 삭제하기..
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st(vo.getBrd_id());
    fvo.setAtckey_2nd(new Integer(vo.getCont_idx()).toString());
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);

    boardfaqDAO.deleteBoardfaq(vo);
  }

  /**
   * 게시판항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public BoardfaqVO selectBoardfaq(BoardfaqVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardfaqDAO.selectBoardfaq(vo);
  }

  /**
   * 게시판 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectBoardfaqList(BoardfaqVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardfaqDAO.selectBoardfaqList(vo);
  }

  /**
   * 게시판목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectBoardfaqListTotCnt(BoardfaqVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardfaqDAO.selectBoardfaqListTotCnt(vo);
  }

  /**
   * 게시판 조회수 등 을/를 수정한다.
   * 
   * @param boardhitsVO : 수정할 정보
   * @exception Exception
   */
  @Override
  public void updateBoardxcount(BoardfaqVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardfaqDAO.updateBoardxcount(vo);
  }

  /**
   * 글 (그룹 포함) 을/를 삭제한다. 글을 삭제했을때, 그 답글과 댓글을 함께 삭제한다. 첨부파일 목록도 삭제한다.
   * 
   * @param boardfaqVO : 삭제할 정보
   * @exception Exception
   */
  @Override
  public void deleteBoardfaqgroup(BoardfaqVO vo) throws Exception {
    // TODO Auto-generated method stub


    List grplist = boardfaqDAO.selectBoardfaqgroupList(vo);


    for (int i = 0; i < grplist.size(); i++) {
      BoardfaqVO dvo = (BoardfaqVO) grplist.get(i);
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
      boardfaqDAO.deleteBoardfaq(dvo);
    }
  }


}

