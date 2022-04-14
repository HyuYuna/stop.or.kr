package egovframework.plani.custom.man.map.service;

import java.util.List;
import egovframework.plani.custom.man.map.vo.MapVO;
import egovframework.plani.custom.man.map.vo.ZipcodeVO;

public interface MapService {


  /**
   * map 정보를 저장한다
   * 
   * @param vo-스케쥴 정보가 담긴 vo
   * @return
   * @exception - Exception
   */
  public Integer insertMap(MapVO vo) throws Exception;

  /**
   * 지도 시/군/구 정보를 조회한다
   * 
   * @param vo- vo
   * @exception - Exception
   */
  public List<ZipcodeVO> selectMapSidoList(ZipcodeVO vo) throws Exception;

  /**
   * 지도 시/군/구 정보를 조회한다
   * 
   * @param vo- vo
   * @exception - Exception
   */
  public List<ZipcodeVO> selectMapGugunList(ZipcodeVO vo) throws Exception;

  /**
   * map 정보를 조회한다
   * 
   * @param vo- vo
   * @exception - Exception
   */
  public List<MapVO> selectMapList(MapVO vo) throws Exception;

  /**
   * map 정보를 조회한다
   * 
   * @param vo- vo
   * @exception - Exception
   */
  public MapVO selectMidMap(MapVO vo) throws Exception;

  /**
   * map 목록의 총 개수를 구한다.
   * 
   * @param VO - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public int selectMapListTotCnt(MapVO vo) throws Exception;


  /**
   * map 업데이트 한다
   * 
   * @param VO - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public void updateMap(MapVO vo) throws Exception;


  /**
   * map 삭제한다
   * 
   * @param VO - 조회할 조건이 담긴 VO
   * @exception Exception
   */
  public void deleteMap(MapVO vo) throws Exception;


}
