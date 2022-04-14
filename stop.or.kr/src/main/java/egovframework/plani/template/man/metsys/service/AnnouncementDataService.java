package egovframework.plani.template.man.metsys.service;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.AnnouncementDataVO;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;

public interface AnnouncementDataService {

  public List selectAnnouncementDataList(AnnouncementDataVO vo) throws Exception;

  public AnnouncementDataVO selectAnnouncementData(AnnouncementDataVO vo) throws Exception;

  public int selectAnnouncementDataListTotalCount(AnnouncementDataVO vo) throws Exception;

  public int insertAnnouncementData(AnnouncementDataVO vo) throws Exception;

  public int updateAnnouncementData(AnnouncementDataVO vo) throws Exception;

  public int deleteAnnouncementData(AnnouncementDataVO vo) throws Exception;

  public List selectAnnouncementDataNoticeList(AnnouncementDataVO vo) throws Exception;

  public List selectAnnouncementDataAllList(AnnouncementGroupVO vo) throws Exception;

  public int deleteAnnouncementDataAll(AnnouncementGroupVO vo) throws Exception;
}
