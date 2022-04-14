/*
 * 대상 : SqlServer 2008; 
 * 2008 이전 버전은 지원하지 않는 기능이 있을 수 있음.. 
 * 함수 11개
 * 프로시저 1개 생성문 실행 전에 반드시,
 
	텍스트 REPLACE ::  DBO => DB User ID로.... */



CREATE Function dbo.SF_ATCFILE_INFO



(
	@ARG_KEY_01               VARCHAR(4000),
	@ARG_KEY_02               VARCHAR(4000),
	@ARG_KEY_03               INT,
	@ARG_KEY_04               INT,
	@ARG_IS_THUMB             VARCHAR(4000),
    @ARG_RET_TYPE             VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 첨부파일에 대한 정보를 조회한다
 최초작성자 :  한병한
 최초작성일 : 2014-12-29
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

As
Begin
    Declare @l_key_03   INT;
    Declare @l_key_04   INT;

    Declare @l_ret_val  VARCHAR(128);
 

	IF @ARG_KEY_03 = 0 BEGIN
		Set @l_key_03 = 1;
	END
	ELSE BEGIN
     	Set @l_key_03 = @ARG_KEY_03;
    END 

	IF @ARG_KEY_04 = 0 BEGIN
		Set @l_key_04 = 1;
	END
	ELSE BEGIN
     	Set @l_key_04 = @ARG_KEY_04;
    END 


    /*해당 키값을 모두 주고 파일 찾기*/
	IF @ARG_RET_TYPE = 'VCODE' BEGIN

    	SELECT
        	@l_ret_val = ISNULL(VCHKCODE, '')
        FROM
        	DBO.CMS_ATACH
        WHERE
        	ATCKEY_1ST = @ARG_KEY_01 AND
            ATCKEY_2ND = @ARG_KEY_02 AND
            ATCKEY_3RD = @l_key_03 AND
            ATCKEY_4TH = @l_key_04 AND
            IS_THUMB = @ARG_IS_THUMB;

    END 

    /*첨부파일중 이미지파일 찾기*/
	IF @ARG_RET_TYPE = 'IMGCODE' BEGIN
    	SELECT
        	@l_ret_val = ISNULL(VCHKCODE, '')
        FROM
        	(
	        	SELECT
            	    TOP 1 *
                FROM
    	   			DBO.CMS_ATACH A
                WHERE
                    ATCKEY_1ST = @ARG_KEY_01 AND
                    ATCKEY_2ND = @ARG_KEY_02 AND
                    IS_THUMB = @ARG_IS_THUMB AND
                    UPPER(FEXT) IN ('JPG', 'GIF', 'BMP', 'PNG')
		        ORDER BY ATCKEY_2ND ASC
            ) s;
		
    END 

	IF @ARG_RET_TYPE = 'PDFCODE' BEGIN

    	SELECT
        	@l_ret_val = ISNULL(VCHKCODE, '')
        FROM
        	(
	        	SELECT
            	    TOP 1 *
                FROM
    	   			DBO.CMS_ATACH A
                WHERE
                    ATCKEY_1ST = @ARG_KEY_01 AND
                    ATCKEY_2ND = @ARG_KEY_02 AND
                    IS_THUMB = @ARG_IS_THUMB AND
                    UPPER(FEXT) IN ('PDF')
		        ORDER BY ATCKEY_2ND ASC
            ) s;

    END 


	IF @ARG_RET_TYPE = 'COUNT' BEGIN

    	SELECT
        	@l_ret_val = CONVERT(VARCHAR, COUNT(*))
        FROM
        	DBO.CMS_ATACH
        WHERE
        	ATCKEY_1ST = @ARG_KEY_01 AND
            ATCKEY_2ND = @ARG_KEY_02 AND
            IS_THUMB = @ARG_IS_THUMB;

    END 

RETURN @l_ret_val;


END;









CREATE Function dbo.SF_AUTH_LV

(
    @ARG_AUTH_CD               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 권한 테이블코드로 권한레벨을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

As
Begin
    Declare @l_auth_lv   Varchar(100);
 

	IF @ARG_AUTH_CD IS NULL BEGIN

    	Set @l_auth_lv = '';

    END
    ELSE BEGIN

      SELECT @l_auth_lv = AUTH_LV
        FROM DBO.CMS_SYS_AUTH
       WHERE
          AUTH_CD = @ARG_AUTH_CD;
	END 



RETURN @l_auth_lv;

END;













CREATE Function dbo.SF_AUTH_NM

(
    @ARG_CD_IDX               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 권한 테이블의 권한명을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

As
Begin
    Declare @l_cd_nm   Varchar(100);
 

	IF @ARG_CD_IDX IS NULL BEGIN

    	Set @l_cd_nm = '';

    END
    ELSE BEGIN

      SELECT @l_cd_nm = AUTH_NM
        FROM DBO.CMS_SYS_AUTH
       WHERE
          AUTH_CD = @ARG_CD_IDX;
	END 



RETURN @l_cd_nm;

END;











CREATE Function dbo.SF_CODE_NM


(
    @ARG_CD_IDX               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 공통 코드 테이블의 코드명을 가져온다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

As
Begin
    Declare @l_cd_nm   Varchar(100);
 

	IF @ARG_CD_IDX IS NULL BEGIN

    	Set @l_cd_nm = '';

    END
    ELSE BEGIN

      SELECT @l_cd_nm = CODE_NM
        FROM DBO.CMS_SYS_CODE
       WHERE
          CODE_IDX = @ARG_CD_IDX;
	END 



RETURN @l_cd_nm;


END;

















CREATE Function dbo.SF_CTGRY_NM

(
    @ARG_CD_IDX               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 카테고리 테이블의 카테고리명을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

As
Begin
    Declare @l_cd_nm   Varchar(100);
 

	IF @ARG_CD_IDX IS NULL BEGIN

    	Set @l_cd_nm = '';

    END
    ELSE BEGIN

          SELECT @l_cd_nm = CTGRY_NM
        FROM DBO.CMS_SYS_CTGRY
       WHERE
          CTGRY_IDX = @ARG_CD_IDX;
	END 
	
RETURN @l_cd_nm;

END;













create Function         dbo.SF_GEN_IDSTR
 
(
    @ARG_STR_LEN               FLOAT
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

AS
BEGIN
	DECLARE @l_strcase  FLOAT;
    DECLARE @l_strnow   CHAR(1);
    DECLARE @l_retstr   VARCHAR(256);
    DECLARE @l_cnt 	   FLOAT;

 

	SET @l_cnt = 0;


    WHILE @l_cnt < @ARG_STR_LEN BEGIN

      SELECT @l_strcase = (RNDVAL % 3) FROM VW_PLANI_RAND;

      IF @l_strcase = 0 BEGIN
          SELECT @l_strnow = CHAR(RNDVAL %10 + 48) FROM VW_PLANI_RAND;
      END
      ELSE IF @l_strcase = 1 BEGIN
          SELECT @l_strnow = CHAR(RNDVAL %26 + 65) FROM VW_PLANI_RAND;
      END
      ELSE BEGIN
          SELECT @l_strnow = CHAR(RNDVAL %26 + 97) FROM VW_PLANI_RAND;
      END 

      SET @l_retstr = isnull(@l_retstr, '') + isnull(@l_strnow, '');
      SET @l_cnt = @l_cnt + 1;

    END;

	RETURN @l_retstr;


END;










CREATE Function dbo.SF_MENU_NM



(
    @ARG_MENU_IDX               VARCHAR(4000),
    @ARG_MENU_NIX               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : MENU_IDX, MENU_NIX로 메뉴명을 조회한다
 최초작성자 :  한병한
 최초작성일 : 2015-11-19
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

As
Begin
    Declare @l_menu_nm   Varchar(100);
 

	IF @ARG_MENU_IDX IS NOT NULL AND @ARG_MENU_NIX IS NOT NULL BEGIN

    	Set @l_menu_nm = '';

	END
	ELSE IF  @ARG_MENU_IDX IS NULL AND @ARG_MENU_NIX IS NULL BEGIN

    	Set @l_menu_nm = '';

    END
    ELSE BEGIN

      SELECT @l_menu_nm = MENU_NM
        FROM DBO.CMS_SYS_MENU
       WHERE
          MENU_IDX = @ARG_MENU_IDX OR
          MENU_NIX = @ARG_MENU_NIX;
	END 



RETURN @l_menu_nm;

END;












create
Function dbo.SF_REFERER_GR



(
    @ARG_REFERER               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 유입경로 분석
 최초작성자 :  한병한
 최초작성일 : 2017-02-09
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

As
Begin
    Declare @l_referer   Varchar(300);
    Declare @l_return   Varchar(100);
 

   	Set @l_return = 'ETC';


	IF @ARG_REFERER IS NULL BEGIN

    	Set @l_return = '직접입력';

    END
    ELSE BEGIN

    	Set @l_referer = UPPER(@ARG_REFERER);

    	IF CHARINDEX('GOOGLE.COM', @l_referer) <> 0 OR CHARINDEX('GOOGLE.CO.KR', @l_referer) <> 0 BEGIN
    		Set @l_return = 'GOOGLE';
        END
        ELSE IF CHARINDEX('NAVER.COM', @l_referer) <> 0 BEGIN
    		Set @l_return = 'NAVER';
        END
        ELSE IF CHARINDEX('DAUM.NET', @l_referer) <> 0 BEGIN
    		Set @l_return = 'DAUM';
		END
		ELSE BEGIN
       	    Set @l_return = 'ETC';
        END 

	END 



RETURN @l_return;


END;












CREATE
Function dbo.SF_SRVY_PCT

(
    @ARG_SRVY_IDX               INT,
    @ARG_QUES_IDX               INT,
    @ARG_ANS_ORD            		INT,
    @ARG_QUES_TYPE			   VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 통계 답변의 통계치를 구한다
 최초작성자 :  한병한
 최초작성일 : 2017-04-23
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

AS
BEGIN
	DECLARE @l_cnt     BIGINT;
	DECLARE @l_cntall  BIGINT;
	DECLARE @l_pct     DECIMAL(11,2);
    DECLARE @l_result   Varchar(100);
    
 	DECLARE @l_data_cont varchar(1024);
 	DECLARE @l_data_cnt INT;
	
	SET @l_result = '';


	/* 객관식 단답형인 경우 */
	IF @ARG_QUES_TYPE = 'CDIDX00082' BEGIN
    
    	/* 질문에 전체 답한 개수 */
    	SELECT
            @l_cntall = COUNT(*)
        FROM
            DBO.CMS_SURVEY_DATA
        WHERE 
            SRVY_IDX = @ARG_SRVY_IDX AND
            QUES_IDX = @ARG_QUES_IDX;

		/* 개별 답변에 답한 개수 */
    	SELECT
            @l_cnt = COUNT(*)
        FROM
            DBO.CMS_SURVEY_DATA
        WHERE 
            SRVY_IDX = @ARG_SRVY_IDX AND
            QUES_IDX = @ARG_QUES_IDX AND
            DATA_CONT = @ARG_ANS_ORD;
		       
        IF @l_cntall = 0 BEGIN 
            SET @l_result = '0_0.0';
        END
        ELSE BEGIN
	    	SET @l_pct = round((@l_cnt / @l_cntall * 100), 1);
    		SET @l_result = ISNULL(CONVERT(VARCHAR, @l_cnt), '') + '_' + ISNULL(CONVERT(VARCHAR, @l_pct), '');
        END 
             
         
    END
    ELSE BEGIN 
    
    	/* 문제에 답을 한 전체 카운트 */
        SELECT
            @l_cntall = COUNT(*)
        FROM
            DBO.CMS_SURVEY_DATA
        WHERE 
            SRVY_IDX = @ARG_SRVY_IDX AND
            QUES_IDX = @ARG_QUES_IDX AND
            QUESSUB_IDX = @ARG_ANS_ORD;
    
    	DECLARE cur CURSOR FOR
            /* 해당 보기를 선택한 카운트 (답변 유형별로 그룹핑) */
            SELECT
                DATA_CONT,
                COUNT(*) AS L_CNT
            FROM
                DBO.CMS_SURVEY_DATA
            WHERE 
                SRVY_IDX = @ARG_SRVY_IDX AND
                QUES_IDX = @ARG_QUES_IDX AND
                QUESSUB_IDX = @ARG_ANS_ORD
                GROUP BY DATA_CONT
                ORDER BY DATA_CONT
        OPEN cur
        FETCH NEXT FROM cur INTO @l_data_cont, @l_data_cnt;
        WHILE @@FETCH_STATUS=0
        BEGIN
            
            /* 전체 답변의 백분율 구함 */	
            SET @l_pct = round((@l_data_cnt / @l_cntall * 100), 1);
            
            IF LEN(@l_result) > 0 BEGIN
                SET @l_result = isnull(@l_result, '') + '##';
            END 
            
            /* 수치와 백분율을 결합 */
            SET @l_result = isnull(@l_result, '') + ISNULL(@l_data_cont, '') + '_' + ISNULL(CONVERT(VARCHAR, @l_data_cnt), '') + '_' + ISNULL(CONVERT(VARCHAR, @l_pct), ''); 
        	
			FETCH NEXT FROM cur INTO @l_data_cont, @l_data_cnt;
        END;
        CLOSE cur;
        DEALLOCATE cur;
           
    END 
    	



	
RETURN @l_result;


END;















CREATE Function dbo.SF_USER_NM

(
    @ARG_USR_ID               VARCHAR(4000)
)
 /**************************************************************
 업무 그룹명 : 사용자 ID로 사용자 이름을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(4000)

As
Begin
    Declare @l_usr_nm   Varchar(100);
 

	IF @ARG_USR_ID IS NULL BEGIN

    	Set @l_usr_nm = '';

    END
    ELSE BEGIN

      SELECT @l_usr_nm = USER_NM
        FROM DBO.CMS_USR_INFO
       WHERE
          USER_ID = @ARG_USR_ID;
	END 



RETURN @l_usr_nm;

END;



CREATE Function dbo.SF_COL_INFO

(
    @ARG_TABLE               VARCHAR(30),
    @ARG_COLUMN            	 VARCHAR(30),
	@INFO_TYPE				 VARCHAR(10)                   
)
 /**************************************************************
 업무 그룹명 : 테이블 정보 조회 (코멘트, PK여부).
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(100)

As
Begin
    Declare @l_result Varchar(100);
    Declare @l_cnt  INT;
 

	IF @INFO_TYPE = 'CMNT' BEGIN
		

		IF @ARG_TABLE IS NULL OR @ARG_COLUMN IS NULL BEGIN

			Set @l_result = '';

		END
		ELSE BEGIN
			
			SELECT 
				@l_result = CAST(C.VALUE AS CHAR(30))
			FROM 
				SYSOBJECTS A
			INNER JOIN SYS.COLUMNS B
			   ON A.ID = B.OBJECT_ID
			LEFT JOIN  SYS.EXTENDED_PROPERTIES  C   
			   ON C.MAJOR_ID = B.OBJECT_ID AND C.MINOR_ID = B.COLUMN_ID  
			WHERE A.XTYPE = 'U' AND
				A.NAME = @ARG_TABLE AND
				B.NAME = @ARG_COLUMN; 
		END 
	END
	IF @INFO_TYPE = 'ISPK' BEGIN
	
		SELECT
			@l_cnt = COUNT(*) 
		FROM
			INFORMATION_SCHEMA.KEY_COLUMN_USAGE
		WHERE
			OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_NAME), 'ISPRIMARYKEY') = 1 AND
			TABLE_NAME = @ARG_TABLE AND
			COLUMN_NAME = @ARG_COLUMN;
	
		IF @l_cnt = 1 BEGIN
			set @l_result = 'PK';
		END
		ELSE BEGIN 
			set @l_result = '';
		END
	
	END


RETURN @l_result;

END;





create Function         dbo.SF_TOP_MENU
 
(
    @ARG_MENU_NIX               VARCHAR(8)
)
 /**************************************************************
 업무 그룹명 : 자신이 속한 최상위 메뉴를 구함
 최초작성자 :  한병한
 최초작성일 : 2018-02-14
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS VARCHAR(16)

AS
BEGIN

    DECLARE @l_idx   VARCHAR(16);
    DECLARE @l_up_idx   VARCHAR(16);
    DECLARE @l_next_nix   VARCHAR(16);
    DECLARE @l_retstr   VARCHAR(16);

	SET @l_up_idx = 'START';
	SET @l_next_nix = @ARG_MENU_NIX;


    WHILE @l_up_idx != '' AND @l_up_idx IS NOT NULL BEGIN

      SELECT @l_idx = MENU_IDX, @l_up_idx = UP_MENU_IDX FROM DBO.CMS_SYS_MENU WHERE
	  MENU_NIX = @l_next_nix;

      SELECT @l_next_nix = MENU_NIX FROM DBO.CMS_SYS_MENU WHERE
	  MENU_IDX = @l_up_idx;
		
	  set @l_retstr = @l_idx;
    END;

	RETURN @l_retstr;


END;












CREATE Function         dbo.SF_BRD_SIBL_ARTCL

 
(
	@ARG_SIBL_TYPE	            VARCHAR(4),
	@ARG_BRD_ID               	VARCHAR(32),
    @ARG_CONT_IDX               INT,
    @ARG_IS_NOTICE              CHAR(1),
    @ARG_CTGRY_IDX	            VARCHAR(16)
)
 /**************************************************************
 업무 그룹명 : 게시글이 PREV, NEXT ARTICLE을 구한다.
 				<LAG, LEAD 대응>
 최초작성자 :  한병한
 최초작성일 : 2018-02-11
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURNS INT

AS
BEGIN

	DECLARE @ret_cont_idx  INT;
	DECLARE @l_brd_type  VARCHAR(16);


	SELECT @l_brd_type = BRD_GB FROM DBO.CMS_BRD_INFO
		WHERE BRD_ID = @ARG_BRD_ID;

	
	/* 이전 글 */
	IF @ARG_SIBL_TYPE = 'PREV' BEGIN
	
		/* 일반 게시판 / 익명게시판 */
		IF @l_brd_type = 'CDIDX00042' OR @l_brd_type = 'CDIDX00046' BEGIN

			/* 카테고리 설정되지 않음 */
			IF @ARG_CTGRY_IDX IS NULL OR @ARG_CTGRY_IDX = '' BEGIN
			
				SELECT @ret_cont_idx = ISNULL(MAX(CONT_IDX), 0) FROM DBO.CMS_BRD_TXT_IDX_VXD5L880
				WHERE 
					BRD_ID = @ARG_BRD_ID AND  
					IS_NOTICE = @ARG_IS_NOTICE AND
					IS_SCRT = 'N' AND
					CONT_IDX < @ARG_CONT_IDX;
			
			END
			/* 카테고리 설정 됨 */
			ELSE BEGIN
			
				SELECT @ret_cont_idx = ISNULL(MAX(CONT_IDX), 0) FROM DBO.CMS_BRD_TXT_IDX_VXD5L880
				WHERE 
					BRD_ID = @ARG_BRD_ID AND  
					IS_NOTICE = @ARG_IS_NOTICE AND
					CTGRY_IDX = @ARG_CTGRY_IDX AND
					IS_SCRT = 'N' AND
					CONT_IDX < @ARG_CONT_IDX;
			
			END

		END
		/* FAQ 게시판 */
		ELSE IF @l_brd_type = 'CDIDX00043' BEGIN

			/* 카테고리 설정되지 않음 */
			IF @ARG_CTGRY_IDX IS NULL OR @ARG_CTGRY_IDX = '' BEGIN
			
				SELECT @ret_cont_idx = ISNULL(MAX(CONT_IDX), 0) FROM DBO.CMS_BRD_FAQ_IDX_MP43Z23Q
				WHERE 
					BRD_ID = @ARG_BRD_ID AND  
					CONT_IDX < @ARG_CONT_IDX;
			
			END	
			/* 카테고리 설정 됨 */
			ELSE BEGIN
			
				SELECT @ret_cont_idx = ISNULL(MAX(CONT_IDX), 0) FROM DBO.CMS_BRD_FAQ_IDX_MP43Z23Q
				WHERE 
					BRD_ID = @ARG_BRD_ID AND  
					CTGRY_IDX = @ARG_CTGRY_IDX AND
					CONT_IDX < @ARG_CONT_IDX;
			
			END

		END
		/* 이미지 게시판 */ 
		ELSE IF @l_brd_type = 'CDIDX00044' BEGIN	
		
			
			SELECT @ret_cont_idx = ISNULL(MAX(CONT_IDX), 0) FROM DBO.CMS_BRD_THM_IDX_CF68M3GZ
			WHERE 
				BRD_ID = @ARG_BRD_ID AND  
				IS_NOTICE = @ARG_IS_NOTICE AND
				CONT_IDX < @ARG_CONT_IDX;
		
		END	
	END
	/* 다음 글 */
	ELSE BEGIN

		/* 일반 게시판 / 익명게시판 */
		IF @l_brd_type = 'CDIDX00042' OR @l_brd_type = 'CDIDX00046' BEGIN

			/* 카테고리 설정되지 않음 */
			IF @ARG_CTGRY_IDX IS NULL OR @ARG_CTGRY_IDX = '' BEGIN
			
				SELECT @ret_cont_idx = ISNULL(MIN(CONT_IDX), 0) FROM DBO.CMS_BRD_TXT_IDX_VXD5L880
				WHERE 
					BRD_ID = @ARG_BRD_ID AND  
					IS_NOTICE = @ARG_IS_NOTICE AND
					IS_SCRT = 'N' AND
					CONT_IDX > @ARG_CONT_IDX;
			
			END		
			/* 카테고리 설정 됨 */
			ELSE BEGIN
			
				SELECT @ret_cont_idx = ISNULL(MIN(CONT_IDX), 0) FROM DBO.CMS_BRD_TXT_IDX_VXD5L880
				WHERE 
					BRD_ID = @ARG_BRD_ID AND  
					IS_NOTICE = @ARG_IS_NOTICE AND
					CTGRY_IDX = @ARG_CTGRY_IDX AND
					IS_SCRT = 'N' AND
					CONT_IDX > @ARG_CONT_IDX;
			
			END

		END
		/* FAQ 게시판 */
		ELSE IF @l_brd_type = 'CDIDX00043' BEGIN

			/* 카테고리 설정되지 않음 */
			IF @ARG_CTGRY_IDX IS NULL OR @ARG_CTGRY_IDX = '' BEGIN
			
				SELECT @ret_cont_idx = ISNULL(MIN(CONT_IDX), 0) FROM DBO.CMS_BRD_FAQ_IDX_MP43Z23Q
				WHERE 
					BRD_ID = @ARG_BRD_ID AND  
					CONT_IDX > @ARG_CONT_IDX;
			
			END	
			/* 카테고리 설정 됨 */
			ELSE BEGIN
			
				SELECT @ret_cont_idx = ISNULL(MIN(CONT_IDX), 0) FROM DBO.CMS_BRD_FAQ_IDX_MP43Z23Q
				WHERE 
					BRD_ID = @ARG_BRD_ID AND  
					CTGRY_IDX = @ARG_CTGRY_IDX AND
					CONT_IDX > @ARG_CONT_IDX;
			
			END

		END
		/* 이미지 게시판 */ 
		ELSE IF @l_brd_type = 'CDIDX00044' BEGIN	
		
			
			SELECT @ret_cont_idx = ISNULL(MIN(CONT_IDX), 0) FROM DBO.CMS_BRD_THM_IDX_CF68M3GZ
			WHERE 
				BRD_ID = @ARG_BRD_ID AND  
				IS_NOTICE = @ARG_IS_NOTICE AND
				CONT_IDX > @ARG_CONT_IDX;
			
		
		END	
	
	END


	RETURN @ret_cont_idx;


END;








CREATE PROCEDURE dbo.SP_SEQ_NEXTVAL @seq_name VARCHAR(30), @nextval BIGINT OUTPUT
   AS
     UPDATE DBO.CMS_SYS_SEQUENCE SET @nextval = SEQ_VALUE = SEQ_VALUE + SEQ_INC WHERE @seq_name = seq_name;


