DROP TABLE CMS_ACCESS_IP CASCADE CONSTRAINTS;
DROP TABLE CMS_ATACH CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_DRY_IDX_MH3H22JH CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_FAQ_IDX_MP43Z23Q CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_INFO CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_NWS_IDX_M3KMB33X CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_RCMND CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_REPLY_IDX_CF68M3GZ CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_REPLY_IDX_VXD5L880 CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_THM_IDX_CF68M3GZ CASCADE CONSTRAINTS;
DROP TABLE CMS_BRD_TXT_IDX_VXD5L880 CASCADE CONSTRAINTS;
DROP TABLE CMS_COMM_STAT CASCADE CONSTRAINTS;
DROP TABLE CMS_MAN_LOG CASCADE CONSTRAINTS;
DROP TABLE CMS_MENU_AUTH CASCADE CONSTRAINTS;
DROP TABLE CMS_POPUP CASCADE CONSTRAINTS;
DROP TABLE CMS_SYS_AUTH CASCADE CONSTRAINTS;
DROP TABLE CMS_SYS_CODE CASCADE CONSTRAINTS;
DROP TABLE CMS_SYS_CTGRY CASCADE CONSTRAINTS;
DROP TABLE CMS_SYS_MENU CASCADE CONSTRAINTS;
DROP TABLE CMS_USR_CONTENTS CASCADE CONSTRAINTS;
DROP TABLE CMS_USR_INFO CASCADE CONSTRAINTS;
DROP TABLE CMS_SURVEY_MAIN CASCADE CONSTRAINTS;
DROP TABLE CMS_SURVEY_PART CASCADE CONSTRAINTS;
DROP TABLE CMS_SURVEY_QUESANS CASCADE CONSTRAINTS;
DROP TABLE CMS_SURVEY_DATA CASCADE CONSTRAINTS;


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ACCESS_IP
-- 만든 날짜 : 2016-03-25 오전 10:15:50
-- 마지막으로 수정한 날짜 : 2016-04-08 오후 12:05:31
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_ACCESS_IP (
  AUTH_CD      CHAR(5)          NOT NULL, 
  ACCESS_IP    VARCHAR2(16)     NOT NULL, 
  DESCRIPTION  VARCHAR2(512)     NULL, 
  WRITER       VARCHAR2(24)         NULL, 
  WDT          DATE            DEFAULT SYSDATE             NOT NULL, 
  MODIFIER     VARCHAR2(24)         NULL, 
  MDT          DATE                 NULL
)
;

COMMENT ON TABLE CMS_ACCESS_IP IS '[시스템] 접근 IP';

COMMENT ON COLUMN CMS_ACCESS_IP.AUTH_CD IS '권한코드';

COMMENT ON COLUMN CMS_ACCESS_IP.ACCESS_IP IS '접근 IP';

COMMENT ON COLUMN CMS_ACCESS_IP.DESCRIPTION IS '설명';

COMMENT ON COLUMN CMS_ACCESS_IP.WRITER IS '작성자';

COMMENT ON COLUMN CMS_ACCESS_IP.WDT IS '작성일';

COMMENT ON COLUMN CMS_ACCESS_IP.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_ACCESS_IP.MDT IS '수정일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ATACH
-- 만든 날짜 : 2015-03-17 오전 9:19:15
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:19:15
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_ATACH (
  ATCKEY_1ST    VARCHAR2(32)      NOT NULL, 
  ATCKEY_2ND    VARCHAR2(16)      NOT NULL, 
  ATCKEY_3RD    NUMBER           DEFAULT 1            NOT NULL, 
  ATCKEY_4TH    NUMBER           DEFAULT 1            NOT NULL, 
  IS_THUMB      CHAR(1)          DEFAULT 'N'           NOT NULL, 
  VCHKCODE      CHAR(12)          NOT NULL, 
  FPATH         VARCHAR2(256)         NULL, 
  FNAME         VARCHAR2(256)         NULL, 
  RNAME         VARCHAR2(256)         NULL, 
  FEXT          VARCHAR2(16)          NULL, 
  SIZE_KB       NUMBER                NULL, 
  IMG_WIDTH     NUMBER                NULL, 
  IMG_HEIGHT    NUMBER                NULL, 
    CONSTRAINT PK_CMS_ATACH
    PRIMARY KEY ( ATCKEY_1ST, ATCKEY_2ND, ATCKEY_3RD, ATCKEY_4TH, IS_THUMB ), 
    CONSTRAINT UNIQ_CMS_ATACH_VCHKCODE
    UNIQUE ( VCHKCODE )
)
;

COMMENT ON TABLE CMS_ATACH IS '[시스템] 첨부파일';

COMMENT ON COLUMN CMS_ATACH.ATCKEY_1ST IS '1번째 키구분';

COMMENT ON COLUMN CMS_ATACH.ATCKEY_2ND IS '2번째 키구분';

COMMENT ON COLUMN CMS_ATACH.ATCKEY_3RD IS '3번째 키구분';

COMMENT ON COLUMN CMS_ATACH.ATCKEY_4TH IS '4번째 키구분';

COMMENT ON COLUMN CMS_ATACH.IS_THUMB IS '썸네일 이미지인지 여부';

COMMENT ON COLUMN CMS_ATACH.VCHKCODE IS '파일확인 키 (키값이 모두 노출되는 경우 아무파일이나 조회하는 것을 방지하기 위해 사용)';

COMMENT ON COLUMN CMS_ATACH.FPATH IS '파일 경로';

COMMENT ON COLUMN CMS_ATACH.FNAME IS '변경된 파일 명';

COMMENT ON COLUMN CMS_ATACH.RNAME IS '실제 파일 명';

COMMENT ON COLUMN CMS_ATACH.FEXT IS '확장자';

COMMENT ON COLUMN CMS_ATACH.SIZE_KB IS '파일크기';

COMMENT ON COLUMN CMS_ATACH.IMG_WIDTH IS '이미지파일의 경우 width';

