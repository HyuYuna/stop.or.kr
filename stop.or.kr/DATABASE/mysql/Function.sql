-- Mysql 5.0 이상 테스트


/*------------------------------------------------------------------------------
-- 개체 이름: SF_ATCFILE_INFO
-- 만든 날짜: 2014-12-29
-- 마지막으로 수정한 날짜: 2014-08-18 오전 11:03:59
-- 상태: VALID
------------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS SF_ATCFILE_INFO;

DELIMITER //

CREATE Function SF_ATCFILE_INFO



(
	ARG_KEY_01               VARCHAR(4000),
	ARG_KEY_02               VARCHAR(4000),
	ARG_KEY_03               INT,
	ARG_KEY_04               INT,
	ARG_IS_THUMB             VARCHAR(4000),
    ARG_RET_TYPE             VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 첨부파일에 대한 정보를 조회한다
 최초작성자 :  한병한
 최초작성일 : 2014-12-29
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

Begin
    Declare l_key_03   INT;
    Declare l_key_04   INT;

    Declare l_ret_val  VARCHAR(128);
  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

	IF ARG_KEY_03 = 0 THEN
		Set l_key_03 = 1;
	ELSE
     	Set l_key_03 = ARG_KEY_03;
    END IF;

	IF ARG_KEY_04 = 0 THEN
		Set l_key_04 = 1;
	ELSE
     	Set l_key_04 = ARG_KEY_04;
    END IF;


    /*해당 키값을 모두 주고 파일 찾기*/
	IF ARG_RET_TYPE = 'VCODE' THEN

    	SELECT
        	IFNULL(VCHKCODE, '') INTO l_ret_val
        FROM
        	CMS_ATACH
        WHERE
        	ATCKEY_1ST = ARG_KEY_01 AND
            ATCKEY_2ND = ARG_KEY_02 AND
            ATCKEY_3RD = l_key_03 AND
            ATCKEY_4TH = l_key_04 AND
            IS_THUMB = ARG_IS_THUMB;

    END IF;

    /*첨부파일중 이미지파일 찾기*/
	IF ARG_RET_TYPE = 'IMGCODE' THEN
    	SELECT
        	IFNULL(VCHKCODE, '') INTO l_ret_val
        FROM
        	(
	        	SELECT
            	    ROWNUM RN,
                    A.*
                FROM
    	   			CMS_ATACH A
                WHERE
                    ATCKEY_1ST = ARG_KEY_01 AND
                    ATCKEY_2ND = ARG_KEY_02 AND
                    IS_THUMB = ARG_IS_THUMB AND
                    UPPER(FEXT) IN ('JPG', 'GIF', 'BMP', 'PNG')
		        ORDER BY ATCKEY_2ND ASC
            ) A
		WHERE
            RN = 1;
    END IF;

	IF ARG_RET_TYPE = 'PDFCODE' THEN

    	SELECT
        	IFNULL(VCHKCODE, '') INTO l_ret_val
        FROM
        	(
	        	SELECT
            	    ROWNUM RN,
                    A.*
                FROM
    	   			CMS_ATACH A
                WHERE
                    ATCKEY_1ST = ARG_KEY_01 AND
                    ATCKEY_2ND = ARG_KEY_02 AND
                    IS_THUMB = ARG_IS_THUMB AND
                    UPPER(FEXT) IN ('PDF')
		        ORDER BY ATCKEY_2ND ASC
            ) A
		WHERE
            RN = 1;

    END IF;


	IF ARG_RET_TYPE = 'COUNT' THEN

    	SELECT
        	TO_CHAR(COUNT(*)) INTO l_ret_val
        FROM
        	CMS_ATACH
        WHERE
        	ATCKEY_1ST = ARG_KEY_01 AND
            ATCKEY_2ND = ARG_KEY_02 AND
            IS_THUMB = ARG_IS_THUMB;

    END IF;

RETURN l_ret_val;


END;
//

DELIMITER ;













DROP FUNCTION IF EXISTS SF_AUTH_LV;

DELIMITER //

CREATE Function SF_AUTH_LV

