package egovframework.plani.template.cardnews.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.cardnews.dao.CardNewsDAO;
import egovframework.plani.template.cardnews.service.CardNewsService;
import egovframework.plani.template.cardnews.vo.CardNewsVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 카드뉴스에 관한 CURD를 처리한다.
 * 
 * @class [ContextPath] [egovframework.plani.template.cardnews.service.impl]
 *        [CardNewsServiceImpl.java]
 *
 */
@Service("cardNewsService")
public class CardNewsServiceImpl extends EgovAbstractServiceImpl implements CardNewsService {

  /** cardNewsDAO */
  @Resource(name = "cardNewsDAO")
  private CardNewsDAO cardNewsDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  /**
   * 카드뉴스을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  @Override
  public Integer insertCardNews(CardNewsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return cardNewsDAO.insertCardNews(vo);
  }

  /**
   * 카드뉴스을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateCardNews(CardNewsVO vo) throws Exception {
    // TODO Auto-generated method stub

    cardNewsDAO.updateCardNews(vo);
  }

  /**
   * 카드뉴스을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteCardNews(CardNewsVO vo) throws Exception {
    // TODO Auto-generated method stub

    // TODO: 첨부파일 전체 삭제
    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st("CARD_NEWS");
    fvo.setAtckey_2nd(new Integer(vo.getCn_seq()).toString());
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);

    cardNewsDAO.deleteCardNews(vo);
  }

  /**
   * 카드뉴스항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CardNewsVO
   * @exception Exception
   */
  @Override
  public CardNewsVO selectCardNews(CardNewsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return cardNewsDAO.selectCardNews(vo);
  }

  /**
   * 카드뉴스항목을(공지) 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CardNewsVO
   * @exception Exception
   */
  @Override
  public List selectNoticeCardNewsList(CardNewsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return cardNewsDAO.selectNoticeCardNewsList(vo);
  }



  /**
   * 카드뉴스 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  @Override
  public List selectCardNewsList(CardNewsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return cardNewsDAO.selectCardNewsList(vo);
  }

  /**
   * 카드뉴스목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  @Override
  public int selectCardNewsListTotCnt(CardNewsVO vo) throws Exception {
    // TODO Auto-generated method stub
    return cardNewsDAO.selectCardNewsListTotCnt(vo);
  }

  /**
   * 조회수 업데이트
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  @Override
  public void updatecCardNewsCount(CardNewsVO vo) throws Exception {
    // TODO Auto-generated method stub
    cardNewsDAO.updatecCardNewsCount(vo);
  }
}
