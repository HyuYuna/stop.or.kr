package egovframework.plani.template.man.menuctgry.dao;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.assertThat;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;
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
import com.github.springtestdbunit.annotation.DatabaseOperation;
import com.github.springtestdbunit.annotation.DatabaseSetup;
import egovframework.plani.template.man.menuctgry.vo.SyscodeVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "syscode_sample.xml", type = DatabaseOperation.REFRESH)
public class SyscodeDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SyscodeDAO syscodeDAO;

  private SyscodeVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new SyscodeVO();
  }

  @Test
  public void testInsertSyscode() throws Exception {

    vo.setCode_idx("CDIDX00344");
    vo.setCode_nm("ych2_test");
    vo.setUp_code_idx("CDIDX00342");
    syscodeDAO.deleteSyscode(vo);
    syscodeDAO.insertSyscode(vo);

    SyscodeVO syscode = syscodeDAO.selectSyscode(vo);

    assertThat("ych2_test", is(syscode.getCode_nm()));

    syscodeDAO.deleteSyscode(vo);

  }

  @Test
  public void testUpdateSyscode() throws Exception {

    vo.setCode_idx("CDIDX00342");

    SyscodeVO syscode = syscodeDAO.selectSyscode(vo);

    assertThat("ych_test", is(syscode.getCode_nm()));

    syscode.setCode_nm("테스트");

    syscodeDAO.updateSyscode(syscode);

    assertThat("테스트", is(syscode.getCode_nm()));



  }

  @Test
  public void testUpdateSyscodeOrderP() throws Exception {

    vo.setCode_idx("CDIDX00342");
    vo.setCode_ord(2);

    SyscodeVO syscode = syscodeDAO.selectSyscode(vo);

    assertThat("ych_test", is(syscode.getCode_nm()));

    syscodeDAO.updateSyscodeOrderP(syscode);

    syscode = syscodeDAO.selectSyscode(vo);

    assertThat(3, is(syscode.getCode_ord()));
  }

  @Test
  public void testUpdateSyscodeOrderM() throws Exception {

    vo.setCode_idx("CDIDX00343");
    vo.setUp_code_idx("CDIDX00342");
    vo.setAdd_ord(1);
    vo.setFrom_ord(1);
    vo.setTo_ord(4);

    SyscodeVO syscode = syscodeDAO.selectSyscode(vo);

    assertThat("ych_test2", is(syscode.getCode_nm()));

    syscodeDAO.updateSyscodeOrderM(vo);

    syscode = syscodeDAO.selectSyscode(vo);

    assertThat(4, is(syscode.getCode_ord()));

  }

  @Test
  public void testDeleteSyscode() throws Exception {
    /* 업뎃으로 바뀜 */
    vo.setCode_idx("CDIDX00343");
    vo.setUp_code_idx("CDIDX00342");

    syscodeDAO.deleteSyscode(vo);

    SyscodeVO syscode = syscodeDAO.selectSyscode(vo);


    assertThat("ych_test2", is(syscode.getCode_nm()));
  }

  @Test
  public void testSelectSyscode() throws Exception {

    vo.setCode_idx("CDIDX00342");
    // vo.setUp_code_idx("ych");

    SyscodeVO syscode = syscodeDAO.selectSyscode(vo);

    assertThat("ych_test", is(syscode.getCode_nm()));
  }

  @Test
  public void testSelectSyscodeList() throws Exception {

    List syscodelist = syscodeDAO.selectSyscodeList(vo);

    assertTrue(syscodelist.size() >= 1);
  }

  @Test
  public void testSelectSyscodeListTotCnt() throws Exception {

    vo.setCode_idx("CDIDX00342");

    assertTrue(syscodeDAO.selectSyscodeListTotCnt(vo) >= 1);
  }

  @Test
  @Ignore
  // @TODO XML에 쿼리없음.
  public void testXlsSyscodeList() throws Exception {
    fail("Not yet implemented");
  }

}
