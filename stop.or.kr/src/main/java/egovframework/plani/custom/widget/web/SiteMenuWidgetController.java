package egovframework.plani.custom.widget.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.service.impl.SiteMenuServiceImpl;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

@Controller
public class SiteMenuWidgetController {

  /** SiteMenuServiceImpl */
  @Resource
  private SiteMenuServiceImpl sitemenuserviceimple;

  @Resource
  private SysmenuService sysmenuService;

  /**
   * 사이트 메인화면 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/SiteMenuWidget/menu")
  public String menu(HttpServletRequest request, Model model) throws Exception {

    String ext = EgovWebUtil.getExtension(request.getRequestURI());
    String type = request.getParameter("type");
    String return_url = "";
    if (type == null)
      type = "site_menu";
    String srch_mu_lang = request.getParameter("srch_mu_lang");
    if(srch_mu_lang!=null){
    	srch_mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_lang);//20191108 취약점 조치 추가
    }
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;    

    String srch_mu_site = request.getParameter("srch_mu_site");
    if(srch_mu_site!=null){
    	srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가
    }
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;    
    
    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null)
      auth_cd = "G0001";

    Map<String, String> request_map = new HashMap<String, String>();

    request_map.put("ext", ext);
    request_map.put("srch_mu_site", srch_mu_site);
    request_map.put("srch_mu_lang", srch_mu_lang);
    request_map.put("auth_cd", auth_cd);


    Map<String, SysmenuVO> menu =
        sitemenuserviceimple.getNodeTree("", request.getParameter("use"), request_map);
    model.addAttribute("menu", menu);

    if (srch_mu_site.equals("CDIDX00002")) {
      if (srch_mu_lang.equals("CDIDX00022")) {
        return_url = "/custom/widget/kor/" + type;
      } else {
        return_url = "/custom/widget/eng/" + type;
      }
    } else if (srch_mu_site.equals("CDIDX00005")) {
      return_url = "/custom/widget/women/kor/" + type;
    } else if (srch_mu_site.equals("CDIDX00004")) { // 2018-07-19 : pigcos 공모전
      return_url = "/custom/widget/complicity/kor/site_menu";
    }
    
    return return_url;

  }

  /**
   * 사이트 사이드 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/SiteMenuWidget/sidemenu")
  public String sidemenu(HttpServletRequest request, Model model) throws Exception {

    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String return_url = "";

    String srch_mu_lang = request.getParameter("srch_mu_lang");
    if(srch_mu_lang!=null){
    	srch_mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_lang);//20191108 취약점 조치 추가
    }
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    String srch_mu_site = request.getParameter("srch_mu_site");
    if(srch_mu_site!=null){
    	srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가
    }
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;
    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null)
      auth_cd = "G0001";

    Map<String, String> request_map = new HashMap<String, String>();

    request_map.put("ext", ext);
    request_map.put("srch_mu_site", srch_mu_site);
    request_map.put("srch_mu_lang", srch_mu_lang);
    request_map.put("auth_cd", auth_cd);

    /* 현재 상위 메뉴 구하기 */
    List<SysmenuVO> path = getPath(request, request.getParameter("srch_menu_nix"));

    Map<String, SysmenuVO> menu =
        sitemenuserviceimple.getNodeTree(path.get(0).getMenu_idx(), "Y", request_map);

    model.addAttribute("sidemenu", menu);
    if (path.size() > 1)
      model.addAttribute("secondPathIdx", path.get(1).getMenu_idx());
    if (path.size() > 2) {
      model.addAttribute("thirdPathIdx", path.get(2).getMenu_idx());
    }


    if (srch_mu_site.equals("CDIDX00002")) {
      if (srch_mu_lang.equals("CDIDX00022")) {
        return_url = "/custom/widget/kor/site_sidemenu";
      } else {
        return_url = "/custom/widget/eng/site_sidemenu";
      }
    } else if (srch_mu_site.equals("CDIDX00005")) {
      return_url = "/custom/widget/women/kor/site_sidemenu";
    }

