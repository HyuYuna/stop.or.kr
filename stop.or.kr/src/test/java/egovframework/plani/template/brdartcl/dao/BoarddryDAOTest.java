/**
 * 
 */
package egovframework.plani.template.brdartcl.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import egovframework.plani.template.brdartcl.vo.BoarddryVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "boarddry.xml", type = DatabaseOperation.REFRESH)


public class BoarddryDAOTest {

  /**
   * @throws java.lang.Exception
   */
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public BoarddryDAO boarddryDAO;
  static BoarddryVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new BoarddryVO();

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoarddryDAO#insertBoarddry(egovframework.plani.template.brdartcl.vo.BoarddryVO)}
   * .
   */
  @Test
  public void testInsertBoarddry() throws Exception {

    SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
    String wdt = sm.format(new Date());

    vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    vo.setBrd_id("BDIDX_4IXfUd6cT235f2iudyx8Dk");
    vo.setSubject("insert test");
    vo.setBrd_cont("insert cont");
    vo.setStartdt(wdt);
    vo.setEnddt(wdt);
    vo.setWriter("plani");
    vo.setAllday_yn("N");
    vo.setRepeat_yn("N");
    vo.setHoliday_yn("N");

    boarddryDAO.deleteBoarddry(vo);
    boarddryDAO.insertBoarddry(vo);

    BoarddryVO article = boarddryDAO.selectBoarddry(vo);
    System.out.println(121212);
    System.out.println(vo.getBrd_id());
    assertThat("BDIDX_4IXfUd6cT235f2iudyx8Dk", is(article.getBrd_id()));
    assertThat("insert test", is(article.getSubject()));

    article.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    boarddryDAO.deleteBoarddry(article);


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoarddryDAO#updateBoarddry(egovframework.plani.template.brdartcl.vo.BoarddryVO)}
   * .
   */
  @Test
  public void testUpdateBoarddry() throws Exception {

    vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    vo.setCont_idx(300);
    vo.setBrd_id("BDIDX_4IXfUd6cT235f2iudyx8Dk");
    BoarddryVO article = boarddryDAO.selectBoarddry(vo);
    assertThat("plani", is(article.getWriter()));


    SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
    String wdt = sm.format(new Date());
    vo.setSubject("test_update");
    vo.setModifier("plani");
    vo.setAllday_yn("Y");
    vo.setRepeat_yn("Y");
    vo.setHoliday_yn("Y");
    vo.setStartdt(wdt);
    vo.setEnddt(wdt);

    boarddryDAO.updateBoarddry(vo);
    BoarddryVO updateResult = boarddryDAO.selectBoarddry(vo);
    assertThat("test_update", is(updateResult.getSubject()));
    assertThat("plani", is(updateResult.getModifier()));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoarddryDAO#deleteBoarddry(egovframework.plani.template.brdartcl.vo.BoarddryVO)}
   * .
   */
  @Test
  public void testDeleteBoarddry() throws Exception {

    vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    vo.setCont_idx(300);
    vo.setBrd_id("BDIDX_4IXfUd6cT235f2iudyx8Dk");
    boarddryDAO.deleteBoarddry(vo);

    assertNull(boarddryDAO.selectBoarddry(vo));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoarddryDAO#selectBoarddry(egovframework.plani.template.brdartcl.vo.BoarddryVO)}
   * .
   */
  @Test
  public void testSelectBoarddry() throws Exception {

    vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    vo.setCont_idx(300);
    vo.setBrd_id("BDIDX_4IXfUd6cT235f2iudyx8Dk");
    BoarddryVO result = boarddryDAO.selectBoarddry(vo);

    assertThat(300, is(result.getCont_idx()));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoarddryDAO#selectBoarddryList(egovframework.plani.template.brdartcl.vo.BoarddryVO)}
   * .
   */
  @Test
  public void testSelectBoarddryList() throws Exception {

    vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    vo.setBrd_id("BDIDX_4IXfUd6cT235f2iudyx8Dk");
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<BoarddryVO> articleList = boarddryDAO.selectBoarddryList(vo);
    assertTrue(articleList.size() >= 1);
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoarddryDAO#selectBoarddryListTotCnt(egovframework.plani.template.brdartcl.vo.BoarddryVO)}
   * .
   */
  @Test
  public void testSelectBoarddryListTotCnt() throws Exception {

    vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    vo.setBrd_id("BDIDX_4IXfUd6cT235f2iudyx8Dk");

    assertTrue(boarddryDAO.selectBoarddryListTotCnt(vo) > 0);
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoarddryDAO#xlsBoarddryList(egovframework.plani.template.brdartcl.vo.BoarddryVO)}
   * .
   */
  @Test
  public void testXlsBoarddryList() throws Exception {

    vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    vo.setCont_idx(300);
    vo.setBrd_id("BDIDX_4IXfUd6cT235f2iudyx8Dk");
    BoarddryVO result = boarddryDAO.selectBoarddry(vo);

    assertThat(300, is(result.getCont_idx()));

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoarddryDAO#selectBoarddryMainList(egovframework.plani.template.brdartcl.vo.BoarddryVO)}
   * .
   */
  @Test
  public void testSelectBoarddryMainList() throws Exception {

    vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
    vo.setBrd_id("BDIDX_4IXfUd6cT235f2iudyx8Dk");
    vo.setStartdt("2018-05-02");
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<BoarddryVO> articleList = boarddryDAO.selectBoarddryMainList(vo);
    assertTrue(articleList.size() >= 1);
  }

}
