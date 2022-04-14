package egovframework.plani.template.man.menuctgry.dao;

import static org.hamcrest.CoreMatchers.is;
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
import egovframework.plani.template.man.menuctgry.vo.SyscategoryVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
@DatabaseSetup(value = "syscategory_sample.xml", type = DatabaseOperation.REFRESH)
public class SyscategoryDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public SyscategoryDAO syscategoryDAO;

  private SyscategoryVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new SyscategoryVO();
  }

  @Test
  public void testInsertSyscategory() throws Exception {

    vo.setCtgry_idx("CTIDX00062");
    vo.setUp_ctgry_idx("CTIDX00024");
    vo.setCtgry_nm("ych_test3");
    vo.setUse_yn("N");

    syscategoryDAO.deleteSyscategory(vo);
    syscategoryDAO.insertSyscategory(vo);

    SyscategoryVO syscategory = syscategoryDAO.selectSyscategory(vo);

    assertThat("ych_test3", is(syscategory.getCtgry_nm()));

    syscategoryDAO.deleteSyscategory(vo);
  }

  @Test
  public void testUpdateSyscategory() throws Exception {

    vo.setCtgry_idx("CTIDX00024");

    SyscategoryVO syscategory = syscategoryDAO.selectSyscategory(vo);

    assertThat("ych_test", is(syscategory.getCtgry_nm()));

    syscategory.setCtgry_nm("테스트요");

    syscategoryDAO.updateSyscategory(syscategory);

    syscategory = syscategoryDAO.selectSyscategory(vo);

    assertThat("테스트요", is(syscategory.getCtgry_nm()));

  }

  @Test
  public void testUpdateSyscategoryOrderP() throws Exception {

    vo.setCtgry_idx("CTIDX00025");
    vo.setUp_ctgry_idx("CTIDX00024");

    vo.setCtgry_ord(2);

    SyscategoryVO syscategory = syscategoryDAO.selectSyscategory(vo);

    assertThat("ych_test2", is(syscategory.getCtgry_nm()));

    syscategoryDAO.updateSyscategoryOrderP(vo);

    syscategory = syscategoryDAO.selectSyscategory(syscategory);

    assertThat(3, is(syscategory.getCtgry_ord()));

  }

  @Test
  public void testUpdateSyscategoryOrderM() throws Exception {

    vo.setCtgry_idx("CTIDX00025");
    vo.setUp_ctgry_idx("CTIDX00024");
    vo.setAdd_ord(1);
    vo.setFrom_ord(2);
    vo.setTo_ord(3);

    SyscategoryVO syscategory = syscategoryDAO.selectSyscategory(vo);
    assertThat("ych_test2", is(syscategory.getCtgry_nm()));

    syscategoryDAO.updateSyscategoryOrderM(vo);

    syscategory = syscategoryDAO.selectSyscategory(vo);

    assertThat(3, is(syscategory.getCtgry_ord()));



  }

  @Test
  public void testDeleteSyscategory() throws Exception {

    vo.setCtgry_idx("CTIDX00025");
    vo.setUp_ctgry_idx("CTIDX00024");

    SyscategoryVO syscategory = syscategoryDAO.selectSyscategory(vo);
    assertThat("ych_test2", is(syscategory.getCtgry_nm()));

    syscategoryDAO.deleteSyscategory(vo);

    syscategory = syscategoryDAO.selectSyscategory(vo);

    assertThat("N", is(syscategory.getUse_yn()));
  }

  @Test
  public void testSelectSyscategory() throws Exception {
    vo.setCtgry_idx("CTIDX00024");

    SyscategoryVO syscategory = syscategoryDAO.selectSyscategory(vo);
    assertThat("ych_test", is(syscategory.getCtgry_nm()));
  }

  @Test
  public void testSelectSyscategoryList() throws Exception {

    List syscategorylist = syscategoryDAO.selectSyscategoryList(vo);

    assertTrue(syscategorylist.size() >= 1);

  }

  @Test
  public void testSelectSyscategoryListTotCnt() throws Exception {

    vo.setCtgry_idx("CTIDX00024");
    assertTrue(syscategoryDAO.selectSyscategoryListTotCnt(vo) >= 1);
  }

}
