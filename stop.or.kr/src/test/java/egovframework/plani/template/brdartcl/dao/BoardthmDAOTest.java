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
import egovframework.plani.template.brdartcl.vo.BoardthmVO;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "board_sample.xml", type = DatabaseOperation.REFRESH)


public class BoardthmDAOTest {

  /**
   * @throws java.lang.Exception
   */

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public BoardthmDAO boardthmDAO;
  static BoardthmVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new BoardthmVO();

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardthmDAO#insertBoardthm(egovframework.plani.template.brdartcl.vo.BoardthmVO)}
   * .
   * 
   * @throws Exception
   */
  @Test
  public void testInsertBoardthm() throws Exception {

    SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
    String wdt = sm.format(new Date());

    vo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setSubject("test");
    vo.setBrd_cont("&lt;p&gt;22&lt;br&gt;&lt;/p&gt;");
    vo.setImg_idx(0);
    vo.setThm_img_idx(0);
    vo.setHits(10);
    vo.setIs_notice("N");
    vo.setWriter("nimdasys");
    vo.setWdt(wdt);
    vo.setBrd_utb(null);
    vo.setModifier(null);
    vo.setMdt(null);

    boardthmDAO.deleteBoardthm(vo);
    boardthmDAO.insertBoardthm(vo);

    BoardthmVO article = boardthmDAO.selectBoardthm(vo);

    assertThat("BDIDX_5bpW8dU6T90YyF0gZe5nVC", is(article.getBrd_id()));
    assertThat("test", is(article.getSubject()));

    article.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
    boardthmDAO.deleteBoardthm(article);



  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardthmDAO#updateBoardthm(egovframework.plani.template.brdartcl.vo.BoardthmVO)}
   * .
   */
  @Test
  public void testUpdateBoardthm() throws Exception {


    vo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
    vo.setCont_idx(300);
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    BoardthmVO article = boardthmDAO.selectBoardthm(vo);
    assertThat("plani", is(article.getWriter()));

    SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String wdtUdate = sm.format(new Date());
    vo.setSubject("test_update");
    vo.setModifier("plani");
    vo.setMdt(wdtUdate);

    boardthmDAO.updateBoardthm(vo);
    BoardthmVO updateResult = boardthmDAO.selectBoardthm(vo);
    assertThat("test_update", is(updateResult.getSubject()));
    assertThat("plani", is(updateResult.getModifier()));


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardthmDAO#deleteBoardthm(egovframework.plani.template.brdartcl.vo.BoardthmVO)}
   * .
   */
  @Test
  public void testDeleteBoardthm() throws Exception {

    vo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
    vo.setCont_idx(300);
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    boardthmDAO.deleteBoardthm(vo);

    assertNull(boardthmDAO.selectBoardthm(vo));

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardthmDAO#selectBoardthm(egovframework.plani.template.brdartcl.vo.BoardthmVO)}
   * .
   */
  @Test
  public void testSelectBoardthm() throws Exception {

    vo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
    vo.setCont_idx(300);
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    BoardthmVO result = boardthmDAO.selectBoardthm(vo);

    assertThat(300, is(result.getCont_idx()));

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardthmDAO#selectBoardthmList(egovframework.plani.template.brdartcl.vo.BoardthmVO)}
   * .
   */
  @Test
  public void testSelectBoardthmList() throws Exception {

    vo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<BoardthmVO> articleList = boardthmDAO.selectBoardthmList(vo);
    assertTrue(articleList.size() >= 1);

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardthmDAO#selectBoardthmListTotCnt(egovframework.plani.template.brdartcl.vo.BoardthmVO)}
   * .
   */
  @Test
  public void testSelectBoardthmListTotCnt() throws Exception {

    vo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");

    assertTrue(boardthmDAO.selectBoardthmListTotCnt(vo) > 0);

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardthmDAO#updateBoardxcount(egovframework.plani.template.brdartcl.vo.BoardthmVO)}
   * .
   */
  @Test
  public void testUpdateBoardxcount() throws Exception {

    vo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
    vo.setCont_idx(300);
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    BoardthmVO article = boardthmDAO.selectBoardthm(vo);

    assertThat("plani", is(article.getWriter()));

    vo.setHits(500);

    System.out.println(vo.getHits());
    boardthmDAO.updateBoardxcount(vo);
    BoardthmVO updateResult = boardthmDAO.selectBoardthm(vo);
    assertThat(500, is(updateResult.getHits()));

  }

}
