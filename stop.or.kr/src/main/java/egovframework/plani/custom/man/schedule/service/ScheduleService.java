package egovframework.plani.custom.man.schedule.service;

import java.util.List;
import egovframework.plani.custom.man.schedule.vo.ScheduleVO;

public interface ScheduleService {

  /**
   * 스케쥴 정보를 저장한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @exception - Exception
   */
  public void insertSchedule(ScheduleVO vo) throws Exception;

  /**
   * 스케쥴 정보를 수정한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @exception - Exception
   */
  public void updateSchedule(ScheduleVO vo) throws Exception;

  /**
   * 스케쥴 정보를 삭제한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @exception - Exception
   */
  public void deleteSchedule(ScheduleVO vo) throws Exception;

  /**
   * 스케쥴 정보를 조회한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @exception - Exception
   */
  public ScheduleVO selectSchedule(ScheduleVO vo) throws Exception;

  /**
   * 스케쥴 정보 리스트를 조회한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @return
   * @exception - Exception
   */
  public List<ScheduleVO> selectScheduleList(ScheduleVO vo) throws Exception;

  /**
   * 현재 날짜 기준 스케쥴 정보 리스트를 조회한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @return
   * @exception - Exception
   */
  public List<ScheduleVO> selectTodayScheduleList(ScheduleVO vo) throws Exception;

  /**
   * 현재 월 기준 정보 리스트를 조회한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @return
   * @exception - Exception
   */
  public List<ScheduleVO> selectMonthScheduleList(ScheduleVO vo) throws Exception;

  /**
   * 스케쥴 정보 목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectScheduleListTotCnt(ScheduleVO vo) throws Exception;
}
