package egovframework.plani.template.cmm.utils;

import egovframework.plani.template.man.menuctgry.vo.SysmenuVO;

public class CategoryItem extends CategoryComponent {

  private SysmenuVO sysmenuVO;

  public CategoryItem() {}

  public CategoryItem(SysmenuVO menu) {
    this.sysmenuVO = menu;
  }

  @Override
  public String getId() {
    return sysmenuVO.getMenu_idx();
  }

  @Override
  public String getParentId() {
    return sysmenuVO.getUp_menu_idx() == null ? ROOT : sysmenuVO.getUp_menu_idx();
  }

  @Override
  public String getName() {
    return sysmenuVO.getMenu_nm();
  }

  public String getUri() {
    return sysmenuVO.getMenu_link();
  }

  public int children_cnt() {
    return categoryChildren.size();
  }

  @Override
  public void children() {
    int children_cnt = categoryChildren.size();
    if (children_cnt > 0) {
      print("\n<ul>\n");
      for (int i = 0; i < children_cnt; i++) {
        print("\t<li>");
        print(categoryChildren.get(i).getName());
        categoryChildren.get(i).children();
        print("</li>\n");
      }
      print("</ul>\n");
    }
  }

  @Override
  public void breadcrumb() {
    if (this.getId() != ROOT) {
      print("\t<li>");
      print(this.getParent().getName());
      print("</li>\n");
      this.getParent().breadcrumb();
    }
  }

  public void print(String str) {
    System.out.print(str);
  }

}
