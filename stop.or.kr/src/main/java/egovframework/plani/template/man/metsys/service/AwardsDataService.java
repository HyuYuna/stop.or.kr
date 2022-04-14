package egovframework.plani.template.man.metsys.service;

import java.util.List;
import java.util.Map;
import egovframework.plani.template.man.metsys.vo.AwardsDataVO;
import egovframework.plani.template.man.metsys.vo.AwardsGroupVO;

public interface AwardsDataService {

  public Map<String, String> getAwardsSelectList() throws Exception;



  public List selectAwardsDataList(AwardsDataVO vo) throws Exception;

  public AwardsDataVO selectAwardsData(AwardsDataVO vo) throws Exception;

  public int selectAwardsDataListTotalCount(AwardsDataVO vo) throws Exception;

  public int insertAwardsData(AwardsDataVO vo) throws Exception;

  public int updateAwardsData(AwardsDataVO vo) throws Exception;

  public int deleteAwardsData(AwardsDataVO vo) throws Exception;

  public List selectAwardsDataNoticeList(AwardsDataVO vo) throws Exception;

  public List selectAwardsDataAllList(AwardsGroupVO vo) throws Exception;

  public int deleteAwardsDataAll(AwardsGroupVO vo) throws Exception;
}
