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
package egovframework.plani.template.brdartcl.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.brdartcl.dao.BoardinfoDAO;
import egovframework.plani.template.brdartcl.service.BoardarticleService;
import egovframework.plani.template.brdartcl.service.BoardinfoService;
import egovframework.plani.template.brdartcl.service.BoardreplyService;
import egovframework.plani.template.brdartcl.vo.BoardarticleVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.plani.template.brdartcl.vo.BoardreplyVO;
import egovframework.plani.template.cmm.utils.EgovWebUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 게시판 정보 Service IMPL
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.metsys.service.impl] [BoardinfoImpl.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 13. 오전 11:29:55
 * @version : 1.0
 */
@Service("boardinfoService")
public class BoardinfoServiceImpl extends EgovAbstractServiceImpl implements BoardinfoService {

  /** BoardinfoDAO */
  @Resource(name = "boardinfoDAO")
  private BoardinfoDAO boardInfoDAO;

  /** BoardreplyService */
  @Resource(name = "boardreplyService")
  private BoardreplyService boardreplyService;

  /** BoardarticleService */
  @Resource(name = "boardarticleService")
  private BoardarticleService boardarticleService;

  /** ID Generation */
  @Resource(name = "egovIdGnrService")
  private EgovIdGnrService egovIdGnrService;


  /**
   * 게시판을 등록한다.
   * 
   * @param vo - 등록할 정보가 담긴 BoardinfoVO
   * @return 등록 결과
   * @exception Exception
   */
  @Override
  public Integer insertBoardinfo(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub

    vo.setBrd_id("BD" + EgovWebUtil.generateIDString("IDX_", 22));
    BoardreplyVO repVO = new BoardreplyVO();

    // 썸네일 게시판 인 경우
    if ("CDIDX00044".equals(vo.getBrd_gb())) {
      if ("N".equals(vo.getCreate_new_table())) {
        // 모든 게시판이 하나의 테이블을 사용한다.
        // 만약 게시판마다 다른테이블을 사용하고 싶은 경우 아래 주석처리된 부분과 교체하고
        // 그 아래에 테이블 생성하는 부분을 추가한다.
        vo.setTbl_nm("CMS_BRD_THM_IDX_CF68M3GZ");
      } else {
        // 모든 게시판이 각각의 테이블을 사용한다.
        vo.setTbl_nm((EgovWebUtil.generateIDString("CMS_BRD_THM_IDX_", 8)).toUpperCase());
        boardInfoDAO.createBoardTable(vo);

        // 댓글을 사용하는 경우
        if ("R".equals(vo.getReply_gb()) || "B".equals(vo.getReply_gb())) {
          // 댓글 저장 테이블도 새로 생성한다.
          repVO.setTbl_nm(vo.getTbl_nm());
          boardreplyService.createBoardReplyTable(repVO);
        }
      }

    }
    // 일정 게시판 인 경우
    else if ("CDIDX00045".equals(vo.getBrd_gb())) {
      if ("N".equals(vo.getCreate_new_table())) {
        // 모든 게시판이 하나의 테이블을 사용한다.
        // 만약 게시판마다 다른테이블을 사용하고 싶은 경우 아래 주석처리된 부분과 교체하고
        // 그 아래에 테이블 생성하는 부분을 추가한다.
        vo.setTbl_nm("CMS_BRD_DRY_IDX_MH3H22JH");
      } else {
        vo.setTbl_nm((EgovWebUtil.generateIDString("CMS_BRD_DRY_IDX_", 8)).toUpperCase());
        boardInfoDAO.createBoardTable(vo);
      }
    }
    // FAQ 게시판 인 경우
    else if ("CDIDX00043".equals(vo.getBrd_gb())) {
      if ("N".equals(vo.getCreate_new_table())) {
        // 모든 게시판이 하나의 테이블을 사용한다.
        // 만약 게시판마다 다른테이블을 사용하고 싶은 경우 아래 주석처리된 부분과 교체하고
        // 그 아래에 테이블 생성하는 부분을 추가한다.
        vo.setTbl_nm("CMS_BRD_FAQ_IDX_MP43Z23Q");
      } else {
        vo.setTbl_nm((EgovWebUtil.generateIDString("CMS_BRD_FAQ_IDX_", 8)).toUpperCase());
        boardInfoDAO.createBoardTable(vo);
      }
    }

    // 일반 게시판인 경우
    else {

      if ("N".equals(vo.getCreate_new_table())) {
        // 모든 게시판이 하나의 테이블을 사용한다.
        // 만약 게시판마다 다른테이블을 사용하고 싶은 경우 아래 주석처리된 부분과 교체하고
        // 그 아래에 테이블 생성하는 부분을 추가한다.
        vo.setTbl_nm("CMS_BRD_TXT_IDX_VXD5L880");
      } else {

        // 모든 게시판이 각각의 테이블을 사용한다.
        vo.setTbl_nm((EgovWebUtil.generateIDString("CMS_BRD_TXT_IDX_", 8)).toUpperCase());
        boardInfoDAO.createBoardTable(vo);

        // 댓글을 사용하는 경우
        if ("R".equals(vo.getReply_gb()) || "B".equals(vo.getReply_gb())) {
          // 댓글 저장 테이블도 새로 생성한다.
          repVO.setTbl_nm(vo.getTbl_nm());
          boardreplyService.createBoardReplyTable(repVO);
        }
      }

    }

    return boardInfoDAO.insertBoardinfo(vo);
  }

  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  @Override
  public void updateBoardinfo(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardInfoDAO.updateBoardinfo(vo);
  }


  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  @Override
  public void updateBoardinfoMenunix(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardInfoDAO.updateBoardinfoMenunix(vo);
  }


  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  @Override
  public void updateBoardinfoMenunixNull(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub
    boardInfoDAO.updateBoardinfoMenunixNull(vo);
  }

  /**
   * 게시판을 삭제한다.
   * 
   * @param vo - 삭제할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  @Override
  public void deleteBoardinfo(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub

    // 게시판이 추가될때 게시판이 사용하는 테이블이 생성되었으므로
    // 게시판이 삭제될때 테이블도 같이 삭제(DROP)되어야 한다.
    // 하지만 테이블을 DROP하는 것은 많은 문제를 내포하고 있으므로
    // 그냥 두기로 한다.


    // 게시판 게시글 전체 삭제
    BoardarticleVO articleVO = new BoardarticleVO();
    articleVO.setTbl_nm(vo.getTbl_nm());
    articleVO.setBrd_id(vo.getBrd_id());
    boardarticleService.deleteBoard(articleVO);

    // 게시판 삭제
    boardInfoDAO.deleteBoardinfo(vo);
  }

  /**
   * 게시판 정보를 조회한다.
   * 
   * @param vo - 조회할 정보가 담긴 BoardinfoVO
   * @return 조회한 게시판
   * @exception Exception
   */
  @Override
  public BoardinfoVO selectBoardinfo(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardInfoDAO.selectBoardinfo(vo);
  }

  /**
   * 게시판 목록을 조회한다.
   * 
   * @param searchVO - 조회할 정보가 담긴 VO
   * @return 게시판 목록
   * @exception Exception
   */
  @Override
  public List selectBoardinfoList(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardInfoDAO.selectBoardinfoList(vo);
  }

  /**
   * 게시판 총 갯수를 조회한다. @param searchVO - 조회할 정보가 담긴 VO @return 게시판 총 갯수 @exception
   */
  @Override
  public int selectBoardinfoListTotCnt(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardInfoDAO.selectBoardinfoListTotCnt(vo);
  }

  /**
   * 게시판을 조회(게시판명으로)한다.
   * 
   * @param vo - 조회할 정보가 담긴 BoardinfoVO
   * @return 조회한 게시판
   * @exception Exception
   */
  @Override
  public BoardinfoVO selectBoardinfoByName(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardInfoDAO.selectBoardinfoByName(vo);

  }

  /**
   * 게시판 (메인구조 보기) 목록을 조회한다.
   * 
   * @param searchMap - 조회할 정보가 담긴 Map
   * @return 게시판 목록
   * @exception Exception
   */
  @Override
  public List selectBoardinfomenuList(BoardinfoVO vo) throws Exception {
    // TODO Auto-generated method stub
    return boardInfoDAO.selectBoardinfomenuList(vo);
  }
}
