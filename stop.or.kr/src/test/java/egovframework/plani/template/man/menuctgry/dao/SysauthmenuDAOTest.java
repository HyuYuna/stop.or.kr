package egovframework.plani.template.man.menuctgry.dao;

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
import egovframework.plani.template.man.menuctgry.vo.SysauthVO;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "sysauthmenu_sample.xml", type = DatabaseOperation.REFRESH)
public class SysauthmenuDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SysauthmenuDAO sysauthmenuDAO;

  private SysauthVO auth_vo;

  private SysmenuVO menu_vo;


  @Before
  public void setUp() throws Exception {
    auth_vo = new SysauthVO();
    menu_vo = new SysmenuVO();
  }

  @Test
  public void testInsertSysauthmenu() throws Exception {

    auth_vo.setAuth_cd("G0003");
    // auth_vo.setMenu_nix("MNIDX02006");

    menu_vo.setAuth_cd("G0003");
    menu_vo.setMenu_idx("MNIDX02006");
    menu_vo.setWriter("ych2");

    sysauthmenuDAO.deleteSysauthmenuByAuthcd(auth_vo);
    sysauthmenuDAO.insertSysauthmenu(menu_vo);

    SysmenuVO sysmenu = sysauthmenuDAO.selectSysauthmenu(menu_vo);

    assertThat("ych2", is(sysmenu.getWriter()));

    sysauthmenuDAO.deleteSysauthmenuByAuthcd(auth_vo);

  }

  @Test
  public void testUpdateSysauthmenu() throws Exception {

    menu_vo.setAuth_cd("G0003");
    menu_vo.setMenu_idx("MNIDX02007");
    // menu_vo.setWriter("ych");
    SysmenuVO sysmenu = sysauthmenuDAO.selectSysauthmenu(menu_vo);

    assertThat("ych", is(sysmenu.getWriter()));

    sysmenu.setModifier("테스트");

    sysauthmenuDAO.updateSysauthmenu(sysmenu);

    sysmenu = sysauthmenuDAO.selectSysauthmenu(menu_vo);

    assertThat("테스트", is(sysmenu.getModifier()));


  }

  @Test
  public void testDeleteSysauthmenuByAuthcd() throws Exception {

    auth_vo.setAuth_cd("G0003");
    auth_vo.setMenu_nix("MNIDX02007");
    menu_vo.setAuth_cd("G0003");
    menu_vo.setMenu_idx("MNIDX02007");

    sysauthmenuDAO.deleteSysauthmenuByAuthcd(auth_vo);

    assertNull(sysauthmenuDAO.selectSysauthmenu(menu_vo));
  }

  @Test
  public void testDeleteSysauthmenuByMenuidx() throws Exception {
    menu_vo.setAuth_cd("G0003");
    menu_vo.setMenu_idx("MNIDX02007");

    sysauthmenuDAO.deleteSysauthmenuByMenuidx(menu_vo);

    assertNull(sysauthmenuDAO.selectSysauthmenu(menu_vo));

  }

  @Test
  public void testSelectSysauthmenu() throws Exception {

    menu_vo.setAuth_cd("G0003");
    menu_vo.setMenu_idx("MNIDX02007");

    SysmenuVO sysmenu = sysauthmenuDAO.selectSysauthmenu(menu_vo);

    assertThat("G0003", is(sysmenu.getAuth_cd()));
  }

  @Test
  public void testSelectSysauthmenuList() throws Exception {

    menu_vo.setAuth_cd("G0003");
    menu_vo.setMu_gub("USER");
    menu_vo.setMenu_idx("MNIDX02007");

    List sysmenulist = sysauthmenuDAO.selectSysauthmenuList(menu_vo);

    assertTrue(sysmenulist.size() >= 0);

  }

  @Test
  public void testSelectSysauthmenuListTotCnt() throws Exception {

    menu_vo.setAuth_cd("G0003");
    menu_vo.setMenu_idx("MNIDX02007");
    logger.warn("testSelectSysauthmenuListTotCnt"
        + sysauthmenuDAO.selectSysauthmenuListTotCnt(menu_vo));
    assertTrue(sysauthmenuDAO.selectSysauthmenuListTotCnt(menu_vo) >= 1);
  }

  @Test
  public void testXlsSysauthmenuList() throws Exception {
    menu_vo.setAuth_cd("G0003");
    menu_vo.setMenu_idx("MNIDX02007");

    List sysmenulist = sysauthmenuDAO.xlsSysauthmenuList(menu_vo);

    assertTrue(sysmenulist.size() >= 0);
  }

}
