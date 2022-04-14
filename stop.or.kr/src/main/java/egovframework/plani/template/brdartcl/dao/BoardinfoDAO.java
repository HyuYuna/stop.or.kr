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
package egovframework.plani.template.brdartcl.dao;

import java.util.List;
import egovframework.plani.template.brdartcl.vo.BoardExtraVO;
import egovframework.plani.template.brdartcl.vo.BoardinfoVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


/**
 * @Class Name : BoardinfoDAO.java
 * @Description : Boardinfo DAO Class
 * @Modification Information @ @ 수정일 수정자 수정내용 @ --------- --------- ------------------------------- @
 *               2009.03.16 최초생성
 * 
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see Copyright (C) by MOPAS All right reserved.
 */

@Mapper
public interface BoardinfoDAO {

  /**
   * 게시판을 등록한다.
   * 
   * @param vo - 등록할 정보가 담긴 BoardinfoVO
   * @return 등록 결과
   * @exception Exception
   */
  public Integer insertBoardinfo(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 테이블을 생성한다.
   * 
   * @param vo - 등록할 정보가 담긴 BoardinfoVO
   * @return 등록 결과
   * @exception Exception
   */
  public Integer createBoardTable(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  public int updateBoardinfo(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  public int updateBoardinfoMenunix(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 수정한다.
   * 
   * @param vo - 수정할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  public int updateBoardinfoMenunixNull(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 삭제한다.
   * 
   * @param vo - 삭제할 정보가 담긴 BoardinfoVO
   * @return void형
   * @exception Exception
   */
  public void deleteBoardinfo(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 조회한다.
   * 
   * @param vo - 조회할 정보가 담긴 BoardinfoVO
   * @return 조회한 게시판
   * @exception Exception
   */
  public BoardinfoVO selectBoardinfo(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 여분 필드 조회한다.
   * 
   * @param vo - 조회할 정보가 담긴 BoardinfoVO
   * @return 조회한 게시판
   * @exception Exception
   */
  public BoardExtraVO selectBoardExtra(BoardinfoVO vo) throws Exception;

  /**
   * 게시판을 조회(게시판명으로)한다.
   * 
   * @param vo - 조회할 정보가 담긴 BoardinfoVO
   * @return 조회한 게시판
   * @exception Exception
   */
  public BoardinfoVO selectBoardinfoByName(BoardinfoVO vo) throws Exception;

  /**
   * 게시판 목록을 조회한다.
   * 
   * @param searchMap - 조회할 정보가 담긴 Map
   * @return 게시판 목록
   * @exception Exception
   */
  public List selectBoardinfoList(BoardinfoVO vo) throws Exception;


  /**
   * 게시판 총 갯수를 조회한다. @param searchMap - 조회할 정보가 담긴 Map @return 게시판 총 갯수 @exception
   */
  public int selectBoardinfoListTotCnt(BoardinfoVO vo) throws Exception;

  /**
   * 게시판 (메인구조 보기) 목록을 조회한다.
   * 
   * @param searchMap - 조회할 정보가 담긴 Map
   * @return 게시판 목록
   * @exception Exception
   */
  public List selectBoardinfomenuList(BoardinfoVO vo) throws Exception;

}
