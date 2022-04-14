package egovframework.plani.template.cmm.dao;

import static org.junit.Assert.fail;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import com.github.springtestdbunit.DbUnitTestExecutionListener;
import com.github.springtestdbunit.TransactionDbUnitTestExecutionListener;
import com.github.springtestdbunit.annotation.DatabaseOperation;
import com.github.springtestdbunit.annotation.DatabaseSetup;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "message_sample.xml", type = DatabaseOperation.CLEAN_INSERT)
public class MessageDAOTest {

  @Before
  public void setUp() throws Exception {}

  @Test
  @Ignore
  // @TODO 테이블 존재하지 않음
  public void testSendSms() {
    fail("Not yet implemented");
  }

  @Test
  @Ignore
  // @TODO 테이블 존재하지 않음
  public void testSendMmsMessageVO() {
    fail("Not yet implemented");
  }

  @Test
  @Ignore
  // @TODO 테이블 존재하지 않음
  public void testSendMmsListOfMessageVO() {
    fail("Not yet implemented");
  }

}
