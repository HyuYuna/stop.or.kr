package egovframework.plani.template.man.metsys.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.man.metsys.dao.VisitLogDAO;
import egovframework.plani.template.man.metsys.service.VisitLogService;
import egovframework.plani.template.man.metsys.vo.VisitLogVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("visitLogService")
public class VisitLogServiceImpl extends EgovAbstractServiceImpl implements VisitLogService {
  @Resource(name = "visitLogDAO")
  private VisitLogDAO logDao;

  /**
   * 방문 정보를 기록
   */
  @Override
  public String insertVisitLog(VisitLogVO vo) throws Exception {
    return logDao.insertVisitLog(vo);
  }

  /**
   * 방문 기록 조회
   */
  @Override
  public List selectVisitLogList(VisitLogVO vo) throws Exception {
    return logDao.selectVisitLogList(vo);
  }
}
