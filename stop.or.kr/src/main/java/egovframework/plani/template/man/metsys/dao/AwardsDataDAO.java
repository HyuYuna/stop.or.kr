package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.AwardsDataVO;
import egovframework.plani.template.man.metsys.vo.AwardsGroupVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AwardsDataDAO {

  /**
   * 공고 리스트
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List selectAwardsDataList(AwardsDataVO vo) throws Exception;

  /**
   * 공고 그룹 전체 개수
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public int selectAwardsDataListTotalCount(AwardsDataVO vo) throws Exception;

  /**
   * 공고 개별 정보
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public AwardsDataVO selectAwardsData(AwardsDataVO vo) throws Exception;

  /**
   * 공고 등록
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer insertAwardsData(AwardsDataVO vo) throws Exception;

  /**
   * 공고 수정
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer updateAwardsData(AwardsDataVO vo) throws Exception;

  /**
   * 공고 삭제
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer deleteAwardsData(AwardsDataVO vo) throws Exception;

  /**
   * 공고 공지 리스트
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List selectAwardsDataNoticeList(AwardsDataVO vo) throws Exception;

  /**
   * 공고그룹 리스트
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List selectAwardsDataAllList(AwardsGroupVO vo) throws Exception;

  /**
   * 공고 그룹 데이터 삭제
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public int deleteAwardsDataAll(AwardsGroupVO vo) throws Exception;
}
