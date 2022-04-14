package egovframework.plani.template.atchfile.dao;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
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
import egovframework.plani.template.atchfile.vo.AtchfileVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
public class AtchfileDAOTest {
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  private AtchfileDAO atchfileDAO;

  @Before
  public void setUp() throws Exception {}

  /**
   * 팝업 더미데이터 생성
   * 
   * @return PopupVO
   */
  private AtchfileVO getAtchfileVO() {
    AtchfileVO vo = new AtchfileVO();
    vo.setAtckey_1st("TEST");
    vo.setAtckey_2nd("2");
    vo.setAtckey_3rd(1);
    vo.setAtckey_4th(1);
    vo.setIs_thumb("N");
    vo.setVchkcode("0nNdTMDkY911");
    vo.setFpath("/2018/04");
    vo.setFname("20180430_N4bx6FaRiCqg.png");
    vo.setRname("스크린샷 2018-04-27 오후 2.31.32.png");
    vo.setFext("png");
    vo.setSize_kb(283);
    vo.setImg_width(500);
    vo.setImg_height(500);
    return vo;
  }

  /**
   * 더미데이터 Insert
   * 
   * @param vo
   * @return insertId
   */
  private int atchInsert(AtchfileVO vo) {
    int insertId = -1;
    try {
      insertId = atchfileDAO.insertAtchfile(vo);
      assertTrue("insert fail!!", insertId > 0);
      logger.debug("insertId : " + insertId);
    } catch (Exception e) {
      e.printStackTrace();
      fail("insert fail!!");
    }
    return insertId;
  }

  /**
   * 더미데이터 InsertDrct
   * 
   * @param vo
   * @return insertId
   */
  private int atchInsertDrct(AtchfileVO vo) {
    int insertId = -1;
    try {
      insertId = atchfileDAO.insertAtchfileDrct(vo);
      assertTrue("insert fail!!", insertId > 0);
      logger.debug("insertId : " + insertId);
    } catch (Exception e) {
      e.printStackTrace();
      fail("insert fail!!");
    }
    return insertId;
  }

  private int atchThumb(AtchfileVO vo) {
    int insertId = -1;
    try {
      insertId = atchfileDAO.insertAtchThumb(vo);
      assertTrue("insert fail!!", insertId > 0);
      logger.debug("insertId : " + insertId);
    } catch (Exception e) {
      e.printStackTrace();
      fail("insert fail!!");
    }
    return insertId;
  }

  /**
   * 더미데이터 삭제 : 정상 Insert 인 경우 추가 row 삭제
   * 
   * @param insertId
   * @return 삭제된 행개수
   */
  private int atchDelete(int insertId, AtchfileVO data) {
    int deleteRow = 0;
    if (insertId > 0) {
      try {
        AtchfileVO vo = new AtchfileVO();
        vo.setAtckey_1st(data.getAtckey_1st());
        vo.setAtckey_2nd(data.getAtckey_2nd());
        vo.setAtckey_3rd(data.getAtckey_3rd());
        vo.setAtckey_4th(data.getAtckey_4th());
        vo.setIs_thumb(data.getIs_thumb());
        deleteRow = atchfileDAO.deleteAtchOnefile(vo);
        logger.debug("delete row : " + deleteRow);
        assertTrue("delete fail!!", deleteRow > 0);
      } catch (Exception e) {
        e.printStackTrace();
        fail("delete fail!!");
      }
    }
    return deleteRow;
  }

