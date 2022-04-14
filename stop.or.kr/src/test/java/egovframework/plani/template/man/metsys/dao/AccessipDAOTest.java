package egovframework.plani.template.man.metsys.dao;

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
import egovframework.plani.template.man.metsys.vo.AccessipVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})


public class AccessipDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public AccessipDAO accessipDAO;

  private AccessipVO vo;


  @Before
  public void setUp() throws Exception {
    vo = new AccessipVO();
  }

  @Test
  public void testInsertAccessip() throws Exception {

    vo = Insert_query(vo);

    AccessipVO accessip = accessipDAO.selectAccessip(vo);

    assertThat("G0003", is(accessip.getAuth_cd()));

    accessipDAO.deleteAccessip(vo);
  }

  @Test
  public void testUpdateAccessip() throws Exception {

    vo = Insert_query(vo);

    AccessipVO accessip = accessipDAO.selectAccessip(vo);

    assertThat("G0003", is(accessip.getAuth_cd()));

    accessip.setModifier("테스트");

    accessipDAO.updateAccessip(accessip);

    accessip = accessipDAO.selectAccessip(vo);

    assertThat("테스트", is(accessip.getModifier()));

    accessipDAO.deleteAccessip(vo);

  }

  @Test
  public void testDeleteAccessip() throws Exception {

    vo = Insert_query(vo);

    AccessipVO accessip = accessipDAO.selectAccessip(vo);

    assertThat("G0003", is(accessip.getAuth_cd()));

    accessipDAO.deleteAccessip(vo);

    assertNull(accessipDAO.selectAccessip(vo));

  }

  @Test
  public void testSelectAccessip() throws Exception {

    vo = Insert_query(vo);

    AccessipVO accessip = accessipDAO.selectAccessip(vo);

    assertThat("G0003", is(accessip.getAuth_cd()));

    accessipDAO.deleteAccessip(vo);
  }

  @Test
  public void testSelectAccessipList() throws Exception {

    vo = Insert_query(vo);

    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List accessiplist = accessipDAO.selectAccessipList(vo);

    assertTrue(accessiplist.size() >= 1);

    accessipDAO.deleteAccessip(vo);

  }

  @Test
  public void testSelectAccessipListTotCnt() throws Exception {

    vo = Insert_query(vo);

    assertTrue(accessipDAO.selectAccessipListTotCnt(vo) >= 1);

    accessipDAO.deleteAccessip(vo);
  }

  @Test
  public void testXlsAccessipList() throws Exception {

    vo = Insert_query(vo);

    List accessiplist = accessipDAO.xlsAccessipList(vo);

    assertTrue(accessiplist.size() >= 1);

    accessipDAO.deleteAccessip(vo);

  }

  public AccessipVO Insert_query(AccessipVO vo) throws Exception {

    vo.setAuth_cd("G0003");
    vo.setAccess_ip("*");

    accessipDAO.deleteAccessip(vo);
    accessipDAO.insertAccessip(vo);

    return vo;



  }

}
