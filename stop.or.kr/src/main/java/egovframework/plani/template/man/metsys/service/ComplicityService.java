package egovframework.plani.template.man.metsys.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import egovframework.plani.template.man.metsys.vo.ComplicityItemVO;
import egovframework.plani.template.man.metsys.vo.ComplicityVO;

public interface ComplicityService {

  public ArrayList<String> getEmailSelectList() throws Exception;

  public Map<String, String> getStateSelectList() throws Exception;



  public ArrayList<String> getAwardSelectList() throws Exception;

  public Map<String, String> getCitySelectList() throws Exception;

  public Map<String, String> getTargetSelectList() throws Exception;

  public Integer insertComplicity(ComplicityVO vo) throws Exception;

  public Integer insertComplicityItem(ComplicityItemVO vo) throws Exception;

  public Boolean insertComplicityItems(HttpServletRequest request, ComplicityVO vo)
      throws Exception;


  public Boolean updateComplicityItems(ComplicityVO vo) throws Exception;

  public Integer selectComplicityByEmailCount(ComplicityVO vo) throws Exception;

  public List selectComplicityItemGroupList(ComplicityVO vo) throws Exception;


  public Integer selectComplicityItemListAllTotalCount(ComplicityVO vo) throws Exception;

  public List<ComplicityItemVO> selectComplicityItemListAll(ComplicityVO vo) throws Exception;

  public List<ComplicityItemVO> getXlsList(ComplicityVO vo) throws Exception;

  public List<ComplicityVO> getSrvyXlsList(ComplicityVO vo) throws Exception;

  public ComplicityVO selectComplicity(String group_id) throws Exception;

  public ComplicityItemVO selectComplicityItem(String data_id) throws Exception;

  public List<ComplicityItemVO> selectComplicityItemGroupByList(ComplicityVO vo) throws Exception;


  public Boolean deleteComplicity(ComplicityVO vo) throws Exception;
}
