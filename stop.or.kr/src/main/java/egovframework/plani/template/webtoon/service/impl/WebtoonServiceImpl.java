package egovframework.plani.template.webtoon.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.webtoon.dao.WebtoonDAO;
import egovframework.plani.template.webtoon.service.WebtoonService;
import egovframework.plani.template.webtoon.vo.WebtoonVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("webtoonService")
public class WebtoonServiceImpl extends EgovAbstractServiceImpl implements WebtoonService {

  @Resource(name = "webtoonDAO")
  private WebtoonDAO webtoonDAO;

  /** AtchfileService */
  @Resource(name = "atchfileService")
  private AtchfileService atchfileService;

  @Override
  public Integer insertWebtoon(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub
    return webtoonDAO.insertWebtoon(vo);
  }

  @Override
  public void updateWebtoon(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub
    webtoonDAO.updateWebtoon(vo);

  }

  @Override
  public void deleteWebtoon(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub

    AtchfileVO fvo = new AtchfileVO();
    fvo.setAtckey_1st("WEBTOON");
    fvo.setAtckey_2nd(new Integer(vo.getCn_seq()).toString());
    fvo.setAtckey_3rd(1);
    atchfileService.deleteAtchfiles(fvo);
    webtoonDAO.deleteWebtoon(vo);

  }

  @Override
  public WebtoonVO selectWebtoon(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub
    return webtoonDAO.selectWebtoon(vo);
  }

  @Override
  public List selectNoticeWebtoonList(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub
    return webtoonDAO.selectNoticeWebtoonList(vo);
  }

  @Override
  public List selectWebtoonList(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub
    return webtoonDAO.selectWebtoonList(vo);
  }

  @Override
  public int selectWebtoonListTotCnt(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub
    return webtoonDAO.selectWebtoonListTotCnt(vo);
  }

  @Override
  public void updateWebtoonCount(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub
    webtoonDAO.updateWebtoonCount(vo);

  }

  @Override
  public WebtoonVO selectDescSeq(WebtoonVO vo) throws Exception {
    // TODO Auto-generated method stub
    return webtoonDAO.selectDescSeq(vo);
  }

}
