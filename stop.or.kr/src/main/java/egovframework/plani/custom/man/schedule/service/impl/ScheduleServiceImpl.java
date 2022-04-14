package egovframework.plani.custom.man.schedule.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.custom.man.schedule.dao.ScheduleDAO;
import egovframework.plani.custom.man.schedule.service.ScheduleService;
import egovframework.plani.custom.man.schedule.vo.ScheduleVO;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

  @Resource(name = "scheduleDAO")
  private ScheduleDAO scheduleDAO;

  @Override
  public void insertSchedule(ScheduleVO vo) throws Exception {
    // TODO Auto-generated method stub
    scheduleDAO.insertSchedule(vo);
  }

  @Override
  public void updateSchedule(ScheduleVO vo) throws Exception {
    // TODO Auto-generated method stub
    scheduleDAO.updateSchedule(vo);
  }

  @Override
  public void deleteSchedule(ScheduleVO vo) throws Exception {
    // TODO Auto-generated method stub
    scheduleDAO.deleteSchedule(vo);
  }

  @Override
  public ScheduleVO selectSchedule(ScheduleVO vo) throws Exception {
    // TODO Auto-generated method stub
    return scheduleDAO.selectSchedule(vo);
  }

  @Override
  public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception {
    return scheduleDAO.selectScheduleList(vo);
    // TODO Auto-generated method stub

  }

  @Override
  public int selectScheduleListTotCnt(ScheduleVO vo) throws Exception {
    // TODO Auto-generated method stub
    return scheduleDAO.selectScheduleListTotCnt(vo);
  }

  @Override
  public List<ScheduleVO> selectTodayScheduleList(ScheduleVO vo) throws Exception {
    // TODO Auto-generated method stub
    return scheduleDAO.selectTodayScheduleList(vo);
  }

  @Override
  public List<ScheduleVO> selectMonthScheduleList(ScheduleVO vo) throws Exception {
    // TODO Auto-generated method stub
    return scheduleDAO.selectMonthScheduleList(vo);
  }

}
