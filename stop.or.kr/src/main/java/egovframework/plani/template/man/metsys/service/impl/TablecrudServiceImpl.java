package egovframework.plani.template.man.metsys.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.man.metsys.dao.TablecrudDAO;
import egovframework.plani.template.man.metsys.service.TablecrudService;
import egovframework.plani.template.man.metsys.vo.TablecrudVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 테이블 목록과 컬럼 목록을 조회한다.
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.metsys.service.impl] [TablecrudServiceImpl.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 15. 오전 11:42:09
 * @version : 1.0
 */
@Service("tablecrudService")
public class TablecrudServiceImpl extends EgovAbstractServiceImpl implements TablecrudService {

  /** TablecrudDAO */
  @Resource(name = "tablecrudDAO")
  private TablecrudDAO tablecrudDAO;


  /**
   * 테이블 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectTableList(TablecrudVO vo) throws Exception {
    // TODO Auto-generated method stub

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    if ("mysql".equals(dbtype)) {
      String schema = EgovProperties.getProperty("Globals.Url");
      schema = schema.substring(schema.lastIndexOf("/") + 1, schema.length());
      System.out.println(schema);
      vo.setTable_schema(schema);
    }

    return tablecrudDAO.selectTableList(vo);
  }

  /**
   * 테이블 컬럼 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectTablecolList(TablecrudVO vo) throws Exception {
    // TODO Auto-generated method stub

    return tablecrudDAO.selectTablecolList(vo);
  }


}

