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
import egovframework.plani.template.survey.vo.SrvymainVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "srvymain_sample.xml", type = DatabaseOperation.REFRESH)
public class SrvymainDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SrvymainDAO srvymainDAO;

  private SrvymainVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new SrvymainVO();
  }

  @Test
  public void testInsertSrvymain() throws Exception {

    vo.setSrvy_idx(3);
    vo.setSrvy_nm("테테테");
    vo.setSrvy_allow_dup("Y");
    vo.setSrvy_open_yn("Y");
    vo.setSrvy_max_ans(0);
    vo.setSrvy_pop_type("W");
    vo.setSrvy_end("2018-05-02");

    srvymainDAO.deleteSrvymain(vo);
    srvymainDAO.insertSrvymain(vo);

    SrvymainVO srvymainvo = srvymainDAO.selectSrvymain(vo);
    assertThat(3, is(srvymainvo.getSrvy_idx()));

    srvymainDAO.deleteSrvymain(vo);

  }

  @Test
  public void testUpdateSrvymain() throws Exception {

    vo.setSrvy_idx(2);
    SrvymainVO srvymainvo = srvymainDAO.selectSrvymain(vo);
    srvymainvo.setSrvy_nm("하하하하");
    srvymainDAO.updateSrvymain(srvymainvo);

    srvymainvo = srvymainDAO.selectSrvymain(vo);

    assertThat("하하하하", is(srvymainvo.getSrvy_nm()));
  }

  @Test
  public void testDeleteSrvymain() throws Exception {

    vo.setSrvy_idx(2);
    SrvymainVO srvymainvo = srvymainDAO.selectSrvymain(vo);
    assertThat(2, is(srvymainvo.getSrvy_idx()));
    srvymainDAO.deleteSrvymain(vo);
    assertNull(srvymainDAO.selectSrvymain(vo));
  }

  @Test
  public void testSelectSrvymain() throws Exception {
    vo.setSrvy_idx(2);
    SrvymainVO srvymainvo = srvymainDAO.selectSrvymain(vo);
    assertThat(2, is(srvymainvo.getSrvy_idx()));
  }

  @Test
  public void testSelectSrvymainList() throws Exception {
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<SrvymainVO> srvymainList = srvymainDAO.selectSrvymainList(vo);
    assertTrue(srvymainList.size() >= 1);
  }

  @Test
  public void testSelectSrvymainListTotCnt() throws Exception {
    assertTrue(srvymainDAO.selectSrvymainListTotCnt(vo) >= 1);
  }

  @Test
  public void testXlsSrvymainList() throws Exception {
    List<SrvymainVO> srvymainList = srvymainDAO.xlsSrvymainList(vo);
    assertTrue(srvymainList.size() >= 1);
  }

}
