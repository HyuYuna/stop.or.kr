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
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "boardreply.xml", type = DatabaseOperation.REFRESH)

public class BoardreplyDAOTest {

  /**
   * @throws java.lang.Exception
   */
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public BoardreplyDAO boardreplyDAO;
  static BoardreplyVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new BoardreplyVO();

  }


  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardreplyDAO#insertBoardreply(egovframework.plani.template.brdartcl.vo.BoardreplyVO)}
   * .
   */
  @Test
  public void testInsertBoardreply() throws Exception {

    SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd");
    String wdt = sm.format(new Date());

    vo.setTbl_nm("CMS_BRD_REPLY_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(123);
    vo.setReply_idx(10);
    vo.setRcmnd_cnt(99);
    vo.setWriter("plani");
    vo.setWdt(wdt);

    boardreplyDAO.deleteBoardreply(vo);
    boardreplyDAO.insertBoardreply(vo);

    BoardreplyVO article = boardreplyDAO.selectBoardreply(vo);

    assertThat("BDIDX_5bpW8dU6T90YyF0gZe5nVC", is(article.getBrd_id()));
    assertThat(123, is(article.getCont_idx()));

    article.setTbl_nm("CMS_BRD_REPLY_IDX_VXD5L880");
    boardreplyDAO.deleteBoardreply(article);


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardreplyDAO#createBoardReplyTable(egovframework.plani.template.brdartcl.vo.BoardreplyVO)}
   * .
   */
  @Test
  public void testCreateBoardReplyTable() throws Exception {

    // 테이블 생성쿼리 보류
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardreplyDAO#updateBoardreply(egovframework.plani.template.brdartcl.vo.BoardreplyVO)}
   * .
   */
  @Test
  public void testUpdateBoardreply() throws Exception {

    vo.setCont_idx(300);
    vo.setReply_idx(400);
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    BoardreplyVO article = boardreplyDAO.selectBoardreply(vo);
    assertThat("plani", is(article.getWriter()));
    assertThat(300, is(article.getCont_idx()));

    vo.setReply_cont("testest");
    vo.setRcmnd_cnt(100);
    vo.setModifier("plani_test");

    boardreplyDAO.updateBoardreply(vo);
    BoardreplyVO updateResult = boardreplyDAO.selectBoardreply(vo);
    assertThat(100, is(updateResult.getRcmnd_cnt()));

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardreplyDAO#deleteBoard(egovframework.plani.template.brdartcl.vo.BoardreplyVO)}
   * .
   */
  @Test
  public void testDeleteBoard() throws Exception {

    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    boardreplyDAO.deleteBoard(vo);

    assertNull(boardreplyDAO.selectBoardreply(vo));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardreplyDAO#deleteBoardreply(egovframework.plani.template.brdartcl.vo.BoardreplyVO)}
   * .
   */
  @Test
  public void testDeleteBoardreply() throws Exception {

    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(300);
    vo.setReply_idx(400);
    boardreplyDAO.deleteBoardreply(vo);

    assertNull(boardreplyDAO.selectBoardreply(vo));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardreplyDAO#deleteBoardreplyByCont(egovframework.plani.template.brdartcl.vo.BoardreplyVO)}
   * .
   */
  @Test
  public void testDeleteBoardreplyByCont() throws Exception {

    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(300);
    boardreplyDAO.deleteBoardreplyByCont(vo);

    assertNull(boardreplyDAO.selectBoardreply(vo));

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardreplyDAO#selectBoardreply(egovframework.plani.template.brdartcl.vo.BoardreplyVO)}
   * .
   */
  @Test
  public void testSelectBoardreply() throws Exception {

    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(300);
    vo.setReply_idx(400);
    BoardreplyVO result = boardreplyDAO.selectBoardreply(vo);

    assertThat(300, is(result.getCont_idx()));

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardreplyDAO#selectBoardreplyList(egovframework.plani.template.brdartcl.vo.BoardreplyVO)}
   * .
   */
  @Test
  public void testSelectBoardreplyList() throws Exception {

    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(300);
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<BoardreplyVO> articleList = boardreplyDAO.selectBoardreplyList(vo);
    assertTrue(articleList.size() >= 1);

  }

}
