package egovframework.plani.template.survey.dao;

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
import egovframework.plani.template.survey.vo.SrvypartVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "srvypart_sample.xml", type = DatabaseOperation.REFRESH)
public class SrvypartDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SrvypartDAO srvypartDAO;

  private SrvypartVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new SrvypartVO();
  }

  @Test
  @Ignore
  // @TODO 쿼리가 없음
  public void testMergeSrvypart() throws Exception {

  }

  @Test
  public void testInsertSrvypart() throws Exception {

    vo.setSrvy_idx(1);
    vo.setPart_idx(4);
    vo.setPart_nm("테테테2");
    vo.setPart_type("테타입");

    srvypartDAO.deleteSrvypart(vo);
    srvypartDAO.insertSrvypart(vo);

    vo.setPart_idx(4);
    SrvypartVO srvypartvo = srvypartDAO.selectSrvypart(vo);


    assertThat(4, is(srvypartvo.getPart_idx()));

    srvypartDAO.deleteSrvypart(srvypartvo);

  }

  @Test
  public void testUpdateSrvypart() throws Exception {

    vo.setSrvy_idx(1);
    vo.setPart_idx(3);
    SrvypartVO srvypartvo = srvypartDAO.selectSrvypart(vo);

    assertThat("테스트", is(srvypartvo.getPart_nm()));

    srvypartvo.setPart_nm("탁탁");
    srvypartvo.setPart_type("탁타입");

    srvypartDAO.updateSrvypart(srvypartvo);

    srvypartvo = srvypartDAO.selectSrvypart(vo);

    assertThat("탁탁", is(srvypartvo.getPart_nm()));
  }

  @Test
  public void testDeleteSrvypart() throws Exception {

    vo.setSrvy_idx(1);
    vo.setPart_idx(3);
    SrvypartVO srvypartvo = srvypartDAO.selectSrvypart(vo);

    assertThat("테스트", is(srvypartvo.getPart_nm()));

    srvypartDAO.deleteSrvypart(vo);

    assertNull(srvypartDAO.selectSrvypart(vo));

  }

  @Test
  public void testSelectSrvypart() throws Exception {

    vo.setSrvy_idx(1);
    vo.setPart_idx(3);
    SrvypartVO srvypartvo = srvypartDAO.selectSrvypart(vo);
    assertThat("테스트", is(srvypartvo.getPart_nm()));
  }

  @Test
  public void testSelectSrvypartList() throws Exception {

    vo.setSrvy_idx(1);

    List srvypartlist = srvypartDAO.selectSrvypartList(vo);

    assertTrue(srvypartlist.size() >= 2);
  }

  @Test
  @Ignore
  // @TODO 쿼리가 없음
  public void testSelectSrvypartListTotCnt() throws Exception {

  }

  @Test
  // @TODO SRVY_IDX를 셋팅하지 않고 하게되면 디폴트 0으로 값이 셋팅 되는데 그럴경우 쿼리가 사이즈를 계속 0을 던져줘서 값을 셋팅해서 뺌...
  public void testXlsSrvypartList() throws Exception {
    vo.setSrvy_idx(1);
    assertTrue(srvypartDAO.xlsSrvypartList(vo).size() >= 1);
  }

}
