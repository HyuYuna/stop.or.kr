package egovframework.plani.template.man.metsys.service;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.AwardsGroupVO;

public interface AwardsGroupService {

  public List selectAwardsGroupList(AwardsGroupVO vo) throws Exception;

  public AwardsGroupVO selectAwardsGroup(AwardsGroupVO vo) throws Exception;

  public int selectAwardsGroupListTotalCount(AwardsGroupVO vo) throws Exception;

  public int insertAwardsGroup(AwardsGroupVO vo) throws Exception;

  public int updateAwardsGroup(AwardsGroupVO vo) throws Exception;

  public int deleteAwardsGroup(AwardsGroupVO vo) throws Exception;

  public List selectAwardsGroupListAll() throws Exception;

}
