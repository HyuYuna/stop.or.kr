package egovframework.plani.template.man.menuctgry.service.impl;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.brdartcl.dao.BoardinfoDAO;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.cmm.utils.EgovProperties;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.plani.template.man.menuctgry.dao.SysmenuDAO;
import egovframework.plani.template.man.menuctgry.service.SysauthmenuService;
import egovframework.plani.template.man.menuctgry.service.SysmenuService;
import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;
import egovframework.plani.template.man.metsys.dao.ContentsmanDAO;
import egovframework.plani.template.man.metsys.vo.ContentsmanVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("sysmenuService")
public class SysmenuServiceImpl extends EgovAbstractServiceImpl implements SysmenuService {

  /** SysmenuDAO */
  @Resource(name = "sysmenuDAO")
  private SysmenuDAO sysmenuDAO;

  /** BoardinfoDAO */
  @Resource(name = "boardinfoDAO")
  private BoardinfoDAO boardinfoDAO;

  /** BoardinfoService */
  @Resource(name = "boardinfoService")
  private BoardinfoService boardinfoService;

  /** ContentsmanDAO */
  @Resource(name = "contentsmanDAO")
  private ContentsmanDAO contentsmanDAO;

  /** SysauthmenuService */
  @Resource(name = "sysauthmenuService")
  private SysauthmenuService sysauthmenuService;

