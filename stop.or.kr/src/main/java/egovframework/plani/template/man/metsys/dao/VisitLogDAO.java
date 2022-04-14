package egovframework.plani.template.man.metsys.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import egovframework.plani.template.cmm.dao.EgovComAbstractDAO;
import egovframework.plani.template.man.metsys.vo.VisitLogVO;

@Repository("visitLogDAO")
public class VisitLogDAO extends EgovComAbstractDAO {
  /**
   * 방문 정보를 기록
   * 
   * @param vo
   * @throws Exception
   */
  public String insertVisitLog(VisitLogVO vo) throws Exception {
    return (String) insert("VisitLogDAO.insertVisitLog", vo);
  }

  /**
   * 방문 기록 조회
   */
  public List selectVisitLogList(VisitLogVO vo) throws Exception {
    List result = null;
    if (vo.getSearchCondition() != null) {
      if (vo.getSearchCondition().equals("year"))
        result = (List) list("VisitLogDAO.selectVisitLogListYear", vo);
      else if (vo.getSearchCondition().equals("month") || vo.getSearchCondition().equals("day")
          || vo.getSearchCondition().equals("hour"))
        result = (List) list("VisitLogDAO.selectVisitLogListMDH", vo);
      else if (vo.getSearchCondition().equals("keyword"))
        result = (List) list("VisitLogDAO.selectVisitLogListKeyword", vo);
      else
        result = (List) list("VisitLogDAO.selectVisitLogListARNC", vo);
    }

    return result;
  }
}
