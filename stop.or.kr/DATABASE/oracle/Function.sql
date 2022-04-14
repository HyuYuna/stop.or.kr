CREATE OR REPLACE Function SF_ATCFILE_INFO



(
	ARG_KEY_01               VARCHAR2,
	ARG_KEY_02               VARCHAR2,
	ARG_KEY_03               NUMBER,
	ARG_KEY_04               NUMBER,
	ARG_IS_THUMB             VARCHAR2,
    ARG_RET_TYPE             VARCHAR2
)
 /**************************************************************
 업무 그룹명 : 첨부파일에 대한 정보를 조회한다
 최초작성자 :  한병한
 최초작성일 : 2014-12-29
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

Is
    l_key_03   NUMBER;
    l_key_04   NUMBER;

    l_ret_val  VARCHAR2(128);
BEGIN

	IF ARG_KEY_03 = 0 THEN
		l_key_03 := 1;
	ELSE
     	l_key_03 := ARG_KEY_03;
    END IF;

	IF ARG_KEY_04 = 0 THEN
		l_key_04 := 1;
	ELSE
     	l_key_04 := ARG_KEY_04;
    END IF;


    /*해당 키값을 모두 주고 파일 찾기*/
	IF ARG_RET_TYPE = 'VCODE' THEN

    	SELECT
        	NVL(VCHKCODE, '') INTO l_ret_val
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
        	NVL(VCHKCODE, '') INTO l_ret_val
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
            )
		WHERE
            RN = 1;
    END IF;

	IF ARG_RET_TYPE = 'PDFCODE' THEN

    	SELECT
        	NVL(VCHKCODE, '') INTO l_ret_val
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
            )
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

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;



CREATE OR REPLACE Function SF_AUTH_LV

