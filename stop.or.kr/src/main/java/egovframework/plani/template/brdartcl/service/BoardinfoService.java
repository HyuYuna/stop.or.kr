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
package egovframework.plani.template.brdartcl.service;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;


/**
 * 게시판정보 Service
 * 
 * @class : [PLANI_TMPL] [egovframework.plani.metsys.service] [BoardinfoService.java]
 * @author : byunghanhan@PLANI
 * @date : 2013. 5. 13. 오전 11:29:29
 * @version : 1.0
 */
public interface BoardinfoService {

  /**
   * 게시판을 등록한다.
   * 
   * @param vo - 등록할 정보가 담긴 BoardinfoVO
   * @return 등록 결과
   * @exception Exception
   */
  Integer insertBoardinfo(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  void updateBoardinfo(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  void updateBoardinfoMenunix(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  void updateBoardinfoMenunixNull(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 삭제한다.
   * 
   * @param vo - 삭제할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  void deleteBoardinfo(BoardinfoVO vo) throws Exception;

  /**
   * 게시판 정보를 조회한다.
   * 
   * @param vo - 조회할 정보가 담긴 BoardinfoVO
   * @return 조회한 게시판
   * @exception Exception
   */
  BoardinfoVO selectBoardinfo(BoardinfoVO vo) throws Exception;

  /**
   * 게시판 목록을 조회한다.
   * 
   * @param searchVO - 조회할 정보가 담긴 VO
   * @return 게시판 목록
   * @exception Exception
   */
  List selectBoardinfoList(BoardinfoVO vo) throws Exception;

  /**
   * 게시판 총 갯수를 조회한다. @param searchVO - 조회할 정보가 담긴 VO @return 게시판 총 갯수 @exception
   */
  int selectBoardinfoListTotCnt(BoardinfoVO vo) throws Exception;

  /**
   * 게시판 (메인구조 보기) 목록을 조회한다.
   * 
   * @param searchMap - 조회할 정보가 담긴 Map
   * @return 게시판 목록
   * @exception Exception
   */
  public List selectBoardinfomenuList(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 조회(게시판명으로)한다.
   * 
   * @param vo - 조회할 정보가 담긴 BoardinfoVO
   * @return 조회한 게시판
   * @exception Exception
   */
  BoardinfoVO selectBoardinfoByName(BoardinfoVO vo) throws Exception;
}
