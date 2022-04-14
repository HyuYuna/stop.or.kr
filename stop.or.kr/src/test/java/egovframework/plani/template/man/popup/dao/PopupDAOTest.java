package egovframework.plani.template.man.popup.dao;

import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
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
import egovframework.plani.template.man.popup.vo.PopupVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
public class PopupDAOTest {
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  private PopupDAO popupDAO;

  @Before
  public void setUp() throws Exception {}

  /**
   * 팝업 더미데이터 생성
   * 
   * @return PopupVO
   */
  private PopupVO getPopupVO() {
    Date from = new Date();
    SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
    String today = transFormat.format(from);
    PopupVO vo = new PopupVO();
    vo.setPop_title("테스트");
    vo.setPop_type("W");
    vo.setPop_from("2018-05-01");
    vo.setPop_to(today);
    vo.setPop_w("100");
    vo.setPop_h("100");
    vo.setPop_content("내용내용");
    vo.setPop_image(null);
    vo.setPop_link("http://google.co.kr");
    vo.setPop_target("_blank");
    vo.setUse_yn("Y");
    vo.setWriter("tmp");
    vo.setWdt("18/05/03");
    vo.setPop_x("0");
    vo.setPop_y("0");
    vo.setPop_alt(null);
    return vo;
  }

  /**
   * 팝업 더미데이터 Insert
   * 
   * @param vo
   * @return insertId
   */
  private int popupInsert(PopupVO vo) {
    int insertId = -1;
    try {
      popupDAO.insertPopup(vo);
      insertId = vo.getPop_seq();
      assertTrue("insert fail!!", insertId > 0);
      logger.debug("insertId : " + insertId);
    } catch (Exception e) {
      e.printStackTrace();
      fail("insert fail!!");
    }
    return insertId;
  }

  /**
   * 팝업 더미데이터 삭제 : 정상 Insert 인 경우 추가 row 삭제
   * 
   * @param insertId
   * @return 삭제된 행개수
   */
  private int popupDelete(int insertId) {
    int deleteRow = 0;
    if (insertId > 0) {
      try {
        PopupVO vo = new PopupVO();
        vo.setPop_seq(insertId);
        deleteRow = popupDAO.deletePopup(vo);
        assertTrue("delete fail!!", deleteRow > 0);
      } catch (Exception e) {
        e.printStackTrace();
        fail("delete fail!!");
      }
    }
    return deleteRow;
  }

  @Test
  public void testInsertPopup() {
    PopupVO vo = getPopupVO();
    int insertId = popupInsert(vo);
    popupDelete(insertId);
  }

  @Test
  public void testUpdatePopup() {
    PopupVO vo = getPopupVO();
    int insertId = popupInsert(vo);
    int updateRow = 0;
    try {
      // 내용 업데이트
      vo.setPop_title(vo.getPop_title() + " 수정");
      vo.setPop_content(vo.getPop_content() + " 수정");
      updateRow = popupDAO.updatePopup(vo);
      logger.debug("updateRow : " + updateRow);
      assertTrue("update fail!!", updateRow > 0);
    } catch (Exception e) {
      e.printStackTrace();
    }
    popupDelete(insertId);
  }

  @Test
  public void testDeletePopup() {
    PopupVO vo = getPopupVO();
    int insertId = popupInsert(vo);
    popupDelete(insertId);
  }

  @Test
  public void testSelectPopup() {
    PopupVO vo = getPopupVO();
    int insertId = popupInsert(vo);
    try {
      vo.setPop_seq(insertId);
      PopupVO result = popupDAO.selectPopup(vo);
      logger.debug("result:" + result.toString());
      assertTrue("selct fail!!", vo.getPop_seq() == result.getPop_seq());
    } catch (Exception e) {
      e.printStackTrace();
      fail("select fail!!");
    }
    popupDelete(insertId);
  }

  @Test
  public void testSelectPopupList() {
    PopupVO insert = getPopupVO();
    int insertId = popupInsert(insert);
    // 검색
    PopupVO vo = new PopupVO();
    vo.setSearchPopType("W");
    vo.setSearchUseYn("Y");
    vo.setSearchCondition("POP_TITLE");
    vo.setSearchKeyword("테스트");
    try {
      List<PopupVO> data = popupDAO.selectPopupList(vo);
      logger.debug("data size : " + data.size());
      assertTrue("select list fail!!", data.size() > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("select list fail!!");
    }
    popupDelete(insertId);
  }

  @Test
  public void testSelectPopupListTotCnt() {
    PopupVO insert = getPopupVO();
    int insertId = popupInsert(insert);
    // 검색
    PopupVO vo = new PopupVO();
    vo.setSearchPopType("W");
    vo.setSearchUseYn("Y");
    vo.setSearchCondition("POP_TITLE");
    vo.setSearchKeyword("테스트");
    try {
      int totalCnt = popupDAO.selectPopupListTotCnt(vo);
      logger.debug("totalCnt : " + totalCnt);
      assertTrue("total count fail!!", totalCnt > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("total count fail!!");
    }
    popupDelete(insertId);
  }

  @Test
  public void testSelectTargetReplaced() {
    PopupVO insert = getPopupVO();
    int insertId1 = popupInsert(insert);
    int insertId2 = popupInsert(insert);

    logger.debug("insert id 1: " + insertId1);
    logger.debug("insert id 2: " + insertId2);

    // 검색
    PopupVO vo = new PopupVO();
    vo.setPop_seq(insertId2);
    vo.setSort_dir("down");
    // vo.setSort_dir("up");
    try {
      PopupVO result = popupDAO.selectTargetReplaced(vo);
      logger.debug("insert SEQ : " + insertId2);
      logger.debug("result SEQ : " + result.getPop_seq());
      assertTrue("up fail!!", result.getPop_seq() == insertId1);
    } catch (Exception e) {
      e.printStackTrace();
      fail("up fail!!");
    }
    popupDelete(insertId1);
    popupDelete(insertId2);
  }

  @Test
  public void testUpdatePopupSort() {
    PopupVO insert = getPopupVO();
    int insertId = popupInsert(insert);
    insert.setPop_seq(insertId);
    insert.setPop_sort(9999);
    try {
      int updateRow = popupDAO.updatePopupSort(insert);
      assertTrue("sort update fail!!", updateRow == 1);
    } catch (Exception e) {
      e.printStackTrace();
      fail("sort update fail!!");
    }
    popupDelete(insertId);
  }

  @Test
  public void testSelectValidPopupList() {
    PopupVO insert = getPopupVO();
    int insertId = popupInsert(insert);
    // 검색
    PopupVO vo = new PopupVO();
    vo.setPop_type("W");
    try {
      List<PopupVO> data = popupDAO.selectValidPopupList(vo);
      assertTrue("vaild popup list fail!!", data.size() > 0);
    } catch (Exception e) {
      e.printStackTrace();
      fail("valid popup list fail!!");
    }
    popupDelete(insertId);
  }

  @Test
  public void testUpdatePopupUseYn() {
    PopupVO insert = getPopupVO();
    insert.setUse_yn("N"); // 기본 무조건 Y값으로 셋팅, 변경안됨.
    logger.debug("use yn : " + insert.getUse_yn());
    int insertId = popupInsert(insert);
    try {
      int updateRow = popupDAO.updatePopupUseYn(Integer.toString(insertId));
      assertTrue("popup use yn fail!!", updateRow == 1);
    } catch (Exception e) {
      e.printStackTrace();
      fail("popup use yn fail!!");
    }
    popupDelete(insertId);
  }

}
