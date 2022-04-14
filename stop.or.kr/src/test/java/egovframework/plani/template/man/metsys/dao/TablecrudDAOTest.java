package egovframework.plani.template.man.metsys.dao;

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
import egovframework.plani.template.man.metsys.vo.TablecrudVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml"})
@TestExecutionListeners({DependencyInjectionTestExecutionListener.class,
    DbUnitTestExecutionListener.class, TransactionDbUnitTestExecutionListener.class})
public class TablecrudDAOTest {

  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  @Resource
  public TablecrudDAO tablecrudDAO;

  private TablecrudVO vo;

  @Before
  public void setUp() throws Exception {
    vo = new TablecrudVO();
  }

  @Test
  public void testSelectTableList() throws Exception {

    List tablecrudlist = tablecrudDAO.selectTableList(vo);

    assertTrue(tablecrudlist.size() >= 1);

  }

  @Test
  public void testSelectTablecolList() throws Exception {

    vo.setTable_name("CMS_POPUP");
    vo.setOwner("base_framework_jsp");
    List tablecrudlist = tablecrudDAO.selectTablecolList(vo);

    assertTrue(tablecrudlist.size() >= 1);

  }

}