  /**
   * 시스템 메뉴을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public String insertSysmenu(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub

    String menu_nix = EgovWebUtil.generateIDString("", 8);
    vo.setMenu_nix(menu_nix);

    sysmenuDAO.insertSysmenu(vo);
    String menu_idx = vo.getMenu_idx();
    vo.setMenu_idx(menu_idx);

    // 메뉴순서(menu_ord)는 insert 하고 난 다음에 구해지기 때문에 insert 된 메뉴를 조회한다.
    SysmenuVO tmenuVO = new SysmenuVO();
    tmenuVO.setMenu_idx(menu_idx);
    tmenuVO = sysmenuDAO.selectSysmenu(tmenuVO);
    vo.setMenu_ord(tmenuVO.getMenu_ord());

    // 게시판 타입의 메뉴인 경우 게시판 신규 생성
    if ("B".equals(vo.getMenucont_type())) {
      BoardinfoVO brdinfoVO = new BoardinfoVO();
      brdinfoVO.setWriter(vo.getWriter());
      brdinfoVO.setMu_site(vo.getMu_site());
      brdinfoVO.setMu_lang(vo.getMu_lang());
      brdinfoVO.setRef_menu_nix(menu_nix);
      brdinfoVO.setBrd_nm(vo.getMenu_nm());
      brdinfoVO.setBrd_dft(vo.getMenu_nm());
      brdinfoVO.setBrd_gb(vo.getMenubrd_type());
      brdinfoVO.setReply_gb("N");
      brdinfoVO.setEditor_gb("G");
      brdinfoVO.setAttach_cnt_limit(5);
      boardinfoService.insertBoardinfo(brdinfoVO);
      String brd_id = brdinfoVO.getBrd_id();

      // FAQ 게시판인 경우
      if ("CDIDX00043".equals(vo.getMenubrd_type())) {
        vo.setMenu_link("/brdfaq/boardfaqList.do?brd_id=" + brd_id);
      }

      // 이미지 / 갤러리 게시판인 경우
      else if ("CDIDX00044".equals(vo.getMenubrd_type())) {
        vo.setMenu_link("/brdthm/boardthmList.do?brd_id=" + brd_id);
      }

      // 일정게시판인 경우
      else if ("CDIDX00045".equals(vo.getMenubrd_type())) {
        vo.setMenu_link("/brddry/boarddryList.do?brd_id=" + brd_id);
      }

      // 익명게시판인 경우
      else if ("CDIDX00046".equals(vo.getMenubrd_type())) {
        vo.setMenu_link("/brdanm/boardanonimList.do?brd_id=" + brd_id);
      }

      // 일반 게시판인 경우
      else {
        vo.setMenu_link("/brdartcl/boardarticleList.do?brd_id=" + brd_id);
      }
    }

    // 컨텐츠 타입의 메뉴인 경우 컨텐츠 신규 생성
    else if ("C".equals(vo.getMenucont_type())) {
      ContentsmanVO contVO = new ContentsmanVO();
      contVO.setWriter(vo.getWriter());
      contVO.setMu_site(vo.getMu_site());
      contVO.setMu_lang(vo.getMu_lang());
      contVO.setRef_menu_nix(menu_nix);
      contVO.setUcont_subject(vo.getMenu_nm());
      contVO.setUcont_version(1);
      contVO.setUcont_dft(vo.getMenu_nm());
      contVO.setUcont_cont(vo.getMenu_nm());
      contentsmanDAO.insertContentsman(contVO);
      String ucont_id = contVO.getUcont_id();
      vo.setMenu_link("/modedg/contentsView.do?ucont_id=" + ucont_id);
    } else {
      // 메뉴가 게시판과 연결된 경우 해당 게시판의 메뉴값을 셋팅해준다.
      int cidx = vo.getMenu_link().indexOf("brd_id=BDIDX_");
      if (cidx >= 0 && vo.getSelectBrdlist() != null && "".equals(vo.getSelectBrdlist()) == false) {
        String brd_id = vo.getMenu_link().substring(cidx + 7, (cidx + 7) + 28);
        BoardinfoVO infoVO = new BoardinfoVO();
        infoVO.setBrd_id(brd_id);
        infoVO.setRef_menu_nix(menu_nix);
        boardinfoDAO.updateBoardinfoMenunix(infoVO);
      }

      // 메뉴가 컨텐츠와 연결된 경우 해당 컨텐츠의 메뉴값을 셋팅해준다.
      cidx = vo.getMenu_link().indexOf("ucont_id=CTX");
      if (cidx >= 0 && vo.getSelectContlist() != null && "".equals(vo.getSelectContlist()) == false) {
        String ucont_id = vo.getMenu_link().substring(cidx + 9, (cidx + 9) + 9);
        ContentsmanVO contmanVO = new ContentsmanVO();
        contmanVO.setUcont_id(ucont_id);
        contmanVO.setRef_menu_nix(menu_nix);
        contentsmanDAO.updateContentsmanMenunix(contmanVO);
      }
    }

    sysmenuDAO.updateSysmenu(vo);


    // 상위메뉴링크 자동 세팅
    if ("U".equals(vo.getMenucont_type()) == false)
      setUppermenulinkAuto(vo);

    // //////////////////////////////////////////////////////////////////////////////////
    // 메뉴가 추가되면
    // 개발자와 최고관리자는 당연히 사용가능하도록 자동으로 권한을 추가해준다..
    SysmenuVO authmenuVO = new SysmenuVO();
    authmenuVO.setAuth_cd("D0001");
    authmenuVO.setMenu_idx(menu_idx);
    authmenuVO.setAuth_yn("Y");
    authmenuVO.setWriter("planidev");
    sysauthmenuService.insertSysauthmenu(authmenuVO);

    authmenuVO.setAuth_cd("M0001");
    authmenuVO.setMenu_idx(menu_idx);
    authmenuVO.setAuth_yn("Y");
    authmenuVO.setWriter("nimdasys");
    sysauthmenuService.insertSysauthmenu(authmenuVO);
    // //////////////////////////////////////////////////////////////////////////////////



    return menu_idx;
  }

  /**
   * 상위메뉴의 링크는 하위 첫번째 메뉴(그 메뉴가 종단 메뉴일 경우에 한하여)에 의해 결정되므로 하위메뉴 등록(또는 변경)에 따른 상위메뉴의 링크를 자동 변경한다. 최초
   * 등록(또는 변경)된 메뉴로부터 상위메뉴로 타고 올라가며 메뉴링크를 변경한다. 상위메뉴의 메뉴순서가 1일 경우(첫번째 메뉴인 경우) 계속 상위메뉴로 올라가며 그렇지 않은
   * 경우 중단한다.
   * 
   * @param menuVO
   * @throws Exception 2016.03.21 bhhan
   */
  private void setUppermenulinkAuto(SysmenuVO menuVO) throws Exception {

    // 전체 메뉴 조회
    List menulist = sysmenuDAO.selectSysmenumanList(menuVO);

    // 상위메뉴에 자동 설정할 최하단 추가된 메뉴
    String automenu = menuVO.getMenu_link();
    if (automenu.indexOf(".do") >= 0 && automenu.indexOf("srch_menu_nix=") < 0) {
      if (automenu.indexOf("?") >= 0)
        automenu += ("&srch_menu_nix=" + menuVO.getMenu_nix());
      else
        automenu += ("?srch_menu_nix=" + menuVO.getMenu_nix());
    }

    if (menulist != null) {
      String find_idx = menuVO.getMenu_idx();
      SysmenuVO findVO = null;
      do {
        for (int i = 0; i < menulist.size(); i++) {
          findVO = (SysmenuVO) menulist.get(i);
          if (findVO.getMenu_idx().equals(find_idx))
            break;
        }

        // 찾는 VO가 null이면 즉시 종료
        if (findVO == null)
          break;

        // ////////////////////////////////////////////////////////////////////////////////
        // 마지막에 등록 또는 변경된 메뉴가 아닌 경우 메뉴링크 변경 (최초 반복시작때는 등록된 메뉴이므로..)
        if (findVO.getMenu_idx().equals(menuVO.getMenu_idx()) == false) {
          SysmenuVO updateVO = new SysmenuVO();
          updateVO.setMenu_idx(findVO.getMenu_idx());
          updateVO.setMenu_link(automenu);
          sysmenuDAO.updateSysmenuLink(updateVO);
        }
        // ///////////////////////////////////////////////////////////////////////////////

        find_idx = findVO.getUp_menu_idx();

        // 상위메뉴가 없는 경우 즉시 종료
        if (find_idx == null || find_idx.equals(""))
          break;

        // 찾은 메뉴가 첫번째 메뉴가 아닌 경우도 즉시 종료
        if (findVO.getMenu_ord() != 1)
          break;

      } while ("".equals(find_idx) == false);

    }

  }


