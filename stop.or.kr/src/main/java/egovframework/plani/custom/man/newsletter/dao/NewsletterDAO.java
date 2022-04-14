package egovframework.plani.custom.man.newsletter.dao;

import java.util.List;

import egovframework.plani.custom.man.newsletter.vo.NewsletterVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface NewsletterDAO {

  /**
   * 정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertNewsletter(NewsletterVO vo) throws Exception;

  /**
   * 정보을/를 수정한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateNewsletter(NewsletterVO vo) throws Exception;
  
  public void updateNewsletterReForm(NewsletterVO vo) throws Exception;//20200727 뉴스레터 재동의 추가

  /**
   * 정보을/를 조회한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public NewsletterVO selectNewsletter(NewsletterVO vo) throws Exception;

  /**
   * 정보을/를 조회한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public List<NewsletterVO> selectNewsletterList(NewsletterVO vo) throws Exception;

  /**
   * 뉴스레터 정보 목록의 총 개수를 구한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectNewsletterListTotCnt(NewsletterVO vo) throws Exception;

  /**
   * 뉴스레터 정보 목록의 총 개수를 구한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteNewsletter(NewsletterVO vo) throws Exception;

  /**
   * 정보을/를 조회한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectNewsletterCheckEmail(String email) throws Exception;

	/**
	 * 정보을/를 조회한다.
	 * 
	 * @param vo
	 *            - 등록할 조건이 담긴 VO
	 * @exception Exception
	 */
	public List<NewsletterVO> selectExcelList(NewsletterVO vo) throws Exception;

}
