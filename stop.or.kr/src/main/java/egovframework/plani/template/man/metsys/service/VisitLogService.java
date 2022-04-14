package egovframework.plani.template.man.metsys.service;

import java.util.List;
import egovframework.plani.template.man.metsys.vo.VisitLogVO;

public interface VisitLogService {
  /**
   * 방문정보 기록
   */
  public String insertVisitLog(VisitLogVO vo) throws Exception;

  /**
   * 방문 기록 조회
   */
  public List selectVisitLogList(VisitLogVO vo) throws Exception;
}
