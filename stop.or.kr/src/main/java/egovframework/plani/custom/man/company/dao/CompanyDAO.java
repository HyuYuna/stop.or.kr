package egovframework.plani.custom.man.company.dao;

import java.util.List;
import egovframework.plani.custom.man.company.vo.CompanyVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper
public interface CompanyDAO {

  /**
   * 정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public Integer insertCompany(CompanyVO vo) throws Exception;

  /**
   * 정보을/를 등록한다.
   * 
   * @param vo - 등록할 조건이 담긴 VO
   * @exception Exception
   */
  public List<CompanyVO> xlsCompanyList(CompanyVO vo) throws Exception;

}
