package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.TablecrudVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

/**
 * 테이블 목록과 컬럼목록을 조회한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.metsys.dao] [TablecrudDAO.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오전 11:41:50
 * @version : 1.0
 */
@Mapper
public interface TablecrudDAO {


  /**
   * 테이블 CRUD 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectTableList(TablecrudVO vo) throws Exception;

  /**
   * 테이블 CRUD 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public List selectTablecolList(TablecrudVO vo) throws Exception;


}
