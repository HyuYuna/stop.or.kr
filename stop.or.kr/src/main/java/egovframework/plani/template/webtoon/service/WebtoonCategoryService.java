package egovframework.plani.template.webtoon.service;

import java.util.List;
import egovframework.plani.template.webtoon.vo.WebtoonCategoryVO;

public interface WebtoonCategoryService {


  /**
   * 데이터을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @return Integer
   * @exception Exception
   */
  public Integer insertWebtoonCategory(WebtoonCategoryVO vo) throws Exception;

  /**
   * 데이터을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateWebtoonCategory(WebtoonCategoryVO vo) throws Exception;

  /**
   * 데이터을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteWebtoonCategory(WebtoonCategoryVO vo) throws Exception;

  /**
   * 데이터 항목을 상세조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return CardNewsVO
   * @exception Exception
   */
  public WebtoonCategoryVO selectWebtoonCategory(WebtoonCategoryVO vo) throws Exception;

  /**
   * 데이터 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return List
   * @exception Exception
   */
  public List selectWebtoonCategoryList(WebtoonCategoryVO vo) throws Exception;

  /**
   * 데이터 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @return int
   * @exception Exception
   */
  public int selectWebtoonCategoryListTotCnt(WebtoonCategoryVO vo) throws Exception;


  /**
   * 데이터을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteWebtoonAll(WebtoonCategoryVO vo) throws Exception;



}
