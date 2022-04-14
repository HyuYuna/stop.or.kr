package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.AwardsGroupVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AwardsGroupDAO {

  /**
   * 공고 그룹 전체 리스트
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List selectAwardsGroupList(AwardsGroupVO vo) throws Exception;

  /**
   * 공고 그룹 전체 개수
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public int selectAwardsGroupListTotalCount(AwardsGroupVO vo) throws Exception;

  /**
   * 공고 그룹 개별 정보
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public AwardsGroupVO selectAwardsGroup(AwardsGroupVO vo) throws Exception;

  /**
   * 공고 그룹 등록
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer insertAwardsGroup(AwardsGroupVO vo) throws Exception;

  /**
   * 공고 그룹 수정
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer updateAwardsGroup(AwardsGroupVO vo) throws Exception;

  /**
   * 공고 그룹 삭제
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer deleteAwardsGroup(AwardsGroupVO vo) throws Exception;

  /**
   * 공고그룹 전체
   * 
   * @return
   * @throws Exception
   */
  public List selectAwardsGroupListAll() throws Exception;
}
