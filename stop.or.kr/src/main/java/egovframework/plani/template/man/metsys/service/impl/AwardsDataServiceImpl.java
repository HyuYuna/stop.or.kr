package egovframework.plani.template.man.metsys.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.metsys.dao.AwardsDataDAO;
import egovframework.plani.template.man.metsys.service.AwardsDataService;
import egovframework.plani.template.man.metsys.vo.AwardsDataVO;
import egovframework.plani.template.man.metsys.vo.AwardsGroupVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("awardsDataService")
public class AwardsDataServiceImpl extends EgovAbstractServiceImpl implements AwardsDataService {

  /** 수상작 DAO */
  @Resource(name = "awardsDataDAO")
  private AwardsDataDAO awardsDataDAO;


  @Override
  public Map<String, String> getAwardsSelectList() throws Exception {
    Map<String, String> state = new LinkedHashMap<String, String>();
    state.put("10", "대상");
    state.put("20", "금상");
    state.put("30", "은상");
    state.put("40", "동상");
    state.put("999", "수상작");
    state.put("50", "최우수상");
    state.put("60", "우수상");
    return state;
  }

  @Override
  public List selectAwardsDataList(AwardsDataVO vo) throws Exception {
    return awardsDataDAO.selectAwardsDataList(vo);
  }

  @Override
  public int selectAwardsDataListTotalCount(AwardsDataVO vo) throws Exception {
    return awardsDataDAO.selectAwardsDataListTotalCount(vo);
  }

  @Override
  public int insertAwardsData(AwardsDataVO vo) throws Exception {
    return awardsDataDAO.insertAwardsData(vo);
  }

  @Override
  public int updateAwardsData(AwardsDataVO vo) throws Exception {
    return awardsDataDAO.updateAwardsData(vo);
  }

  @Override
  public AwardsDataVO selectAwardsData(AwardsDataVO vo) throws Exception {
    return awardsDataDAO.selectAwardsData(vo);
  }

  @Override
  public int deleteAwardsData(AwardsDataVO vo) throws Exception {
    return awardsDataDAO.deleteAwardsData(vo);
  }

  @Override
  public List selectAwardsDataNoticeList(AwardsDataVO vo) throws Exception {
    return awardsDataDAO.selectAwardsDataNoticeList(vo);
  }

  @Override
  public List selectAwardsDataAllList(AwardsGroupVO vo) throws Exception {
    return awardsDataDAO.selectAwardsDataAllList(vo);
  }

  @Override
  public int deleteAwardsDataAll(AwardsGroupVO vo) throws Exception {
    return awardsDataDAO.deleteAwardsDataAll(vo);
  }


}
