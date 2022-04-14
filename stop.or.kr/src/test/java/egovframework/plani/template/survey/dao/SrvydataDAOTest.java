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
import egovframework.plani.template.survey.vo.SrvydataVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "srvydata_sample.xml", type = DatabaseOperation.REFRESH)
public class SrvydataDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SrvydataDAO srvydataDAO;

  private SrvydataVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new SrvydataVO();
  }

  @Test
  public void testMergeSrvydata() throws Exception {

    vo.setData_idx(2);
    vo.setQues_idx(2);
    vo.setQuessub_idx(2);
    vo.setSrvy_idx(2);
    vo.setData_cont("testtest");
    vo.setData_addr("MDowOjA6MDowOjA6MDox");

    srvydataDAO.deleteSrvydata(vo);
    srvydataDAO.insertSrvydata(vo);

    SrvydataVO srvydata = srvydataDAO.selectSrvydata(vo);

    assertThat(2, is(srvydata.getData_idx()));

    srvydataDAO.deleteSrvydata(srvydata);

  }

  @Test
  public void testInsertSrvydata() throws Exception {

    vo.setData_idx(2);
    vo.setQues_idx(2);
    vo.setQuessub_idx(2);
    vo.setSrvy_idx(2);
    vo.setData_cont("testtest");
    vo.setData_addr("MDowOjA6MDowOjA6MDox");

    srvydataDAO.deleteSrvydata(vo);
    srvydataDAO.insertSrvydata(vo);

    SrvydataVO srvydata = srvydataDAO.selectSrvydata(vo);

    assertThat(2, is(srvydata.getData_idx()));

    srvydataDAO.deleteSrvydata(srvydata);
  }

  @Test
  @Ignore
  // @TODO 쿼리가없음
  public void testUpdateSrvydata() throws Exception {

    vo.setData_idx(1);
    vo.setQues_idx(1);
    vo.setQuessub_idx(1);

    SrvydataVO srvydata = srvydataDAO.selectSrvydata(vo);

    assertThat("ych_test", is(srvydata.getData_cont()));

    srvydata.setData_cont("ych_test2");

    srvydataDAO.updateSrvydata(srvydata);

    srvydata = srvydataDAO.selectSrvydata(vo);

    assertThat("ych_test2", is(srvydata.getData_cont()));

  }

  @Test
  public void testDeleteSrvydata() throws Exception {

    vo.setData_idx(1);
    vo.setQues_idx(1);
    vo.setQuessub_idx(1);

    SrvydataVO srvydata = srvydataDAO.selectSrvydata(vo);

    assertThat("ych_test", is(srvydata.getData_cont()));

    srvydataDAO.deleteSrvydata(vo);

    assertNull(srvydataDAO.selectSrvydata(vo));

  }

  @Test
  public void testSelectSrvydata() throws Exception {

    vo.setData_idx(1);
    vo.setQues_idx(1);
    vo.setQuessub_idx(1);

    SrvydataVO srvydata = srvydataDAO.selectSrvydata(vo);

    assertThat("ych_test", is(srvydata.getData_cont()));


  }

  @Test
  public void testSelectSrvydataList() throws Exception {

    List srvydatalist = srvydataDAO.selectSrvydataList(vo);

    assertTrue(srvydatalist.size() >= 1);


  }

  @Test
  public void testSelectSrvydataListTotCnt() throws Exception {

    assertTrue(srvydataDAO.selectSrvydataListTotCnt(vo) >= 1);
  }

  @Test
  @Ignore
  // @TODO 쿼리에서 컬럼명이 맞지않는거 같음..
  public void testXlsSrvydataList() throws Exception {

    List srvydatalist = srvydataDAO.xlsSrvydataList(vo);
    logger.warn("testXlsSrvydataList" + srvydatalist.size());
    assertTrue(srvydatalist.size() >= 1);
  }

  @Test
  public void testSelectSrvydataKey() throws Exception {

    assertTrue(srvydataDAO.selectSrvydataKey(vo) >= 1);

  }

  @Test
  public void testSelectSrvydataCont() throws Exception {

    vo.setSrvy_idx(1);
    List srvydata = srvydataDAO.selectSrvydataCont(vo);

    assertTrue(srvydata.size() >= 1);
  }

  @Test
  public void testSelectSrvydataDupCnt() throws Exception {

    vo.setSrvy_idx(1);
    vo.setData_addr("MDowOjA6MDowOjA6MDox");

    assertTrue(srvydataDAO.selectSrvydataDupCnt(vo) >= 1);


  }

}
