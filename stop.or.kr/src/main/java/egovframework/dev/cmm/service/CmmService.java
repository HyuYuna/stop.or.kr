package egovframework.dev.cmm.service;

import java.util.List;
import egovframework.dev.cmm.service.CmmMap;

/**
 * 공통 서비스 
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

public interface CmmService {

	List<CmmMap> selectList(String sqlId, CmmMap param) throws Exception;
	
	CmmMap selectObject(String sqlId, CmmMap param) throws Exception;
	
	void insertObject(String sqlId, CmmMap param) throws Exception;
	
	Object insertObjectReturnKey(String sqlId, CmmMap param) throws Exception;
	
	String insertObjectReturnKeyString(String sqlId, CmmMap param) throws Exception;

	int updateObject(String sqlId, CmmMap param) throws Exception;
	
	int deleteObject(String sqlId, CmmMap param) throws Exception;

}
