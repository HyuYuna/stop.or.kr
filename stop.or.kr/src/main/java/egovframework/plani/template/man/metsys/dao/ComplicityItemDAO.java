package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.ComplicityItemVO;
import egovframework.plani.template.man.metsys.vo.ComplicityVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ComplicityItemDAO {

  public Integer insertComplicityItem(ComplicityItemVO vo) throws Exception;

  public Integer updateComplicityItem(ComplicityItemVO vo) throws Exception;

  public List selectComplicityItemGroupList(ComplicityVO vo) throws Exception;

  public Integer selectComplicityItemListAllTotalCount(ComplicityVO vo) throws Exception;

  public List<ComplicityItemVO> selectComplicityItemListAll(ComplicityVO vo) throws Exception;

  public List<ComplicityItemVO> getXlsList(ComplicityVO vo) throws Exception;

  public List<ComplicityVO> getSrvyXlsList(ComplicityVO vo) throws Exception;

  public ComplicityItemVO selectComplicityItem(String data_id) throws Exception;

  public List<ComplicityItemVO> selectComplicityItemGroupByList(ComplicityVO vo) throws Exception;

  public Integer deleteComplicityItemByGroupId(Integer group_id) throws Exception;
}
