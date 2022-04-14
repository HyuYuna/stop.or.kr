package egovframework.plani.custom.man.company.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.custom.man.company.dao.CompanyDAO;
import egovframework.plani.custom.man.company.service.CompanyService;
import egovframework.plani.custom.man.company.vo.CompanyVO;

@Service("companyService")
public class CompanyServiceImpl implements CompanyService {

  @Resource(name = "companyDAO")
  private CompanyDAO companyDAO;

  @Override
  public void insertCompany(CompanyVO vo) throws Exception {
    // TODO Auto-generated method stub
    companyDAO.insertCompany(vo);
  }

  @Override
  public List<CompanyVO> xlsCompanyList(CompanyVO vo) throws Exception {
    // TODO Auto-generated method stub
    return companyDAO.xlsCompanyList(vo);
  }

}
