package egovframework.plani.template.man.metsys.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.metsys.dao.AwardsGroupDAO;
import egovframework.plani.template.man.metsys.service.AwardsGroupService;
import egovframework.plani.template.man.metsys.vo.AwardsGroupVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("awardsGroupService")
public class AwardsGroupServiceImpl extends EgovAbstractServiceImpl implements AwardsGroupService {

  /** 공고 그룹 DAO */
  @Resource(name = "awardsGroupDAO")
  private AwardsGroupDAO awardsGroupDAO;

  @Override
  public List selectAwardsGroupList(AwardsGroupVO vo) throws Exception {
    return awardsGroupDAO.selectAwardsGroupList(vo);
  }

  @Override
  public int selectAwardsGroupListTotalCount(AwardsGroupVO vo) throws Exception {
    return awardsGroupDAO.selectAwardsGroupListTotalCount(vo);
  }

  @Override
  public int insertAwardsGroup(AwardsGroupVO vo) throws Exception {
    return awardsGroupDAO.insertAwardsGroup(vo);
  }

  @Override
  public int updateAwardsGroup(AwardsGroupVO vo) throws Exception {
    return awardsGroupDAO.updateAwardsGroup(vo);
  }

  @Override
  public AwardsGroupVO selectAwardsGroup(AwardsGroupVO vo) throws Exception {
    return awardsGroupDAO.selectAwardsGroup(vo);
  }

  @Override
  public int deleteAwardsGroup(AwardsGroupVO vo) throws Exception {
    return awardsGroupDAO.deleteAwardsGroup(vo);
  }

  @Override
  public List selectAwardsGroupListAll() throws Exception {
    return awardsGroupDAO.selectAwardsGroupListAll();
  }



}
