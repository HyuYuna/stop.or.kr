package egovframework.plani.template.man.metsys.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.metsys.dao.AnnouncementGroupDAO;
import egovframework.plani.template.man.metsys.service.AnnouncementGroupService;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("announcementGroupService")
public class AnnouncementGroupServiceImpl extends EgovAbstractServiceImpl
    implements AnnouncementGroupService {

  /** 공고 그룹 DAO */
  @Resource(name = "announcementGroupDAO")
  private AnnouncementGroupDAO announcementGroupDAO;

  @Override
  public List selectAnnouncementGroupList(AnnouncementGroupVO vo) throws Exception {
    return announcementGroupDAO.selectAnnouncementGroupList(vo);
  }

  @Override
  public int selectAnnouncementGroupListTotalCount(AnnouncementGroupVO vo) throws Exception {
    return announcementGroupDAO.selectAnnouncementGroupListTotalCount(vo);
  }

  @Override
  public int insertAnnouncementGroup(AnnouncementGroupVO vo) throws Exception {
    return announcementGroupDAO.insertAnnouncementGroup(vo);
  }

  @Override
  public int updateAnnouncementGroup(AnnouncementGroupVO vo) throws Exception {
    return announcementGroupDAO.updateAnnouncementGroup(vo);
  }

  @Override
  public AnnouncementGroupVO selectAnnouncementGroup(AnnouncementGroupVO vo) throws Exception {
    return announcementGroupDAO.selectAnnouncementGroup(vo);
  }

  @Override
  public int deleteAnnouncementGroup(AnnouncementGroupVO vo) throws Exception {
    return announcementGroupDAO.deleteAnnouncementGroup(vo);
  }

  @Override
  public List selectAnnouncementGroupListAll() throws Exception {
    return announcementGroupDAO.selectAnnouncementGroupListAll();
  }



}
