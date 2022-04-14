package egovframework.plani.template.cmm.utils;

import java.util.ArrayList;
import java.util.List;

public abstract class CategoryComponent {

  final static public String ROOT = "-";
  protected List<CategoryComponent> categoryChildren = new ArrayList<>();
  protected CategoryComponent parent;

  public abstract String getName();

  public abstract String getId();

  public abstract String getParentId();

  public abstract void children();

  public abstract void breadcrumb();

  public void setParent(CategoryComponent parent) {
    this.parent = parent;
  }

  public CategoryComponent getParent() {
    return this.parent;
  }

  public void add(CategoryComponent item) {
    categoryChildren.add(item);
  }

}
