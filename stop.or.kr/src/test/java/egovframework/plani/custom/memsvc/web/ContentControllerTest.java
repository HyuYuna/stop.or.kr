package egovframework.plani.custom.memsvc.web;

import static org.junit.Assert.fail;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.plani.template.man.stat.service.CommstatService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml",
    "file:src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml"})
@WebAppConfiguration
public class ContentControllerTest {

  private MockMvc mockMvc;

  @Resource
  private WebApplicationContext wac;

  @Mock
  private CommstatService commstatService;

  @Mock
  private SysmenuService sysmenuService;

  @InjectMocks
  private ContentController contentController;

  @Before
  public void setUp() throws Exception {
    MockitoAnnotations.initMocks(this);
    this.mockMvc = MockMvcBuilders.standaloneSetup(contentController).alwaysDo(print()).build();
  }

  @Test
  public void testSiteMain() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testSiteMainstatWrite() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testSitePagestatWrite() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testSiteMain2() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testLoadNoticeJsonList() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testMainTotalSearch() throws Exception {
    fail("Not yet implemented");
  }

  @Test
  public void testSiteMapView() throws Exception {

    SysmenuVO menuVO = new SysmenuVO();
    when(sysmenuService.selectSysmenu(any(SysmenuVO.class))).thenReturn(menuVO);

    mockMvc.perform(get("/contents/siteMapView.do")).andExpect(status().isOk())
        .andExpect(view().name("/contents/sitemapView"));

    verify(sysmenuService).selectSysmenu(any(SysmenuVO.class));

    mockMvc.perform(get("/contents/siteMapView.do").param("srch_mu_lang", "CDIDX00033"))
        .andExpect(status().isOk()).andExpect(view().name("/lang/contents/sitemapView"));

    verify(sysmenuService, times(2)).selectSysmenu(any(SysmenuVO.class));

  }

}
