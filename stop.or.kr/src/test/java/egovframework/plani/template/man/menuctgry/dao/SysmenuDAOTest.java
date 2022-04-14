package egovframework.plani.template.man.menuctgry.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import java.util.ArrayList;
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
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "sysmenu_sample.xml", type = DatabaseOperation.REFRESH)
public class SysmenuDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SysmenuDAO sysmenuDAO;

  private SysmenuVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new SysmenuVO();
  }

  @Test
  public void testInsertSysmenu() throws Exception {

    vo.setMenu_idx("MNIDX02202");
    vo.setMenu_nm("유채화테스트3");
    vo.setMenu_nix("ych33");
    vo.setMu_gub("USR");
    vo.setMu_site("CDIDX00002");
    vo.setMu_lang("CDIDX00022");
    vo.setBlank_yn("N");
    vo.setTabmenu_yn("N");
    vo.setMemmenu_yn("N");
    vo.setUse_yn("N");

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    if ("mysql".equals(dbtype)) {
      SysmenuVO srchlistVO = new SysmenuVO();
      srchlistVO.setSrch_mu_gub(vo.getSrch_mu_gub());
      srchlistVO.setSrch_mu_lang(vo.getSrch_mu_lang());
      srchlistVO.setSrch_mu_site(vo.getSrch_mu_site());
      List sysmenuList = sysmenuDAO.selectSysmenumanList(srchlistVO);

      // 조작하기 편하도록 필요한 데이터만 String 배열로 빼낸다.
      String[][] orgList = new String[sysmenuList.size()][2];
      for (int i = 0; i < sysmenuList.size(); i++) {
        SysmenuVO menuVO = (SysmenuVO) sysmenuList.get(i);
        // if(menuVO.getBrd_id())

        orgList[i][0] = menuVO.getMenu_idx();
        orgList[i][1] = menuVO.getUp_menu_idx();
      }

      // 게시판과 연동된 메뉴만 상위메뉴까지 포함해서 가져와 리스트를 만든다.
      List srchList = new ArrayList();
      srchList.add(vo.getMenu_idx());
      EgovWebUtil.getChildList(orgList, vo.getMenu_idx(), srchList);
      String[] args = (String[]) srchList.toArray(new String[srchList.size()]);
      vo.setProconce_list(args);
    }

    sysmenuDAO.deleteSysmenu(vo);
    sysmenuDAO.insertSysmenu(vo);

    SysmenuVO sysmenu = sysmenuDAO.selectSysmenu(vo);

    assertThat("ych33", is(sysmenu.getMenu_nix()));

    sysmenuDAO.deleteSysmenu(vo);

  }

  @Test
  public void testUpdateSysmenu() throws Exception {

    vo.setMenu_idx("MNIDX02006");

    SysmenuVO sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    sysmenuvo.setMenu_nm("탁");

    sysmenuDAO.updateSysmenu(sysmenuvo);

    sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("탁", is(sysmenuvo.getMenu_nm()));

  }

  @Test
  public void testUpdateSysmenuLink() throws Exception {

    vo.setMenu_idx("MNIDX02006");
    vo.setMenu_nix("ych");
    // vo.setUp_menu_idx("ych");

    SysmenuVO sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("MNIDX02006", is(sysmenuvo.getMenu_idx()));

    sysmenuvo.setMenu_link("/ych2/test2");

    sysmenuDAO.updateSysmenuLink(sysmenuvo);

    sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("/ych2/test2", is(sysmenuvo.getMenu_link()));


  }

  @Test
  public void testUpdateSysmenuOrdPlus() throws Exception {

    vo.setMenu_idx("MNIDX02007");
    vo.setMenu_nix("ych2");
    vo.setUp_menu_idx("MNIDX02006");

    SysmenuVO sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("MNIDX02007", is(sysmenuvo.getMenu_idx()));

    sysmenuvo.setOrg_menu_ord(2);
    sysmenuvo.setMenu_ord(2);

    sysmenuDAO.updateSysmenuOrdPlus(sysmenuvo);


    sysmenuvo = sysmenuDAO.selectSysmenu(vo);


    assertThat(3, is(sysmenuvo.getMenu_ord()));


  }

  @Test
  public void testUpdateSysmenuOrdMinus() throws Exception {

    vo.setMenu_idx("MNIDX02007");
    vo.setMenu_nix("ych2");
    vo.setUp_menu_idx("MNIDX02006");

    SysmenuVO sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("MNIDX02007", is(sysmenuvo.getMenu_idx()));

    sysmenuvo.setOrg_menu_ord(2);
    sysmenuvo.setMenu_ord(2);

    sysmenuDAO.updateSysmenuOrdMinus(sysmenuvo);


    sysmenuvo = sysmenuDAO.selectSysmenu(vo);


    assertThat(1, is(sysmenuvo.getMenu_ord()));
  }

  @Test
  public void testUpdateSysmenuUsetab() throws Exception {

    vo.setMenu_idx("MNIDX02006");
    vo.setMenu_nix("ych");
    vo.setUp_menu_idx("MNIDX02006");

    SysmenuVO sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("MNIDX02006", is(sysmenuvo.getMenu_idx()));

    sysmenuvo.setTabmenu_yn("Y");

    sysmenuDAO.updateSysmenuUsetab(sysmenuvo);

    sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("Y", is(sysmenuvo.getTabmenu_yn()));
  }

  @Test
  public void testUpdateUseynWithSubLevel() throws Exception {

    vo.setMenu_idx("MNIDX02006");
    vo.setMenu_nix("ych");

    SysmenuVO sysmenu = sysmenuDAO.selectSysmenu(vo);

    assertThat("MNIDX02006", is(sysmenu.getMenu_idx()));

    sysmenu.setUse_yn("N");

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    if ("mysql".equals(dbtype)) {
      SysmenuVO srchlistVO = new SysmenuVO();
      srchlistVO.setSrch_mu_gub(vo.getSrch_mu_gub());
      srchlistVO.setSrch_mu_lang(vo.getSrch_mu_lang());
      srchlistVO.setSrch_mu_site(vo.getSrch_mu_site());
      List sysmenuList = sysmenuDAO.selectSysmenumanList(srchlistVO);

      // 조작하기 편하도록 필요한 데이터만 String 배열로 빼낸다.
      String[][] orgList = new String[sysmenuList.size()][2];
      for (int i = 0; i < sysmenuList.size(); i++) {
        SysmenuVO menuVO = (SysmenuVO) sysmenuList.get(i);
        // if(menuVO.getBrd_id())

        orgList[i][0] = menuVO.getMenu_idx();
        orgList[i][1] = menuVO.getUp_menu_idx();
      }

      // 게시판과 연동된 메뉴만 상위메뉴까지 포함해서 가져와 리스트를 만든다.
      List srchList = new ArrayList();
      srchList.add(vo.getMenu_idx());
      EgovWebUtil.getChildList(orgList, vo.getMenu_idx(), srchList);
      String[] args = (String[]) srchList.toArray(new String[srchList.size()]);
      sysmenu.setProconce_list(args);
    }

    sysmenuDAO.updateUseynWithSubLevel(sysmenu);

    sysmenu = sysmenuDAO.selectSysmenu(vo);

    assertThat("N", is(sysmenu.getTabmenu_yn()));
  }

  @Test
  public void testDeleteSysmenu() throws Exception {

    vo.setMenu_idx("MNIDX02006");
    vo.setMenu_nix("ych");

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    if ("mysql".equals(dbtype)) {
      SysmenuVO srchlistVO = new SysmenuVO();
      srchlistVO.setSrch_mu_gub(vo.getSrch_mu_gub());
      srchlistVO.setSrch_mu_lang(vo.getSrch_mu_lang());
      srchlistVO.setSrch_mu_site(vo.getSrch_mu_site());
      List sysmenuList = sysmenuDAO.selectSysmenumanList(srchlistVO);

      // 조작하기 편하도록 필요한 데이터만 String 배열로 빼낸다.
      String[][] orgList = new String[sysmenuList.size()][2];
      for (int i = 0; i < sysmenuList.size(); i++) {
        SysmenuVO menuVO = (SysmenuVO) sysmenuList.get(i);
        // if(menuVO.getBrd_id())

        orgList[i][0] = menuVO.getMenu_idx();
        orgList[i][1] = menuVO.getUp_menu_idx();
      }

      // 게시판과 연동된 메뉴만 상위메뉴까지 포함해서 가져와 리스트를 만든다.
      List srchList = new ArrayList();
      srchList.add(vo.getMenu_idx());
      EgovWebUtil.getChildList(orgList, vo.getMenu_idx(), srchList);
      String[] args = (String[]) srchList.toArray(new String[srchList.size()]);
      vo.setProconce_list(args);
    }

    SysmenuVO sysmenu = sysmenuDAO.selectSysmenu(vo);

    assertThat("MNIDX02006", is(sysmenu.getMenu_idx()));

    sysmenuDAO.deleteSysmenu(vo);

    assertNull(sysmenuDAO.selectSysmenu(vo));



  }

  @Test
  public void testSelectSysmenu() throws Exception {

    vo.setMenu_idx("MNIDX02006");
    vo.setMenu_nix("ych");

    SysmenuVO sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("MNIDX02006", is(sysmenuvo.getMenu_idx()));

  }

  @Test
  @Ignore
  // @TODO 쓰고있지않음
  public void testSelectSysupmenu() throws Exception {

    vo.setMenu_idx("MNIDX02007");
    vo.setMenu_nix("ych2");

    SysmenuVO sysmenuvo = sysmenuDAO.selectSysmenu(vo);

    assertThat("MNIDX02007", is(sysmenuvo.getMenu_idx()));

    sysmenuvo = sysmenuDAO.selectSysupmenu(sysmenuvo);

    assertThat("MNIDX02006", is(sysmenuvo.getMenu_nix()));

  }

  @Test
  public void testSelectSysmenuList() throws Exception {

    vo.setMenu_idx("MNIDX02006");
    vo.setMenu_nix("ych");

    vo.setAuth_cd("MNIDX02006");

    List sysmenulist = sysmenuDAO.selectSysmenuList(vo);

    assertTrue(sysmenulist.size() >= 1);

  }

  @Test
  public void testSelectSysmenumanList() throws Exception {

    List sysmenulist = sysmenuDAO.selectSysmenumanList(vo);

    assertTrue(sysmenulist.size() >= 1);

  }

  @Test
  public void testSelectSubmenuList() throws Exception {

    vo.setAuth_cd("D0001");

    vo.setUp_menu_idx("MNIDX02006");
    vo.setSrch_menu_nix("ych");

    List sysmenulist = sysmenuDAO.selectSubmenuList(vo);

    assertTrue(sysmenulist.size() >= 1);
  }

  @Test
  public void testSelectSysmenuListSub() throws Exception {

    vo.setUp_menu_idx("MNIDX02006");

    List sysmenulist = sysmenuDAO.selectSysmenuListSub(vo);

    assertTrue(sysmenulist.size() >= 1);
  }

  @Test
  public void testSelectSysmenuListTotCnt() throws Exception {
    assertTrue(sysmenuDAO.selectSysmenuListTotCnt(vo) >= 1);
  }

}
