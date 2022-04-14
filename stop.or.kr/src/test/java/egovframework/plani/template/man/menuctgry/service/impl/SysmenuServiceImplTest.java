package egovframework.plani.template.man.menuctgry.service.impl;

import static org.junit.Assert.fail;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import egovframework.plani.template.cmm.utils.CategoryComponent;
import egovframework.plani.template.cmm.utils.CategoryItem;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:egovframework/spring/context-*.xml",
    "file:src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml"})
@WebAppConfiguration
public class SysmenuServiceImplTest {

  @Resource
  SysmenuService sysmenuService;

  @Before
  public void setUp() throws Exception {}

  @Test
  public void test() {
    fail("Not yet implemented");
  }

  @Test
  public void menu() throws Exception {
    SysmenuVO sysmenuVO = new SysmenuVO();
    sysmenuVO.setSrch_mu_gub("USR");
    sysmenuVO.setSrch_mu_lang("CDIDX00022");
    sysmenuVO.setSrch_mu_site("CDIDX00002");
    sysmenuVO.setMenu_idx(CategoryItem.ROOT);
    sysmenuVO.setMenu_nm("최상위");
    List<SysmenuVO> menuList = sysmenuService.selectSysmenuList(sysmenuVO);

    // 기존 메뉴를 Composite Pattern 에 대응이 가능하도록 adapter 한후 맵(순서고려) 형태로 변형
    // CategoryItem 이 다른 클래스로 변경되기 용이하도록 CategoryComponent 추상 클래스 적용(다형성)
    Map<String, CategoryComponent> menuMap = new LinkedHashMap<>();
    menuMap.put(CategoryComponent.ROOT, new CategoryItem(sysmenuVO)); // 최상위 노드는 무조건 있어야 하니
    for (SysmenuVO menu : menuList) {
      menuMap.put(menu.getMenu_idx(), new CategoryItem(menu));
    }

    // 부모와 자식들 채워주기
    for (String menuId : menuMap.keySet()) {
      String pid = menuMap.get(menuId).getParentId();
      if (!pid.equals(menuId)) {
        menuMap.get(menuId).setParent(menuMap.get(pid)); // 부모 할당
        menuMap.get(pid).add(menuMap.get(menuId)); // 자식들 할당
      }
    }

    // ROOT 구조 그리기
    menuMap.get(CategoryComponent.ROOT).children();

    // 특정메뉴 구조 그리기
    System.out.println("----------------------------------");
    menuMap.get("MNIDX02010").children();

    // 라인맵 그리기
    System.out.println("----------------------------------");
    menuMap.get("MNIDX02016").breadcrumb();

  }

}
