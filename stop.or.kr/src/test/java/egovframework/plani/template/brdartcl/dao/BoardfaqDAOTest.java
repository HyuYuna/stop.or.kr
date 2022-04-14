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
import egovframework.plani.template.brdartcl.vo.BoardfaqVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "boardfaq.xml", type = DatabaseOperation.REFRESH)


public class BoardfaqDAOTest {

  /**
   * @throws java.lang.Exception
   */
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public BoardfaqDAO boardfaqDAO;
  static BoardfaqVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new BoardfaqVO();

  }


  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#insertBoardfaq(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testInsertBoardfaq() throws Exception {

    vo.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setSubject("플랜아이 테스트");
    vo.setHits(200);
    vo.setWriter("플랜아이");
    vo.setBrd_cont("내용");

    boardfaqDAO.deleteBoardfaq(vo);
    boardfaqDAO.insertBoardfaq(vo);


    BoardfaqVO article = boardfaqDAO.selectBoardfaq(vo);


    assertThat("BDIDX_5bpW8dU6T90YyF0gZe5nVC", is(article.getBrd_id()));
    assertThat("플랜아이 테스트", is(article.getSubject()));

    article.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
    boardfaqDAO.deleteBoardfaq(article);
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#updateBoardfaqreply(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testUpdateBoardfaqreply() throws Exception {

    // TODO 연결된 쿼리문 없음

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#updateBoardfaq(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testUpdateBoardfaq() throws Exception {

    vo.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(100);

    BoardfaqVO article = boardfaqDAO.selectBoardfaq(vo);
    assertThat("plani test", is(article.getSubject()));

    vo.setModifier("플랜아이");

    boardfaqDAO.updateBoardfaq(vo);
    BoardfaqVO updateResult = boardfaqDAO.selectBoardfaq(vo);
    assertThat("플랜아이", is(updateResult.getModifier()));


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#deleteBoardfaq(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testDeleteBoardfaq() throws Exception {

    vo.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(100);
    boardfaqDAO.deleteBoardfaq(vo);

    assertNull(boardfaqDAO.selectBoardfaq(vo));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#selectBoardfaq(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testSelectBoardfaq() throws Exception {

    vo.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(100);

    BoardfaqVO result = boardfaqDAO.selectBoardfaq(vo);
    assertThat("plani test", is(result.getSubject()));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#selectBoardfaqList(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testSelectBoardfaqList() throws Exception {
    vo.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<BoardfaqVO> articleList = boardfaqDAO.selectBoardfaqList(vo);
    assertTrue(articleList.size() >= 1);

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#selectBoardfaqListTotCnt(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testSelectBoardfaqListTotCnt() throws Exception {

    vo.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");

    assertTrue(boardfaqDAO.selectBoardfaqListTotCnt(vo) > 0);
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#updateBoardxcount(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testUpdateBoardxcount() throws Exception {

    vo.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
    vo.setBrd_id("BDIDX_5bpW8dU6T90YyF0gZe5nVC");
    vo.setCont_idx(100);
    boardfaqDAO.updateBoardxcount(vo);

    BoardfaqVO updateResult = boardfaqDAO.selectBoardfaq(vo);
    assertThat(101, is(updateResult.getHits()));


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardfaqDAO#selectBoardfaqgroupList(egovframework.plani.template.brdartcl.vo.BoardfaqVO)}
   * .
   */
  @Test
  public void testSelectBoardfaqgroupList() throws Exception {
    // TODO 연결된 쿼리가 없음
  }

}
