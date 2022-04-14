package egovframework.plani.custom.man.schedule.dao;

import java.util.List;
import egovframework.plani.custom.man.schedule.vo.ScheduleVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface ScheduleDAO {
  /**
   * 정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertSchedule(ScheduleVO vo) throws Exception;

  /**
   * 정보을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateSchedule(ScheduleVO vo) throws Exception;

  /**
   * 정보을/를 삭제한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteSchedule(ScheduleVO vo) throws Exception;

  /**
   * 정보을/를 조회한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public ScheduleVO selectSchedule(ScheduleVO vo) throws Exception;

  /**
   * 정보리스트을/를 조회한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;

  /**
   * 현재 날짜 리스트을/를 조회한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public List<ScheduleVO> selectTodayScheduleList(ScheduleVO vo) throws Exception;

  /**
   * 현재 월 리스트을/를 조회한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  public List<ScheduleVO> selectMonthScheduleList(ScheduleVO vo) throws Exception;

  /**
   * 정보리스트을/를 조회한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @return
   * @exception Exception
   */
  public int selectScheduleListTotCnt(ScheduleVO vo) throws Exception;


}
