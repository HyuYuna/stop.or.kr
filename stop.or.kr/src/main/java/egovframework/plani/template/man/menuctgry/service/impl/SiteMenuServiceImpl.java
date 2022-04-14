package egovframework.plani.template.man.menuctgry.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service
public class SiteMenuServiceImpl extends EgovAbstractServiceImpl {

  /** SysmenuService */
  @Resource
  private SysmenuService sysmenuService;


  public Map<String, SysmenuVO> getNodeTree(String start, String use,
      Map<String, String> request_map) throws Exception {

    Map<String, SysmenuVO> menu_map = new LinkedHashMap<String, SysmenuVO>(); // 메뉴 해시맵

    String standard = start;

    if (standard.equals("") || standard == null) {
      standard = null;
    }

    // String use_yn = "Y";

    // if (!use.equals("") || use != null) {
    // use_yn = use;
    // }

    SysmenuVO sysmenuVO = new SysmenuVO();

    // ContentsmanVO contentsmanVO = new ContentsmanVO();

    String ext = request_map.get("ext");

    String mu_lang =
        request_map.get("srch_mu_lang") == null ? "CDIDX00022" : request_map.get("srch_mu_lang");
    String mu_site = request_map.get("srch_mu_site");
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;



    String auth_cd = request_map.get("auth_cd");
    if (auth_cd == null)
      auth_cd = "G0001";
    // if (standard == null) {
    // if (use_yn.equals("Y"))
    // sysmenuVO.setUse_yn(use_yn);
    // }
    sysmenuVO.setAuth_cd(auth_cd);
    sysmenuVO.setSrch_mu_site(mu_site);
    sysmenuVO.setSrch_mu_lang(mu_lang);

    List<SysmenuVO> sess_main_menu = sysmenuService.selectSysmenuList(sysmenuVO);

    String dbtype = EgovProperties.getProperty("Globals.DbType");

    if ("mysql".equals(dbtype)) {
      EgovWebUtil.getLeveldList(sess_main_menu, null, 1, new Integer(1));
    }



    for (int i = 0; i < sess_main_menu.size(); i++) // 1뎁스
    {
      Map<String, SysmenuVO> menu_map2 = new LinkedHashMap<String, SysmenuVO>(); // 2뎁스 해시맵

      if (standard != null) {
        if (!sess_main_menu.get(i).getMenu_idx().equals(standard)) {
          continue;
        }
      }

      /* 전체메뉴 1deth hashmap에 담기 -> 비엇는지 안비엇는지 체크 */
      if (sess_main_menu.get(i).getUp_menu_idx() == null
          || sess_main_menu.get(i).getUp_menu_idx().isEmpty()) {

        menu_map.put(sess_main_menu.get(i).getMenu_idx(), sess_main_menu.get(i));

        for (int j = 0; j < sess_main_menu.size(); j++) // 2뎁스
        {
          Map<String, SysmenuVO> menu_map3 = new LinkedHashMap<String, SysmenuVO>(); // 3뎁스 해시맵

          if (sess_main_menu.get(j).getUp_menu_idx() != null) {
            if (sess_main_menu.get(j).getUp_menu_idx().equals(sess_main_menu.get(i).getMenu_idx())) {
              /* 전체메뉴 2deth hashmap에 담기 -> 비엇는지 안비엇는지 체크 */
              menu_map2.put(sess_main_menu.get(j).getMenu_idx(), sess_main_menu.get(j));
              sess_main_menu.get(i).set_children_(menu_map2);

              for (int z = 0; z < sess_main_menu.size(); z++) // 3뎁스
              {
                Map<String, SysmenuVO> menu_map4 = new LinkedHashMap<String, SysmenuVO>(); // 4뎁스
                                                                                           // 해시맵

                if (sess_main_menu.get(z).getUp_menu_idx() != null) {

                  if (sess_main_menu.get(z).getUp_menu_idx()
                      .equals(sess_main_menu.get(j).getMenu_idx())) {

                    /* 전체메뉴 3deth hashmap에 담기 -> 비엇는지 안비엇는지 체크 */
                    menu_map3.put(sess_main_menu.get(z).getMenu_idx(), sess_main_menu.get(z));
                    sess_main_menu.get(j).set_children_(menu_map3);


                    // 4depth
                    for (int f = 0; f < sess_main_menu.size(); f++) // 3뎁스
                    {
                      if (sess_main_menu.get(f).getUp_menu_idx() != null) {

                        if (sess_main_menu.get(f).getUp_menu_idx()
                            .equals(sess_main_menu.get(z).getMenu_idx())) {

                          /* 전체메뉴 3deth hashmap에 담기 -> 비엇는지 안비엇는지 체크 */
                          menu_map4.put(sess_main_menu.get(f).getMenu_idx(), sess_main_menu.get(f));
                          sess_main_menu.get(z).set_children_(menu_map4);
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    return menu_map;
  }

  public SysmenuVO getCurrentNode(String menu_nix) throws Exception {

    if (menu_nix.equals("") || menu_nix == null) {
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);
    }

    SysmenuVO menuVO = new SysmenuVO();

    menuVO.setSrch_menu_nix(menu_nix);

    menuVO = sysmenuService.selectSysmenu(menuVO);

    return menuVO;
  }

  public List<SysmenuVO> getPath(String menu_nix, Map<String, String> request_map) throws Exception {

    if (menu_nix.equals("") || menu_nix == null) {
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);
    }

    List<SysmenuVO> menu_map = new LinkedList<SysmenuVO>(); // 메뉴 해시맵

    SysmenuVO sysmenuVO = new SysmenuVO();

    // ContentsmanVO contentsmanVO = new ContentsmanVO();

    String ext = request_map.get("ext");

    String mu_lang =
        request_map.get("srch_mu_lang") == null ? "CDIDX00022" : request_map.get("srch_mu_lang");
    String mu_site = request_map.get("srch_mu_site");
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;

    String auth_cd = request_map.get("auth_cd");
    if (auth_cd == null)
      auth_cd = "G0001";


    // sysmenuVO.setUse_yn("Y");
    sysmenuVO.setAuth_cd(auth_cd);
    sysmenuVO.setSrch_mu_site(mu_site);
    sysmenuVO.setSrch_mu_lang(mu_lang);
    List<SysmenuVO> sess_main_menu = sysmenuService.selectSysmenuList(sysmenuVO);

    String dbtype = EgovProperties.getProperty("Globals.DbType");

    if ("mysql".equals(dbtype)) {
      EgovWebUtil.getLeveldList(sess_main_menu, null, 1, new Integer(1));
    }

    /* 내 현제 메뉴 저장 */

    sysmenuVO.setSrch_menu_nix(menu_nix);

    sysmenuVO = sysmenuService.selectSysmenu(sysmenuVO);

    menu_map.add(sysmenuVO);


    for (int i = 0; i < sess_main_menu.size(); i++) {

      // sysmenuVO = sess_main_menu.get(i);
      // menu_map을 뒤져서 있으면 그마지막기준으로 찾기
      if (menu_map.size() == 1) {
        if (sysmenuVO.getUp_menu_idx() != null) {

          if (sysmenuVO.getUp_menu_idx().equals(sess_main_menu.get(i).getMenu_idx())) // 내 현재 메뉴 먼저
                                                                                      // 찾기
          {
            menu_map.add(sess_main_menu.get(i));
            i = -1;
          }
        }
      } else if (menu_map.size() > 1) {
        if (menu_map.get(menu_map.size() - 1).getUp_menu_idx() == null) {
          break;
        } else if (menu_map.get(menu_map.size() - 1).getUp_menu_idx()
            .equals(sess_main_menu.get(i).getMenu_idx())) {
          menu_map.add(sess_main_menu.get(i));
          if (sess_main_menu.get(i).getUp_menu_idx() == null
              || sess_main_menu.get(i).getUp_menu_idx().isEmpty())
            break;
          i = -1;
        }
      }
    }
    Collections.reverse(menu_map);
    return menu_map;

  }

  public List getTabMenu(String menu_nix, Map<String, String> request_map) throws Exception {
    // 위젯 탭메뉴 보완 사용
    if (menu_nix.equals("") || menu_nix == null) {
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);
    }

    // ContentsmanVO contentsmanVO = new ContentsmanVO();

    List menuList = new ArrayList();

    String ext = request_map.get("ext");

    String mu_lang =
        request_map.get("srch_mu_lang") == null ? "CDIDX00022" : request_map.get("srch_mu_lang");
    String mu_site = request_map.get("srch_mu_site");
    mu_site = (mu_site == null || "".equals(mu_site)) ? "CDIDX00002" : mu_site;
    mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : mu_site;

    String auth_cd = request_map.get("auth_cd");
    if (auth_cd == null)
      auth_cd = "G0001";

    SysmenuVO menuVO = new SysmenuVO();
    menuVO.setSrch_menu_nix(menu_nix);
    menuVO = sysmenuService.selectSysmenu(menuVO);
    String up_menu_idx = menuVO.getMenu_idx() == null ? "" : menuVO.getUp_menu_idx();

    if (menuVO == null)
      throw new CmmnException(MessageHelper.getMessage("THE-WRONG-APPROACH")/* 잘못된 접근입니다. */);

    // 탭메뉴인 경우 탭메뉴 형제 탭메뉴 컨텐츠를 읽어온다.
    if ("Y".equals(menuVO.getTabmenu_yn())) {
      // 메뉴와 연관된 컨텐츠 목록을 직접 읽어오기 어려우므로
      // 이미 구성되어 세션에 저장된 메뉴목록에서 현재 탭으로 구성된 메뉴 목록을 구한다.
      // 메인페이지를 거치지 않고 주소 입력으로 바로 들어온 경우 세션에 메뉴구성이 되어있지 않으므로
      // 조회해서 메뉴목록을 가져온다.

      SysmenuVO srchmenuVO = new SysmenuVO();
      srchmenuVO.setMu_gub("USR");
      srchmenuVO.setSrch_mu_site(mu_site);
      srchmenuVO.setSrch_mu_lang(mu_lang);
      // srchmenuVO.setUse_yn("Y");
      srchmenuVO.setAuth_cd(auth_cd);
      List sess_main_menu = sysmenuService.selectSysmenuList(srchmenuVO);

      String dbtype = EgovProperties.getProperty("Globals.DbType");

      if ("mysql".equals(dbtype)) {
        EgovWebUtil.getLeveldList(sess_main_menu, null, 1, new Integer(1));
      }

      int cnt = 0;
      for (int i = 0; i < sess_main_menu.size(); i++) {
        menuVO = (SysmenuVO) sess_main_menu.get(i);

        /* 상위 부모메뉴가 탭메뉴가 y인지 체킹 */
        if (menuVO.getMenu_idx().equals(up_menu_idx)) {
          if (!"Y".equals(menuVO.getTabmenu_yn())) {
            menuList.clear();
            break;
          }
        }
        /* 하위메뉴들이 탭메뉴가 y인지 체킹 */
        if (up_menu_idx.equals(menuVO.getUp_menu_idx()) && "Y".equals(menuVO.getTabmenu_yn())) {
          menuList.add(cnt++, menuVO);
        }

      }
    }

    return menuList;
  }
}
