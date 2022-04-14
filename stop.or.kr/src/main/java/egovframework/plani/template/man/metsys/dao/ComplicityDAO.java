package egovframework.plani.template.man.metsys.dao;

import egovframework.plani.template.man.metsys.vo.ComplicityVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ComplicityDAO {

  /**
   * 작품접수 기본정보 저장
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer insertComplicity(ComplicityVO vo) throws Exception;

  public Integer selectComplicityByEmailCount(ComplicityVO vo) throws Exception;

  public ComplicityVO selectComplicity(String group_id) throws Exception;

  public Integer deleteComplicity(Integer group_id) throws Exception;
}
