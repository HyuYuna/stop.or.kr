package egovframework.plani.template.survey.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
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
import egovframework.plani.template.survey.vo.SrvyquesansVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "srvyquesans_sample.xml", type = DatabaseOperation.REFRESH)
public class SrvyquesansDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SrvyquesansDAO srvyquesansDAO;

  private SrvyquesansVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new SrvyquesansVO();
  }

  @Test
  public void testMergeSrvyquesans() throws Exception {

    vo.setQues_idx(2);
    vo.setQuesans_idx(1);
    vo.setSrvy_idx(1);
    vo.setPart_idx(3);
    vo.setQues_type("CDIDX00084");
    vo.setQuesans_cont("탁탁탁2");
    vo.setQuesans_type("N");
    vo.setAns_need_spl("N");
    vo.setAns_ord(1);

    srvyquesansDAO.deleteSrvyquesans(vo);
    srvyquesansDAO.mergeSrvyquesans(vo);

    SrvyquesansVO srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);

    assertThat(2, is(srvyquesans.getQues_idx()));

    srvyquesansDAO.deleteSrvyquesans(srvyquesans);

  }

  @Test
  public void testInsertSrvyquesans() throws Exception {

    vo.setQues_idx(3);
    vo.setQuesans_idx(1);
    vo.setSrvy_idx(1);
    vo.setPart_idx(3);
    vo.setQues_type("CDIDX00084");
    vo.setQuesans_cont("탁탁탁2");
    vo.setQuesans_type("N");
    vo.setAns_need_spl("N");
    vo.setAns_ord(1);

    srvyquesansDAO.deleteSrvyquesans(vo);
    srvyquesansDAO.insertSrvyquesans(vo);

    SrvyquesansVO srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);

    assertThat(3, is(srvyquesans.getQues_idx()));

    srvyquesansDAO.deleteSrvyquesans(srvyquesans);
  }

  @Test
  public void testUpdateSrvyquesans() throws Exception {

    vo.setQues_idx(1);
    vo.setQuesans_idx(1);

    SrvyquesansVO srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);
    srvyquesans.setQuesans_cont("탁아");

    srvyquesansDAO.updateSrvyquesans(srvyquesans);

    srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);

    assertThat("탁아", is(srvyquesans.getQuesans_cont()));

  }

  @Test
  public void testUpdateSrvyquesansOrd() throws Exception {

    vo.setQues_idx(1);
    vo.setAns_ord(1);
    vo.setQuesans_idx(1);

    SrvyquesansVO srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);
    assertThat("ych_test", is(srvyquesans.getQuesans_cont()));

    // srvyquesans.setQuesans_cont("ych_test2");

    srvyquesansDAO.updateSrvyquesansOrd(srvyquesans);

    srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);
    assertThat(1, is(srvyquesans.getQuesans_idx()));



  }

  @Test
  public void testDeleteSrvyquesans() throws Exception {

    vo.setQues_idx(1);
    vo.setQuesans_idx(1);

    SrvyquesansVO srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);
    assertThat("ych_test", is(srvyquesans.getQuesans_cont()));

    srvyquesansDAO.deleteSrvyquesans(vo);

    assertNull(srvyquesansDAO.selectSrvyquesans(vo));
  }

  @Test
  public void testDeleteSrvyquesansGroup() throws Exception {

    vo.setQues_idx(1);
    vo.setQuesans_idx(1);

    SrvyquesansVO srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);

    assertThat("ych_test", is(srvyquesans.getQuesans_cont()));

    srvyquesansDAO.deleteSrvyquesansGroup(vo);

    assertNull(srvyquesansDAO.selectSrvyquesans(vo));
  }

  @Test
  public void testSelectSrvyquesans() throws Exception {

    vo.setQues_idx(1);
    vo.setQuesans_idx(1);

    SrvyquesansVO srvyquesans = srvyquesansDAO.selectSrvyquesans(vo);

    assertThat("ych_test", is(srvyquesans.getQuesans_cont()));
  }

  @Test
  public void testSelectSrvyquesList() throws Exception {

    List srvyquesanslist = srvyquesansDAO.selectSrvyquesansList(vo);

    assertTrue(srvyquesanslist.size() >= 1);


  }

  @Test
  public void testSelectSrvyquesansList() throws Exception {

    List srvyquesanslist = srvyquesansDAO.selectSrvyquesansList(vo);

    assertTrue(srvyquesanslist.size() >= 1);
  }

  @Test
  public void testSelectSrvyquesansListTotCnt() throws Exception {
    assertTrue(srvyquesansDAO.selectSrvyquesansListTotCnt(vo) >= 1);
  }

  @Test
  public void testXlsSrvyquesansList() throws Exception {

    List srvyquesanslist = srvyquesansDAO.xlsSrvyquesansList(vo);

    assertTrue(srvyquesanslist.size() >= 1);
  }

  @Test
  public void testSelectSrvyquesansResult() throws Exception {

    List srvyquesans = srvyquesansDAO.selectSrvyquesansResult(vo);

    assertTrue(srvyquesans.size() >= 1);
  }

  @Test
  public void testSelectSrvyquesansQuesidx() throws Exception {

    assertTrue(srvyquesansDAO.selectSrvyquesansQuesidx(vo) > 1);
  }

  @Test
  public void testSelectXlsSrvyquesansList() throws Exception {

    List srvyquesans = srvyquesansDAO.xlsSrvyquesansList(vo);

    assertTrue(srvyquesans.size() >= 1);
  }

}