(
    ARG_AUTH_CD               VARCHAR2
)
 /**************************************************************
 업무 그룹명 : 권한 테이블코드로 권한레벨을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

Is
    l_auth_lv   Varchar2(100);
BEGIN

	IF ARG_AUTH_CD IS NULL THEN

    	l_auth_lv := '';

    ELSE

      SELECT AUTH_LV
        INTO l_auth_lv
        FROM CMS_SYS_AUTH
       WHERE
          AUTH_CD = ARG_AUTH_CD;
	END IF;



RETURN l_auth_lv;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;




CREATE OR REPLACE Function SF_AUTH_NM

(
    ARG_CD_IDX               VARCHAR2
)
 /**************************************************************
 업무 그룹명 : 권한 테이블의 권한명을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

Is
    l_cd_nm   Varchar2(100);
BEGIN

	IF ARG_CD_IDX IS NULL THEN

    	l_cd_nm := '';

    ELSE

      SELECT AUTH_NM
        INTO l_cd_nm
        FROM CMS_SYS_AUTH
       WHERE
          AUTH_CD = ARG_CD_IDX;
	END IF;



RETURN l_cd_nm;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;







CREATE OR REPLACE Function SF_CODE_NM


(
    ARG_CD_IDX               VARCHAR2
)
 /**************************************************************
 업무 그룹명 : 공통 코드 테이블의 코드명을 가져온다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

Is
    l_cd_nm   Varchar2(100);
BEGIN

	IF ARG_CD_IDX IS NULL THEN

    	l_cd_nm := '';

    ELSE

      SELECT CODE_NM
        INTO l_cd_nm
        FROM CMS_SYS_CODE
       WHERE
          CODE_IDX = ARG_CD_IDX;
	END IF;



RETURN l_cd_nm;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;




CREATE OR REPLACE Function SF_CTGRY_NM

(
    ARG_CD_IDX               VARCHAR2
)
 /**************************************************************
 업무 그룹명 : 카테고리 테이블의 카테고리명을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

Is
    l_cd_nm   Varchar2(100);
BEGIN

	IF ARG_CD_IDX IS NULL THEN

    	l_cd_nm := '';

    ELSE

      SELECT CTGRY_NM
        INTO l_cd_nm
        FROM CMS_SYS_CTGRY
       WHERE
          CTGRY_IDX = ARG_CD_IDX;
	END IF;



RETURN l_cd_nm;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;




CREATE OR REPLACE Function         SF_GEN_IDSTR



(
    ARG_STR_LEN               NUMBER
)
 /**************************************************************
 업무 그룹명 : 숫자와 알파벳 소문자, 대문자의 조합으로
 				ID String을 생성한다
 최초작성자 :  한병한
 최초작성일 : 2014-11-21
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

IS
	l_strcase  NUMBER;
    l_strnow   CHAR(1);
    l_retstr   VARCHAR2(256);
    l_cnt 	   NUMBER;

BEGIN

	l_cnt := 0;


    WHILE l_cnt < ARG_STR_LEN LOOP

      l_strcase := MOD(ABS(DBMS_RANDOM.RANDOM), 3);

      IF l_strcase = 0 THEN
          SELECT CHR(MOD(ABS(DBMS_RANDOM.RANDOM),10) + 48) INTO l_strnow FROM dual;
      ELSIF l_strcase = 1 THEN
          SELECT CHR(MOD(ABS(DBMS_RANDOM.RANDOM),26) + 65) INTO l_strnow  FROM dual;
      ELSE
          SELECT CHR(MOD(ABS(DBMS_RANDOM.RANDOM),26) + 97) INTO l_strnow  FROM dual;
      END IF;

      l_retstr := l_retstr || l_strnow;
      l_cnt := l_cnt + 1;

    END LOOP;

RETURN l_retstr;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;




CREATE OR REPLACE Function SF_USER_NM

(
    ARG_USR_ID               VARCHAR2
)
 /**************************************************************
 업무 그룹명 : 사용자 ID로 사용자 이름을 조회한다.
 최초작성자 :  한병한
 최초작성일 : 2013-09-16
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

Is
    l_usr_nm   Varchar2(100);
BEGIN

	IF ARG_USR_ID IS NULL THEN

    	l_usr_nm := '';

    ELSE

      SELECT USER_NM
        INTO l_usr_nm
        FROM CMS_USR_INFO
       WHERE
          USER_ID = ARG_USR_ID;
	END IF;



RETURN l_usr_nm;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;








CREATE OR REPLACE Function SF_MENU_NM



(
    ARG_MENU_IDX               VARCHAR2,
    ARG_MENU_NIX               VARCHAR2
)
 /**************************************************************
 업무 그룹명 : MENU_IDX, MENU_NIX로 메뉴명을 조회한다
 최초작성자 :  한병한
 최초작성일 : 2015-11-19
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

Is
    l_menu_nm   Varchar2(100);
BEGIN

	IF ARG_MENU_IDX IS NOT NULL AND ARG_MENU_NIX IS NOT NULL THEN

    	l_menu_nm := '';

	ELSIF  ARG_MENU_IDX IS NULL AND ARG_MENU_NIX IS NULL THEN

    	l_menu_nm := '';

    ELSE

      SELECT MENU_NM
        INTO l_menu_nm
        FROM CMS_SYS_MENU
       WHERE
          MENU_IDX = ARG_MENU_IDX OR
          MENU_NIX = ARG_MENU_NIX;
	END IF;



RETURN l_menu_nm;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;




CREATE OR REPLACE
Function SF_REFERER_GR



(
    ARG_REFERER               VARCHAR2
)
 /**************************************************************
 업무 그룹명 : 유입경로 분석
 최초작성자 :  한병한
 최초작성일 : 2017-02-09
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

Is
    l_referer   Varchar2(300);
    l_return   Varchar2(100);
BEGIN

   	l_return := 'ETC';


	IF ARG_REFERER IS NULL THEN

    	l_return := '직접입력';

    ELSE

    	l_referer := UPPER(ARG_REFERER);

    	IF INSTR(l_referer, 'GOOGLE.COM') <> 0 OR INSTR(l_referer, 'GOOGLE.CO.KR') <> 0 THEN
    		l_return := 'GOOGLE';
        ELSIF INSTR(l_referer, 'NAVER.COM') <> 0 THEN
    		l_return := 'NAVER';
        ELSIF INSTR(l_referer, 'DAUM.NET') <> 0 THEN
    		l_return := 'DAUM';
		ELSE
       	    l_return := 'ETC';
        END IF;

	END IF;



RETURN l_return;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;




CREATE OR REPLACE
Function SF_SRVY_PCT

(
    ARG_SRVY_IDX               NUMBER,
    ARG_QUES_IDX               NUMBER,
    ARG_ANS_ORD            		NUMBER,
    ARG_QUES_TYPE			   VARCHAR2
)
 /**************************************************************
 업무 그룹명 : 통계 답변의 통계치를 구한다
 최초작성자 :  한병한
 최초작성일 : 2017-04-23
 최종수정자 :
 최종수정일 :
***********************************************************/