  @Test
  public void testInsertAtchfile() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    atchDelete(insertId, vo);
  }

  @Test
  public void testInsertAtchfileDrct() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsertDrct(vo);
    atchDelete(insertId, vo);
  }

  @Test
  public void testInsertAtchThumb() {
    AtchfileVO vo = getAtchfileVO();
    vo.setIs_thumb("Y");
    int insertId = atchThumb(vo);
    atchDelete(insertId, vo);
  }

  @Test
  public void testDeleteBoardAtchfiles() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchThumb(vo);
    // 조건
    AtchfileVO condition = new AtchfileVO();
    condition.setAtckey_1st(vo.getAtckey_1st());
    try {
      int deleteRow = atchfileDAO.deleteBoardAtchfiles(vo);
      assertTrue("delete board file fail!!", deleteRow > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("delete board file fail!!");
    }
  }

  @Test
  public void testDeleteAtchOnefile() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    atchDelete(insertId, vo);
  }

  @Test
  public void testDeleteAtchOnefileByVchkcode() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    // 조건
    AtchfileVO condition = new AtchfileVO();
    condition.setVchkcode(vo.getVchkcode());
    try {
      int deleteRow = atchfileDAO.deleteAtchOnefileByVchkcode(vo);
      assertTrue("delete board file fail!!", deleteRow > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("delete board file fail!!");
    }
  }

  @Test
  public void testSelectAtchfile() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      AtchfileVO result = atchfileDAO.selectAtchfile(vo);
      assertTrue("select atchfile fail!!", vo.getVchkcode().equals(result.getVchkcode()));
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectAtchfilePair() {
    AtchfileVO vo1 = getAtchfileVO();
    int insertId1 = atchInsert(vo1);
    AtchfileVO vo2 = getAtchfileVO();
    vo2.setVchkcode("0nNdTMDkY912");
    int insertId2 = atchInsert(vo2);
    try {
      List<AtchfileVO> results = atchfileDAO.selectAtchfilePair(vo1);
      logger.debug("results size :" + results.size());
      assertTrue("select atchfile fail!!", results.size() > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile fail!!");
    }
    atchDelete(insertId1, vo1);
    atchDelete(insertId2, vo2);
  }

  @Test
  public void testSelectAtchfileByVchkcode() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      AtchfileVO result = atchfileDAO.selectAtchfileByVchkcode(vo);
      logger.debug("result vchkcode :" + result.getVchkcode());
      assertTrue("select atchfile vchkcode fail!!", vo.getVchkcode().equals(result.getVchkcode()));
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile vchkcode fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectAtchfileByFilename() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      AtchfileVO result = atchfileDAO.selectAtchfileByFilename(vo);
      assertTrue("select atchfile filename fail!!", vo.getVchkcode().equals(result.getVchkcode()));
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile filename fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectAtchfileList() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      List<AtchfileVO> result = atchfileDAO.selectAtchfileList(vo);
      assertTrue("select atchfile list fail!!", result.size() > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile list fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectAtchfileListWithThumb() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      List<AtchfileVO> result = atchfileDAO.selectAtchfileListWithThumb(vo);
      assertTrue("select atchfile list thumb fail!!", result.size() > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile list thumb fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectAtchfileListTotCnt() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      int result = atchfileDAO.selectAtchfileListTotCnt(vo);
      assertTrue("select atchfile list totcnt fail!!", result > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile list totcnt fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectAtchfileThmCnt() {
    AtchfileVO vo = getAtchfileVO();
    vo.setIs_thumb("Y");
    int insertId = atchThumb(vo);
    try {
      int result = atchfileDAO.selectAtchfileThmCnt(vo);
      logger.debug("result :" + result);

      assertTrue("select atchfile thmcnt fail!!", result > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile list thmcnt fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectCustomAtchfileList() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      List<AtchfileVO> result = atchfileDAO.selectCustomAtchfileList(vo);
      assertTrue("select atchfile custom file list fail!!", result.size() > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile list custom file list fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectCustomAtchfileListTotCnt() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      int result = atchfileDAO.selectCustomAtchfileListTotCnt(vo);
      assertTrue("select atchfile custom file totcnt fail!!", result > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile list custom file totcnt fail!!");
    }
    atchDelete(insertId, vo);
  }

  @Test
  public void testSelectMaxAtchkey2nd() {
    AtchfileVO vo = getAtchfileVO();
    int insertId = atchInsert(vo);
    try {
      int result = atchfileDAO.selectMaxAtchkey2nd(vo);
      assertTrue("select atchfile 2nd fail!!", result > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select atchfile 2nd fail!!");
    }
    atchDelete(insertId, vo);
  }

}
