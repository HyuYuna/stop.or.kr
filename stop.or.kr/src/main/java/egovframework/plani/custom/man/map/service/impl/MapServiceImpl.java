package egovframework.plani.custom.man.map.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.custom.man.map.dao.MapDAO;
import egovframework.plani.custom.man.map.service.MapService;
import egovframework.plani.custom.man.map.vo.MapVO;
import egovframework.plani.custom.man.map.vo.ZipcodeVO;

@Service("mapService")
public class MapServiceImpl implements MapService {


  @Resource(name = "mapDAO")
  private MapDAO mapDAO;

  @Override
  public List<ZipcodeVO> selectMapSidoList(ZipcodeVO vo) throws Exception {
    // TODO Auto-generated method stub
    return mapDAO.selectMapSidoList(vo);
  }

  @Override
  public List<ZipcodeVO> selectMapGugunList(ZipcodeVO vo) throws Exception {
    // TODO Auto-generated method stub
    return mapDAO.selectMapGugunList(vo);
  }

  @Override
  public List<MapVO> selectMapList(MapVO vo) throws Exception {
    // TODO Auto-generated method stub
    return mapDAO.selectMapList(vo);
  }

  @Override
  public int selectMapListTotCnt(MapVO vo) throws Exception {
    // TODO Auto-generated method stub
    return mapDAO.selectMapListTotCnt(vo);
  }

  @Override
  public MapVO selectMidMap(MapVO vo) throws Exception {
    // TODO Auto-generated method stub
    return mapDAO.selectMidMap(vo);
  }

  @Override
  public Integer insertMap(MapVO vo) throws Exception {
    return mapDAO.insertMap(vo);

  }

  @Override
  public void updateMap(MapVO vo) throws Exception {
    // TODO Auto-generated method stub
    mapDAO.updateMap(vo);

  }

  @Override
  public void deleteMap(MapVO vo) throws Exception {
    // TODO Auto-generated method stub
    mapDAO.deleteMap(vo);

  }


}
