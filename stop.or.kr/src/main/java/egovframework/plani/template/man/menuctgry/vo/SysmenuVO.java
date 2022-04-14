package egovframework.plani.template.man.menuctgry.vo;

import java.util.Map;
import egovframework.plani.template.man.menuctgry.vo.base.SyscodeBaseVO;

public class SysmenuVO extends SyscodeBaseVO {

  private static final long serialVersionUID = 1L;

  /** 메뉴 ID */
  private String menu_idx;

  /** 상위메뉴 ID */
  private String up_menu_idx;

  /** 메뉴 명 */
  private String menu_nm;

  /** 메뉴 링크 */
  private String menu_link;

  /** 메뉴 순서 */
  private int menu_ord;
  private int org_menu_ord;

  /** 하위메뉴 수 */
  private int sub_menu_cnt;

  /** 메뉴 레벨 */
  private int menu_lv;

  /** 메뉴 이미지 경로 */
  private String menu_img_path;

  /** 레프트메뉴 이미지 경로 */
  private String left_img_path;

  /** 타이틀 이미지 경로 */
  private String title_img_path;

  /** 사이트맵 이미지 경로 */
  private String sitemap_img_path;

  /** 메뉴 이미지 경로 */
  private String info01_img_path;

  /** 기타 이미지 경로 1 */
  private String info02_img_path;

  /** 권한 유무 (조회용) */
  private String auth_yn;

  /** 권한 코드 (조회용) */
  private String auth_cd;

  /** 링크 새창열기 여부 */
  private String blank_yn = "N";

  /** 사용자 메뉴 여부 (상단 메뉴에 나타나지 않는 회원가입, 이용약관 등의 사이트 메뉴) */
  private String memmenu_yn = "N";

  /** 제공부서, 담당자, 전화번호 등 정보 */
  private String own_info;

  /** 탭메뉴 사용 여부 */
  private String tabmenu_yn = "N";

  /** 메뉴와 연결된 컨텐츠 - 메뉴관리에서 직접 컨텐츠 수정이 가능하도록 하기 위해 */
  private String ucont_id;

  /** 메뉴와 연결된 게시판 - 메뉴관리에서 직접 컨텐츠 수정이 가능하도록 하기 위해 */
  private String brd_id;

  private String selectBrdlist;
  private String selectContlist;

  private String[] proconce_list;
  
  /** 상위메뉴 명 */
  private String up_menu_nm;

  // ych 메뉴 추가
  private Map<String, SysmenuVO> _children_;


  public Map<String, SysmenuVO> get_children_() {
    return _children_;
  }

  public void set_children_(Map<String, SysmenuVO> _children_) {
    this._children_ = _children_;
  }

  public String[] getProconce_list() {
    return proconce_list;
  }

  public void setProconce_list(String[] proconce_list) {
    this.proconce_list = proconce_list;
  }

  /** 메뉴 컨텐츠 타입 : 일반, 컨텐츠, 게시판 (메뉴와 함께 자동생성하기 위한 구분) */
  private String menucont_type = "N";

  /** 게시판 타입 : 게시판타입일 경우 생성할 게시판의 유형 */
  private String menubrd_type = "CDIDX00042";

  // 종단노드인지 여부 [0/1]
  private String is_leaf;

  public String getMenu_idx() {
    return menu_idx;
  }

  public void setMenu_idx(String menu_idx) {
    this.menu_idx = menu_idx;
  }

  public String getUp_menu_idx() {
    return up_menu_idx;
  }

  public void setUp_menu_idx(String up_menu_idx) {
    this.up_menu_idx = up_menu_idx;
  }

  public String getMenu_nm() {
    return menu_nm;
  }

  public void setMenu_nm(String menu_nm) {
    this.menu_nm = menu_nm;
  }

  public String getMenu_link() {
    return menu_link;
  }

  public void setMenu_link(String menu_link) {
    this.menu_link = menu_link;
  }

  public int getMenu_ord() {
    return menu_ord;
  }

  public void setMenu_ord(int menu_ord) {
    this.menu_ord = menu_ord;
  }

