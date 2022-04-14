package egovframework.dev.cmm.service.impl;

import java.util.List;
import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.dev.cmm.service.CmmMap;

/**
 * 공통 DAO
 * @author 개발팀 진효진
 * @since 2017.10.31
 * @version 1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  ------------   --------    ---------------------------
 *  2017.10.31  진효진          최초 생성
 *  </pre>
 */

@Repository("cmmDAO")
public class CmmDAO extends EgovComAbstractDAO{

	@SuppressWarnings("unchecked")
	public List<CmmMap> selectList(String sqlId, CmmMap param) throws Exception{
		return (List<CmmMap>) list(sqlId, param);
	}
	
	public CmmMap selectObject(String sqlId, CmmMap param) throws Exception{
		return (CmmMap)select(sqlId, param);
	}
	
	public void insertObject(String sqlId, CmmMap param) throws Exception{
	     insert(sqlId, param);
	}
	
	public Object insertObjectReturnKey(String sqlId, CmmMap param) throws Exception{
		return  (Object)insert(sqlId, param);
	}
	
	public String insertObjectReturnKeyString(String sqlId, CmmMap param) throws Exception{
		return  (String)insert(sqlId, param);
	}
	
	public int updateObject(String sqlId, CmmMap param) throws Exception{
		return update(sqlId, param);
	}
	
	public int deleteObject(String sqlId, CmmMap param) throws Exception{
		return delete(sqlId, param);
	}
	

}
