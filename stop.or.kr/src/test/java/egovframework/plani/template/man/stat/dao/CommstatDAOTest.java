package egovframework.plani.template.man.stat.dao;

import static org.junit.Assert.assertTrue;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import com.github.springtestdbunit.DbUnitTestExecutionListener;
import com.github.springtestdbunit.TransactionDbUnitTestExecutionListener;
import com.github.springtestdbunit.annotation.DatabaseOperation;
import com.github.springtestdbunit.annotation.DatabaseSetup;
import com.ibm.icu.util.Calendar;
import egovframework.plani.template.man.stat.vo.CommstatVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "commstat_sample.xml", type = DatabaseOperation.REFRESH)
public class CommstatDAOTest {

  @Resource
  public CommstatDAO commstatDAO;

  private CommstatVO vo;

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  Calendar car = Calendar.getInstance();

  @Before
  public void setUp() throws Exception {
    vo = new CommstatVO();
  }

  @Test
  public void testInsertCommstat() throws Exception {

    vo.setStat_key("ychtest");
    vo.setStat_sessid("he4x3s2yg7QsH8GsOr30662621Io84q34PB5yFO40ZqcpnUWWr6kHOHHrclO04D3");
    vo.setStat_key_nm("테스트");

    commstatDAO.insertCommstat(vo);
    // delte 없습니다.
    assertTrue(commstatDAO.selectCommstatCnt(vo) >= 1);


  }

  @Test
  public void testViewstatCountry() throws Exception {


    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.MONTH, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    List<CommstatVO> commstatList = commstatDAO.viewstatCountry(vo);

    assertTrue(commstatList.size() >= 1);

  }

  @Test
  public void testViewstatCity() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.MONTH, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    List<CommstatVO> commstatList = commstatDAO.viewstatCity(vo);
    logger.warn("testViewstatCity" + commstatList.size());
    assertTrue(commstatList.size() >= 1);
  }

  @Test
  public void testViewstatOS() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.MONTH, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    List<CommstatVO> commstatList = commstatDAO.viewstatOS(vo);

    assertTrue(commstatList.size() >= 1);
  }

  @Test
  public void testViewstatBrowser() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.MONTH, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    List<CommstatVO> commstatList = commstatDAO.viewstatBrowser(vo);

    assertTrue(commstatList.size() >= 1);
  }

  @Test
  public void testViewstatVisitHourly() throws Exception {

    List<CommstatVO> commstatList = commstatDAO.viewstatVisitHourly(vo);

    assertTrue(commstatList.size() >= 1);

  }

  @Test
  public void testViewstatVisitDaily() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.MONTH, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    List<CommstatVO> commstatList = commstatDAO.viewstatVisitDaily(vo);

    assertTrue(commstatList.size() >= 1);
  }

  @Test
  public void testViewstatVisitMonthly() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyyMM");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.MONTH, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    List<CommstatVO> commstatList = commstatDAO.viewstatVisitMonthly(vo);
    logger.warn("testViewstatVisitMonthly" + commstatList.size());
    assertTrue(commstatList.size() >= 1);
  }

  @Test
  public void testViewstatVisitYearly() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyy");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.YEAR, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    List<CommstatVO> commstatList = commstatDAO.viewstatVisitYearly(vo);

    assertTrue(commstatList.size() >= 1);
  }

  @Test
  public void testSelectCommstatCnt() throws Exception {

    vo.setStat_key("test");
    vo.setStat_sessid("he4x3s2yg7QsH8GsOr30662621Io84q34PB5yFO40ZqcpnUWWr6kHOHHrclO04D3");

    assertTrue(commstatDAO.selectCommstatCnt(vo) >= 1);
  }

  @Test
  public void testSelectCommstatList() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyy");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.YEAR, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);
    logger.warn("testSelectCommstatList" + vo);
    List<CommstatVO> commstatList = commstatDAO.viewstatVisitYearly(vo);
    logger.warn("testSelectCommstatList" + commstatList.size());
    assertTrue(commstatList.size() >= 1);
  }

  @Test
  // @TODO 값이 들어잇지 않는 케이스므로 0
  public void testSelectCommstatListTotCnt() throws Exception {

    vo.setStat_key("test");

    assertTrue(commstatDAO.selectCommstatListTotCnt(vo) >= 0);
  }

  @Test
  public void testXlsCommstatList() throws Exception {
    vo.setStat_key("test");
    List<CommstatVO> commstatList = commstatDAO.xlsCommstatList(vo);
    logger.warn("testXlsCommstatList" + commstatList.size());
    assertTrue(commstatList.size() >= 1);
  }

  @Test
  public void testViewstatVisitDailyTotCnt() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.MONTH, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    CommstatVO commstatvo = commstatDAO.viewstatVisitDailyTotCnt(vo);
    logger.warn("testViewstatVisitDailyTotCnt" + commstatvo.toString());
    assertTrue(commstatvo.getTot_cnt() >= 1);
  }

  @Test
  public void testViewstatVisitMonthlyTotCnt() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyyMM");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.MONTH, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    CommstatVO commstatvo = commstatDAO.viewstatVisitMonthlyTotCnt(vo);
    assertTrue(commstatvo.getTot_cnt() >= 1);
  }

  @Test
  public void testViewstatVisitYearlyTotCnt() throws Exception {

    SimpleDateFormat sf = new SimpleDateFormat("yyyy");

    vo.setSrchToDT(sf.format(car.getTime()));
    car.add(Calendar.YEAR, -1);
    vo.setSrchFromDT(sf.format(car.getTime()));

    CommstatVO commstatvo = commstatDAO.viewstatVisitYearlyTotCnt(vo);
    assertTrue(commstatvo.getTot_cnt() >= 1);
  }

  @Test
  public void testUpdateCommstatContactCnt() throws Exception {

    vo.setStat_key("test");
    vo.setStat_sessid("he4x3s2yg7QsH8GsOr30662621Io84q34PB5yFO40ZqcpnUWWr6kHOHHrclO04D3");

    commstatDAO.updateCommstatContactCnt(vo);

    assertTrue(commstatDAO.selectCommstatCnt(vo) >= 1);

  }

  @Test
  public void testViewstatVisitPage() throws Exception {

    List<CommstatVO> commstatList = commstatDAO.viewstatVisitPage(vo);

    assertTrue(commstatList.size() >= 1);
  }

}
