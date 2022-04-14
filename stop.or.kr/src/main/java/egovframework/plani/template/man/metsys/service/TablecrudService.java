package egovframework.plani.template.man.metsys.service;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.TablecrudVO;

/**
 * 테이블 목록과 컬럼 목록을 조회한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.metsys.service] [TablecrudService.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오전 11:42:22
 * @version : 1.0
 */
public interface TablecrudService {


  /**
   * 테이블 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectTableList(TablecrudVO vo) throws Exception;


  /**
   * 테이블 컬럼 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectTablecolList(TablecrudVO vo) throws Exception;

}

