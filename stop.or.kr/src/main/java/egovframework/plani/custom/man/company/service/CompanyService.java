package egovframework.plani.custom.man.company.service;

import java.util.List;
import egovframework.plani.custom.man.company.vo.CompanyVO;


public interface CompanyService {

  /**
   * company 정보를 저장한다
   * 
   * @param vo-정보가 담긴 vo
   * @exception - Exception
   */
  public void insertCompany(CompanyVO vo) throws Exception;

  public List<CompanyVO> xlsCompanyList(CompanyVO vo) throws Exception;
}
