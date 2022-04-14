package egovframework.plani.template.man.metsys.service;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;

public interface AnnouncementGroupService {

  public List selectAnnouncementGroupList(AnnouncementGroupVO vo) throws Exception;

  public AnnouncementGroupVO selectAnnouncementGroup(AnnouncementGroupVO vo) throws Exception;

  public int selectAnnouncementGroupListTotalCount(AnnouncementGroupVO vo) throws Exception;

  public int insertAnnouncementGroup(AnnouncementGroupVO vo) throws Exception;

  public int updateAnnouncementGroup(AnnouncementGroupVO vo) throws Exception;

  public int deleteAnnouncementGroup(AnnouncementGroupVO vo) throws Exception;

  public List selectAnnouncementGroupListAll() throws Exception;

}
