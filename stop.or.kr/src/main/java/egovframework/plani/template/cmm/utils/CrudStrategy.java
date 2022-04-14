package egovframework.plani.template.cmm.utils;

import java.util.List;

/**
 * 
 * @author gangja
 *
 * @param <T> DefaultSearchVO 를 extends 한 DTO 객체
 */
public interface CrudStrategy<T> {

  /**
   * 총 개수를 가져옵니다.
   * 
   * @return int
   * @throws Exception
   */
  public int totalCount() throws Exception;

  /**
   * 페이징된 목록을 가져옵니다.
   * 
   * @return List
   * @throws Exception
   */
  public List<T> pagingList() throws Exception;

}
