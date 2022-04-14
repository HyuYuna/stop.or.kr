package egovframework.plani.custom.man.map.web;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;
import egovframework.plani.custom.man.map.service.MapService;
import egovframework.plani.custom.man.map.vo.MapVO;
import egovframework.plani.custom.man.map.vo.ZipcodeVO;

@Controller
@RequestMapping("/map")
public class MapController {

  @Resource(name = "mapService")
  private MapService mapService;

  /** Gson */
  @Resource(name = "gson")
  protected Gson gson;


  /**
   * 기관정보 main list
   * 
   * @param ZipcodeVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */
  @RequestMapping(value = "mapList")
  public String mapList(@ModelAttribute("zipcodeVO") ZipcodeVO zipcodeVO,
      @ModelAttribute("mapVO") MapVO mapVO, Model model, HttpServletRequest request)
      throws Exception {
    String sido = "";
    String gugun = "";
    List sidolist = mapService.selectMapSidoList(zipcodeVO);
    List gugunlist = null;

    if (zipcodeVO.getSido() != null) {
      gugunlist = mapService.selectMapGugunList(zipcodeVO);

    }



    /* map 리스트 추출하기 */
    List maplist = mapService.selectMapList(mapVO);
    int totcnt = mapService.selectMapListTotCnt(mapVO);
    String json_maplist = gson.toJson(maplist);
    model.addAttribute("sidolist", sidolist);
    model.addAttribute("gugunlist", gugunlist);
    model.addAttribute("maplist", maplist);
    model.addAttribute("totcnt", totcnt);
    model.addAttribute("json_maplist", json_maplist);

    if (mapVO.getSrch_mu_site().equals("CDIDX00005"))
      return "/map/mapList";
    else
      return "/map/dmapList";
  }


  /**
   * 기관정보 ajax search
   * 
   * @param ZipcodeVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */
  @RequestMapping(value = "mapListSearch")
  @ResponseBody
  public String mapListSearch(@ModelAttribute("zipcodeVO") ZipcodeVO zipcodeVO,
      @ModelAttribute("mapVO") MapVO mapVO, Model model, HttpServletRequest request)
      throws Exception {
    /* map 리스트 추출하기 */
    if (mapVO.getMap_idx() != 0) {

      MapVO mvo = mapService.selectMidMap(mapVO);

      String json_mvolist = gson.toJson(mvo);

      return json_mvolist;

    } else {

      List maplist = mapService.selectMapList(mapVO);

      String json_maplist = gson.toJson(maplist);

      return json_maplist;

    }


  }


  /**
   * 기관정보 ajax gugun search
   * 
   * @param ZipcodeVO
   * @param model
   * @param request
   * @exception Exception
   * @return String
   * 
   */
  @RequestMapping(value = "mapSearchGugunList")
  @ResponseBody
  public List mapSearchGugunList(@ModelAttribute("zipcodeVO") ZipcodeVO zipcodeVO, Model model,
      HttpServletRequest request) throws Exception {
    List sido = mapService.selectMapSidoList(zipcodeVO);
    List gugun = null;
    if (zipcodeVO.getSido() != null) {
      gugun = mapService.selectMapGugunList(zipcodeVO);

    }
    return gugun;
  }

}
