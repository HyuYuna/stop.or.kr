package egovframework.plani.template.webtoon.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.plani.template.atchfile.service.AtchfileService;
import egovframework.plani.template.atchfile.vo.AtchfileVO;
import egovframework.plani.template.webtoon.dao.WebtoonCategoryDAO;
import egovframework.plani.template.webtoon.service.WebtoonCategoryService;
import egovframework.plani.template.webtoon.service.WebtoonService;
import egovframework.plani.template.webtoon.vo.WebtoonCategoryVO;
import egovframework.plani.template.webtoon.vo.WebtoonVO;

@Service("webtoonCategoryService")
public class WebtoonCategoryServiceImpl implements WebtoonCategoryService {

	@Resource(name = "webtoonCategoryDAO")
	private WebtoonCategoryDAO webtoonCategoryDAO;

	@Resource(name = "webtoonService")
	private WebtoonService webtoonService;

	/** AtchfileService */
	@Resource(name = "atchfileService")
	private AtchfileService atchfileService;

	@Override
	public Integer insertWebtoonCategory(WebtoonCategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		return webtoonCategoryDAO.insertWebtoonCategory(vo);
	}

	@Override
	public void updateWebtoonCategory(WebtoonCategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		webtoonCategoryDAO.updateWebtoonCategory(vo);

	}

	@Override
	public void deleteWebtoonCategory(WebtoonCategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		webtoonCategoryDAO.deleteWebtoonCategory(vo);

	}

	@Override
	public WebtoonCategoryVO selectWebtoonCategory(WebtoonCategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		return webtoonCategoryDAO.selectWebtoonCategory(vo);
	}

	@Override
	public List selectWebtoonCategoryList(WebtoonCategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		return webtoonCategoryDAO.selectWebtoonCategoryList(vo);
	}

	@Override
	public int selectWebtoonCategoryListTotCnt(WebtoonCategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		return webtoonCategoryDAO.selectWebtoonCategoryListTotCnt(vo);
	}

	@Override
	public void deleteWebtoonAll(WebtoonCategoryVO vo) throws Exception {
		WebtoonVO wvo = new WebtoonVO();
		// wvo.setCategory(new Integer(vo.getCn_seq()).toString());
		wvo.setSearchCondition(new Integer(vo.getCn_seq()).toString());
		List<WebtoonVO> wlist = webtoonService.selectWebtoonList(wvo);
		AtchfileVO fvo = new AtchfileVO();
		fvo.setAtckey_1st("WEBTOON");
		fvo.setAtckey_3rd(1);
		for (int i = 0; i < wlist.size(); i++) {
			fvo.setAtckey_2nd(new Integer(wlist.get(i).getCn_seq()).toString());
			atchfileService.deleteAtchfiles(fvo);
		}
		webtoonCategoryDAO.deleteWebtoonAll(vo);

	}

}
