package egovframework.plani.template.man.metsys.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.metsys.dao.AnnouncementDataDAO;
import egovframework.plani.template.man.metsys.service.AnnouncementDataService;
import egovframework.plani.template.man.metsys.vo.AnnouncementDataVO;
import egovframework.plani.template.man.metsys.vo.AnnouncementGroupVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("announcementDataService")
public class AnnouncementDataServiceImpl extends EgovAbstractServiceImpl
    implements AnnouncementDataService {

  /** 공고 DAO */
  @Resource(name = "announcementDataDAO")
  private AnnouncementDataDAO announcementDataDAO;

  @Override
  public List selectAnnouncementDataList(AnnouncementDataVO vo) throws Exception {
    return announcementDataDAO.selectAnnouncementDataList(vo);
  }

  @Override
  public int selectAnnouncementDataListTotalCount(AnnouncementDataVO vo) throws Exception {
    return announcementDataDAO.selectAnnouncementDataListTotalCount(vo);
  }

  @Override
  public int insertAnnouncementData(AnnouncementDataVO vo) throws Exception {
    return announcementDataDAO.insertAnnouncementData(vo);
  }

  @Override
  public int updateAnnouncementData(AnnouncementDataVO vo) throws Exception {
    return announcementDataDAO.updateAnnouncementData(vo);
  }

  @Override
  public AnnouncementDataVO selectAnnouncementData(AnnouncementDataVO vo) throws Exception {
    return announcementDataDAO.selectAnnouncementData(vo);
  }

  @Override
  public int deleteAnnouncementData(AnnouncementDataVO vo) throws Exception {
    return announcementDataDAO.deleteAnnouncementData(vo);
  }

  @Override
  public List selectAnnouncementDataNoticeList(AnnouncementDataVO vo) throws Exception {
    return announcementDataDAO.selectAnnouncementDataNoticeList(vo);
  }

  @Override
  public List selectAnnouncementDataAllList(AnnouncementGroupVO vo) throws Exception {
    return announcementDataDAO.selectAnnouncementDataAllList(vo);
  }

  @Override
  public int deleteAnnouncementDataAll(AnnouncementGroupVO vo) throws Exception {
    return announcementDataDAO.deleteAnnouncementDataAll(vo);
  }


}
