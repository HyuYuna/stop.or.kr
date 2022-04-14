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
import egovframework.plani.template.brdartcl.vo.BoardrcmndVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "boardrcmnd.xml", type = DatabaseOperation.REFRESH)


public class BoardrcmndDAOTest {

  /**
   * @throws java.lang.Exception
   */
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public BoardrcmndDAO boardrcmndDAO;
  static BoardrcmndVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new BoardrcmndVO();

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardrcmndDAO#insertBoardrcmnd(egovframework.plani.template.brdartcl.vo.BoardrcmndVO)}
   * .
   */
  @Test
  public void testInsertBoardrcmnd() throws Exception {


    vo.setBrd_id("BDIDX_77A32WZfbw3NBY6Wa82BP6");
    vo.setRcmnd_id("plani");
    vo.setRcmnd_gb("J");
    vo.setCont_idx(301);

    boardrcmndDAO.deleteBoardrcmnd(vo);
    boardrcmndDAO.insertBoardrcmnd(vo);


    BoardrcmndVO article = boardrcmndDAO.selectBoardrcmnd(vo);

    assertThat("BDIDX_77A32WZfbw3NBY6Wa82BP6", is(article.getBrd_id()));
    assertThat(301, is(article.getCont_idx()));

    boardrcmndDAO.deleteBoardrcmnd(article);


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardrcmndDAO#updateBoardrcmnd(egovframework.plani.template.brdartcl.vo.BoardrcmndVO)}
   * .
   */
  @Test
  public void testUpdateBoardrcmnd() throws Exception {


    /*
     * TODO map파일에 쿼리문이 존재하지않음. 쿼리문 필요.
     */

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardrcmndDAO#deleteBoardrcmnd(egovframework.plani.template.brdartcl.vo.BoardrcmndVO)}
   * .
   */
  @Test
  public void testDeleteBoardrcmnd() throws Exception {

    vo.setBrd_id("BDIDX_77A32WZfbw3NBY6Wa82BP6");
    vo.setCont_idx(300);
    boardrcmndDAO.deleteBoardrcmnd(vo);

    vo.setRcmnd_idx(100);
    assertNull(boardrcmndDAO.selectBoardrcmnd(vo));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardrcmndDAO#selectBoardrcmnd(egovframework.plani.template.brdartcl.vo.BoardrcmndVO)}
   * .
   */
  @Test
  public void testSelectBoardrcmnd() throws Exception {

    vo.setRcmnd_idx(100);
    BoardrcmndVO result = boardrcmndDAO.selectBoardrcmnd(vo);

    assertThat(100, is(result.getRcmnd_idx()));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardrcmndDAO#selectBoardrcmndList(egovframework.plani.template.brdartcl.vo.BoardrcmndVO)}
   * .
   */
  @Test
  public void testSelectBoardrcmndList() throws Exception {

    vo.setBrd_id("BDIDX_77A32WZfbw3NBY6Wa82BP6");
    vo.setCont_idx(300);

    List<BoardrcmndVO> articleList = boardrcmndDAO.selectBoardrcmndList(vo);
    assertTrue(articleList.size() >= 1);
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardrcmndDAO#selectBoardrcmndListTotCnt(egovframework.plani.template.brdartcl.vo.BoardrcmndVO)}
   * .
   */
  @Test
  public void testSelectBoardrcmndListTotCnt() throws Exception {

    vo.setBrd_id("BDIDX_77A32WZfbw3NBY6Wa82BP6");
    vo.setCont_idx(300);

    assertTrue(boardrcmndDAO.selectBoardrcmndListTotCnt(vo) > 0);

  }

}
