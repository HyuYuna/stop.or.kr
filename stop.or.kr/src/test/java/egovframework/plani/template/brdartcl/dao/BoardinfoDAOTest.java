/**
 * 
 */
package egovframework.plani.template.brdartcl.dao;

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
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "boardinfo.xml", type = DatabaseOperation.REFRESH)



public class BoardinfoDAOTest {

  /**
   * @throws java.lang.Exception
   */
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public BoardinfoDAO boardinfoDAO;
  static BoardinfoVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new BoardinfoVO();

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#insertBoardinfo(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testInsertBoardinfo() throws Exception {

    vo.setBrd_id("BDIDX_9tAmZ5x0kM2z7FXtrtest");
    vo.setTbl_nm("CMS_BRD_THM_IDX_CF681234");
    vo.setBrd_nm("insert test");
    vo.setMu_site("CDIDX00002");
    vo.setMu_lang("CDIDX00022");
    vo.setBrd_dft_skin("A");
    vo.setBrd_gb("CDIDX00044");
    vo.setBrd_gb_sub("A");
    vo.setEditor_gb("A");
    vo.setUse_ctgry("N");
    vo.setUse_notice("N");
    vo.setUse_scrt("N");
    vo.setUse_rcmnd("N");
    vo.setUse_rjct("N");
    vo.setUse_atch("N");
    vo.setUse_uploadify("N");
    vo.setUse_kogl("N");
    vo.setReply_gb("N");
    vo.setAttach_cnt_limit(1);
    vo.setAttach_size_limit(20);
    vo.setAtcl_per_pg(15);
    vo.setPg_per_navi(10);
    vo.setOn_viewmode("2");
    vo.setOff_viewmode("1");
    vo.setCreate_new_table("N");

    boardinfoDAO.deleteBoardinfo(vo);
    boardinfoDAO.insertBoardinfo(vo);

    BoardinfoVO article = boardinfoDAO.selectBoardinfo(vo);

    assertThat("BDIDX_9tAmZ5x0kM2z7FXtrtest", is(article.getBrd_id()));
    assertThat("CMS_BRD_THM_IDX_CF681234", is(article.getTbl_nm()));

    boardinfoDAO.deleteBoardinfo(article);

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#createBoardTable(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testCreateBoardTable() throws Exception {

    /*
     * TODO 테이블 생성쿼리 테스트보류
     */

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#updateBoardinfo(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testUpdateBoardinfo() throws Exception {

    vo.setBrd_id("BDIDX_9tAmZ5x0kM2z7FXtr5678");
    BoardinfoVO article = boardinfoDAO.selectBoardinfo(vo);
    assertThat("CMS_BRD_THM_IDX_CF68M3GZ", is(article.getTbl_nm()));

    vo.setBrd_nm("plani 테스트 업데이트");
    vo.setModifier("플랜아이");
    vo.setUse_notice("Y");

    boardinfoDAO.updateBoardinfo(vo);
    BoardinfoVO updateResult = boardinfoDAO.selectBoardinfo(vo);
    assertThat("plani 테스트 업데이트", is(updateResult.getBrd_nm()));
    assertThat("Y", is(updateResult.getUse_notice()));


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#updateBoardinfoMenunix(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testUpdateBoardinfoMenunix() throws Exception {

    vo.setBrd_id("BDIDX_9tAmZ5x0kM2z7FXtr5678");
    BoardinfoVO article = boardinfoDAO.selectBoardinfo(vo);
    assertThat("CMS_BRD_THM_IDX_CF68M3GZ", is(article.getTbl_nm()));

    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setRef_menu_nix("ych2");
    boardinfoDAO.updateBoardinfoMenunix(vo);
    BoardinfoVO updateResult = boardinfoDAO.selectBoardinfo(vo);
    assertThat("ych2", is(updateResult.getRef_menu_nix()));


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#updateBoardinfoMenunixNull(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testUpdateBoardinfoMenunixNull() throws Exception {
    vo.setBrd_id("BDIDX_9tAmZ5x0kM2z7FXtr5678");
    BoardinfoVO article = boardinfoDAO.selectBoardinfo(vo);
    assertThat("CMS_BRD_THM_IDX_CF68M3GZ", is(article.getTbl_nm()));

    vo.setRef_menu_nix("KQc525x0");
    boardinfoDAO.updateBoardinfoMenunixNull(vo);
    BoardinfoVO updateResult = boardinfoDAO.selectBoardinfo(vo);
    assertNull(updateResult.getRef_menu_nix());

    vo.setBrd_id("BDIDX_5yD7hlmM52KpC1uORFd7Pg");
    vo.setRef_menu_nix("KQc525x0");
    boardinfoDAO.updateBoardinfoMenunix(vo);

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#deleteBoardinfo(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testDeleteBoardinfo() throws Exception {


    vo.setBrd_id("BDIDX_9tAmZ5x0kM2z7FXtr5678");
    boardinfoDAO.deleteBoardinfo(vo);

    assertNull(boardinfoDAO.selectBoardinfo(vo));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#selectBoardinfo(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testSelectBoardinfo() throws Exception {

    vo.setBrd_id("BDIDX_9tAmZ5x0kM2z7FXtr5678");
    BoardinfoVO result = boardinfoDAO.selectBoardinfo(vo);
    assertThat("CMS_BRD_THM_IDX_CF68M3GZ", is(result.getTbl_nm()));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#selectBoardinfoByName(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testSelectBoardinfoByName() throws Exception {

    vo.setBrd_nm("plani테스트게시판");
    BoardinfoVO result = boardinfoDAO.selectBoardinfoByName(vo);
    assertThat("BDIDX_9tAmZ5x0kM2z7FXtr5678", is(result.getBrd_id()));

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#selectBoardinfoList(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testSelectBoardinfoList() throws Exception {

    vo.setMu_site("CDIDX00002");
    vo.setMu_lang("CDIDX00022");

    List<BoardinfoVO> articleList = boardinfoDAO.selectBoardinfoList(vo);
    assertTrue(articleList.size() >= 1);
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#selectBoardinfoListTotCnt(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testSelectBoardinfoListTotCnt() throws Exception {

    vo.setMu_site("CDIDX00002");
    vo.setMu_lang("CDIDX00022");

    assertTrue(boardinfoDAO.selectBoardinfoListTotCnt(vo) > 0);
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardinfoDAO#selectBoardinfomenuList(egovframework.plani.template.brdartcl.vo.BoardinfoVO)}
   * .
   */
  @Test
  public void testSelectBoardinfomenuList() throws Exception {

    vo.setMu_site("CDIDX00002");
    vo.setMu_lang("CDIDX00022");

    List<BoardinfoVO> articleList = boardinfoDAO.selectBoardinfomenuList(vo);
    assertTrue(articleList.size() >= 1);
  }

}
