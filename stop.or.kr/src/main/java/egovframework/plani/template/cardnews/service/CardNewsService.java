package egovframework.plani.template.cardnews.service;

import java.util.List;
import egovframework.plani.template.cardnews.vo.CardNewsVO;

/**
 * 카드뉴스목록에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath]
 *
 */
public interface CardNewsService {

  /**
   * 카드뉴스데이터을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertCardNews(CardNewsVO vo) throws Exception;

  /**
   * 카드뉴스데이터을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateCardNews(CardNewsVO vo) throws Exception;

  /**
   * 카드뉴스데이터을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteCardNews(CardNewsVO vo) throws Exception;

  /**
   * 카드뉴스데이터 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CardNewsVO
   * @exception Exception
   */
  public CardNewsVO selectCardNews(CardNewsVO vo) throws Exception;


  /**
   * 카드뉴스데이터 항목을(공지) 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CardNewsVO
   * @exception Exception
   */
  public List selectNoticeCardNewsList(CardNewsVO vo) throws Exception;



  /**
   * 카드뉴스데이터 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectCardNewsList(CardNewsVO vo) throws Exception;

  /**
   * 카드뉴스데이터 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectCardNewsListTotCnt(CardNewsVO vo) throws Exception;


  /**
   * 조회수 업데이트.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public void updatecCardNewsCount(CardNewsVO vo) throws Exception;

}