    return return_url;

  }

  /**
   * 사이트 사이드 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/SiteMenuWidget/tabmenu")
  public String tabmenu(HttpServletRequest request, Model model) throws Exception {

    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String return_url = "";

    String srch_mu_lang = request.getParameter("srch_mu_lang");
    if(srch_mu_lang!=null){
    	srch_mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_lang);//20191108 취약점 조치 추가
    }
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    String srch_mu_site = request.getParameter("srch_mu_site");
    if(srch_mu_site!=null){
    	srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가
    }
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;
    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null)
      auth_cd = "G0001";

    Map<String, String> request_map = new HashMap<String, String>();

    request_map.put("ext", ext);
    request_map.put("srch_mu_site", srch_mu_site);
    request_map.put("srch_mu_lang", srch_mu_lang);
    request_map.put("auth_cd", auth_cd);


    List<SysmenuVO> tabmenu =
        sitemenuserviceimple.getTabMenu(request.getParameter("srch_menu_nix"), request_map);


    model.addAttribute("tabmenu", tabmenu);

    if (srch_mu_site.equals("CDIDX00002")) {
      if (srch_mu_lang.equals("CDIDX00022")) {
        return_url = "/custom/widget/kor/site_tabmenu";
      } else {
        return_url = "/custom/widget/eng/site_tabmenu";
      }
    } else if (srch_mu_site.equals("CDIDX00005")) {
      return_url = "/custom/widget/women/kor/site_tabmenu";
    } else if (srch_mu_site.equals("CDIDX00004")) {// 2018-07-20 : pigcos 공모전
      return_url = "/custom/widget/complicity/kor/site_tabmenu";
    }

    return return_url;

  }

  /**
   * 사이트 사이드 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/SiteMenuWidget/tabmenu2awards")
  public String tabmenu2awards(HttpServletRequest request, Model model) throws Exception {

    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String return_url = "";

    String srch_mu_lang = request.getParameter("srch_mu_lang");
    if(srch_mu_lang!=null){
    	srch_mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_lang);//20191108 취약점 조치 추가
    }
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    String srch_mu_site = request.getParameter("srch_mu_site");
    if(srch_mu_site!=null){
    	srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가
    }
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;
    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null) {
      auth_cd = "G0001";
    }


    String srch_menu_nix = request.getParameter("srch_menu_nix");
    // 현재 메뉴
    SysmenuVO nowMenuVO = new SysmenuVO();
    nowMenuVO.setSrch_menu_nix(srch_menu_nix);
    nowMenuVO = sysmenuService.selectSysmenu(nowMenuVO);

    System.out.println("현재 메뉴 정보 : " + nowMenuVO);


    SysmenuVO srchmenuVO = new SysmenuVO();
    srchmenuVO.setMu_gub("USR");
    srchmenuVO.setSrch_mu_site(srch_mu_site);
    srchmenuVO.setSrch_mu_lang(srch_mu_lang);
    srchmenuVO.setUse_yn("Y");
    srchmenuVO.setAuth_cd(auth_cd);
    List menus = sysmenuService.selectSysmenuList(srchmenuVO);

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    if ("mysql".equals(dbtype)) {
      EgovWebUtil.getLeveldList(menus, null, 1, new Integer(1));
    }

    Map<String, SysmenuVO> parentsMap = new HashMap<String, SysmenuVO>();
    for (int i = 0; i < menus.size(); i++) {
      SysmenuVO menu = (SysmenuVO) menus.get(i);
      parentsMap.put(menu.getMenu_idx(), menu);
    }

    System.out.println("메뉴정보들 : " + parentsMap);

    ArrayList<SysmenuVO> paths = new ArrayList<>();
    paths.add(nowMenuVO);
    String parent = nowMenuVO.getUp_menu_idx();
    while (true) {
      if (parentsMap.get(parent) == null) {
        break;
      } else {
        paths.add(parentsMap.get(parent));
        parent = parentsMap.get(parent).getUp_menu_idx();
      }
    }

    // path 역순
    Collections.reverse(paths);
    System.out.println("path : " + paths);

    if (paths.get(0) != null && paths.size() >= 2) {
      List tabmenu_1 = getTabMenus(paths.get(0).getMenu_idx(), menus);
      System.out.println("tabmenu_1 : " + tabmenu_1);
      model.addAttribute("tabmenu_idx", paths.get(1).getMenu_idx());
      model.addAttribute("tabmenu", tabmenu_1);
    }
    if (paths.get(1) != null && paths.size() >= 3) {
      List tabmenu_2 = getTabMenus(paths.get(1).getMenu_idx(), menus);
      System.out.println("tabmenu_2 : " + tabmenu_2);
      model.addAttribute("tabmenu2_idx", paths.get(2).getMenu_idx());
      model.addAttribute("tabmenu2", tabmenu_2);
    }


    // Map<String, String> request_map = new HashMap<String, String>();
    //
    // request_map.put("ext", ext);
    // request_map.put("srch_mu_site", srch_mu_site);
    // request_map.put("srch_mu_lang", srch_mu_lang);
    // request_map.put("auth_cd", auth_cd);
    //
    //
    // // List<SysmenuVO> tabmenu =
    // // sitemenuserviceimple.getTabMenu(request.getParameter("srch_menu_nix"), request_map);
    // List<SysmenuVO> tabmenu =
    // sitemenuserviceimple.getTabMenu(paths.get(1).getMenu_idx(), request_map);
    //
    // System.out.println("tabmenu : " + tabmenu);
    //
    // model.addAttribute("tabmenu", tabmenu);



    if (srch_mu_site.equals("CDIDX00002")) {
      if (srch_mu_lang.equals("CDIDX00022")) {
        return_url = "/custom/widget/kor/site_tabmenu";
      } else {
        return_url = "/custom/widget/eng/site_tabmenu";
      }
    } else if (srch_mu_site.equals("CDIDX00005")) {
      return_url = "/custom/widget/women/kor/site_tabmenu";
    } else if (srch_mu_site.equals("CDIDX00004")) {// 2018-07-20 : pigcos 공모전
      return_url = "/custom/widget/complicity/kor/site_tabmenu2awards";
    }

    return return_url;

  }

  /**
   * 사이트 사이드 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/SiteMenuWidget/tabmenu3awards")
  public String tabmenu3awards(HttpServletRequest request, Model model) throws Exception {

    String ext = EgovWebUtil.getExtension(request.getRequestURI());

    String return_url = "";

    String srch_mu_lang = request.getParameter("srch_mu_lang");
    if(srch_mu_lang!=null){
    	srch_mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_lang);//20191108 취약점 조치 추가
    }
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    String srch_mu_site = request.getParameter("srch_mu_site");
    if(srch_mu_site!=null){
    	srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가
    }
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;
    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null) {
      auth_cd = "G0001";
    }


    String srch_menu_nix = request.getParameter("srch_menu_nix");
    // 현재 메뉴
    SysmenuVO nowMenuVO = new SysmenuVO();
    nowMenuVO.setSrch_menu_nix(srch_menu_nix);
    nowMenuVO = sysmenuService.selectSysmenu(nowMenuVO);

    System.out.println("현재 메뉴 정보 : " + nowMenuVO);


    SysmenuVO srchmenuVO = new SysmenuVO();
    srchmenuVO.setMu_gub("USR");
    srchmenuVO.setSrch_mu_site(srch_mu_site);
    srchmenuVO.setSrch_mu_lang(srch_mu_lang);
    srchmenuVO.setUse_yn("Y");
    srchmenuVO.setAuth_cd(auth_cd);
    List menus = sysmenuService.selectSysmenuList(srchmenuVO);

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    if ("mysql".equals(dbtype)) {
      EgovWebUtil.getLeveldList(menus, null, 1, new Integer(1));
    }

    Map<String, SysmenuVO> parentsMap = new HashMap<String, SysmenuVO>();
    for (int i = 0; i < menus.size(); i++) {
      SysmenuVO menu = (SysmenuVO) menus.get(i);
      parentsMap.put(menu.getMenu_idx(), menu);
    }

    System.out.println("메뉴정보들 : " + parentsMap);

    ArrayList<SysmenuVO> paths = new ArrayList<>();
    paths.add(nowMenuVO);
    String parent = nowMenuVO.getUp_menu_idx();
    while (true) {
      if (parentsMap.get(parent) == null) {
        break;
      } else {
        paths.add(parentsMap.get(parent));
        parent = parentsMap.get(parent).getUp_menu_idx();
      }
    }

    // path 역순
    Collections.reverse(paths);
    System.out.println("path : " + paths);

    if (paths.get(0) != null && paths.size() >= 2) {
      List tabmenu_1 = getTabMenus(paths.get(0).getMenu_idx(), menus);
      System.out.println("tabmenu_1 : " + tabmenu_1);
      model.addAttribute("tabmenu_idx", paths.get(1).getMenu_idx());
      model.addAttribute("tabmenu", tabmenu_1);
    }
    if (paths.get(1) != null && paths.size() >= 3) {
      List tabmenu_2 = getTabMenus(paths.get(1).getMenu_idx(), menus);
      System.out.println("tabmenu_2 : " + tabmenu_2);
      model.addAttribute("tabmenu2_idx", paths.get(2).getMenu_idx());
      model.addAttribute("tabmenu2", tabmenu_2);
    }

    if (paths.get(1) != null) {
      model.addAttribute("tabmenu_nm", paths.get(1).getMenu_nm());
    }

    // Map<String, String> request_map = new HashMap<String, String>();
    //
    // request_map.put("ext", ext);
    // request_map.put("srch_mu_site", srch_mu_site);
    // request_map.put("srch_mu_lang", srch_mu_lang);
    // request_map.put("auth_cd", auth_cd);
    //
    //
    // // List<SysmenuVO> tabmenu =
    // // sitemenuserviceimple.getTabMenu(request.getParameter("srch_menu_nix"), request_map);
    // List<SysmenuVO> tabmenu =
    // sitemenuserviceimple.getTabMenu(paths.get(1).getMenu_idx(), request_map);
    //
    // System.out.println("tabmenu : " + tabmenu);
    //
    // model.addAttribute("tabmenu", tabmenu);



    if (srch_mu_site.equals("CDIDX00002")) {
      if (srch_mu_lang.equals("CDIDX00022")) {
        return_url = "/custom/widget/kor/site_tabmenu";
      } else {
        return_url = "/custom/widget/eng/site_tabmenu";
      }
    } else if (srch_mu_site.equals("CDIDX00005")) {
      return_url = "/custom/widget/women/kor/site_tabmenu";
    } else if (srch_mu_site.equals("CDIDX00004")) {// 2018-07-20 : pigcos 공모전
      return_url = "/custom/widget/complicity/kor/site_tabmenu3awards";
    }

    return return_url;

  }

  private List getTabMenus(String up_menu_idx, List menus) {

    List tabmenu = new ArrayList();
    int cnt = 0;
    for (int i = 0; i < menus.size(); i++) {
      SysmenuVO menuVO = (SysmenuVO) menus.get(i);

      /* 상위 부모메뉴가 탭메뉴가 y인지 체킹 */
      if (menuVO.getMenu_idx().equals(up_menu_idx)) {
        if (!"Y".equals(menuVO.getTabmenu_yn())) {
          tabmenu.clear();
          break;
        }
      }
      /* 하위메뉴들이 탭메뉴가 y인지 체킹 */
      if (up_menu_idx.equals(menuVO.getUp_menu_idx()) && "Y".equals(menuVO.getTabmenu_yn())) {
        tabmenu.add(cnt++, menuVO);
      }
    }
    return tabmenu;
  }

  /**
   * 사이트 path 메뉴을 생성하기 위해 메뉴 목록을 조회한다.
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping("/SiteMenuWidget/path")
  public String path(HttpServletRequest request, Model model) throws Exception {

    String ext = EgovWebUtil.getExtension(request.getRequestURI());
    String return_url = "";
    String viewFile = request.getParameter("viewFile");

    String srch_mu_lang = request.getParameter("srch_mu_lang");
    if(srch_mu_lang!=null){
    	srch_mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_lang);//20191108 취약점 조치 추가
    }
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    String srch_mu_site = request.getParameter("srch_mu_site");
    if(srch_mu_site!=null){
    	srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가
    }
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;
    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null)
      auth_cd = "G0001";

    Map<String, String> request_map = new HashMap<String, String>();

    request_map.put("ext", ext);
    request_map.put("srch_mu_site", srch_mu_site);
    request_map.put("srch_mu_lang", srch_mu_lang);
    request_map.put("auth_cd", auth_cd);


    List<SysmenuVO> path =
        sitemenuserviceimple.getPath(request.getParameter("srch_menu_nix"), request_map);

    Map<String, SysmenuVO> menu =
        sitemenuserviceimple.getNodeTree("", request.getParameter("use"), request_map);


    model.addAttribute("menu", menu);

    model.addAttribute("path", path);

    if (srch_mu_site.equals("CDIDX00002")) {
      if (srch_mu_lang.equals("CDIDX00022")) {
        return_url = "/custom/widget/kor/" + viewFile;
      } else {
        return_url = "/custom/widget/eng/" + viewFile;
      }
    } else if (srch_mu_site.equals("CDIDX00005")) {
      return_url = "/custom/widget/women/kor/" + viewFile;
    }

    return return_url;

  }



  /**
   * 
   * @param request
   * @param model
   * @return
   * @throws Exception
   */

  public String getCurrent(HttpServletRequest request, Model model) throws Exception {

    SysmenuVO current = sitemenuserviceimple.getCurrentNode(request.getParameter("srch_menu_nix"));

    model.addAttribute("current", current);

    return null;
  }


  /**
   * 
   * @param request
   * @param menu_nix
   * @return
   * @throws Exception
   */
  public List<SysmenuVO> getPath(HttpServletRequest request, String menu_nix) throws Exception {


    String ext = EgovWebUtil.getExtension(request.getRequestURI());


    String srch_mu_lang = request.getParameter("srch_mu_lang");
    if(srch_mu_lang!=null){
    	srch_mu_lang = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_lang);//20191108 취약점 조치 추가
    }
    srch_mu_lang = (srch_mu_lang == null || "".equals(srch_mu_lang)) ? "CDIDX00022" : srch_mu_lang;

    String srch_mu_site = request.getParameter("srch_mu_site");
    if(srch_mu_site!=null){
    	srch_mu_site = egovframework.com.cmm.EgovWebUtil.removeSQLInjectionRisk(srch_mu_site);//20191108 취약점 조치 추가
    }
    srch_mu_site = (srch_mu_site == null || "".equals(srch_mu_site)) ? "CDIDX00002" : srch_mu_site;
    srch_mu_site = ("mdo".equals(ext)) ? "CDIDX00003" : srch_mu_site;
    // 권한에 따른 메뉴 사용 가능 여부를 조회하기 위해서 파라미터 설정한다.
    String auth_cd = (String) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_AUTH");
    if (auth_cd == null)
      auth_cd = "G0001";

    Map<String, String> request_map = new HashMap<String, String>();

    request_map.put("ext", ext);
    request_map.put("srch_mu_site", srch_mu_site);
    request_map.put("srch_mu_lang", srch_mu_lang);
    request_map.put("auth_cd", auth_cd);

    List<SysmenuVO> path = sitemenuserviceimple.getPath(menu_nix, request_map);

    return path;
  }


}