  public int getSub_menu_cnt() {
    return sub_menu_cnt;
  }

  public void setSub_menu_cnt(int sub_menu_cnt) {
    this.sub_menu_cnt = sub_menu_cnt;
  }

  public int getMenu_lv() {
    return menu_lv;
  }

  public void setMenu_lv(int menu_lv) {
    this.menu_lv = menu_lv;
  }

  public String getMenu_img_path() {
    return menu_img_path;
  }

  public void setMenu_img_path(String menu_img_path) {
    this.menu_img_path = menu_img_path;
  }

  public String getLeft_img_path() {
    return left_img_path;
  }

  public void setLeft_img_path(String left_img_path) {
    this.left_img_path = left_img_path;
  }

  public String getTitle_img_path() {
    return title_img_path;
  }

  public void setTitle_img_path(String title_img_path) {
    this.title_img_path = title_img_path;
  }

  public String getInfo01_img_path() {
    return info01_img_path;
  }

  public void setInfo01_img_path(String info01_img_path) {
    this.info01_img_path = info01_img_path;
  }

  public String getInfo02_img_path() {
    return info02_img_path;
  }

  public void setInfo02_img_path(String info02_img_path) {
    this.info02_img_path = info02_img_path;
  }

  public String getAuth_yn() {
    return auth_yn;
  }

  public void setAuth_yn(String auth_yn) {
    this.auth_yn = auth_yn;
  }

  public String getAuth_cd() {
    return auth_cd;
  }

  public void setAuth_cd(String auth_cd) {
    this.auth_cd = auth_cd;
  }

  public String getSitemap_img_path() {
    return sitemap_img_path;
  }

  public void setSitemap_img_path(String sitemap_img_path) {
    this.sitemap_img_path = sitemap_img_path;
  }

  public String getBlank_yn() {
    return blank_yn;
  }

  public void setBlank_yn(String blank_yn) {
    this.blank_yn = blank_yn;
  }

  public String getMemmenu_yn() {
    return memmenu_yn;
  }

  public void setMemmenu_yn(String memmenu_yn) {
    this.memmenu_yn = memmenu_yn;
  }

  public String getOwn_info() {
    return own_info;
  }

  public void setOwn_info(String own_info) {
    this.own_info = own_info;
  }

  public String getTabmenu_yn() {
    return tabmenu_yn;
  }

  public void setTabmenu_yn(String tabmenu_yn) {
    this.tabmenu_yn = tabmenu_yn;
  }

  public String getUcont_id() {
    return ucont_id;
  }

  public void setUcont_id(String ucont_id) {
    this.ucont_id = ucont_id;
  }

  public String getSelectBrdlist() {
    return selectBrdlist;
  }

  public void setSelectBrdlist(String selectBrdlist) {
    this.selectBrdlist = selectBrdlist;
  }

  public String getSelectContlist() {
    return selectContlist;
  }

  public void setSelectContlist(String selectContlist) {
    this.selectContlist = selectContlist;
  }

  public String getIs_leaf() {
    return is_leaf;
  }

  public void setIs_leaf(String is_leaf) {
    this.is_leaf = is_leaf;
  }

  public int getOrg_menu_ord() {
    return org_menu_ord;
  }

  public void setOrg_menu_ord(int org_menu_ord) {
    this.org_menu_ord = org_menu_ord;
  }

  public String getBrd_id() {
    return brd_id;
  }

  public void setBrd_id(String brd_id) {
    this.brd_id = brd_id;
  }

  public String getMenucont_type() {
    return menucont_type;
  }

  public void setMenucont_type(String menucont_type) {
    this.menucont_type = menucont_type;
  }

  public String getMenubrd_type() {
    return menubrd_type;
  }

  public void setMenubrd_type(String menubrd_type) {
    this.menubrd_type = menubrd_type;
  }

  public String getUp_menu_nm() {
	return up_menu_nm;
  }

  public void setUp_menu_nm(String up_menu_nm) {
	this.up_menu_nm = up_menu_nm;
  }


}
