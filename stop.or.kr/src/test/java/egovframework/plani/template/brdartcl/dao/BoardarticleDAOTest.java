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
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "boardarticle.xml", type = DatabaseOperation.REFRESH)
public class BoardarticleDAOTest {

  /**
   * @throws java.lang.Exception
   */
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public BoardarticleDAO boardarticleDAO;
  static BoardarticleVO vo;

  @Before
  public void setUp() throws Exception {

    vo = new BoardarticleVO();

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#insertBoardarticle(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testInsertBoardarticle() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setSubject("플랜아이테스트");
    vo.setCont_idx(3);
    vo.setHits(200);
    vo.setGrp_no(1);
    vo.setGrp_lv(1);
    vo.setGrp_ord(1);
    vo.setEdomweivgp("P");

    // mssql
    vo.setCtgry_idx("CTIDX00024");

    // mysql
    vo.setBrd_cont("1234");


    vo.setWriter("플랜아이");

    boardarticleDAO.deleteBoardarticle(vo);
    boardarticleDAO.insertBoardarticle(vo);

    BoardarticleVO article = boardarticleDAO.selectBoardarticle(vo);

    // assertThat("BDIDX_2JA41KFZ3982IX44w905I5", is(article.getBrd_id()));
    assertThat("플랜아이테스트", is(article.getSubject()));

    article.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    boardarticleDAO.deleteBoardarticle(article);



  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#updateBoardarticlereply(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testUpdateBoardarticlereply() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setGrp_no(100);
    vo.setGrp_ord(1);

    // mysql
    vo.setBrd_cont("1234");

    boardarticleDAO.updateBoardarticlereply(vo);

    vo.setCont_idx(100);
    vo.setWriter("플랜아이");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    BoardarticleVO article = boardarticleDAO.selectBoardarticle(vo);

    assertThat(3, is(article.getGrp_ord()));


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#updateBoardarticle(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testUpdateBoardarticle() throws Exception {


    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setCont_idx(100);
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");

    BoardarticleVO article = boardarticleDAO.selectBoardarticle(vo);
    assertThat("plani test", is(article.getSubject()));

    vo.setSubject("plani 테스트 업데이트");
    vo.setModifier("플랜아이");

    // mysql
    vo.setBrd_cont("1234");

    boardarticleDAO.updateBoardarticle(vo);
    BoardarticleVO updateResult = boardarticleDAO.selectBoardarticle(vo);
    assertThat("plani 테스트 업데이트", is(updateResult.getSubject()));
    assertThat("플랜아이", is(updateResult.getModifier()));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#deleteBoard(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testDeleteBoard() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    boardarticleDAO.deleteBoard(vo);

    vo.setCont_idx(100);

    assertNull(boardarticleDAO.selectBoardarticle(vo));


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#deleteBoardarticle(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testDeleteBoardarticle() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setCont_idx(100);
    boardarticleDAO.deleteBoard(vo);

    assertNull(boardarticleDAO.selectBoardarticle(vo));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectBoardarticle(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectBoardarticle() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setCont_idx(100);

    BoardarticleVO article = boardarticleDAO.selectBoardarticle(vo);
    assertThat("BDIDX_2JA41KFZ3982IX44w905I5", is(article.getBrd_id()));
    assertThat("plani test", is(article.getSubject()));
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectBoardarticleGrpwriterCnt(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectBoardarticleGrpwriterCnt() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setGrp_no(100);
    vo.setWriter("플랜아이");

    assertTrue(boardarticleDAO.selectBoardarticleGrpwriterCnt(vo) > 0);

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectBoardarticlePwd(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectBoardarticlePwd() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setCont_idx(100);
    vo.setAdd_info_04("1234");

    BoardarticleVO article = boardarticleDAO.selectBoardarticlePwd(vo);
    assertThat(100, is(article.getCont_idx()));

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectBoardarticleMainList(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectBoardarticleMainList() throws Exception {

    // TODO 사용하는 컨트롤러가 없어서 제외함.

    // vo.setReply_gb("N");
    // vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    // vo.setFirstIndex(0);
    // vo.setLastIndex(10);
    // vo.setRecordCountPerPage(15);
    //
    // vo.setBrd_id_list("BDIDX_2JA41KFZ3982IX44w905I5");
    //
    // List<BoardarticleVO> articleList = boardarticleDAO.selectBoardarticleMainList(vo);
    // assertTrue(articleList.size() >= 1);
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectBoardarticleList(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectBoardarticleList() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setFirstIndex(0);
    vo.setLastIndex(10);
    vo.setRecordCountPerPage(15);

    List<BoardarticleVO> articleList = boardarticleDAO.selectBoardarticleList(vo);
    assertTrue(articleList.size() >= 1);

  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectBoardarticleListTotCnt(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectBoardarticleListTotCnt() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");

    assertTrue(boardarticleDAO.selectBoardarticleListTotCnt(vo) > 0);


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#updateBoardxcount(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testUpdateBoardxcount() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setCont_idx(100);
    vo.setHits(88);
    boardarticleDAO.updateBoardxcount(vo);

    BoardarticleVO article = boardarticleDAO.selectBoardarticle(vo);
    assertThat(88, is(article.getHits()));


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectBoardarticlegroupList(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectBoardarticlegroupList() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setGrp_no(100);
    vo.setGrp_ord(2);
    vo.setGrp_lv(1);


    List<BoardarticleVO> articleList = boardarticleDAO.selectBoardarticlegroupList(vo);
    assertTrue(articleList.size() >= 1);


  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectTotalSearchList(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectTotalSearchList() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setSearchType("BRD");
    vo.setSearchCondition("SUBJECT");
    vo.setSearchKeyword("plani");



    List<BoardarticleVO> articleList = boardarticleDAO.selectTotalSearchList(vo);
    assertTrue(articleList.size() >= 1);



    // property="searchCondition" compareValue="SC_ALL">
    // $searchCondition$ LIKE '%' || #searchKeyword# || '%'
  }

  /**
   * Test method for
   * {@link egovframework.plani.template.brdartcl.dao.BoardarticleDAO#selectBoardarticleAnonimChk(egovframework.plani.template.brdartcl.vo.BoardarticleVO)}
   * .
   */
  @Test
  public void testSelectBoardarticleAnonimChk() throws Exception {

    vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
    vo.setBrd_id("BDIDX_2JA41KFZ3982IX44w905I5");
    vo.setAdd_info_02("ttt");

    assertTrue(boardarticleDAO.selectBoardarticleAnonimChk(vo) >= 0);

  }

}
