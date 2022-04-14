package egovframework.plani.template.man.menuctgry.dao;

import static org.hamcrest.CoreMatchers.is;
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
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "sysauth_sample.xml", type = DatabaseOperation.REFRESH)
public class SysauthDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SysauthDAO sysauthDAO;

  private SysauthVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new SysauthVO();
  }

  @Test
  // @TODO 쿼리에서 값을 추출해서 넣어주는데, 문자가 안들어가고 공백으로 들어가는 형태로 들어감..
  public void testInsertSysauth() throws Exception {

    vo.setAuth_cd("U0000");
    vo.setAuth_nm("ych3_test2");
    vo.setUp_auth_cd("Y0000");
    sysauthDAO.deleteSysauth(vo);
    // 플래그만바뀜.
    sysauthDAO.insertSysauth(vo);
    // vo.setAuth_cd("0001 ");
    SysauthVO sysauth = sysauthDAO.selectSysauth(vo);

    logger.warn("testInsertSysauth" + sysauth.toString());

    assertThat("ych3_test2", is(sysauth.getAuth_nm()));

    sysauthDAO.deleteSysauth(sysauth);

  }

  @Test
  public void testUpdateSysauth() throws Exception {

    vo.setAuth_cd("G0003");
    SysauthVO sysauth = sysauthDAO.selectSysauth(vo);

    assertThat("ych2_test", is(sysauth.getAuth_nm()));

    sysauth.setAuth_nm("테스트");

    sysauthDAO.updateSysauth(sysauth);

    assertThat("테스트", is(sysauth.getAuth_nm()));
  }

  @Test
  public void testDeleteSysauth() throws Exception {

    vo.setAuth_cd("G0003");

    SysauthVO sysauth = sysauthDAO.selectSysauth(vo);

    assertThat("ych2_test", is(sysauth.getAuth_nm()));

    sysauthDAO.deleteSysauth(vo);

    sysauth = sysauthDAO.selectSysauth(vo);

    assertThat("N", is(sysauth.getUse_yn()));

  }

  @Test
  public void testSelectSysauth() throws Exception {

    vo.setAuth_cd("G0003");

    SysauthVO sysauth = sysauthDAO.selectSysauth(vo);

    assertThat("ych2_test", is(sysauth.getAuth_nm()));
  }

  @Test
  public void testSelectSysauthList() throws Exception {

    List sysauthlist = sysauthDAO.selectSysauthList(vo);

    assertTrue(sysauthlist.size() >= 1);
  }

  @Test
  public void testSelectSysauthListTotCnt() throws Exception {
    vo.setAuth_cd("G0003");
    assertTrue(sysauthDAO.selectSysauthListTotCnt(vo) >= 1);
  }

  @Test
  public void testSelectSysauthSubList() throws Exception {

    List sysauthlist = sysauthDAO.selectSysauthList(vo);
    logger.warn("testSelectSysauthSubList" + sysauthlist.size());
    assertTrue(sysauthlist.size() >= 1);
  }

  @Test
  @Ignore
  // @TODO XML에 쿼리함수가 존재하지않음.
  public void testXlsSysauthList() throws Exception {

    List sysauthlist = sysauthDAO.xlsSysauthList(vo);

    assertTrue(sysauthlist.size() >= 1);
  }

}
