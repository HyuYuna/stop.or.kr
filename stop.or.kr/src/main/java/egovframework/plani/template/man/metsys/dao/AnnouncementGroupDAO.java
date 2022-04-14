package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface AnnouncementGroupDAO {

  /**
   * 공고 그룹 전체 리스트
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public List selectAnnouncementGroupList(AnnouncementGroupVO vo) throws Exception;

  /**
   * 공고 그룹 전체 개수
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public int selectAnnouncementGroupListTotalCount(AnnouncementGroupVO vo) throws Exception;

  /**
   * 공고 그룹 개별 정보
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public AnnouncementGroupVO selectAnnouncementGroup(AnnouncementGroupVO vo) throws Exception;

  /**
   * 공고 그룹 등록
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer insertAnnouncementGroup(AnnouncementGroupVO vo) throws Exception;

  /**
   * 공고 그룹 수정
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer updateAnnouncementGroup(AnnouncementGroupVO vo) throws Exception;

  /**
   * 공고 그룹 삭제
   * 
   * @param vo
   * @return
   * @throws Exception
   */
  public Integer deleteAnnouncementGroup(AnnouncementGroupVO vo) throws Exception;

  /**
   * 공고그룹 전체
   * 
   * @return
   * @throws Exception
   */
  public List selectAnnouncementGroupListAll() throws Exception;
}
