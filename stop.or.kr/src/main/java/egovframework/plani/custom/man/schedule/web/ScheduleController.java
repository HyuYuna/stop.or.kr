package egovframework.plani.custom.man.schedule.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;
import egovframework.plani.custom.man.schedule.service.ScheduleService;
import egovframework.plani.custom.man.schedule.vo.ScheduleVO;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.man.log.service.ManlogService;

@Controller
@RequestMapping("/sch")
public class ScheduleController {

  @Resource(name = "scheduleService")
  private ScheduleService scheduleService;

  @Resource
  private CrudTemplate crudTemplate;

  /** ManlogService */
  @Resource(name = "manlogService")
  protected ManlogService manlogService;

  /** Gson */
  @Resource(name = "gson")
  protected Gson gson;


  /**
   * 리스트 페이지 출력
   * 
   * @param scheduleVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */

  @RequestMapping("schList")
  public String schList(final @ModelAttribute("scheduleVO") ScheduleVO scheduleVO, Model model,
      HttpServletRequest request) throws Exception {

    Calendar cal = Calendar.getInstance(); // 현재시간

    int YEAR =
        (scheduleVO.getSrchcalYr() == null || "".equals(scheduleVO.getSrchcalYr())) ? cal
            .get(Calendar.YEAR) : Integer.parseInt(scheduleVO.getSrchcalYr()); // 현재년도
    int MON =
        (scheduleVO.getSrchcalMon() == null || "".equals(scheduleVO.getSrchcalMon())) ? cal
            .get(Calendar.MONTH) + 1 : Integer.parseInt(scheduleVO.getSrchcalMon()); // 현재월


    int CURYEAR = cal.get(Calendar.YEAR);
    int CURMON = cal.get(Calendar.MONTH) + 1; // 현재 달
    int CURDAY = cal.get(Calendar.DATE); // 현재 몇일인지

    cal.set(Calendar.YEAR, YEAR); // 입력받은 연도로 셋팅
    cal.set(Calendar.MONTH, MON - 1); // 입력받은 월로 셋팅
    cal.set(Calendar.DAY_OF_MONTH, 1); // 1일로 셋팅한 후

    String CUR_MON_NAME = cal.getDisplayName(Calendar.MONTH, Calendar.LONG, Locale.ENGLISH);


    // 여기까지 날짜 셋팅 됨.
    int DOW = cal.get(Calendar.DAY_OF_WEEK) - 1; // 1일의 요일을 구함
    int DCNT = cal.getActualMaximum(Calendar.DATE); // 현재월의 날짜 수
    int DTO = (int) (7 * (Math.floor((DCNT + DOW) / 7) + ((DCNT + DOW) % 7 == 0 ? 0 : 1)));

    // 이전달 구하기
    cal.add(Calendar.MONTH, -1);
    int PREYEAR = cal.get(Calendar.YEAR);
    int PREMON = cal.get(Calendar.MONTH) + 1;
    int PREDAY = cal.get(Calendar.DATE);

    cal.set(Calendar.MONTH, MON - 1);

    // 다음달 구하기
    cal.add(Calendar.MONTH, 1);
    int NEXTYEAR = cal.get(Calendar.YEAR);
    int NEXTMON = cal.get(Calendar.MONTH) + 1;
    int NEXTDAY = cal.get(Calendar.DATE);


    model.addAttribute("SYEAR", YEAR);
    model.addAttribute("SMON", MON);
    model.addAttribute("CUR_MON_NAME", CUR_MON_NAME);
    model.addAttribute("SCURDAY", CURDAY);
    // model.addAttribute("SCURMON", CURMON);
    // model.addAttribute("SCURYEAR", CURYEAR);
    model.addAttribute("PREYEAR", PREYEAR);
    model.addAttribute("PREMON", PREMON);
    model.addAttribute("PREDAY", PREDAY);
    model.addAttribute("NEXTYEAR", NEXTYEAR);
    model.addAttribute("NEXTMON", NEXTMON);
    model.addAttribute("NEXTDAY", NEXTDAY);
    model.addAttribute("SDOW", DOW);
    model.addAttribute("SDCNT", DCNT);
    model.addAttribute("DTO", DTO);

    // int M_LEN = (int) (Math.log10(MON) + 1);
    // int D_LEN = (int) (Math.log10(CURDAY) + 1);
    // String Z_MON = ((M_LEN <= 1) ? "0" + MON : MON).toString();
    // String Z_DAY = ((D_LEN <= 1) ? "0" + CURDAY : CURDAY).toString();
    //
    // scheduleVO.setS_date(YEAR + "-" + Z_MON + "-" + Z_DAY);

    // scheduleVO.setS_date(YEAR + "-" + MON + "-" + DCNT);

    scheduleVO.setS_date(YEAR + "-" + MON + "-" + CURDAY);

    /* 오늘 날짜에 대한 데이터 값 뽑아오기 */
    List<ScheduleVO> todaylist = scheduleService.selectTodayScheduleList(scheduleVO);
    model.addAttribute("todaylist", todaylist);

    /* 해당 월에 대한 데이터 값 뽑아오기 */
    List<ScheduleVO> monlist = scheduleService.selectMonthScheduleList(scheduleVO);
    model.addAttribute("monlist", monlist);

    // 월별로 구하고 나서.. 전체로 가지고 가서 날짜가 돌때마다 체킹해서 표시하기.
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
    Date sdate = null;
    List mdaylist = new ArrayList();

    if (monlist != null) {
      for (int i = 0; i < monlist.size(); i++) {
        cal.setTime(formatter.parse(monlist.get(i).getS_date()));
        mdaylist.add(cal.get(Calendar.DAY_OF_MONTH));
      }
      model.addAttribute("mdaylist", mdaylist);
    }

    return "/sch/schList";
  }

  /**
   * 클릭한 날짜 일정 가져오기
   * 
   * @param scheduleVO
   * @param model
   * @param request
   * @return
   * @throws Exception
   */
  @RequestMapping("seldayschlist")
  @ResponseBody
  public String seldayschlist(@ModelAttribute("scheduleVO") ScheduleVO scheduleVO, Model model,
      HttpServletRequest request) throws Exception {

    /* 해당날짜에 대한 데이터 값 뽑아오기 */
    List<ScheduleVO> seldaylist = scheduleService.selectTodayScheduleList(scheduleVO);
    List daylist = new ArrayList();
    // wdt를 vo에서 가져오는데 gson multi name error 나므로 각각 다시 필요한 subject만 arraylist으로 전달
    for (int i = 0; i < seldaylist.size(); i++) {
      daylist.add(seldaylist.get(i).getSubject());
    }

    String json_maplist = gson.toJson(daylist);


    return json_maplist;
  }
}
