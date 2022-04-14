/**
 * 
 */
package egovframework.plani.template.man.metsys.dao;

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
import egovframework.plani.template.man.metsys.vo.VisitLogVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
// @DatabaseSetup(value = "boardfaq.xml", type = DatabaseOperation.REFRESH)

public class VisitLogDAOTest {

  /**
   * @throws java.lang.Exception
   */
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public VisitLogDAO visitLogDAO;
  static VisitLogVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new VisitLogVO();

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.man.metsys.dao.VisitLogDAO#insertVisitLog(egovframework.plani.template.man.metsys.vo.VisitLogVO)}
   * .
   */
  @Test
  public void testInsertVisitLog() {
    // TODO map파일 없음

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.man.metsys.dao.VisitLogDAO#selectVisitLogList(egovframework.plani.template.man.metsys.vo.VisitLogVO)}
   * .
   */
  @Test
  public void testSelectVisitLogList() {
    // TODO map파일 없음

  }

}
