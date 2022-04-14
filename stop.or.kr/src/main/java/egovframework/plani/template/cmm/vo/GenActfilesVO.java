/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
package egovframework.plani.template.cmm.vo;

import java.io.Serializable;

public class GenActfilesVO implements Serializable {

  private static final long serialVersionUID = 5449770115329813385L;

  private String ctrl;
  private String ctrl_man;
  private String vo;
  private String svc;
  private String impl;
  private String dao;
  private String sqlmap;

  private String biznm;
  private String bizkr;

  private String src;
  private String dir;
  private String pkgnm;

  private String lastdir;

  private String baseacttable;

  public String getCtrl() {
    return ctrl;
  }

  public void setCtrl(String ctrl) {
    this.ctrl = ctrl;
  }

  public String getCtrl_man() {
    return ctrl_man;
  }

  public void setCtrl_man(String ctrl_man) {
    this.ctrl_man = ctrl_man;
  }

  public String getVo() {
    return vo;
  }

  public void setVo(String vo) {
    this.vo = vo;
  }

  public String getSvc() {
    return svc;
  }

  public void setSvc(String svc) {
    this.svc = svc;
  }

  public String getImpl() {
    return impl;
  }

  public void setImpl(String impl) {
    this.impl = impl;
  }

  public String getDao() {
    return dao;
  }

  public void setDao(String dao) {
    this.dao = dao;
  }

  public String getSqlmap() {
    return sqlmap;
  }

  public void setSqlmap(String sqlmap) {
    this.sqlmap = sqlmap;
  }

  public String getBiznm() {
    return biznm;
  }

  public void setBiznm(String biznm) {
    this.biznm = biznm;
  }

  public String getBizkr() {
    return bizkr;
  }

  public void setBizkr(String bizkr) {
    this.bizkr = bizkr;
  }

  public String getSrc() {
    return src;
  }

  public void setSrc(String src) {
    this.src = src;
  }

  public String getDir() {
    return dir;
  }

  public void setDir(String dir) {
    this.dir = dir;
  }

  public String getPkgnm() {
    return pkgnm;
  }

  public void setPkgnm(String pkgnm) {
    this.pkgnm = pkgnm;
  }

  public String getBaseacttable() {
    return baseacttable;
  }

  public void setBaseacttable(String baseacttable) {
    this.baseacttable = baseacttable;
  }

  public String getLastdir() {
    lastdir =
        dir.substring((dir.lastIndexOf(".") < 0 ? 0 : dir.lastIndexOf(".") + 1), dir.length());
    return lastdir;
  }

  public void setLastdir(String lastdir) {
    this.lastdir = lastdir;
  }



}
