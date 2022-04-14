package egovframework.plani.template.cardnews.dao;

import java.util.List;
import egovframework.plani.template.cardnews.vo.CardNewsVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 카드뉴스목록데이터에 관한 CRUD를 처리한다.
 * 
 * @class [ContextPath]
 *
 */
@Mapper
public interface CardNewsDAO {

  /**
   * 카드뉴스목록데이터을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertCardNews(CardNewsVO vo) throws Exception;

  /**
   * 카드뉴스목록데이터을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer updateCardNews(CardNewsVO vo) throws Exception;

  /**
   * 카드뉴스목록데이터을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer deleteCardNews(CardNewsVO vo) throws Exception;

  /**
   * 카드뉴스목록데이터항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CardNewsDAO
   * @exception Exception
   */
  public CardNewsVO selectCardNews(CardNewsVO vo) throws Exception;


  /**
   * 카드뉴스목록데이터항목을(공지) 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CardNewsDAO
   * @exception Exception
   */
  public List selectNoticeCardNewsList(CardNewsVO vo) throws Exception;



  /**
   * 카드뉴스목록데이터 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectCardNewsList(CardNewsVO vo) throws Exception;

  /**
   * 카드뉴스목록데이터목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectCardNewsListTotCnt(CardNewsVO vo) throws Exception;


  /**
   * 조회수 증가
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer updatecCardNewsCount(CardNewsVO vo) throws Exception;
}