RETURN VARCHAR2

IS
	l_cnt     NUMBER(11,0);
	l_cntall  NUMBER(11,0);
	l_pct     NUMBER(11,2);
    l_result   Varchar2(100);
    
BEGIN
	
	l_result := '';


	/* 객관식 단답형인 경우 */
	IF ARG_QUES_TYPE = 'CDIDX00082' THEN
    
    	/* 질문에 전체 답한 개수 */
    	SELECT
            COUNT(*) INTO l_cntall
        FROM
            CMS_SURVEY_DATA
        WHERE 
            SRVY_IDX = ARG_SRVY_IDX AND
            QUES_IDX = ARG_QUES_IDX;

		/* 개별 답변에 답한 개수 */
    	SELECT
            COUNT(*) INTO l_cnt
        FROM
            CMS_SURVEY_DATA
        WHERE 
            SRVY_IDX = ARG_SRVY_IDX AND
            QUES_IDX = ARG_QUES_IDX AND
            DATA_CONT = ARG_ANS_ORD;
		       
        IF l_cntall = 0 THEN 
            l_result := '0_0.0';
        ELSE
	    	l_pct := round((l_cnt / l_cntall * 100), 1);
    		l_result := TO_CHAR(l_cnt) || '_' || TO_CHAR(l_pct);
        END IF;
             
         
    ELSE 
    
    	/* 문제에 답을 한 전체 카운트 */
        SELECT
            COUNT(*) INTO l_cntall
        FROM
            CMS_SURVEY_DATA
        WHERE 
            SRVY_IDX = ARG_SRVY_IDX AND
            QUES_IDX = ARG_QUES_IDX AND
            QUESSUB_IDX = ARG_ANS_ORD;

    
    	FOR cur IN
        (
            /* 해당 보기를 선택한 카운트 (답변 유형별로 그룹핑) */
            SELECT
                DATA_CONT,
                COUNT(*) AS L_CNT
            FROM
                CMS_SURVEY_DATA
            WHERE 
                SRVY_IDX = ARG_SRVY_IDX AND
                QUES_IDX = ARG_QUES_IDX AND
                QUESSUB_IDX = ARG_ANS_ORD
                GROUP BY DATA_CONT
                ORDER BY DATA_CONT
        ) 
        LOOP
            
            /* 전체 답변의 백분율 구함 */	
            l_pct := round((cur.L_CNT / l_cntall * 100), 1);
            
            IF LENGTH(l_result) > 0 THEN
                l_result := l_result || '##';
            END IF;
            
            /* 수치와 백분율을 결합 */
            l_result := l_result || cur.DATA_CONT || '_' || TO_CHAR(cur.L_CNT) || '_' || TO_CHAR(l_pct); 
        	
        END LOOP;
           
    END IF;
    	



	
RETURN l_result;

EXCEPTION WHEN Others THEN
      RETURN NULL;

END;