COMMENT ON COLUMN CMS_ATACH.IMG_HEIGHT IS '이미지파일의 경우 height';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_DRY_IDX_MH3H22JH
-- 만든 날짜 : 2015-03-17 오전 9:19:19
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:19:19
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_DRY_IDX_MH3H22JH (
  BRD_ID           VARCHAR2(32)       NOT NULL, 
  CONT_IDX         NUMBER             NOT NULL, 
  SUBJECT          VARCHAR2(512)          NULL, 
  BRD_CONT         VARCHAR2(4000)         NULL, 
  STARTDT          DATE               NOT NULL, 
  ENDDT            DATE               NOT NULL, 
  ALLDAY_YN        CHAR(1)           DEFAULT 'N'            NOT NULL, 
  REPEAT_YN        CHAR(1)           DEFAULT 'N'            NOT NULL, 
  HOLIDAY_YN       CHAR(1)           DEFAULT 'N'            NOT NULL, 
  REF_URL          VARCHAR2(256)          NULL, 
  WRITER           VARCHAR2(24)           NULL, 
  WDT              DATE                   NULL, 
  MODIFIER         VARCHAR2(24)           NULL, 
  MDT              DATE                   NULL, 
  REFERENCE_KEY    VARCHAR2(100)          NULL, 
  CONSTRAINT PK_CMS_BRD_DRY_IDX_MH3H22JH
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

COMMENT ON TABLE CMS_BRD_DRY_IDX_MH3H22JH IS '[게시판] 일정 게시판';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.BRD_ID IS '게시판 번호';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.CONT_IDX IS '게시판 순번';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.SUBJECT IS '제목';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.BRD_CONT IS '내용';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.STARTDT IS '시작일시';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.ENDDT IS '종료일시';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.ALLDAY_YN IS '종일스케줄 여부';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.REPEAT_YN IS '반복여부';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.HOLIDAY_YN IS '국경일 여부';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.REF_URL IS '참조 URL';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.WRITER IS '작성자';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.WDT IS '작성일';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.MDT IS '수정일';

COMMENT ON COLUMN CMS_BRD_DRY_IDX_MH3H22JH.REFERENCE_KEY IS '참조키';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_FAQ_IDX_MP43Z23Q
-- 만든 날짜 : 2015-03-20 오후 2:27:47
-- 마지막으로 수정한 날짜 : 2015-03-20 오후 2:28:36
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_FAQ_IDX_MP43Z23Q (
  BRD_ID       VARCHAR2(32)       NOT NULL, 
  CONT_IDX     NUMBER             NOT NULL, 
  CTGRY_IDX    VARCHAR2(16)           NULL, 
  SUBJECT      VARCHAR2(512)      NOT NULL, 
  BRD_CONT     VARCHAR2(4000)     NOT NULL, 
  HITS         NUMBER                 NULL, 
  WRITER       VARCHAR2(24)           NULL, 
  WDT          DATE                   NULL, 
  MODIFIER     VARCHAR2(24)           NULL, 
  MDT          DATE                   NULL, 
  KOGL         VARCHAR2(16)           NULL, 
    CONSTRAINT PK_CMS_BRD_FAQ_IDX_MP43Z23Q
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

COMMENT ON TABLE CMS_BRD_FAQ_IDX_MP43Z23Q IS '[게시판] FAQ게시판 컨텐츠';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.BRD_ID IS '게시판 번호';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.CONT_IDX IS '게시물 순번';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.CTGRY_IDX IS '카테고리';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.SUBJECT IS '보고서제목';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.BRD_CONT IS '내용';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.HITS IS '조회수';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.WRITER IS '작성자';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.WDT IS '작성일';

COMMENT ON COLUMN CMS_BRD_FAQ_IDX_MP43Z23Q.MODIFIER IS '수정자';

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_INFO
-- 만든 날짜 : 2016-02-26 오후 4:13:34
-- 마지막으로 수정한 날짜 : 2016-03-14 오전 10:27:19
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_INFO (
  BRD_ID               VARCHAR2(32)       NOT NULL, 
  TBL_NM               VARCHAR2(32)       NOT NULL, 
  BRD_NM               VARCHAR2(256)      NOT NULL, 
  MU_SITE              CHAR(10)          DEFAULT 'CDIDX00002'           NOT NULL, 
  MU_LANG              CHAR(10)          DEFAULT 'CDIDX00022'           NOT NULL, 
  BRD_DFT              VARCHAR2(256)          NULL, 
  BRD_DFT_SKIN         CHAR(1)           DEFAULT 'A'            NOT NULL, 
  BRD_CUST_SKIN        VARCHAR2(16)           NULL, 
  BRD_GB               CHAR(10)          DEFAULT 'CDIDX00042'           NOT NULL, 
  BRD_GB_SUB           CHAR(1)           DEFAULT 'A'            NOT NULL, 
  EDITOR_GB            CHAR(1)           DEFAULT 'A'            NOT NULL, 
  USE_CTGRY            CHAR(1)           DEFAULT 'N'            NOT NULL, 
  CTGRY_IDX            VARCHAR2(16)           NULL, 
  USE_NOTICE           CHAR(1)           DEFAULT 'N'            NOT NULL, 
  USE_SCRT             CHAR(1)           DEFAULT 'N'            NOT NULL, 
  USE_RCMND            CHAR(1)           DEFAULT 'N'            NOT NULL, 
  USE_RJCT             CHAR(1)           DEFAULT 'N'            NOT NULL, 
  USE_ATCH             CHAR(1)           DEFAULT 'Y'            NOT NULL, 
  USE_UPLOADIFY        CHAR(1)           DEFAULT 'Y'            NOT NULL, 
  USE_KOGL             CHAR(1)           DEFAULT 'N'            NOT NULL, 
  REPLY_GB             CHAR(1)           DEFAULT 'N'            NOT NULL, 
  ATTACH_CNT_LIMIT     NUMBER            DEFAULT 1                 NULL, 
  ATTACH_SIZE_LIMIT    NUMBER            DEFAULT 20                 NULL, 
  ATCL_PER_PG          NUMBER            DEFAULT 15                 NULL, 
  PG_PER_NAVI          NUMBER            DEFAULT 10                 NULL, 
  ON_VIEWMODE          CHAR(1)           DEFAULT '2'                NULL, 
  OFF_VIEWMODE         CHAR(1)           DEFAULT '1'                NULL, 
  CREATE_NEW_TABLE     CHAR(1)           DEFAULT 'N'                NULL, 
  REF_MENU_NIX         VARCHAR2(9)            NULL, 
  BRD_AUTH_USR         VARCHAR2(256)          NULL, 
  INFO_CONT            CLOB                   NULL, 
  WRITER               VARCHAR2(24)           NULL, 
  WDT                  DATE              DEFAULT SYSDATE                   NULL, 
  MODIFIER             VARCHAR2(24)           NULL, 
  MDT                  DATE                   NULL, 
    CONSTRAINT PK_CMS_BRD_INFO
    PRIMARY KEY ( BRD_ID )
)
;

COMMENT ON TABLE CMS_BRD_INFO IS '[게시판] 게시판 정보';

COMMENT ON COLUMN CMS_BRD_INFO.USE_RCMND IS '게시물 추천 사용 여부';

COMMENT ON COLUMN CMS_BRD_INFO.USE_RJCT IS '게시물 반대 사용 여부';

COMMENT ON COLUMN CMS_BRD_INFO.USE_ATCH IS '첨부파일 사용 여부';

COMMENT ON COLUMN CMS_BRD_INFO.USE_UPLOADIFY IS '파일첨부를 위해 UPLOADIFY를 사용할지 여부 (사용하지 않으면 일반 폼 컨트롤사용)';

COMMENT ON COLUMN CMS_BRD_INFO.USE_KOGL IS '공공누리 적용 여부';

COMMENT ON COLUMN CMS_BRD_INFO.REPLY_GB IS '[A|R|N] A : 계단식 답글 형 게시판, R : 댓글형 게시판,  B : 답글 + 댓글, N : 댓글 없음';

COMMENT ON COLUMN CMS_BRD_INFO.ATTACH_CNT_LIMIT IS '첨부파일 개수 제한 [0: 제한없음]';

COMMENT ON COLUMN CMS_BRD_INFO.ATTACH_SIZE_LIMIT IS '첨부파일 크기 제한';

COMMENT ON COLUMN CMS_BRD_INFO.ATCL_PER_PG IS '페이지당 게시물 개수';

COMMENT ON COLUMN CMS_BRD_INFO.PG_PER_NAVI IS '페이지 네비 개수';

COMMENT ON COLUMN CMS_BRD_INFO.ON_VIEWMODE IS '로그인한 사용자에 대한 공개 방식';

COMMENT ON COLUMN CMS_BRD_INFO.OFF_VIEWMODE IS '로그인하지 않은 사용자에 대한 공개방';

COMMENT ON COLUMN CMS_BRD_INFO.CREATE_NEW_TABLE IS '게시판 전용 테이블 생성 여부';

COMMENT ON COLUMN CMS_BRD_INFO.REF_MENU_NIX IS '연결된 메뉴의 IDX';

COMMENT ON COLUMN CMS_BRD_INFO.BRD_AUTH_USR IS '게시판 관리자 목록 -> [ , ] 로 구분된 ID 문자열';

COMMENT ON COLUMN CMS_BRD_INFO.INFO_CONT IS '게시판 컨텐츠';

COMMENT ON COLUMN CMS_BRD_INFO.WRITER IS '작성자';

COMMENT ON COLUMN CMS_BRD_INFO.WDT IS '작성일';

COMMENT ON COLUMN CMS_BRD_INFO.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_BRD_INFO.MDT IS '수정일';

COMMENT ON COLUMN CMS_BRD_INFO.MU_SITE IS '사이트구분 [코드 참조]';

COMMENT ON COLUMN CMS_BRD_INFO.MU_LANG IS '언어구분 [코드 참조]';

COMMENT ON COLUMN CMS_BRD_INFO.BRD_ID IS '게시판 번호';

COMMENT ON COLUMN CMS_BRD_INFO.TBL_NM IS '테이블 명';

COMMENT ON COLUMN CMS_BRD_INFO.BRD_NM IS '게시판 명';

COMMENT ON COLUMN CMS_BRD_INFO.BRD_DFT IS '게시판 설명';

COMMENT ON COLUMN CMS_BRD_INFO.BRD_DFT_SKIN IS '게시판 기본 스킨';

COMMENT ON COLUMN CMS_BRD_INFO.BRD_CUST_SKIN IS '게시판 사용자 정의 스킨';

COMMENT ON COLUMN CMS_BRD_INFO.BRD_GB IS '게시판 구분 [코드 참조]';

COMMENT ON COLUMN CMS_BRD_INFO.BRD_GB_SUB IS '게시판 마이너 구분';

COMMENT ON COLUMN CMS_BRD_INFO.EDITOR_GB IS '에디터 구분 (CLEDITOR, ELRTE)';

COMMENT ON COLUMN CMS_BRD_INFO.USE_CTGRY IS '카테고리 사용여부';

COMMENT ON COLUMN CMS_BRD_INFO.CTGRY_IDX IS '카테고리 ID (사용할 경우)';

COMMENT ON COLUMN CMS_BRD_INFO.USE_NOTICE IS '공지사항포함 여부';

COMMENT ON COLUMN CMS_BRD_INFO.USE_SCRT IS '비밀글 사용 여부 (관리자와 본인만 조회 가능)';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_NWS_IDX_M3KMB33X
-- 만든 날짜 : 2015-03-17 오전 9:17:27
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:27
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_NWS_IDX_M3KMB33X (
  BRD_ID       VARCHAR2(32)      NOT NULL, 
  CONT_IDX     NUMBER            NOT NULL, 
  CTGRY_IDX    VARCHAR2(16)          NULL, 
  SUBJECT      VARCHAR2(512)     NOT NULL, 
  NEWS_LINK    VARCHAR2(512)     NOT NULL, 
  WRITER       VARCHAR2(24)          NULL, 
  WDT          DATE                  NULL, 
  MODIFIER     VARCHAR2(24)          NULL, 
  MDT          DATE                  NULL, 
    CONSTRAINT PK_CMS_BRD_NWS_IDX_M3KMB33X
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

COMMENT ON TABLE CMS_BRD_NWS_IDX_M3KMB33X IS '[게시판] 뉴스링크 게시판 컨텐츠';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.BRD_ID IS '게시판 번호';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.CONT_IDX IS '게시물 순번';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.CTGRY_IDX IS '카테고리';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.SUBJECT IS '제목';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.NEWS_LINK IS '뉴스링크';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.WRITER IS '작성자';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.WDT IS '작성일';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_BRD_NWS_IDX_M3KMB33X.MDT IS '수정일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_RCMND
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_RCMND (
  RCMND_IDX    NUMBER           NOT NULL, 
  BRD_ID       VARCHAR2(32)         NULL, 
  CONT_IDX     NUMBER               NULL, 
  RCMND_ID     VARCHAR2(24)         NULL, 
  RCMND_GB     CHAR(1)              NULL, 
  RDT          DATE                 NULL, 
    CONSTRAINT PK_CMS_BRD_RCMND
    PRIMARY KEY ( RCMND_IDX )
)
;

COMMENT ON TABLE CMS_BRD_RCMND IS '[게시판] 게시판 추천/반대 데이터';

COMMENT ON COLUMN CMS_BRD_RCMND.RCMND_IDX IS '순번';

COMMENT ON COLUMN CMS_BRD_RCMND.BRD_ID IS '게시판 ID';

COMMENT ON COLUMN CMS_BRD_RCMND.CONT_IDX IS '게시물순번';

COMMENT ON COLUMN CMS_BRD_RCMND.RCMND_ID IS '추천인/ 반대인 ID';

COMMENT ON COLUMN CMS_BRD_RCMND.RCMND_GB IS '추천:R/반대:J 구분';

COMMENT ON COLUMN CMS_BRD_RCMND.RDT IS '추천/반대 일시';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_REPLY_IDX_CF68M3GZ
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_REPLY_IDX_CF68M3GZ (
  BRD_ID        VARCHAR2(32)       NOT NULL, 
  CONT_IDX      NUMBER             NOT NULL, 
  REPLY_IDX     NUMBER             NOT NULL, 
  REPLY_CONT    VARCHAR2(4000)         NULL, 
  RCMND_CNT     NUMBER                 NULL, 
  WRITER        VARCHAR2(24)           NULL, 
  WDT           DATE                   NULL, 
  MODIFIER      VARCHAR2(24)           NULL, 
  MDT           DATE                   NULL, 
    CONSTRAINT PK_CMS_BRD_REPLY_IDX_CF68M3GZ
    PRIMARY KEY ( BRD_ID, CONT_IDX, REPLY_IDX )
)
;

COMMENT ON TABLE CMS_BRD_REPLY_IDX_CF68M3GZ IS '[게시판] 이미지 게시판 댓글';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.BRD_ID IS '게시판 번호';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.CONT_IDX IS '게시물 순번';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.REPLY_IDX IS '댓글 순번';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.REPLY_CONT IS '내용';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.RCMND_CNT IS '추천수';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.WRITER IS '작성자';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.WDT IS '작성일';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_CF68M3GZ.MDT IS '수정일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_REPLY_IDX_VXD5L880
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_REPLY_IDX_VXD5L880 (
  BRD_ID        VARCHAR2(32)       NOT NULL, 
  CONT_IDX      NUMBER             NOT NULL, 
  REPLY_IDX     NUMBER             NOT NULL, 
  REPLY_CONT    VARCHAR2(4000)         NULL, 
  RCMND_CNT     NUMBER                 NULL, 
  WRITER        VARCHAR2(24)           NULL, 
  WDT           DATE                   NULL, 
  MODIFIER      VARCHAR2(24)           NULL, 
  MDT           DATE                   NULL, 
  BRD_PWD       VARCHAR2(128)          NULL, 
    CONSTRAINT PK_CMS_BRD_REPLY_IDX_VXD5L880
    PRIMARY KEY ( BRD_ID, CONT_IDX, REPLY_IDX )
)
;

COMMENT ON TABLE CMS_BRD_REPLY_IDX_VXD5L880 IS '[게시판] 텍스트 게시판 댓글';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.BRD_ID IS '게시판 번호';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.CONT_IDX IS '게시물 순번';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.REPLY_IDX IS '댓글 순번';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.REPLY_CONT IS '내용';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.RCMND_CNT IS '추천수';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.WRITER IS '작성자';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.WDT IS '작성일';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.MDT IS '수정일';

COMMENT ON COLUMN CMS_BRD_REPLY_IDX_VXD5L880.BRD_PWD IS '댓글비밀번호';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_THM_IDX_CF68M3GZ
-- 만든 날짜 : 2015-03-17 오전 9:17:29
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:29
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_THM_IDX_CF68M3GZ (
  BRD_ID         VARCHAR2(32)      NOT NULL, 
  CONT_IDX       NUMBER            NOT NULL, 
  SUBJECT        VARCHAR2(512)         NULL, 
  BRD_CONT       CLOB                  NULL, 
  BRD_UTB        VARCHAR2(512)         NULL, 
  IMG_IDX        NUMBER           DEFAULT 0                NULL, 
  THM_IMG_IDX    NUMBER           DEFAULT 0                NULL, 
  HITS           NUMBER                NULL, 
  IS_NOTICE      CHAR(1)          DEFAULT 'N'               NULL, 
  WRITER         VARCHAR2(24)          NULL, 
  WDT            DATE                  NULL, 
  MODIFIER       VARCHAR2(24)          NULL, 
  MDT            DATE                  NULL, 
    CONSTRAINT PK_CMS_BRD_THM_IDX_CF68M3GZ
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

COMMENT ON TABLE CMS_BRD_THM_IDX_CF68M3GZ IS '[게시판] 이미지(썸네일) 게시판 컨텐츠';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.BRD_ID IS '게시판 번호';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.CONT_IDX IS '게시물 순번';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.SUBJECT IS '제목';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.BRD_CONT IS '내용';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.BRD_UTB IS '유튜브 링크';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.IMG_IDX IS '이미지 파일 번호';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.THM_IMG_IDX IS '썸네일 이미지 파일 번호';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.HITS IS '조회수';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.IS_NOTICE IS '공지사항 여부';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.WRITER IS '작성자';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.WDT IS '작성일';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_BRD_THM_IDX_CF68M3GZ.MDT IS '수정일';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_TXT_IDX_VXD5L880
-- 만든 날짜 : 2015-03-17 오전 9:17:30
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_TXT_IDX_VXD5L880 (
  BRD_ID         VARCHAR2(32)       NOT NULL, 
  CONT_IDX       NUMBER             NOT NULL, 
  CTGRY_IDX      VARCHAR2(16)           NULL, 
  SUBJECT        VARCHAR2(512)      NOT NULL, 
  BRD_CONT       CLOB               NOT NULL, 
  HITS           NUMBER                 NULL, 
  GRP_NO         NUMBER                 NULL, 
  GRP_LV         NUMBER                 NULL, 
  GRP_ORD        NUMBER                 NULL, 
  IS_NOTICE      CHAR(1)           DEFAULT 'N'                NULL, 
  IS_SCRT        CHAR(1)           DEFAULT 'N'                NULL, 
  ADD_INFO_01    VARCHAR2(128)          NULL, 
  ADD_INFO_02    VARCHAR2(128)          NULL, 
  ADD_INFO_03    VARCHAR2(128)          NULL, 
  ADD_INFO_04    VARCHAR2(512)          NULL, 
  ADD_INFO_05    VARCHAR2(1024)         NULL, 
  WRITER         VARCHAR2(24)           NULL, 
  WDT            DATE                   NULL, 
  MODIFIER       VARCHAR2(24)           NULL, 
  MDT            DATE                   NULL, 
  KOGL           VARCHAR2(16)           NULL, 
    CONSTRAINT PK_CMS_BRD_TXT_IDX_VXD5L880
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

COMMENT ON TABLE CMS_BRD_TXT_IDX_VXD5L880 IS '[게시판] 텍스트 게시판 컨텐츠';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.BRD_ID IS '게시판 번호';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.CONT_IDX IS '게시물 순번';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.CTGRY_IDX IS '카테고리';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.SUBJECT IS '제목';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.BRD_CONT IS '내용';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.HITS IS '조회수';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.GRP_NO IS '그룹번호';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.GRP_LV IS '그룹레벨';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.GRP_ORD IS '그룹순번';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.IS_NOTICE IS '공지 여부';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.IS_SCRT IS '비밀글 여부';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.ADD_INFO_01 IS '추가정보 1';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.ADD_INFO_02 IS '추가정보 2';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.ADD_INFO_03 IS '추가정보 3';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.ADD_INFO_04 IS '추가정보 4';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.ADD_INFO_05 IS '추가정보 5';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.WRITER IS '작성자';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.WDT IS '작성일';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.MDT IS '수정일';

COMMENT ON COLUMN CMS_BRD_TXT_IDX_VXD5L880.KOGL IS '공공누리 저작권 코드';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_COMM_STAT
-- 만든 날짜 : 2015-03-17 오전 9:17:31
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_COMM_STAT (
  STAT_KEY        VARCHAR2(32)      NOT NULL, 
  STAT_SESSID     VARCHAR2(64)      NOT NULL, 
  STAT_KEY_NM     VARCHAR2(64)          NULL, 
  STAT_CITY       VARCHAR2(32)          NULL, 
  STAT_NAT        VARCHAR2(32)          NULL, 
  STAT_NAT_CD     VARCHAR2(6)           NULL, 
  STAT_OS         VARCHAR2(16)          NULL, 
  STAT_BW         VARCHAR2(16)          NULL, 
  STAT_REFERER    VARCHAR2(256)         NULL, 
  STAT_DT         DATE                  NULL, 
  STAT_RADDR      VARCHAR2(32)          NULL, 
  STAT_UID        VARCHAR2(24)          NULL, 
  CONTACT_CNT     NUMBER(10)       DEFAULT 1        NOT NULL, 
  	CONSTRAINT PK_CMS_COMM_STAT
    PRIMARY KEY ( STAT_KEY, STAT_SESSID )
)
;

COMMENT ON TABLE CMS_COMM_STAT IS '[시스템] 통계테이블';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_SESSID IS '세션 ID';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_KEY_NM IS '통계 KEY 설명';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_CITY IS '도시';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_NAT IS '국가';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_NAT_CD IS '국가코드';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_OS IS '운영체제 종류';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_BW IS '브라우저 종류';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_REFERER IS '이전페이지 링크';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_DT IS '기록일';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_RADDR IS '주소';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_UID IS 'UID';

COMMENT ON COLUMN CMS_COMM_STAT.CONTACT_CNT IS '접속 횟수';

COMMENT ON COLUMN CMS_COMM_STAT.STAT_KEY IS '통계 KEY';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_MAN_LOG
-- 만든 날짜 : 2015-03-17 오전 9:17:32
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:32
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_MAN_LOG (
  LOG_IDX         NUMBER             NOT NULL, 
  LOG_KEY         VARCHAR2(32)       NOT NULL, 
  LOG_KEY_NM      VARCHAR2(64)           NULL, 
  LOG_KEY_DEST    VARCHAR2(1024)         NULL, 
  LOG_JOB_GB      CHAR(1)                NULL, 
  LOG_RADDR       VARCHAR2(32)           NULL, 
  LOG_UID         VARCHAR2(24)           NULL, 
  LOG_DT          DATE                   NULL, 
   CONSTRAINT PK_CMS_MAN_LOG	 
   PRIMARY KEY ( LOG_IDX )
)
;

COMMENT ON TABLE CMS_MAN_LOG IS '[시스템] 관리자 로그';

COMMENT ON COLUMN CMS_MAN_LOG.LOG_IDX IS '일련번호';

COMMENT ON COLUMN CMS_MAN_LOG.LOG_KEY IS '로그 KEY';

COMMENT ON COLUMN CMS_MAN_LOG.LOG_KEY_NM IS '로그 KEY 설명';

COMMENT ON COLUMN CMS_MAN_LOG.LOG_KEY_DEST IS '로그 상세';

COMMENT ON COLUMN CMS_MAN_LOG.LOG_JOB_GB IS '작업구분';

COMMENT ON COLUMN CMS_MAN_LOG.LOG_RADDR IS 'IP 주소';

COMMENT ON COLUMN CMS_MAN_LOG.LOG_UID IS '행위자 ID';

COMMENT ON COLUMN CMS_MAN_LOG.LOG_DT IS '기록일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_MENU_AUTH
-- 만든 날짜 : 2015-03-17 오전 9:17:33
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:33
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_MENU_AUTH (
  AUTH_CD     CHAR(5)          NOT NULL, 
  MENU_IDX    VARCHAR2(16)     NOT NULL, 
  AUTH_YN     CHAR(1)         DEFAULT 'Y'          NOT NULL, 
  WRITER      VARCHAR2(24)         NULL, 
  WDT         DATE                 NULL, 
  MODIFIER    VARCHAR2(24)         NULL, 
  MDT         DATE                 NULL, 
    CONSTRAINT PK_CMS_MENU_AUTH
    PRIMARY KEY ( AUTH_CD, MENU_IDX )
)
;

COMMENT ON TABLE CMS_MENU_AUTH IS '[시스템] 권한별 사용가능 메뉴';

COMMENT ON COLUMN CMS_MENU_AUTH.AUTH_CD IS '권한코드';

COMMENT ON COLUMN CMS_MENU_AUTH.MENU_IDX IS '메뉴 ID';

COMMENT ON COLUMN CMS_MENU_AUTH.AUTH_YN IS '사용가능 여부';

COMMENT ON COLUMN CMS_MENU_AUTH.WRITER IS '등록자';

COMMENT ON COLUMN CMS_MENU_AUTH.WDT IS '등록일';

COMMENT ON COLUMN CMS_MENU_AUTH.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_MENU_AUTH.MDT IS '수정일시';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_POPUP
-- 만든 날짜 : 2015-03-17 오전 9:17:33
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_POPUP (
  POP_SEQ        NUMBER(10)         NOT NULL, 
  POP_TITLE      VARCHAR2(200)      NOT NULL, 
  POP_TYPE       CHAR(1)            NOT NULL, 
  POP_FROM       VARCHAR2(10)           NULL, 
  POP_TO         VARCHAR2(10)           NULL, 
  POP_W          VARCHAR2(10)           NULL, 
  POP_H          VARCHAR2(10)           NULL, 
  POP_CONTENT    VARCHAR2(4000)         NULL, 
  POP_IMAGE      VARCHAR2(200)          NULL, 
  POP_LINK       VARCHAR2(250)          NULL, 
  POP_TARGET     VARCHAR2(10)           NULL, 
  USE_YN         CHAR(1)            NOT NULL, 
  WRITER         VARCHAR2(24)       NOT NULL, 
  WDT            DATE               NOT NULL, 
  POP_X          VARCHAR2(5)            NULL, 
  POP_Y          VARCHAR2(5)            NULL, 
  POP_ALT        VARCHAR2(250)          NULL, 
  POP_SORT       NUMBER(10)             NULL, 
    CONSTRAINT PK_CMS_POPUP
    PRIMARY KEY ( POP_SEQ )
)
;

COMMENT ON TABLE CMS_POPUP IS '[시스템] 팝업/팝업존';

COMMENT ON COLUMN CMS_POPUP.POP_SEQ IS '순번';

COMMENT ON COLUMN CMS_POPUP.POP_TITLE IS '제목';

COMMENT ON COLUMN CMS_POPUP.POP_TYPE IS '구분(W:창팝업/Z:팝업존)';

COMMENT ON COLUMN CMS_POPUP.POP_FROM IS '게시 시작일자';

COMMENT ON COLUMN CMS_POPUP.POP_TO IS '게시 종료일자';

COMMENT ON COLUMN CMS_POPUP.POP_W IS '팝업 너비';

COMMENT ON COLUMN CMS_POPUP.POP_H IS '팝업 높이';

COMMENT ON COLUMN CMS_POPUP.POP_CONTENT IS '팝업 내용 - 텍스트';

COMMENT ON COLUMN CMS_POPUP.POP_IMAGE IS '팝업 내용 - 이미지';

COMMENT ON COLUMN CMS_POPUP.POP_LINK IS '팝업 링크 URL';

COMMENT ON COLUMN CMS_POPUP.POP_TARGET IS '링크 target';

COMMENT ON COLUMN CMS_POPUP.USE_YN IS '사용 여부';

COMMENT ON COLUMN CMS_POPUP.WRITER IS '등록자ID';

COMMENT ON COLUMN CMS_POPUP.WDT IS '등록일시';

COMMENT ON COLUMN CMS_POPUP.POP_X IS '팝업 x좌표';

COMMENT ON COLUMN CMS_POPUP.POP_Y IS '팝업 y좌표';

COMMENT ON COLUMN CMS_POPUP.POP_ALT IS '팝업 이미지 alt 속성값';

COMMENT ON COLUMN CMS_POPUP.POP_SORT IS '정렬값';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_AUTH
-- 만든 날짜 : 2015-03-17 오전 9:17:34
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_AUTH (
  AUTH_CD       CHAR(5)          NOT NULL, 
  UP_AUTH_CD    CHAR(5)              NULL, 
  AUTH_NM       VARCHAR2(32)         NULL, 
  AUTH_LV       NUMBER               NULL, 
  AUTH_ORD      NUMBER               NULL, 
  USE_YN        CHAR(1)         DEFAULT 'Y'          NOT NULL, 
  WRITER        VARCHAR2(24)         NULL, 
  WDT           DATE            DEFAULT SYSDATE             NOT NULL, 
  MODIFIER      VARCHAR2(24)         NULL, 
  MDT           DATE                 NULL, 
    CONSTRAINT PK_CMS_SYS_AUTH
    PRIMARY KEY ( AUTH_CD )
)
;

COMMENT ON TABLE CMS_SYS_AUTH IS '[시스템] 사용자 권한';

COMMENT ON COLUMN CMS_SYS_AUTH.AUTH_CD IS '권한코드';

COMMENT ON COLUMN CMS_SYS_AUTH.UP_AUTH_CD IS '상위 권한 코드';

COMMENT ON COLUMN CMS_SYS_AUTH.AUTH_NM IS '권한명';

COMMENT ON COLUMN CMS_SYS_AUTH.AUTH_LV IS '권한 레벨';

COMMENT ON COLUMN CMS_SYS_AUTH.AUTH_ORD IS '권한 순서';

COMMENT ON COLUMN CMS_SYS_AUTH.USE_YN IS '사용여부';

COMMENT ON COLUMN CMS_SYS_AUTH.WRITER IS '작성자';

COMMENT ON COLUMN CMS_SYS_AUTH.WDT IS '작성일';

COMMENT ON COLUMN CMS_SYS_AUTH.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_SYS_AUTH.MDT IS '수정일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_CODE
-- 만든 날짜 : 2015-03-17 오전 9:17:35
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:35
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_CODE (
  CODE_IDX       VARCHAR2(16)      NOT NULL, 
  UP_CODE_IDX    VARCHAR2(16)          NULL, 
  CODE_NM        VARCHAR2(128)     NOT NULL, 
  CODE_ORD       NUMBER                NULL, 
  USE_YN         CHAR(1)          DEFAULT 'Y'           NOT NULL, 
  WRITER         VARCHAR2(24)          NULL, 
  WDT            DATE             DEFAULT SYSDATE              NOT NULL, 
  MODIFIER       VARCHAR2(24)          NULL, 
  MDT            DATE                  NULL, 
    CONSTRAINT PK_CMS_SYS_CODE
    PRIMARY KEY ( CODE_IDX )
)
;

COMMENT ON TABLE CMS_SYS_CODE IS '[시스템] 코드 관리';

COMMENT ON COLUMN CMS_SYS_CODE.CODE_ORD IS '코드 순서';

COMMENT ON COLUMN CMS_SYS_CODE.USE_YN IS '사용여부';

COMMENT ON COLUMN CMS_SYS_CODE.WRITER IS '작성자';

COMMENT ON COLUMN CMS_SYS_CODE.WDT IS '작성일';

COMMENT ON COLUMN CMS_SYS_CODE.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_SYS_CODE.MDT IS '수정일';

COMMENT ON COLUMN CMS_SYS_CODE.CODE_IDX IS '코드 ID';

COMMENT ON COLUMN CMS_SYS_CODE.UP_CODE_IDX IS '상위코드 ID';

COMMENT ON COLUMN CMS_SYS_CODE.CODE_NM IS '코드 명';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_CTGRY
-- 만든 날짜 : 2015-03-17 오전 9:17:35
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:35
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_CTGRY (
  CTGRY_IDX       VARCHAR2(16)      NOT NULL, 
  UP_CTGRY_IDX    VARCHAR2(16)          NULL, 
  CTGRY_NM        VARCHAR2(128)     NOT NULL, 
  CTGRY_ORD       NUMBER                NULL, 
  USE_YN          CHAR(1)          DEFAULT 'Y'           NOT NULL, 
  WRITER          VARCHAR2(24)          NULL, 
  WDT             DATE             DEFAULT SYSDATE              NOT NULL, 
  MODIFIER        VARCHAR2(24)          NULL, 
  MDT             DATE                  NULL, 
    CONSTRAINT PK_CMS_SYS_CTGRY
    PRIMARY KEY ( CTGRY_IDX )
)
;

COMMENT ON TABLE CMS_SYS_CTGRY IS '[시스템] 카테고리 관리';

COMMENT ON COLUMN CMS_SYS_CTGRY.CTGRY_IDX IS '카테고리 ID';

COMMENT ON COLUMN CMS_SYS_CTGRY.UP_CTGRY_IDX IS '상위카테고리 ID';

COMMENT ON COLUMN CMS_SYS_CTGRY.CTGRY_NM IS '카테고리 명';

COMMENT ON COLUMN CMS_SYS_CTGRY.CTGRY_ORD IS '카테고리 순서';

COMMENT ON COLUMN CMS_SYS_CTGRY.USE_YN IS '사용여부';

COMMENT ON COLUMN CMS_SYS_CTGRY.WRITER IS '작성자';

COMMENT ON COLUMN CMS_SYS_CTGRY.WDT IS '작성일';

COMMENT ON COLUMN CMS_SYS_CTGRY.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_SYS_CTGRY.MDT IS '수정일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_MENU
-- 만든 날짜 : 2015-03-17 오전 9:17:36
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:36
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_MENU (
  MENU_IDX            VARCHAR2(16)      NOT NULL, 
  UP_MENU_IDX         VARCHAR2(16)          NULL, 
  MENU_NM             VARCHAR2(64)      NOT NULL, 
  MENU_NIX            VARCHAR2(8)       NOT NULL, 
  MENU_LINK           VARCHAR2(256)         NULL, 
  MENU_ORD            NUMBER                NULL, 
  MENU_IMG_PATH       VARCHAR2(128)         NULL, 
  LEFT_IMG_PATH       VARCHAR2(128)         NULL, 
  TITLE_IMG_PATH      VARCHAR2(128)         NULL, 
  SITEMAP_IMG_PATH    VARCHAR2(128)         NULL, 
  INFO01_IMG_PATH     VARCHAR2(128)         NULL, 
  INFO02_IMG_PATH     VARCHAR2(128)         NULL, 
  MU_GUB              CHAR(3)          DEFAULT 'USR'               NULL, 
  MU_SITE             CHAR(10)          DEFAULT 'CDIDX00002'               NULL, 
  MU_LANG             CHAR(10)          DEFAULT 'CDIDX00022'               NULL, 
  BLANK_YN            CHAR(1)          DEFAULT 'N'           NOT NULL, 
  TABMENU_YN          CHAR(1)          DEFAULT 'N'           NOT NULL, 
  MEMMENU_YN          CHAR(1)          DEFAULT 'N'           NOT NULL, 
  USE_YN              CHAR(1)          DEFAULT 'Y'           NOT NULL, 
  WRITER              VARCHAR2(24)          NULL, 
  WDT                 DATE             DEFAULT SYSDATE              NOT NULL, 
  MODIFIER            VARCHAR2(24)          NULL, 
  MDT                 DATE                  NULL, 
  OWN_INFO            VARCHAR2(512)         NULL, 
    CONSTRAINT PK_CMS_SYS_MENU
    PRIMARY KEY ( MENU_IDX )
)
;

COMMENT ON TABLE CMS_SYS_MENU IS '[시스템] 메뉴 관리';

COMMENT ON COLUMN CMS_SYS_MENU.MENU_IDX IS '메뉴 ID';

COMMENT ON COLUMN CMS_SYS_MENU.UP_MENU_IDX IS '상위메뉴 ID';

COMMENT ON COLUMN CMS_SYS_MENU.MENU_NM IS '메뉴 명';

COMMENT ON COLUMN CMS_SYS_MENU.MENU_NIX IS '메뉴 코드';

COMMENT ON COLUMN CMS_SYS_MENU.MENU_LINK IS '메뉴 링크';

COMMENT ON COLUMN CMS_SYS_MENU.MENU_ORD IS '메뉴 순서';

COMMENT ON COLUMN CMS_SYS_MENU.MENU_IMG_PATH IS '메인메뉴 이미지 경로 [이미지를 사용할 경우]';

COMMENT ON COLUMN CMS_SYS_MENU.LEFT_IMG_PATH IS '레프트메뉴 이미지 경로';

COMMENT ON COLUMN CMS_SYS_MENU.TITLE_IMG_PATH IS '타이틀 이미지 경로';

COMMENT ON COLUMN CMS_SYS_MENU.SITEMAP_IMG_PATH IS '사이트맵 이미지 경로';

COMMENT ON COLUMN CMS_SYS_MENU.INFO01_IMG_PATH IS '기타 이미지 경로 1';

COMMENT ON COLUMN CMS_SYS_MENU.INFO02_IMG_PATH IS '기타 이미지 경로 2';

COMMENT ON COLUMN CMS_SYS_MENU.MU_GUB IS '관리자/사용자 구분 [MAN : 관리자 / USR : 사용자]';

COMMENT ON COLUMN CMS_SYS_MENU.MU_SITE IS '사이트 구분 (대표웹 / 모바일 / 서브사이트)';

COMMENT ON COLUMN CMS_SYS_MENU.MU_LANG IS '언어 구분';

COMMENT ON COLUMN CMS_SYS_MENU.BLANK_YN IS '새창열기 여부';

COMMENT ON COLUMN CMS_SYS_MENU.TABMENU_YN IS '탭메뉴 여부';

COMMENT ON COLUMN CMS_SYS_MENU.MEMMENU_YN IS '사용자 메뉴 여부 (상단 메뉴에 나타나지 않는 회원가입, 이용약관 등의 사이트 메뉴)';

COMMENT ON COLUMN CMS_SYS_MENU.USE_YN IS '사용여부';

COMMENT ON COLUMN CMS_SYS_MENU.WRITER IS '작성자';

COMMENT ON COLUMN CMS_SYS_MENU.WDT IS '작성일';

COMMENT ON COLUMN CMS_SYS_MENU.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_SYS_MENU.MDT IS '수정일';

COMMENT ON COLUMN CMS_SYS_MENU.OWN_INFO IS '제공부서, 담당자, 전화번호 등 정보';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_USR_CONTENTS
-- 만든 날짜 : 2015-03-18 오후 2:06:33
-- 마지막으로 수정한 날짜 : 2015-03-18 오후 2:06:33
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_USR_CONTENTS (
  UCONT_ID          VARCHAR2(32)       NOT NULL, 
  UCONT_VERSION     NUMBER             NOT NULL, 
  UCONT_SUBJECT     VARCHAR2(512)      NOT NULL, 
  UCONT_DFT         VARCHAR2(512)      NOT NULL, 
  UCONT_CSS         VARCHAR2(4000)         NULL, 
  UCONT_CONT        CLOB               NOT NULL, 
  ALTER_IMG_ATCH    CHAR(1)           DEFAULT 'N'            NOT NULL, 
  MU_SITE           CHAR(10)           DEFAULT 'CDIDX00002'            NOT NULL, 
  MU_LANG           CHAR(10)           DEFAULT 'CDIDX00022'            NOT NULL, 
  REF_MENU_NIX      VARCHAR2(8)            NULL, 
  WRITER            VARCHAR2(24)           NULL, 
  WDT               DATE              DEFAULT SYSDATE                   NULL, 
  MODIFIER          VARCHAR2(24)           NULL, 
  MDT               DATE                   NULL, 
    CONSTRAINT PK_CMS_USR_CONTENTS
    PRIMARY KEY ( UCONT_ID, UCONT_VERSION )
)
;

COMMENT ON TABLE CMS_USR_CONTENTS IS '[시스템] 사용자 추가 컨텐츠';

COMMENT ON COLUMN CMS_USR_CONTENTS.UCONT_ID IS '컨텐츠 ID';

COMMENT ON COLUMN CMS_USR_CONTENTS.UCONT_VERSION IS '컨텐츠 버전';

COMMENT ON COLUMN CMS_USR_CONTENTS.UCONT_SUBJECT IS '컨텐츠 제목';

COMMENT ON COLUMN CMS_USR_CONTENTS.UCONT_DFT IS '컨텐츠 설명';

COMMENT ON COLUMN CMS_USR_CONTENTS.UCONT_CSS IS 'CSS 정의 [CSS파일 또는 CSS코드]';

COMMENT ON COLUMN CMS_USR_CONTENTS.UCONT_CONT IS '내용';

COMMENT ON COLUMN CMS_USR_CONTENTS.ALTER_IMG_ATCH IS '[Y/N] 컨텐츠 내의 이미지를 (이름이 같은)첨부파일로 대체';

COMMENT ON COLUMN CMS_USR_CONTENTS.MU_SITE IS '사이트 구분 (대표웹 / 모바일 / 서브사이트)';

COMMENT ON COLUMN CMS_USR_CONTENTS.MU_LANG IS '언어 구분';

COMMENT ON COLUMN CMS_USR_CONTENTS.REF_MENU_NIX IS '연결된 메뉴의 IDX';

COMMENT ON COLUMN CMS_USR_CONTENTS.WRITER IS '작성자';

COMMENT ON COLUMN CMS_USR_CONTENTS.WDT IS '작성일';

COMMENT ON COLUMN CMS_USR_CONTENTS.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_USR_CONTENTS.MDT IS '수정일';

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_USR_INFO
-- 만든 날짜 : 2015-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_USR_INFO (
  USER_ID          VARCHAR2(24)      NOT NULL, 
  USER_SCRT        VARCHAR2(128)     NOT NULL, 
  USER_NM          VARCHAR2(24)      NOT NULL, 
  USER_EMAIL       VARCHAR2(128)         NULL, 
  USER_BIRTH       VARCHAR2(10)          NULL, 
  USER_CP_1        VARCHAR2(12)          NULL, 
  USER_CP_2        VARCHAR2(12)          NULL, 
  USER_CP_3        VARCHAR2(12)          NULL, 
  USER_TEL_1       VARCHAR2(12)          NULL, 
  USER_TEL_2       VARCHAR2(12)          NULL, 
  USER_TEL_3       VARCHAR2(12)          NULL, 
  USER_ZIP         VARCHAR2(10)          NULL, 
  USER_ADDR_1      VARCHAR2(256)         NULL, 
  USER_ADDR_2      VARCHAR2(128)         NULL, 
  USER_DEPT        VARCHAR2(128)         NULL, 
  USER_GRADE       VARCHAR2(128)         NULL, 
  USER_AUTH_CD     CHAR(5)           NOT NULL, 
  MAILING_YN       CHAR(1)          DEFAULT 'N'           NOT NULL, 
  VALID_YN         CHAR(1)          DEFAULT 'Y'           NOT NULL, 
  USER_DUP_INFO    VARCHAR2(32)          NULL, 
  USER_NAME_CHK    VARCHAR2(32)          NULL, 
  ALLOW_IP         VARCHAR2(24)     DEFAULT '*'      NOT NULL, 
  LAST_LOGIN	   DATE              	 NULL,
  WRITER           VARCHAR2(24)          NULL, 
  WDT              DATE             DEFAULT SYSDATE                  NULL, 
  MODIFIER         VARCHAR2(24)          NULL, 
  MDT              DATE                  NULL, 
    CONSTRAINT PK_CMS_USR_INFO
    PRIMARY KEY ( USER_ID )
)
;

COMMENT ON TABLE CMS_USR_INFO IS '[시스템] 사용자 정보';

COMMENT ON COLUMN CMS_USR_INFO.USER_ID IS '아이디';

COMMENT ON COLUMN CMS_USR_INFO.USER_SCRT IS '패스워드';

COMMENT ON COLUMN CMS_USR_INFO.USER_NM IS '이름';

COMMENT ON COLUMN CMS_USR_INFO.USER_EMAIL IS 'EMAIL';

COMMENT ON COLUMN CMS_USR_INFO.USER_BIRTH IS '생년월일';

COMMENT ON COLUMN CMS_USR_INFO.USER_CP_1 IS '핸드폰 앞자리';

COMMENT ON COLUMN CMS_USR_INFO.USER_CP_2 IS '핸드폰 가운데자리';

COMMENT ON COLUMN CMS_USR_INFO.USER_CP_3 IS '핸드폰 끝자리';

COMMENT ON COLUMN CMS_USR_INFO.USER_TEL_1 IS '전화번호 앞자리';

COMMENT ON COLUMN CMS_USR_INFO.USER_TEL_2 IS '전화번호 가운데자리';

COMMENT ON COLUMN CMS_USR_INFO.USER_TEL_3 IS '전화번호 끝자리';

COMMENT ON COLUMN CMS_USR_INFO.USER_ZIP IS '우편번호';

COMMENT ON COLUMN CMS_USR_INFO.USER_ADDR_1 IS '주소1';

COMMENT ON COLUMN CMS_USR_INFO.USER_ADDR_2 IS '주소2';

COMMENT ON COLUMN CMS_USR_INFO.USER_DEPT IS '부서';

COMMENT ON COLUMN CMS_USR_INFO.USER_GRADE IS '직위/직급';

COMMENT ON COLUMN CMS_USR_INFO.USER_AUTH_CD IS '사용자 권한코드';

COMMENT ON COLUMN CMS_USR_INFO.MAILING_YN IS '메일링 서비스 이용여부';

COMMENT ON COLUMN CMS_USR_INFO.VALID_YN IS '유효사용자 여부 [사용자 삭제시 N으로 변경]';

COMMENT ON COLUMN CMS_USR_INFO.USER_DUP_INFO IS '중복가입 정보';

COMMENT ON COLUMN CMS_USR_INFO.USER_NAME_CHK IS '실명인증정보';

COMMENT ON COLUMN CMS_USR_INFO.ALLOW_IP IS '접속허용 IP규칙 [*는 모두 허용]';

COMMENT ON COLUMN CMS_USR_INFO.LAST_LOGIN IS '마지막 접속일시';

COMMENT ON COLUMN CMS_USR_INFO.WRITER IS '등록자';

COMMENT ON COLUMN CMS_USR_INFO.WDT IS '등록일';

COMMENT ON COLUMN CMS_USR_INFO.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_USR_INFO.MDT IS '수정일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SURVEY_MAIN
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SURVEY_MAIN 
(
  SRVY_IDX NUMBER 					NOT NULL, 
  SRVY_NM VARCHAR2(256 BYTE) 		NOT NULL, 
  SRVY_CONT CLOB, 
  SRVY_OPEN_YN CHAR(1 BYTE) DEFAULT 'N' NOT NULL, 
  SRVY_START DATE, 
  SRVY_END DATE, 
  SRVY_ALLOW_DUP CHAR(1 BYTE) DEFAULT 'Y' NOT NULL, 
  SRVY_MAX_ANS NUMBER DEFAULT 0 NOT NULL, 
  WRITER VARCHAR2(24 BYTE), 
  WDT DATE, 
  MODIFIER VARCHAR2(24 BYTE), 
  MDT DATE, 
  SRVY_X VARCHAR2(5 BYTE) DEFAULT '50', 
  SRVY_Y VARCHAR2(5 BYTE) DEFAULT '50', 
  SRVY_W VARCHAR2(5 BYTE) DEFAULT '460', 
  SRVY_H VARCHAR2(5 BYTE) DEFAULT '370', 
  SRVY_POP_TYPE CHAR(1 BYTE) DEFAULT 'W' NOT NULL, 
  CONSTRAINT PK_CMS_SURVEY_MAIN PRIMARY KEY 
  (
    SRVY_IDX 
  )
);

COMMENT ON TABLE CMS_SURVEY_MAIN IS '[설문] 설문조사 메인';

COMMENT ON COLUMN CMS_SURVEY_MAIN.SRVY_IDX IS '설문조사 번호';

COMMENT ON COLUMN CMS_SURVEY_MAIN.SRVY_NM IS '설문조사 명';

COMMENT ON COLUMN CMS_SURVEY_MAIN.SRVY_CONT IS '설문조사 내용';

COMMENT ON COLUMN CMS_SURVEY_MAIN.SRVY_OPEN_YN IS '현재시점 설문실시 여부[Y/N]';

COMMENT ON COLUMN CMS_SURVEY_MAIN.SRVY_START IS '설문조사 시작일';

COMMENT ON COLUMN CMS_SURVEY_MAIN.SRVY_END IS '설문조사 종료일';

COMMENT ON COLUMN CMS_SURVEY_MAIN.SRVY_ALLOW_DUP IS '중복응답 허용여부 [Y/N]';

COMMENT ON COLUMN CMS_SURVEY_MAIN.SRVY_MAX_ANS IS '선착순 설정 (0 : 제한없음)';

COMMENT ON COLUMN CMS_SURVEY_MAIN.WRITER IS '작성자';

COMMENT ON COLUMN CMS_SURVEY_MAIN.WDT IS '작성일';

COMMENT ON COLUMN CMS_SURVEY_MAIN.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_SURVEY_MAIN.MDT IS '수정일';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SURVEY_PART
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SURVEY_PART 
(
  SRVY_IDX NUMBER NOT NULL, 
  PART_IDX NUMBER NOT NULL, 
  PART_NM VARCHAR2(256 BYTE) NOT NULL, 
  PART_TYPE VARCHAR2(16 BYTE) NOT NULL, 
  PART_PSN_INFO VARCHAR2(4000 BYTE), 
  WRITER VARCHAR2(24 BYTE), 
  WDT DATE, 
  MODIFIER VARCHAR2(24 BYTE), 
  MDT DATE, 
  CONSTRAINT PK_CMS_SURVEY_PART PRIMARY KEY 
  (
    SRVY_IDX, PART_IDX 
  )
);

COMMENT ON TABLE CMS_SURVEY_PART IS '[설문] 설문조사 파트';

COMMENT ON COLUMN CMS_SURVEY_PART.SRVY_IDX IS '설문조사 번호';

COMMENT ON COLUMN CMS_SURVEY_PART.PART_IDX IS '파트 번호';

COMMENT ON COLUMN CMS_SURVEY_PART.PART_NM IS '파트 명';

COMMENT ON COLUMN CMS_SURVEY_PART.PART_TYPE IS '파트 구분 (개인정보 / 일반파트)';

COMMENT ON COLUMN CMS_SURVEY_PART.PART_PSN_INFO IS '개인정보 수집 안내';

COMMENT ON COLUMN CMS_SURVEY_PART.WRITER IS '작성자';

COMMENT ON COLUMN CMS_SURVEY_PART.WDT IS '작성일';

COMMENT ON COLUMN CMS_SURVEY_PART.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_SURVEY_PART.MDT IS '수정일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SURVEY_PART
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SURVEY_QUESANS 
(
  QUES_IDX NUMBER NOT NULL, 
  QUESANS_IDX NUMBER DEFAULT 0 NOT NULL, 
  SRVY_IDX NUMBER NOT NULL, 
  PART_IDX NUMBER NOT NULL, 
  QUESANS_TYPE CHAR(1 BYTE) DEFAULT 'A' NOT NULL, 
  QUESANS_CONT VARCHAR2(1000 BYTE) NOT NULL, 
  QUES_TYPE VARCHAR2(16 BYTE) NOT NULL, 
  ANS_NEED_SPL CHAR(1 BYTE) DEFAULT 'N' NOT NULL, 
  ANS_ORD NUMBER DEFAULT 0 NOT NULL, 
  WRITER VARCHAR2(24 BYTE), 
  WDT DATE, 
  MODIFIER VARCHAR2(24 BYTE), 
  MDT DATE, 
  CONSTRAINT PK_CMS_SURVEY_QUESANS PRIMARY KEY 
  (
    QUES_IDX , QUESANS_IDX 
  )
);

COMMENT ON TABLE CMS_SURVEY_QUESANS IS '[설문] 설문조사 질문/답변';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.QUES_IDX IS '질문 번호';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.QUESANS_IDX IS '질문내 질문 답변 번호 (설문결과 저장시 답변은 이값을 참조하지 않는다.. 답변값이 중간에 삭제될 수 있기 때문)';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.SRVY_IDX IS '설문조사 번호';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.PART_IDX IS '파트 번호';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.QUESANS_TYPE IS '질문 / 답변 구분';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.QUESANS_CONT IS '질문 / 답변 내용';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.QUES_TYPE IS '질문 타입';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.ANS_NEED_SPL IS '보충답변 (Ex: 기타) 필요여부';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.ANS_ORD IS '답변 번호 (중요! - 답변의 순서는 이 값에 의해 정해지며, 설문 결과 저장시 이 값을 참조한다..)';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.WRITER IS '작성자';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.WDT IS '작성일';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.MODIFIER IS '수정자';

COMMENT ON COLUMN CMS_SURVEY_QUESANS.MDT IS '수정일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SURVEY_DATA
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SURVEY_DATA 
(
  DATA_IDX NUMBER NOT NULL, 
  QUES_IDX NUMBER NOT NULL, 
  QUESSUB_IDX NUMBER DEFAULT 1 NOT NULL, 
  SRVY_IDX NUMBER NOT NULL, 
  DATA_CONT VARCHAR2(1024 BYTE) NOT NULL, 
  DATA_SPL VARCHAR2(1024 BYTE), 
  DATA_ADDR VARCHAR2(64 BYTE) NOT NULL, 
  WDT DATE, 
  CONSTRAINT PK_CMS_SURVEY_DATA PRIMARY KEY 
  (
    DATA_IDX, QUES_IDX, QUESSUB_IDX 
  )
); 


COMMENT ON TABLE CMS_SURVEY_DATA IS '[설문] 설문조사 수집 데이터';

COMMENT ON COLUMN CMS_SURVEY_DATA.DATA_IDX IS '데이터 번호 (설문조사 응답자 일련번호;시퀀스)';

COMMENT ON COLUMN CMS_SURVEY_DATA.QUES_IDX IS '질문 번호';

COMMENT ON COLUMN CMS_SURVEY_DATA.QUESSUB_IDX IS '서브질문 번호 (만족도 평가 / 선호도선택 의 하위 항목에 사용)';

COMMENT ON COLUMN CMS_SURVEY_DATA.SRVY_IDX IS '설문 번호';

COMMENT ON COLUMN CMS_SURVEY_DATA.DATA_CONT IS '답변 저장 값';

COMMENT ON COLUMN CMS_SURVEY_DATA.DATA_SPL IS '답변 저장 보충 값';

COMMENT ON COLUMN CMS_SURVEY_DATA.DATA_ADDR IS '답변자 식별값 (IP주소 등)';

COMMENT ON COLUMN CMS_SURVEY_DATA.WDT IS '작성일';



/*------------------------------------------------------------------------------
-- 개체 이름 : IDX_CMS_BRD_TXT_SUBJECT
-- 만든 날짜 : 2015-03-17 오전 9:17:31
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE INDEX IDX_CMS_BRD_TXT_SUBJECT
ON CMS_BRD_TXT_IDX_VXD5L880 (SUBJECT)
LOGGING
NOPARALLEL;


/*------------------------------------------------------------------------------
-- 개체 이름 : IDX_CMS_COMM_STAT
-- 만든 날짜 : 2015-03-17 오전 9:17:31
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE INDEX IDX_CMS_COMM_STAT
ON CMS_COMM_STAT (STAT_UID, STAT_KEY, STAT_SESSID)
LOGGING
NOPARALLEL;


/*------------------------------------------------------------------------------
-- 개체 이름 : IK_POP_SORT
-- 만든 날짜 : 2015-03-17 오전 9:17:34
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE INDEX IDX_CMS_POPUP
ON CMS_POPUP (POP_SORT)
LOGGING
NOPARALLEL;


ALTER TABLE CMS_BRD_DRY_IDX_MH3H22JH ADD
(
    CONSTRAINT FK_BRD_DRY_MH3H22JH_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE 
);

ALTER TABLE CMS_BRD_FAQ_IDX_MP43Z23Q ADD
(
    CONSTRAINT FK_BRD_FAQ_MP43Z23Q_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE 
);

ALTER TABLE CMS_BRD_FAQ_IDX_MP43Z23Q ADD
(
    CONSTRAINT FK_BRD_FAQ_MP43Z23Q_CTGRY_IDX
    FOREIGN KEY ( CTGRY_IDX )
        REFERENCES CMS_SYS_CTGRY ( CTGRY_IDX )
        ON DELETE  SET NULL 
);

ALTER TABLE CMS_BRD_NWS_IDX_M3KMB33X ADD
(
    CONSTRAINT FK_BRD_NWS_M3KMB33X_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE 
);

ALTER TABLE CMS_BRD_NWS_IDX_M3KMB33X ADD
(
    CONSTRAINT FK_BRD_NWS_M3KMB33X_CTGRY_IDX
    FOREIGN KEY ( CTGRY_IDX )
        REFERENCES CMS_SYS_CTGRY ( CTGRY_IDX )
        ON DELETE  SET NULL 
);


ALTER TABLE CMS_BRD_THM_IDX_CF68M3GZ ADD
(
    CONSTRAINT FK_BRD_THM_CF68M3GZ_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE 
);

ALTER TABLE CMS_BRD_TXT_IDX_VXD5L880 ADD
(
  CONSTRAINT FK_BRD_TXT_VXD5L880_BRD_ID
  FOREIGN KEY (BRD_ID) 
	REFERENCES CMS_BRD_INFO(BRD_ID)
	ON DELETE CASCADE
);

ALTER TABLE CMS_BRD_TXT_IDX_VXD5L880 ADD
(
    CONSTRAINT FK_BRD_TXT_VXD5L880_CTGRY_IDX
    FOREIGN KEY ( CTGRY_IDX )
        REFERENCES CMS_SYS_CTGRY ( CTGRY_IDX )
        ON DELETE  SET NULL 
);

ALTER TABLE CMS_SYS_MENU ADD
(
    CONSTRAINT UNI_SYS_MENU_MENU_NIX
    UNIQUE ( MENU_NIX )
);

ALTER TABLE CMS_BRD_INFO ADD
(
    CONSTRAINT FK_BRD_INFO_REF_MENU_NIX
    FOREIGN KEY ( REF_MENU_NIX )
        REFERENCES CMS_SYS_MENU ( MENU_NIX )
        ON DELETE  SET NULL 
);

ALTER TABLE CMS_BRD_INFO ADD
(
    CONSTRAINT FK_BRD_INFO_CTGRY_IDX
    FOREIGN KEY ( CTGRY_IDX )
        REFERENCES CMS_SYS_CTGRY ( CTGRY_IDX )
        ON DELETE  SET NULL 
);


ALTER TABLE CMS_USR_CONTENTS ADD
(
    CONSTRAINT FK_USR_CONTENTS_REF_MENU_NIX
    FOREIGN KEY ( REF_MENU_NIX )
        REFERENCES CMS_SYS_MENU ( MENU_NIX )
        ON DELETE  SET NULL 
);


ALTER TABLE CMS_MENU_AUTH ADD
(
    CONSTRAINT FK_MENU_AUTH_AUTH_CD
    FOREIGN KEY ( AUTH_CD )
        REFERENCES CMS_SYS_AUTH ( AUTH_CD )
        ON DELETE  CASCADE 
);


ALTER TABLE CMS_MENU_AUTH ADD
(
    CONSTRAINT FK_MENU_AUTH_MENU_IDX
    FOREIGN KEY ( MENU_IDX )
        REFERENCES CMS_SYS_MENU ( MENU_IDX )
        ON DELETE  CASCADE 
);


ALTER TABLE CMS_BRD_REPLY_IDX_CF68M3GZ ADD
(
    CONSTRAINT FK_BRD_REPLY_CF68M3GZ_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE
);


ALTER TABLE CMS_BRD_REPLY_IDX_VXD5L880 ADD
(
    CONSTRAINT FK_BRD_REPLY_VXD5L880_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE
);

ALTER TABLE CMS_ACCESS_IP ADD
(
    CONSTRAINT FK_ACCESS_IP_AUTH_CD
    FOREIGN KEY ( AUTH_CD )
        REFERENCES CMS_SYS_AUTH ( AUTH_CD )
        ON DELETE CASCADE
);

ALTER TABLE CMS_SURVEY_PART ADD 
(

	CONSTRAINT FK_CMS_SURVEY_PART_SRVY_IDX 
	FOREIGN KEY (SRVY_IDX)
		REFERENCES CMS_SURVEY_MAIN(SRVY_IDX)
		ON DELETE CASCADE
);
	
ALTER TABLE CMS_SURVEY_QUESANS ADD 
(

	CONSTRAINT FK_CMS_SURVEY_QUESANS_SRVYPART 
	FOREIGN KEY (SRVY_IDX, PART_IDX)
		REFERENCES CMS_SURVEY_PART(SRVY_IDX, PART_IDX )
		ON DELETE CASCADE
);

ALTER TABLE CMS_SURVEY_QUESANS
ADD CONSTRAINT UNIQ_CMS_SURVEY_QUESANS UNIQUE (QUES_IDX, ANS_ORD);




INSERT INTO CMS_USR_INFO
  (USER_ID, USER_SCRT, USER_NM, USER_EMAIL, USER_BIRTH, USER_CP_1, USER_CP_2, USER_CP_3, USER_TEL_1, USER_TEL_2, USER_TEL_3, USER_ZIP, USER_ADDR_1, USER_ADDR_2, USER_DEPT, USER_GRADE, USER_AUTH_CD, MAILING_YN, VALID_YN, ALLOW_IP, WRITER, WDT)
VALUES
  ('nimdasys', 'sF0VDkoxpaXzKSscJTHDhWTey0zNyZR+Rv9rk2rcsBI=', '시스템관리자', 'ZmZmZjE4NDVAbmF2ZXIuY29t', '20131223', 'MDEw', 'Mjk1NQ==', 'MjIyMg==', 'MDI=', 'MzIxMg==', 'MTIyMQ==', '', '', 'U0003', '', '', 'M0001', 'N', 'Y', '*', 'planidev', SYSDATE);
INSERT INTO CMS_USR_INFO
  (USER_ID, USER_SCRT, USER_NM, USER_EMAIL, USER_BIRTH, USER_CP_1, USER_CP_2, USER_CP_3, USER_TEL_1, USER_TEL_2, USER_TEL_3, USER_ZIP, USER_ADDR_1, USER_ADDR_2, USER_DEPT, USER_GRADE, USER_AUTH_CD, MAILING_YN, VALID_YN, ALLOW_IP, WRITER, WDT)
VALUES
  ('planidev', 'Vlhsk6ibLW+uOSUanK0pmlpprSAb7IypY/6iCVOHELY=', '관리자', 'YWRtaW5AcGxhbmkuY28ua3I=', '19850621', 'MDEw', 'MTIzNA==', 'Nzc3Nw==', 'MDI=', '', '', '305-500', '대전 유성구 용산동', '1111', '', '', 'D0001', 'Y', 'Y', '*', 'planidev', SYSDATE);
  
  
  
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00001', '', '개발 도구', '81rD8pHA', '/modedv/modedvPage.do?srch_menu_nix=C43NP3ns', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00002', '', '사용자 관리', 'zumNR6AM', '/modeur/modeurList.do?srch_menu_nix=DF13IQ59', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00003', '', '메뉴관리', '9LR0b1N0', '/menuctgry/sysmenuList.do?srch_menu_nix=k94X9RH9', 3, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00004', '', '컨텐츠 관리', 'z0k797D5', '/modedg/modedgList.do?srch_menu_nix=ztPJqjMk', 4, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00005', '', '게시판 관리', '794x409U', '/modebd/modebdList.do?srch_menu_nix=wZ311Dfx', 5, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00006', '', '통계', 'Ap778PvY', '/modest/modestPage.do?srch_menu_nix=9afxGvI7', 6, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00007', '', '기타 관리', 'h92HwHjt', '/menuctgry/syscodeList.do?srch_menu_nix=2u427mHs', 7, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');

INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00008',null,'설문 관리','9S3cQy1o','/manact/surveySrvymain/srvymainList.do?srch_menu_nix=Ei12sIt4',11,'','','','','','','MAN','CDIDX00002','CDIDX00022','N','N','N','N','planidev',to_date('17/04/11','RR/MM/DD'),'','','');

  
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00101', 'MNIDX00001', '개발도구', 'C43NP3ns', '/modedv/modedvPage.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00102', 'MNIDX00002', '권한관리', '5jS7h1Vh', '/menuctgry/sysauthList.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00103', 'MNIDX00002', '로그관리', 'iI9hxA9k', '/manlog/manlogList.do', 3, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00104', 'MNIDX00002', '사용자 관리', 'DF13IQ59', '/modeur/modeurList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00105', 'MNIDX00003', '관리자 메뉴', 'k94X9RH9', '/menuctgry/sysmenuList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00106', 'MNIDX00003', '사용자 메뉴', 'fCHJYUo1', '/menuctgry/sysmenuList.do?seltab_idx=1', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00107', 'MNIDX00004', '컨텐츠 목록', 'ztPJqjMk', '/modedg/modedgList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00108', 'MNIDX00004', '메뉴연결 보기', 'G0l5opl2', '/modedg/modedgmenuList.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00109', 'MNIDX00005', '게시판 목록', 'wZ311Dfx', '/modebd/modebdList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00110', 'MNIDX00005', '메뉴연결 보기', 'IR3T73EE', '/modebd/modebdmenuList.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00111', 'MNIDX00005', '카테고리 관리', 'SRMy889n', '/menuctgry/syscategoryList.do', 3, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00112', 'MNIDX00007', '코드 관리', '2u427mHs', '/menuctgry/syscodeList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00113', 'MNIDX00007', '팝업 관리', '30k7Xy7k', '/popup/popupList.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'N', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00114', 'MNIDX00007', '첨부파일 관리', '0clH9575', '/modeatch/customAtchPage.do', 3, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00115', 'MNIDX00006', '통계', '9afxGvI7', '/modest/modestPage.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00116', 'MNIDX00002', '접근IP관리', 'DHLViO3C', '/modeip/accessipList.do', 4, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00117', 'MNIDX00006', '페이지별통계', '3pDGzrP5', '/modest/modestpgPage.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', SYSDATE, '', '', '');

INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00118','MNIDX00008','설문 관리','Ei12sIt4','/manact/surveySrvymain/srvymainList.do',1,'','','','','','','MAN','CDIDX00002','CDIDX00022','N','N','N','N','planidev',SYSDATE, '','','');  

  
  


INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0000', '', '개발자', 0, 1, 'Y', '', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'D0000', '개발자', 0, 1, 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0000', '', '시스템관리자', 1, 2, 'Y', '', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'M0000', '시스템 관리자', 2, 1, 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('B0000', '', '컨텐츠관리자', 101, 3, 'N', '', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('B0001', 'B0000', '컨텐츠 관리자', 102, 1, 'N', 'planidev', SYSDATE, 'planidev', SYSDATE);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0000', '', '일반 사용자', 1001, 4, 'Y', '', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0002', 'U0000', '비회원', 9999, 7, 'N', 'planidev', SYSDATE, 'planidev', SYSDATE);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0003', 'U0000', '정회원', 1005, 4, 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('G0000', '', '손님', 10001, 5, 'N', '', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('G0001', 'G0000', '손님', 10002, 1, 'N', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0002', 'M0000', '시스템 제한 관리자', 3, 2, 'N', 'planidev', SYSDATE, 'planidev', SYSDATE);

  
  
  

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00001', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00002', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00003', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00004', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00005', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00006', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00007', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00008', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00101', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00102', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00103', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00104', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00105', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00106', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00107', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00108', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00109', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00110', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00111', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00112', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00113', 'Y', 'planidev', SYSDATE, '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00114', 'Y', 'planidev', SYSDATE, '', NULL);

  INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00115', 'Y', 'planidev', SYSDATE, '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00116', 'Y', 'planidev', SYSDATE, '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00117', 'Y', 'planidev', SYSDATE, '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00118', 'Y', 'planidev', SYSDATE, '', NULL);
  
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00002', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00003', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00004', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00005', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00006', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00007', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00008', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00102', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00103', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00104', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00105', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00106', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00107', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00108', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00109', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00110', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00111', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00112', 'Y', 'planidev', SYSDATE, '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00113', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00114', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00115', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00116', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00117', 'Y', 'planidev', SYSDATE, '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00118', 'Y', 'planidev', SYSDATE, '', NULL);




  
  
INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00001', '', '사이트 구분', 1, 'Y', 'nimdasys', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00002', 'CDIDX00001', '대표웹', 1, 'Y', 'nimdasys', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00003', 'CDIDX00001', '모바일', 2, 'N', 'nimdasys', SYSDATE, 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00021', '', '언어구분', 2, 'Y', 'nimdasys', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00022', 'CDIDX00021', '한국어', 1, 'Y', 'nimdasys', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00023', 'CDIDX00021', '영어', 2, 'N', 'nimdasys', SYSDATE, 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00024', 'CDIDX00021', '중국어', 3, 'N', 'nimdasys', SYSDATE, 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00025', 'CDIDX00021', '일본어', 4, 'N', 'nimdasys', SYSDATE, 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00041', '', '게시판 종류', 3, 'Y', 'nimdasys', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00042', 'CDIDX00041', '일반 게시판 / 자료실', 1, 'Y', 'nimdasys', SYSDATE, 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00043', 'CDIDX00041', 'FAQ형 게시판', 2, 'Y', 'nimdasys', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00044', 'CDIDX00041', '이미지 게시판 / 갤러리', 3, 'Y', 'nimdasys', SYSDATE, '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00045', 'CDIDX00041', '일정 게시판', 5, 'N', 'nimdasys', SYSDATE, 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00046', 'CDIDX00041', '익명 게시판', 4, 'N', 'nimdasys', SYSDATE, 'nimdasys', NULL);



INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00061',null,'설문 파트 유형',4,'Y','nimdasys',to_date('17/04/11','RR/MM/DD'),null,null);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
 	('CDIDX00062','CDIDX00061','개인정보',1,'Y','nimdasys',to_date('17/04/11','RR/MM/DD'),null,null);
   
INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00063','CDIDX00061','일반파트',2,'Y','nimdasys',to_date('17/04/11','RR/MM/DD'),null,null);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00081',null,'설문 질문 유형',5,'Y','nimdasys',to_date('17/04/11','RR/MM/DD'),null,null);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00082','CDIDX00081','객관식 단답형',1,'Y','nimdasys',to_date('17/04/12','RR/MM/DD'),null,null);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00083','CDIDX00081','객관식 복수형',2,'Y','nimdasys',to_date('17/04/12','RR/MM/DD'),null,null);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00084','CDIDX00081','주관식 단답형',3,'Y','nimdasys',to_date('17/04/12','RR/MM/DD'),null,null);
	
INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00085','CDIDX00081','만족도 선택형',4,'Y','nimdasys',to_date('17/04/12','RR/MM/DD'),null,null);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  	('CDIDX00086','CDIDX00081','선호도 선택형',5,'Y','nimdasys',to_date('17/04/12','RR/MM/DD'),null,null);
  
  	
CREATE SEQUENCE SEQ_SRVYDATA_IDX INCREMENT BY 1 MAXVALUE 999999999999999 MINVALUE 0 NOCACHE;