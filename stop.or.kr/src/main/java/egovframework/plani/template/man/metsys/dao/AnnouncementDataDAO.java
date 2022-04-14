package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.AnnouncementDataVO;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AnnouncementDataDAO {

  /**
   * 공고 리스트
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List selectAnnouncementDataList(AnnouncementDataVO vo) throws Exception;

  /**
   * 공고 그룹 전체 개수
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public int selectAnnouncementDataListTotalCount(AnnouncementDataVO vo) throws Exception;

  /**
   * 공고 개별 정보
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public AnnouncementDataVO selectAnnouncementData(AnnouncementDataVO vo) throws Exception;

  /**
   * 공고 등록
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer insertAnnouncementData(AnnouncementDataVO vo) throws Exception;

  /**
   * 공고 수정
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer updateAnnouncementData(AnnouncementDataVO vo) throws Exception;

  /**
   * 공고 삭제
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer deleteAnnouncementData(AnnouncementDataVO vo) throws Exception;

  /**
   * 공고 공지 리스트
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List selectAnnouncementDataNoticeList(AnnouncementDataVO vo) throws Exception;

  /**
   * 공고그룹 리스트
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List selectAnnouncementDataAllList(AnnouncementGroupVO vo) throws Exception;

  /**
   * 공고 그룹 데이터 삭제
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public int deleteAnnouncementDataAll(AnnouncementGroupVO vo) throws Exception;
}
