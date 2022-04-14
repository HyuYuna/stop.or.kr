package egovframework.plani.template.man.log.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import java.util.List;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Ignore;
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
import egovframework.plani.template.man.log.vo.ManlogVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "manlog_sample.xml", type = DatabaseOperation.REFRESH)
public class ManlogDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public ManlogDAO manlogDAO;

  private ManlogVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new ManlogVO();
  }

  @Test
  public void testInsertManlog() throws Exception {

    vo.setLog_key("ych_test");
    vo.setLog_key_nm("유채화 관리");
    vo.setLog_key_dest("유채화 목록 조회");
    vo.setLog_job_gb("F");
    vo.setLog_raddr("MDowOjA6MDowOjA6MDox");
    logger.warn("insert" + vo.toString());
    manlogDAO.deleteManlog(vo);
    manlogDAO.insertManlog(vo);

    ManlogVO manlog = manlogDAO.selectManlog(vo);
    assertThat("ych_test", is(manlog.getLog_key()));

    manlogDAO.deleteManlog(manlog);

  }

  @Test
  @Ignore
  // @TODO update가 없음(xml파일에)
  public void testUpdateManlog() throws Exception {

    vo.setLog_idx(243);
    ManlogVO manlog = manlogDAO.selectManlog(vo);
    assertThat("test_test", is(manlog.getLog_key()));

    manlog.setLog_key("ttt");
    manlog.setLog_key_dest("테테테테");

    manlogDAO.updateManlog(manlog);

    manlog = manlogDAO.selectManlog(vo);
    assertThat("ttt", is(manlog.getLog_key()));
  }

  @Test
  public void testDeleteManlog() throws Exception {
    vo.setLog_idx(243);
    ManlogVO manlog = manlogDAO.selectManlog(vo);
    assertThat("test_test", is(manlog.getLog_key()));

    manlogDAO.deleteManlog(vo);
    assertNull(manlogDAO.selectManlog(manlog));

  }

  @Test
  @Ignore
  // @TODO LOG_FLOW 없음
  public void testSelectManlogSearchKind() throws Exception {

    vo.setLog_idx(243);

    ManlogVO manlog = manlogDAO.selectManlog(vo);

    assertThat("test_test", is(manlog.getLog_key()));
    logger.warn("testSelectManlogSearchKind" + manlog.toString());
    // assertTrue(manlogDAO.selectManlogSearchKind(manlog) >= 1);
  }

  @Test
  public void testSelectManlog() throws Exception {

    vo.setLog_idx(243);
    ManlogVO manlog = manlogDAO.selectManlog(vo);
    assertThat("test_test", is(manlog.getLog_key()));
  }

  @Test
  public void testSelectManlogList() throws Exception {

    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<ManlogVO> manlogList = manlogDAO.selectManlogList(vo);
    assertTrue(manlogList.size() >= 1);

  }

  @Test
  public void testSelectManlogListTotCnt() throws Exception {
    assertTrue(manlogDAO.selectManlogListTotCnt(vo) >= 2);
  }

  @Test
  public void testXlsManlogList() throws Exception {
    List<ManlogVO> manlogList = manlogDAO.xlsManlogList(vo);
    assertTrue(manlogList.size() >= 2);
  }

}