(
    ARG_AUTH_CD               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 권한 테이블코드로 권한레벨을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

Begin
    Declare l_auth_lv   Varchar(100);
  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

	IF ARG_AUTH_CD IS NULL THEN

    	Set l_auth_lv = '';

    ELSE

      SELECT AUTH_LV
        INTO l_auth_lv
        FROM CMS_SYS_AUTH
       WHERE
          AUTH_CD = ARG_AUTH_CD;
	END IF;



RETURN l_auth_lv;


END;
//

DELIMITER ;


















DROP FUNCTION IF EXISTS SF_AUTH_NM;

DELIMITER //

CREATE Function SF_AUTH_NM

(
    ARG_CD_IDX               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 권한 테이블의 권한명을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

Begin
    Declare l_cd_nm   Varchar(100);
  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

	IF ARG_CD_IDX IS NULL THEN

    	Set l_cd_nm = '';

    ELSE

      SELECT AUTH_NM
        INTO l_cd_nm
        FROM CMS_SYS_AUTH
       WHERE
          AUTH_CD = ARG_CD_IDX;
	END IF;



RETURN l_cd_nm;


END;
//

DELIMITER ;





DROP FUNCTION IF EXISTS SF_CODE_NM;

DELIMITER //

CREATE Function SF_CODE_NM


(
    ARG_CD_IDX               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 공통 코드 테이블의 코드명을 가져온다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

Begin
    Declare l_cd_nm   Varchar(100);
  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

	IF ARG_CD_IDX IS NULL THEN

    	Set l_cd_nm = '';

    ELSE

      SELECT CODE_NM
        INTO l_cd_nm
        FROM CMS_SYS_CODE
       WHERE
          CODE_IDX = ARG_CD_IDX;
	END IF;



RETURN l_cd_nm;


END;
//

DELIMITER ;








DROP FUNCTION IF EXISTS SF_CTGRY_NM;

DELIMITER //

CREATE Function SF_CTGRY_NM

(
    ARG_CD_IDX               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 카테고리 테이블의 카테고리명을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

Begin
    Declare l_cd_nm   Varchar(100);
  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

	IF ARG_CD_IDX IS NULL THEN

    	Set l_cd_nm = '';

    ELSE

      SELECT CTGRY_NM
        INTO l_cd_nm
        FROM CMS_SYS_CTGRY
       WHERE
          CTGRY_IDX = ARG_CD_IDX;
	END IF;



RETURN l_cd_nm;


END;
//

DELIMITER ;








DROP FUNCTION IF EXISTS SF_GEN_IDSTR;

DELIMITER //

CREATE Function         SF_GEN_IDSTR



(
    ARG_STR_LEN               INT
)
 /**************************************************************
 업무 그룹명 : 숫자와 알파벳 소문자, 대문자의 조합으로
 				ID String을 생성한다
 최초작성자 :  한병한
 최초작성일 : 2014-11-21
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

BEGIN
	DECLARE l_strcase  INT;
    DECLARE l_strnow   CHAR(1);
    DECLARE l_retstr   VARCHAR(256);
    DECLARE l_cnt 	   INT;

  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

	SET l_cnt = 0;


    WHILE l_cnt < ARG_STR_LEN DO

      SET l_strcase = MOD(ROUND(RAND() * 10000, 0), 3);

      IF l_strcase = 0 THEN
          SELECT CHAR(MOD(ROUND(RAND() * 10000, 0),10) + 48 USING ASCII) INTO l_strnow FROM dual;
      ELSEIF l_strcase = 1 THEN
          SELECT CHAR(MOD(ROUND(RAND() * 10000, 0),26) + 65 USING ASCII) INTO l_strnow  FROM dual;
      ELSE
          SELECT CHAR(MOD(ROUND(RAND() * 10000, 0),26) + 97 USING ASCII) INTO l_strnow  FROM dual;
      END IF;

      SET l_retstr = concat(ifnull(l_retstr, '') , ifnull(l_strnow, ''));
      SET l_cnt = l_cnt + 1;

    END WHILE;

RETURN l_retstr;


END;
//

DELIMITER ;







DROP FUNCTION IF EXISTS SF_USER_NM;

DELIMITER //

CREATE Function SF_USER_NM

(
    ARG_USR_ID               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 사용자 ID로 사용자 이름을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

Begin
    Declare l_usr_nm   Varchar(100);
  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

	IF ARG_USR_ID IS NULL THEN

    	Set l_usr_nm = '';

    ELSE

      SELECT USER_NM
        INTO l_usr_nm
        FROM CMS_USR_INFO
       WHERE
          USER_ID = ARG_USR_ID;
	END IF;



RETURN l_usr_nm;


END;
//

DELIMITER ;









DROP FUNCTION IF EXISTS SF_MENU_NM;

DELIMITER //

CREATE Function SF_MENU_NM



(
    ARG_MENU_IDX               VARCHAR(4000),
    ARG_MENU_NIX               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : MENU_IDX, MENU_NIX로 메뉴명을 조회한다
 최초작성자 :  한병한
 최초작성일 : 2015-11-19
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

Begin
    Declare l_menu_nm   Varchar(100);
  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

	IF ARG_MENU_IDX IS NOT NULL AND ARG_MENU_NIX IS NOT NULL THEN

    	Set l_menu_nm = '';

	ELSEIF  ARG_MENU_IDX IS NULL AND ARG_MENU_NIX IS NULL THEN

    	Set l_menu_nm = '';

    ELSE

      SELECT MENU_NM
        INTO l_menu_nm
        FROM CMS_SYS_MENU
       WHERE
          MENU_IDX = ARG_MENU_IDX OR
          MENU_NIX = ARG_MENU_NIX;
	END IF;



RETURN l_menu_nm;


END;
//

DELIMITER ;








DROP FUNCTION IF EXISTS SF_REFERER_GR;

DELIMITER //

CREATE
Function SF_REFERER_GR



(
    ARG_REFERER               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 유입경로 분석
 최초작성자 :  한병한
 최초작성일 : 2017-02-09
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

Begin
    Declare l_referer   Varchar(300);
    Declare l_return   Varchar(100);
  DECLARE EXIT HANDLER FOR Sqlexception BEGIN
      RETURN NULL;
 END;

   	Set l_return = 'ETC';


	IF ARG_REFERER IS NULL THEN

    	Set l_return = '직접입력';

    ELSE

    	Set l_referer = UPPER(ARG_REFERER);

    	IF INSTR(l_referer, 'GOOGLE.COM') <> 0 OR INSTR(l_referer, 'GOOGLE.CO.KR') <> 0 THEN
    		Set l_return = 'GOOGLE';
        ELSEIF INSTR(l_referer, 'NAVER.COM') <> 0 THEN
    		Set l_return = 'NAVER';
        ELSEIF INSTR(l_referer, 'DAUM.NET') <> 0 THEN
    		Set l_return = 'DAUM';
		ELSE
       	    Set l_return = 'ETC';
        END IF;

	END IF;



RETURN l_return;


END;
//

DELIMITER ;


















--DROP FUNCTION IF EXISTS SF_BRD_PREATCL;
--
--DELIMITER //
--
--CREATE FUNCTION SF_BRD_PREATCL(
--    ARG_CTGRY_IDX			VARCHAR(15),
--    ARG_BRD_IDX				VARCHAR(32),
--    ARG_CONT_IDX				INT,
--    ARG_PRE_TYPE			CHAR(3),
--    ARG_RET_TYPE			CHAR(3),
--	ARG_IS_NOTICE 				CHAR(1)
--) RETURNS varchar(256) CHARSET utf8
--Begin
--    Declare l_ret_idx   int;
--    Declare l_ret_sub   Varchar(256);
--	DECLARE EXIT HANDLER FOR Sqlexception BEGIN
--      RETURN NULL;
-- END;
--
--	IF ARG_PRE_TYPE = 'PRE' THEN
--    
--		IF ARG_CTGRY_IDX IS NULL OR ARG_CTGRY_IDX = '' THEN
--
--			/* 이전글 카테고리가 지정되지 않은 경우 */
--			SELECT 
--				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
--			FROM
--				CMS_BRD_TXT_IDX_VXD5L880
--			WHERE
--				BRD_ID = ARG_BRD_IDX AND
--				IS_NOTICE = ARG_IS_NOTICE AND
--                CONT_IDX < ARG_CONT_IDX		
--			ORDER BY CONT_IDX DESC LIMIT 1;
--        
--        ELSE
--        
--			/* 이전글 카테고리가 지정된 경우 */
--			SELECT 
--				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
--			FROM
--				CMS_BRD_TXT_IDX_VXD5L880
--			WHERE
--				BRD_ID = ARG_BRD_IDX AND
--				IS_NOTICE = ARG_IS_NOTICE AND
--                CTGRY_IDX = ARG_CTGRY_IDX AND
--                CONT_IDX < ARG_CONT_IDX	
--			ORDER BY CONT_IDX DESC LIMIT 1;
--        
--        
--        END IF;
--    
--    
--    ELSE
--    
--   		IF ARG_CTGRY_IDX IS NULL OR ARG_CTGRY_IDX = '' THEN
--
--			/* 다음글 카테고리가 지정되지 않은 경우 */
--			SELECT 
--				CONT_IDX, SUBJECT  INTO l_ret_idx, l_ret_sub
--			FROM
--				CMS_BRD_TXT_IDX_VXD5L880
--			WHERE
--				BRD_ID = ARG_BRD_IDX AND
--				IS_NOTICE = ARG_IS_NOTICE AND
--                CONT_IDX > ARG_CONT_IDX		
--			ORDER BY CONT_IDX ASC LIMIT 1;
--        
--        ELSE
--        
--			/* 다음글 카테고리가 지정된 경우 */
--			SELECT 
--				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
--			FROM
--				CMS_BRD_TXT_IDX_VXD5L880
--			WHERE
--				BRD_ID = ARG_BRD_IDX AND
--				IS_NOTICE = ARG_IS_NOTICE AND
--                CTGRY_IDX = ARG_CTGRY_IDX AND
--                CONT_IDX > ARG_CONT_IDX	
--			ORDER BY CONT_IDX ASC LIMIT 1;
--        
--        
--        END IF;
--    
--    END IF;
--
--
--
--	IF ARG_RET_TYPE = 'IDX' THEN 
--		RETURN l_ret_idx;
--	ELSE
--		RETURN l_ret_sub;
--	END IF;
--		
--
--END
--//
--
--DELIMITER ;


DROP FUNCTION IF EXISTS SF_BRD_PREATCL;

DELIMITER //

CREATE FUNCTION SF_BRD_PREATCL(
    ARG_CTGRY_IDX			VARCHAR(15),
    ARG_BRD_IDX				VARCHAR(32),
    ARG_CONT_IDX			INT,
    ARG_PRE_TYPE			CHAR(3),
    ARG_RET_TYPE			CHAR(3),
   ARG_IS_NOTICE 			CHAR(1)
) RETURNS varchar(256) CHARSET utf8
Begin
    Declare l_ret_idx   int;
    Declare l_brd_type  VARCHAR(16);
    Declare l_ret_sub   Varchar(256);
    DECLARE EXIT HANDLER FOR Sqlexception BEGIN
	RETURN NULL;
    END;
    SELECT BRD_GB into l_brd_type FROM CMS_BRD_INFO WHERE BRD_ID = ARG_BRD_IDX;


IF ARG_PRE_TYPE = 'PRE' THEN

	 /*일반게시판/익명게시판*/
	 IF l_brd_type = 'CDIDX00042' OR l_brd_type = 'CDIDX00046' THEN
    
		IF ARG_CTGRY_IDX IS NULL OR ARG_CTGRY_IDX = '' THEN

			/* 이전글 카테고리가 지정되지 않은 경우 */
			SELECT 
				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
			FROM
				CMS_BRD_TXT_IDX_VXD5L880
			WHERE
				BRD_ID = ARG_BRD_IDX AND
				IS_NOTICE = ARG_IS_NOTICE AND
				IS_SCRT = 'N' AND
				CONT_IDX < ARG_CONT_IDX		
				ORDER BY CONT_IDX DESC LIMIT 1;
	
		ELSE
	
			/* 이전글 카테고리가 지정된 경우 */
			SELECT 
				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
			FROM
				CMS_BRD_TXT_IDX_VXD5L880
			WHERE
				BRD_ID = ARG_BRD_IDX AND
				IS_NOTICE = ARG_IS_NOTICE AND
				IS_SCRT = 'N' AND
				CTGRY_IDX = ARG_CTGRY_IDX AND
				CONT_IDX < ARG_CONT_IDX	
				ORDER BY CONT_IDX DESC LIMIT 1;

		END IF;
		
	/* FAQ 게시판 */
	ELSEIF l_brd_type = 'CDIDX00043' THEN

		IF ARG_CTGRY_IDX IS NULL OR ARG_CTGRY_IDX = '' THEN

			/* 이전글 카테고리가 지정되지 않은 경우 */
			SELECT 
				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
			FROM
				CMS_BRD_FAQ_IDX_MP43Z23Q
			WHERE
				BRD_ID = ARG_BRD_IDX AND
				CONT_IDX < ARG_CONT_IDX		
				ORDER BY CONT_IDX DESC LIMIT 1;
	
		ELSE
	
			/* 이전글 카테고리가 지정된 경우 */
			SELECT 
				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
			FROM
				CMS_BRD_FAQ_IDX_MP43Z23Q
			WHERE
				BRD_ID = ARG_BRD_IDX AND
				 CTGRY_IDX = ARG_CTGRY_IDX AND
				CONT_IDX < ARG_CONT_IDX	
				ORDER BY CONT_IDX DESC LIMIT 1;

		END IF;
  
	/* 이미지 게시판 */ 
	ELSEIF l_brd_type = 'CDIDX00044' THEN
		
		/* 이전글 카테고리가 지정되지 않은 경우 */
		SELECT 
			CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
		FROM
			CMS_BRD_THM_IDX_CF68M3GZ
		WHERE
			BRD_ID = ARG_BRD_IDX AND
			IS_NOTICE = ARG_IS_NOTICE AND
			CONT_IDX < ARG_CONT_IDX		
			ORDER BY CONT_IDX DESC LIMIT 1;

	END IF;

/*다음글*/
ELSE
	/* 일반 게시판 / 익명게시판2 */
	IF l_brd_type = 'CDIDX00042' OR l_brd_type = 'CDIDX00046' THEN

		IF ARG_CTGRY_IDX IS NULL OR ARG_CTGRY_IDX = '' THEN

			/* 다음글 카테고리가 지정되지 않은 경우 */
			SELECT 
				CONT_IDX, SUBJECT  INTO l_ret_idx, l_ret_sub
			FROM
				CMS_BRD_TXT_IDX_VXD5L880
			WHERE
				BRD_ID = ARG_BRD_IDX AND
				IS_NOTICE = ARG_IS_NOTICE AND
				IS_SCRT = 'N' AND
				CONT_IDX > ARG_CONT_IDX	 
				ORDER BY CONT_IDX ASC LIMIT 1;

		ELSE

			/* 다음글 카테고리가 지정된 경우 */
			SELECT 
				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
			FROM
				CMS_BRD_TXT_IDX_VXD5L880
			WHERE
				BRD_ID = ARG_BRD_IDX AND
				IS_NOTICE = ARG_IS_NOTICE AND
				CTGRY_IDX = ARG_CTGRY_IDX AND
				IS_SCRT = 'N' AND
				CONT_IDX > ARG_CONT_IDX	
				ORDER BY CONT_IDX ASC LIMIT 1;
		END IF;

	/* FAQ 게시판 */
	ELSEIF l_brd_type = 'CDIDX00043' THEN
		IF ARG_CTGRY_IDX IS NULL OR ARG_CTGRY_IDX = '' THEN

			/* 다음글 카테고리가 지정되지 않은 경우 */
			SELECT 
				CONT_IDX, SUBJECT  INTO l_ret_idx, l_ret_sub
			FROM
				CMS_BRD_FAQ_IDX_MP43Z23Q
			WHERE
				BRD_ID = ARG_BRD_IDX AND
				CONT_IDX > ARG_CONT_IDX		
				ORDER BY CONT_IDX ASC LIMIT 1;

		ELSE

			/* 다음글 카테고리가 지정된 경우 */
			SELECT 
				CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
			FROM
				CMS_BRD_FAQ_IDX_MP43Z23Q
			WHERE
				BRD_ID = ARG_BRD_IDX AND
				CTGRY_IDX = ARG_CTGRY_IDX AND
				CONT_IDX > ARG_CONT_IDX	
				ORDER BY CONT_IDX ASC LIMIT 1;


		END IF;
	/* 이미지 게시판 */ 
	ELSEIF l_brd_type = 'CDIDX00044' THEN

		/* 다음글 카테고리가 지정된 경우 */
		SELECT 
			CONT_IDX, SUBJECT INTO l_ret_idx, l_ret_sub
		FROM
			CMS_BRD_THM_IDX_CF68M3GZ
		WHERE
			BRD_ID = ARG_BRD_IDX AND
			CONT_IDX > ARG_CONT_IDX	
			ORDER BY CONT_IDX ASC LIMIT 1;
	END IF;

END IF;



IF ARG_RET_TYPE = 'IDX' THEN 
	RETURN l_ret_idx;
ELSE
	RETURN l_ret_sub;
END IF;
	

END
//

DELIMITER ;

