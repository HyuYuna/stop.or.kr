package egovframework.plani.template.man.metsys.dao;

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
import egovframework.plani.template.man.metsys.vo.ContentsmanVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
public class ContentsmanDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public ContentsmanDAO contentsmanDAO;

  private ContentsmanVO vo;


  @Before
  public void setUp() throws Exception {
    vo = new ContentsmanVO();
  }

  @Test
  public void testInsertContentsman() throws Exception {

    Insert_query(vo);

    ContentsmanVO contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych", is(contentsman.getUcont_subject()));


    contentsmanDAO.deleteContentsman(vo);


    // fail("Not yet implemented");
  }

  @Test
  public void testInsertContentsmanNewver() throws Exception {

    vo.setUcont_id("CTX000002");
    vo.setUcont_version(1);
    vo.setUcont_subject("ych");
    vo.setUcont_dft("ych_설명");
    vo.setUcont_cont("설명");

    contentsmanDAO.insertContentsmanNewver(vo);

    ContentsmanVO contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych", is(contentsman.getUcont_subject()));

    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  public void testUpdateContentsman() throws Exception {

    Insert_query(vo);

    ContentsmanVO contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych", is(contentsman.getUcont_subject()));

    contentsman.setUcont_subject("ych2");

    contentsmanDAO.updateContentsman(contentsman);

    contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych2", is(contentsman.getUcont_subject()));

    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  public void testUpdateContentsmanMenunix() throws Exception {

    Insert_query(vo);

    ContentsmanVO contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych", is(contentsman.getUcont_subject()));

    contentsman.setRef_menu_nix("ych2");

    contentsmanDAO.updateContentsmanMenunix(contentsman);

    contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych2", is(contentsman.getRef_menu_nix()));


    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  /* @TODO MYSQL 에서 외래키로 똑같이 필드가 같아야 해서 업데이트 에러뜸. */
  public void testUpdateContentsmanMenunixNull() throws Exception {

    vo.setRef_menu_nix("ych2");
    Insert_query(vo);

    ContentsmanVO contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych", is(contentsman.getUcont_subject()));

    contentsmanDAO.updateContentsmanMenunixNull(vo);

    contentsman = contentsmanDAO.selectContentsman(vo);

    assertNull(contentsman.getRef_menu_nix());

    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  public void testDeleteContentsman() throws Exception {
    Insert_query(vo);

    ContentsmanVO contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych", is(contentsman.getUcont_subject()));

    contentsmanDAO.deleteContentsman(vo);

    assertNull(contentsmanDAO.selectContentsman(vo));
  }

  @Test
  public void testSelectContentsman() throws Exception {
    Insert_query(vo);
    ContentsmanVO contentsman = contentsmanDAO.selectContentsman(vo);

    assertThat("ych", is(contentsman.getUcont_subject()));

    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  public void testSelectContentsmanList() throws Exception {

    Insert_query(vo);

    List contentsmanlist = contentsmanDAO.selectContentsmanList(vo);

    assertTrue(contentsmanlist.size() >= 1);

    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  public void testSelectContentsmanmenuList() throws Exception {

    /* 여기서부터 작업해야함 */
    Insert_query(vo);

    List contentsmanlist = contentsmanDAO.selectContentsmanmenuList(vo);

    assertTrue(contentsmanlist.size() >= 1);

    vo.setUcont_id(vo.getUcont_id());

    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  @Ignore
  // @TODO 쿼리오류, 사용치 않음
  public void testSelectContentsmanRefmenuList() throws Exception {

    Insert_query(vo);

    vo.setOrderbyQuery("ych2");


    List contentsmanlist = contentsmanDAO.selectContentsmanRefmenuList(vo);

    assertTrue(contentsmanlist.size() >= 1);

    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  public void testSelectContentsmanRestorelist() throws Exception {
    Insert_query(vo);

    // vo.setUcont_id(vo.getUcont_id());
    vo.setUcont_version(0);

    List contentsmanlist = contentsmanDAO.selectContentsmanRestorelist(vo);
    assertTrue(contentsmanlist.size() >= 1);

    vo.setUcont_version(1);
    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  public void testSelectContentsmanListTotCnt() throws Exception {

    Insert_query(vo);

    vo.setUcont_id("CTX000002");
    vo.setRef_menu_nix("ych2");
    vo.setUcont_version(1);
    vo.setUcont_subject("ych");
    vo.setUcont_dft("ych_설명");
    vo.setUcont_cont("설명");

    assertTrue(contentsmanDAO.selectContentsmanListTotCnt(vo) >= 1);
    contentsmanDAO.deleteContentsman(vo);
  }

  @Test
  public void testRestoreContentsman() throws Exception {

    Insert_query(vo);
    vo.setUcont_version(0);
    contentsmanDAO.restoreContentsman(vo);
    assertNull(contentsmanDAO.selectContentsman(vo));
  }

  public ContentsmanVO Insert_query(ContentsmanVO vo) throws Exception {

    vo.setUcont_id("CTX000002");
    vo.setRef_menu_nix("ych2");
    vo.setUcont_version(1);
    vo.setUcont_subject("ych");
    vo.setUcont_dft("ych_설명");
    vo.setUcont_cont("설명");

    contentsmanDAO.insertContentsman(vo);



    return vo;



  }



}
