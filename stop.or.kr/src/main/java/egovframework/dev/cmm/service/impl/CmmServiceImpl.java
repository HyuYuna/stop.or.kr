package egovframework.dev.cmm.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import egovframework.dev.cmm.service.CmmService;
import egovframework.dev.cmm.service.CmmMap;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 공통 serviceImpl
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

@Service("cmmService")
public class CmmServiceImpl extends EgovAbstractServiceImpl implements CmmService{
	@Resource(name="cmmDAO")
    private CmmDAO cmmDAO;
	
	public List<CmmMap> selectList(String sqlId, CmmMap param) throws Exception {
		return cmmDAO.selectList(sqlId, param);
	}
	
	public CmmMap selectObject(String sqlId, CmmMap param) throws Exception {
		return cmmDAO.selectObject(sqlId, param);
	}
	
	public void insertObject(String sqlId, CmmMap param) throws Exception {
		cmmDAO.insertObject(sqlId, param);
	}
	
	public Object insertObjectReturnKey(String sqlId, CmmMap param) throws Exception {
		return cmmDAO.insertObjectReturnKey(sqlId, param);
	}
	
	public String insertObjectReturnKeyString(String sqlId, CmmMap param) throws Exception {
		return cmmDAO.insertObjectReturnKeyString(sqlId, param);
	}

	public int updateObject(String sqlId, CmmMap param) throws Exception {
		return cmmDAO.updateObject(sqlId, param);
	}

	public int deleteObject(String sqlId, CmmMap param) throws Exception {
		return cmmDAO.deleteObject(sqlId, param);
	}

}