  /**
   * 시스템 메뉴을/를 수정한다.
   * 
   * @param vo - 수정할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void updateSysmenu(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 메뉴 순서가 조정되는 경우 겹치거나 비게되는 순서 자동조정
    if (vo.getOrg_menu_ord() != vo.getMenu_ord()) {
      // 원래 순서보다 앞으로 가는 경우
      if (vo.getOrg_menu_ord() > vo.getMenu_ord()) {
        sysmenuDAO.updateSysmenuOrdPlus(vo);
      }
      // 원래 순서보다 뒤로 가는 경우
      else {
        sysmenuDAO.updateSysmenuOrdMinus(vo);
      }
    }

    sysmenuDAO.updateSysmenu(vo);

    // 메뉴의 탭메뉴 여부를 변경(하위메뉴도 같이)한다
    if ("Y".equals(vo.getTabmenu_yn()))
      sysmenuDAO.updateSysmenuUsetab(vo);

    // 상위메뉴링크 자동 세팅
    setUppermenulinkAuto(vo);

    String menu_nix = vo.getMenu_nix();

    // 메뉴가 게시판과 연결된 경우 해당 게시판의 메뉴값을 셋팅해준다.
    int cidx = vo.getMenu_link().indexOf("brd_id=BDIDX_");
    BoardinfoVO infoVO = new BoardinfoVO();
    ContentsmanVO contmanVO = new ContentsmanVO();
    infoVO.setRef_menu_nix(menu_nix);
    contmanVO.setRef_menu_nix(menu_nix);

    if (cidx >= 0 && vo.getSelectBrdlist() != null && "".equals(vo.getSelectBrdlist()) == false) {
      // 기존에 연결되어있던 게시판/컨텐츠가 있으면 Null처리 해준다.
      boardinfoDAO.updateBoardinfoMenunixNull(infoVO);
      contentsmanDAO.updateContentsmanMenunixNull(contmanVO);

      String brd_id = vo.getMenu_link().substring(cidx + 7, (cidx + 7) + 28);
      infoVO.setBrd_id(brd_id);
      boardinfoDAO.updateBoardinfoMenunix(infoVO);
    }

    // 메뉴가 컨텐츠와 연결된 경우 해당 컨텐츠의 메뉴값을 셋팅해준다.
    cidx = vo.getMenu_link().indexOf("ucont_id=CTX");
    if (cidx >= 0 && vo.getSelectContlist() != null && "".equals(vo.getSelectContlist()) == false) {
      // 기존에 연결되어있던 게시판/컨텐츠가 있으면 Null처리 해준다.
      boardinfoDAO.updateBoardinfoMenunixNull(infoVO);
      contentsmanDAO.updateContentsmanMenunixNull(contmanVO);

      String ucont_id = vo.getMenu_link().substring(cidx + 9, (cidx + 9) + 9);
      contmanVO.setUcont_id(ucont_id);
      contentsmanDAO.updateContentsmanMenunix(contmanVO);
    }

    // 메뉴를 사용하지 않게 되면 그 하위메뉴도 사용하지 않음으로 바꾼다.
    if ("N".equals(vo.getUse_yn())) {

      String dbtype = EgovProperties.getProperty("Globals.DbType");
      if ("mysql".equals(dbtype)) {
        SysmenuVO srchlistVO = new SysmenuVO();
        srchlistVO.setSrch_mu_gub(vo.getSrch_mu_gub());
        srchlistVO.setSrch_mu_lang(vo.getSrch_mu_lang());
        srchlistVO.setSrch_mu_site(vo.getSrch_mu_site());
        List sysmenuList = sysmenuDAO.selectSysmenumanList(srchlistVO);

        // 조작하기 편하도록 필요한 데이터만 String 배열로 빼낸다.
        String[][] orgList = new String[sysmenuList.size()][2];
        for (int i = 0; i < sysmenuList.size(); i++) {
          SysmenuVO menuVO = (SysmenuVO) sysmenuList.get(i);
          // if(menuVO.getBrd_id())

          orgList[i][0] = menuVO.getMenu_idx();
          orgList[i][1] = menuVO.getUp_menu_idx();
        }

        // 게시판과 연동된 메뉴만 상위메뉴까지 포함해서 가져와 리스트를 만든다.
        List srchList = new ArrayList();
        srchList.add(vo.getMenu_idx());
        EgovWebUtil.getChildList(orgList, vo.getMenu_idx(), srchList);
        String[] args = (String[]) srchList.toArray(new String[srchList.size()]);
        vo.setProconce_list(args);
      }
      sysmenuDAO.updateUseynWithSubLevel(vo);
    }
  }

  /**
   * 시스템 메뉴을/를 삭제한다.
   * 
   * @param vo - 삭제할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public void deleteSysmenu(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub

    SysmenuVO delVO = new SysmenuVO();
    delVO.setMenu_idx(vo.getMenu_idx());
    delVO = sysmenuDAO.selectSysmenu(delVO);

    // 메뉴가 삭제될때 메뉴권한도 같이 삭제한다.
    sysauthmenuService.deleteSysauthmenuByMenuidx(vo);

    if (delVO != null) {
      // 메뉴가 게시판과 연결된 경우 해당 게시판의 연결메뉴정보를 초기화시킨다.
      int cidx = delVO.getMenu_link().indexOf("brd_id=BDIDX_");
      if (cidx >= 0) {
        BoardinfoVO infoVO = new BoardinfoVO();
        infoVO.setRef_menu_nix(delVO.getMenu_nix());
        boardinfoDAO.updateBoardinfoMenunixNull(infoVO);
      }

      // 메뉴가 컨텐츠와 연결된 경우 해당 게시판의 연결메뉴정보를 초기화시킨다.
      cidx = delVO.getMenu_link().indexOf("ucont_id=CTX");
      if (cidx >= 0) {
        ContentsmanVO contmanVO = new ContentsmanVO();
        contmanVO.setRef_menu_nix(delVO.getMenu_nix());
        contentsmanDAO.updateContentsmanMenunixNull(contmanVO);
      }

    }

    String dbtype = EgovProperties.getProperty("Globals.DbType");
    if ("mysql".equals(dbtype)) {
      SysmenuVO srchlistVO = new SysmenuVO();
      srchlistVO.setSrch_mu_gub(vo.getSrch_mu_gub());
      srchlistVO.setSrch_mu_lang(vo.getSrch_mu_lang());
      srchlistVO.setSrch_mu_site(vo.getSrch_mu_site());
      List sysmenuList = sysmenuDAO.selectSysmenumanList(srchlistVO);

      // 조작하기 편하도록 필요한 데이터만 String 배열로 빼낸다.
      String[][] orgList = new String[sysmenuList.size()][2];
      for (int i = 0; i < sysmenuList.size(); i++) {
        SysmenuVO menuVO = (SysmenuVO) sysmenuList.get(i);
        // if(menuVO.getBrd_id())

        orgList[i][0] = menuVO.getMenu_idx();
        orgList[i][1] = menuVO.getUp_menu_idx();
      }

      // 게시판과 연동된 메뉴만 상위메뉴까지 포함해서 가져와 리스트를 만든다.
      List srchList = new ArrayList();
      srchList.add(vo.getMenu_idx());
      EgovWebUtil.getChildList(orgList, vo.getMenu_idx(), srchList);
      String[] args = (String[]) srchList.toArray(new String[srchList.size()]);
      vo.setProconce_list(args);
    }


    sysmenuDAO.deleteSysmenu(vo);


  }

  /**
   * 시스템 메뉴항목을 상세조회 한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public SysmenuVO selectSysmenu(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysmenuDAO.selectSysmenu(vo);
  }

  /**
   * 특정 메뉴의 상위메뉴를 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public SysmenuVO selectSysupmenu(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysmenuDAO.selectSysupmenu(vo);
  }

  /**
   * 메뉴구성 - 시스템 메뉴 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectSysmenuList(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysmenuDAO.selectSysmenuList(vo);
  }

  /**
   * 메뉴관리 - 시스템 메뉴 목록을 조회한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectSysmenumanList(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysmenuDAO.selectSysmenumanList(vo);
  }

  /**
   * 특정 메뉴와 같은 레벨의 서브메뉴 목록을 조회한다..
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public List selectSubmenuList(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysmenuDAO.selectSubmenuList(vo);
  }

  @Override
  public List selectSysmenuListSub(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysmenuDAO.selectSysmenuListSub(vo);
  }

  /**
   * 시스템 메뉴목록의 총 개수를 구한다.
   * 
   * @param vo - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  @Override
  public int selectSysmenuListTotCnt(SysmenuVO vo) throws Exception {
    // TODO Auto-generated method stub
    return sysmenuDAO.selectSysmenuListTotCnt(vo);
  }

}
