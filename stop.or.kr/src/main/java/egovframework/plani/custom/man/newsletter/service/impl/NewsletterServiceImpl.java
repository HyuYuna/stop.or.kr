package egovframework.plani.custom.man.newsletter.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.plani.custom.man.newsletter.dao.NewsletterDAO;
import egovframework.plani.custom.man.newsletter.service.NewsletterService;
import egovframework.plani.custom.man.newsletter.vo.NewsletterVO;

@Service("newsletterService")
public class NewsletterServiceImpl implements NewsletterService {

  @Resource(name = "newsletterDAO")
  private NewsletterDAO newsletterDAO;

  @Override
  public void insertNewsletter(NewsletterVO vo) throws Exception {
    // TODO Auto-generated method stub
    newsletterDAO.insertNewsletter(vo);
  }

  @Override
  public void updateNewsletter(NewsletterVO vo) throws Exception {
    // TODO Auto-generated method stub
    newsletterDAO.updateNewsletter(vo);

  }
  
  @Override
  public void updateNewsletterReForm(NewsletterVO vo) throws Exception {
    // TODO Auto-generated method stub
    newsletterDAO.updateNewsletterReForm(vo);//20200727 뉴스레터 재동의 추가

  }

  @Override
  public NewsletterVO selectNewsletter(NewsletterVO vo) throws Exception {
    // TODO Auto-generated method stub
    return newsletterDAO.selectNewsletter(vo);
  }

  @Override
  public List<NewsletterVO> selectNewsletterList(NewsletterVO vo) throws Exception {
    // TODO Auto-generated method stub
    return newsletterDAO.selectNewsletterList(vo);
  }

  @Override
  public int selectNewsletterListTotCnt(NewsletterVO vo) throws Exception {
    // TODO Auto-generated method stub
    return newsletterDAO.selectNewsletterListTotCnt(vo);
  }

  @Override
  public void deleteNewsletter(NewsletterVO vo) throws Exception {
    // TODO Auto-generated method stub
    newsletterDAO.deleteNewsletter(vo);
  }

  @Override
  public int selectNewsletterCheckEmail(String email) throws Exception {
    // TODO Auto-generated method stub
    return newsletterDAO.selectNewsletterCheckEmail(email);
  }

	@Override
	public List<NewsletterVO> selectExcelList(NewsletterVO vo) throws Exception {
		// TODO Auto-generated method stub
		return newsletterDAO.selectExcelList(vo);
	}

}
