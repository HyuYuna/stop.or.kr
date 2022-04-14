DROP TABLE IF EXISTS CMS_ACCESS_IP CASCADE;
DROP TABLE IF EXISTS CMS_ATACH CASCADE;
DROP TABLE IF EXISTS CMS_BRD_DRY_IDX_MH3H22JH CASCADE;
DROP TABLE IF EXISTS CMS_BRD_FAQ_IDX_MP43Z23Q CASCADE;
DROP TABLE IF EXISTS CMS_BRD_INFO CASCADE;
DROP TABLE IF EXISTS CMS_BRD_NWS_IDX_M3KMB33X CASCADE;
DROP TABLE IF EXISTS CMS_BRD_RCMND CASCADE;
DROP TABLE IF EXISTS CMS_BRD_REPLY_IDX_CF68M3GZ CASCADE;
DROP TABLE IF EXISTS CMS_BRD_REPLY_IDX_VXD5L880 CASCADE;
DROP TABLE IF EXISTS CMS_BRD_THM_IDX_CF68M3GZ CASCADE;
DROP TABLE IF EXISTS CMS_BRD_TXT_IDX_VXD5L880 CASCADE;
DROP TABLE IF EXISTS CMS_COMM_STAT CASCADE;
DROP TABLE IF EXISTS CMS_MAN_LOG CASCADE;
DROP TABLE IF EXISTS CMS_MENU_AUTH CASCADE;
DROP TABLE IF EXISTS CMS_POPUP CASCADE;
DROP TABLE IF EXISTS CMS_SYS_AUTH CASCADE;
DROP TABLE IF EXISTS CMS_SYS_CODE CASCADE;
DROP TABLE IF EXISTS CMS_SYS_CTGRY CASCADE;
DROP TABLE IF EXISTS CMS_SYS_MENU CASCADE;
DROP TABLE IF EXISTS CMS_USR_CONTENTS CASCADE;
DROP TABLE IF EXISTS CMS_USR_INFO CASCADE;
DROP TABLE IF EXISTS CMS_SURVEY_MAIN CASCADE;
DROP TABLE IF EXISTS CMS_SURVEY_PART CASCADE;
DROP TABLE IF EXISTS CMS_SURVEY_QUESANS CASCADE;
DROP TABLE IF EXISTS CMS_SURVEY_DATA CASCADE;



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ACCESS_IP
-- 만든 날짜 : 2016-03-25 오전 10:15:50
-- 마지막으로 수정한 날짜 : 2016-04-08 오후 12:05:31
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_ACCESS_IP (
  AUTH_CD      CHAR(5)          NOT NULL COMMENT '권한코드', 
  ACCESS_IP    VARCHAR(16)     NOT NULL COMMENT '접근 IP', 
  DESCRIPTION  VARCHAR(512)     NULL COMMENT '설명', 
  WRITER       VARCHAR(24)         NULL COMMENT '작성자', 
  WDT          DATETIME            NULL COMMENT '작성일', 
  MODIFIER     VARCHAR(24)         NULL COMMENT '수정자', 
  MDT          DATETIME                 NULL COMMENT '수정일'
)
;
ALTER TABLE CMS_ACCESS_IP COMMENT '[시스템] 접근 IP';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ATACH
-- 만든 날짜 : 2015-03-17 오전 9:19:15
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:19:15
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_ATACH (
  ATCKEY_1ST    VARCHAR(32)      NOT NULL COMMENT '1번째 키구분', 
  ATCKEY_2ND    VARCHAR(16)      NOT NULL COMMENT '2번째 키구분', 
  ATCKEY_3RD    INT           DEFAULT 1            NOT NULL COMMENT '3번째 키구분', 
  ATCKEY_4TH    INT           DEFAULT 1            NOT NULL COMMENT '4번째 키구분', 
  IS_THUMB      CHAR(1)          DEFAULT 'N'           NOT NULL COMMENT '썸네일 이미지인지 여부', 
  VCHKCODE      CHAR(12)          NOT NULL COMMENT '파일확인 키 (키값이 모두 노출되는 경우 아무파일이나 조회하는 것을 방지하기 위해 사용)', 
  FPATH         VARCHAR(256)         NULL COMMENT '파일 경로', 
  FNAME         VARCHAR(256)         NULL COMMENT '변경된 파일 명', 
  RNAME         VARCHAR(256)         NULL COMMENT '실제 파일 명', 
  FEXT          VARCHAR(16)          NULL COMMENT '확장자', 
  SIZE_KB       INT                NULL COMMENT '파일크기', 
  IMG_WIDTH     INT                NULL COMMENT '이미지파일의 경우 width', 
  IMG_HEIGHT    INT                NULL COMMENT '이미지파일의 경우 height', 
    CONSTRAINT PK_CMS_ATACH
    PRIMARY KEY ( ATCKEY_1ST, ATCKEY_2ND, ATCKEY_3RD, ATCKEY_4TH, IS_THUMB ), 
    CONSTRAINT UNIQ_CMS_ATACH_VCHKCODE
    UNIQUE ( VCHKCODE )
)
;

ALTER TABLE CMS_ATACH COMMENT '[시스템] 첨부파일';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_DRY_IDX_MH3H22JH
-- 만든 날짜 : 2015-03-17 오전 9:19:19
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:19:19
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_DRY_IDX_MH3H22JH (
  BRD_ID           VARCHAR(32)       NOT NULL COMMENT '게시판 번호', 
  CONT_IDX         INT             NOT NULL COMMENT '게시판 순번', 
  SUBJECT          VARCHAR(512)          NULL COMMENT '제목', 
  BRD_CONT         VARCHAR(4000)         NULL COMMENT '내용', 
  STARTDT          DATETIME               NOT NULL COMMENT '시작일시', 
  ENDDT            DATETIME               NOT NULL COMMENT '종료일시', 
  ALLDAY_YN        CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '종일스케줄 여부', 
  REPEAT_YN        CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '반복여부', 
  HOLIDAY_YN       CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '국경일 여부', 
  REF_URL          VARCHAR(256)          NULL COMMENT '참조 URL', 
  WRITER           VARCHAR(24)           NULL COMMENT '작성자', 
  WDT              DATETIME                   NULL COMMENT '작성일', 
  MODIFIER         VARCHAR(24)           NULL COMMENT '수정자', 
  MDT              DATETIME                   NULL COMMENT '수정일', 
  REFERENCE_KEY    VARCHAR(100)          NULL, 
  CONSTRAINT PK_CMS_BRD_DRY_IDX_MH3H22JH
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

ALTER TABLE CMS_BRD_DRY_IDX_MH3H22JH COMMENT '[게시판] 일정 게시판';




/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_FAQ_IDX_MP43Z23Q
-- 만든 날짜 : 2015-03-20 오후 2:27:47
-- 마지막으로 수정한 날짜 : 2015-03-20 오후 2:28:36
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_FAQ_IDX_MP43Z23Q (
  BRD_ID       VARCHAR(32)       NOT NULL COMMENT '게시판 번호', 
  CONT_IDX     INT             NOT NULL COMMENT '게시물 순번', 
  CTGRY_IDX    VARCHAR(16)           NULL COMMENT '카테고리', 
  SUBJECT      VARCHAR(512)      NOT NULL COMMENT '보고서제목', 
  BRD_CONT     VARCHAR(4000)     NOT NULL COMMENT '내용', 
  HITS         INT                 NULL COMMENT '조회수', 
  WRITER       VARCHAR(24)           NULL COMMENT '작성자', 
  WDT          DATETIME                   NULL COMMENT '작성일', 
  MODIFIER     VARCHAR(24)           NULL COMMENT '수정자', 
  MDT          DATETIME                   NULL, 
  KOGL         VARCHAR(16)           NULL, 
    CONSTRAINT PK_CMS_BRD_FAQ_IDX_MP43Z23Q
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

ALTER TABLE CMS_BRD_FAQ_IDX_MP43Z23Q COMMENT '[게시판] FAQ게시판 컨텐츠';





/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_INFO
-- 만든 날짜 : 2016-02-26 오후 4:13:34
-- 마지막으로 수정한 날짜 : 2016-03-14 오전 10:27:19
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_INFO (
  BRD_ID               VARCHAR(32)       NOT NULL COMMENT '게시판 번호', 
  TBL_NM               VARCHAR(32)       NOT NULL COMMENT '테이블 명', 
  BRD_NM               VARCHAR(256)      NOT NULL COMMENT '게시판 명', 
  MU_SITE              CHAR(10)          DEFAULT 'CDIDX00002'           NOT NULL COMMENT '사이트구분 [코드 참조]', 
  MU_LANG              CHAR(10)          DEFAULT 'CDIDX00022'           NOT NULL COMMENT '언어구분 [코드 참조]', 
  BRD_DFT              VARCHAR(256)          NULL COMMENT '게시판 설명', 
  BRD_DFT_SKIN         CHAR(1)           DEFAULT 'A'            NOT NULL COMMENT '게시판 기본 스킨', 
  BRD_CUST_SKIN        VARCHAR(16)           NULL COMMENT '게시판 사용자 정의 스킨', 
  BRD_GB               CHAR(10)          DEFAULT 'CDIDX00042'           NOT NULL COMMENT '게시판 구분 [코드 참조]', 
  BRD_GB_SUB           CHAR(1)           DEFAULT 'A'            NOT NULL COMMENT '게시판 마이너 구분', 
  EDITOR_GB            CHAR(1)           DEFAULT 'A'            NOT NULL COMMENT '에디터 구분 (CLEDITOR, ELRTE)', 
  USE_CTGRY            CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '카테고리 사용여부', 
  CTGRY_IDX            VARCHAR(16)           NULL COMMENT '카테고리 ID (사용할 경우)', 
  USE_NOTICE           CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '공지사항포함 여부', 
  USE_SCRT             CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '비밀글 사용 여부 (관리자와 본인만 조회 가능)', 
  USE_RCMND            CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '게시물 추천 사용 여부', 
  USE_RJCT             CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '게시물 반대 사용 여부', 
  USE_ATCH             CHAR(1)           DEFAULT 'Y'            NOT NULL COMMENT '첨부파일 사용 여부', 
  USE_UPLOADIFY        CHAR(1)           DEFAULT 'Y'            NOT NULL COMMENT '파일첨부를 위해 UPLOADIFY를 사용할지 여부 (사용하지 않으면 일반 폼 컨트롤사용)', 
  USE_KOGL             CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '공공누리 적용 여부', 
  REPLY_GB             CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '[A|R|N] A : 계단식 답글 형 게시판, R : 댓글형 게시판,  B : 답글 + 댓글, N : 댓글 없음', 
  ATTACH_CNT_LIMIT     INT            DEFAULT 1                 NULL COMMENT '첨부파일 개수 제한 [0: 제한없음]', 
  ATTACH_SIZE_LIMIT    INT            DEFAULT 20                 NULL COMMENT '첨부파일 크기 제한', 
  ATCL_PER_PG          INT            DEFAULT 15                 NULL COMMENT '페이지당 게시물 개수', 
  PG_PER_NAVI          INT            DEFAULT 10                 NULL COMMENT '페이지 네비 개수', 
  ON_VIEWMODE          CHAR(1)           DEFAULT '2'                NULL COMMENT '로그인한 사용자에 대한 공개 방식', 
  OFF_VIEWMODE         CHAR(1)           DEFAULT '1'                NULL COMMENT '로그인하지 않은 사용자에 대한 공개방', 
  CREATE_NEW_TABLE     CHAR(1)           DEFAULT 'N'                NULL COMMENT '게시판 전용 테이블 생성 여부', 
  REF_MENU_NIX         VARCHAR(9)            NULL COMMENT '연결된 메뉴의 IDX', 
  BRD_AUTH_USR         VARCHAR(256)          NULL COMMENT '게시판 관리자 목록 -> [ , ] 로 구분된 ID 문자열', 
  INFO_CONT            TEXT                   NULL COMMENT '게시판 컨텐츠', 
  WRITER               VARCHAR(24)           NULL COMMENT '작성자', 
  WDT                  DATETIME              NULL COMMENT '작성일', 
  MODIFIER             VARCHAR(24)           NULL COMMENT '수정자', 
  MDT                  DATETIME                   NULL COMMENT '수정일', 
    CONSTRAINT PK_CMS_BRD_INFO
    PRIMARY KEY ( BRD_ID )
)
;

ALTER TABLE CMS_BRD_INFO COMMENT '[게시판] 게시판 정보';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_NWS_IDX_M3KMB33X
-- 만든 날짜 : 2015-03-17 오전 9:17:27
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:27
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_NWS_IDX_M3KMB33X (
  BRD_ID       VARCHAR(32)      NOT NULL COMMENT '게시판 번호', 
  CONT_IDX     INT            NOT NULL COMMENT '게시물 순번', 
  CTGRY_IDX    VARCHAR(16)          NULL COMMENT '카테고리', 
  SUBJECT      VARCHAR(512)     NOT NULL COMMENT '제목', 
  NEWS_LINK    VARCHAR(512)     NOT NULL COMMENT '뉴스링크', 
  WRITER       VARCHAR(24)          NULL COMMENT '작성자', 
  WDT          DATETIME                  NULL COMMENT '작성일', 
  MODIFIER     VARCHAR(24)          NULL COMMENT '수정자', 
  MDT          DATETIME                  NULL COMMENT '수정일', 
    CONSTRAINT CMS_BRD_NWS_IDX_M3KMB33X
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

ALTER TABLE CMS_BRD_NWS_IDX_M3KMB33X COMMENT '[게시판] 뉴스링크 게시판 컨텐츠';





/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_RCMND
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_RCMND (
  RCMND_IDX    INT           NOT NULL COMMENT '순번', 
  BRD_ID       VARCHAR(32)         NULL COMMENT '게시판 ID', 
  CONT_IDX     INT               NULL COMMENT '게시물순번', 
  RCMND_ID     VARCHAR(24)         NULL COMMENT '추천인/ 반대인 ID', 
  RCMND_GB     CHAR(1)              NULL COMMENT '추천:R/반대:J 구분', 
  RDT          DATETIME                 NULL COMMENT '추천/반대 일시', 
    CONSTRAINT PK_CMS_BRD_RCMND
    PRIMARY KEY ( RCMND_IDX )
)
;

ALTER TABLE CMS_BRD_RCMND COMMENT '[게시판] 게시판 추천/반대 데이터';





/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_REPLY_IDX_CF68M3GZ
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_REPLY_IDX_CF68M3GZ (
  BRD_ID        VARCHAR(32)       NOT NULL COMMENT '게시판 번호', 
  CONT_IDX      INT             NOT NULL COMMENT '게시물 순번', 
  REPLY_IDX     INT             NOT NULL COMMENT '댓글 순번', 
  REPLY_CONT    VARCHAR(4000)         NULL COMMENT '내용', 
  RCMND_CNT     INT                 NULL COMMENT '추천수', 
  WRITER        VARCHAR(24)           NULL COMMENT '작성자', 
  WDT           DATETIME                   NULL COMMENT '작성일', 
  MODIFIER      VARCHAR(24)           NULL COMMENT '수정자', 
  MDT           DATETIME                   NULL COMMENT '수정일', 
    CONSTRAINT PK_CMS_BRD_REPLY_IDX_CF68M3GZ
    PRIMARY KEY ( BRD_ID, CONT_IDX, REPLY_IDX )
)
;

ALTER TABLE CMS_BRD_REPLY_IDX_CF68M3GZ COMMENT '[게시판] 이미지 게시판 댓글';




/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_REPLY_IDX_VXD5L880
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_REPLY_IDX_VXD5L880 (
  BRD_ID        VARCHAR(32)       NOT NULL COMMENT '게시판 번호', 
  CONT_IDX      INT             NOT NULL COMMENT '게시물 순번', 
  REPLY_IDX     INT             NOT NULL COMMENT '댓글 순번', 
  REPLY_CONT    VARCHAR(4000)         NULL COMMENT '내용', 
  RCMND_CNT     INT                 NULL COMMENT '추천수', 
  WRITER        VARCHAR(24)           NULL COMMENT '작성자', 
  WDT           DATETIME                   NULL COMMENT '작성일', 
  MODIFIER      VARCHAR(24)           NULL COMMENT '수정자', 
  MDT           DATETIME                   NULL COMMENT '수정일', 
  BRD_PWD       VARCHAR(128)          NULL COMMENT '댓글비밀번호', 
    CONSTRAINT PK_CMS_BRD_REPLY_IDX_VXD5L880
    PRIMARY KEY ( BRD_ID, CONT_IDX, REPLY_IDX )
)
;

ALTER TABLE CMS_BRD_REPLY_IDX_VXD5L880 COMMENT '[게시판] 텍스트 게시판 댓글';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_THM_IDX_CF68M3GZ
-- 만든 날짜 : 2015-03-17 오전 9:17:29
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:29
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_THM_IDX_CF68M3GZ (
  BRD_ID         VARCHAR(32)      NOT NULL COMMENT '게시판 번호', 
  CONT_IDX       INT            NOT NULL COMMENT '게시물 순번', 
  SUBJECT        VARCHAR(512)         NULL COMMENT '제목', 
  BRD_CONT       TEXT                  NULL COMMENT '내용', 
  BRD_UTB        VARCHAR(512)         NULL COMMENT '유튜브 링크', 
  IMG_IDX        INT           DEFAULT 0                NULL COMMENT '이미지 파일 번호', 
  THM_IMG_IDX    INT           DEFAULT 0                NULL COMMENT '썸네일 이미지 파일 번호', 
  HITS           INT                NULL COMMENT '조회수', 
  IS_NOTICE      CHAR(1)          DEFAULT 'N'               NULL COMMENT '공지사항 여부', 
  WRITER         VARCHAR(24)          NULL COMMENT '작성자', 
  WDT            DATETIME                  NULL COMMENT '작성일', 
  MODIFIER       VARCHAR(24)          NULL COMMENT '수정자', 
  MDT            DATETIME                  NULL COMMENT '수정일', 
    CONSTRAINT PK_CMS_BRD_THM_IDX_CF68M3GZ
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

ALTER TABLE CMS_BRD_THM_IDX_CF68M3GZ COMMENT '[게시판] 이미지(썸네일) 게시판 컨텐츠';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_TXT_IDX_VXD5L880
-- 만든 날짜 : 2015-03-17 오전 9:17:30
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_TXT_IDX_VXD5L880 (
  BRD_ID         VARCHAR(32)       NOT NULL COMMENT '게시판 번호', 
  CONT_IDX       INT             NOT NULL COMMENT '게시물 순번', 
  CTGRY_IDX      VARCHAR(16)           NULL COMMENT '카테고리', 
  SUBJECT        VARCHAR(512)      NOT NULL COMMENT '제목', 
  BRD_CONT       TEXT               NOT NULL COMMENT '내용', 
  HITS           INT                 NULL COMMENT '조회수', 
  GRP_NO         INT                 NULL COMMENT '그룹번호', 
  GRP_LV         INT                 NULL COMMENT '그룹레벨', 
  GRP_ORD        INT                 NULL COMMENT '그룹순번', 
  IS_NOTICE      CHAR(1)           DEFAULT 'N'                NULL COMMENT '공지 여부', 
  IS_SCRT        CHAR(1)           DEFAULT 'N'                NULL COMMENT '비밀글 여부', 
  ADD_INFO_01    VARCHAR(128)          NULL COMMENT '추가정보 1', 
  ADD_INFO_02    VARCHAR(128)          NULL COMMENT '추가정보 2', 
  ADD_INFO_03    VARCHAR(128)          NULL COMMENT '추가정보 3', 
  ADD_INFO_04    VARCHAR(512)          NULL COMMENT '추가정보 4', 
  ADD_INFO_05    VARCHAR(1024)         NULL COMMENT '추가정보 5', 
  WRITER         VARCHAR(24)           NULL COMMENT '작성자', 
  WDT            DATETIME                   NULL COMMENT '작성일', 
  MODIFIER       VARCHAR(24)           NULL COMMENT '수정자', 
  MDT            DATETIME                   NULL COMMENT '수정일', 
  KOGL           VARCHAR(16)           NULL COMMENT '공공누리 저작권 코드', 
    CONSTRAINT PK_CMS_BRD_TXT_IDX_VXD5L880
    PRIMARY KEY ( BRD_ID, CONT_IDX )
)
;

ALTER TABLE CMS_BRD_TXT_IDX_VXD5L880 COMMENT '[게시판] 텍스트 게시판 컨텐츠';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_COMM_STAT
-- 만든 날짜 : 2015-03-17 오전 9:17:31
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_COMM_STAT (
  STAT_KEY        VARCHAR(32)      NOT NULL COMMENT '통계 KEY', 
  STAT_SESSID     VARCHAR(64)      NOT NULL COMMENT '세션 ID', 
  STAT_KEY_NM     VARCHAR(64)          NULL COMMENT '통계 KEY 설명', 
  STAT_CITY       VARCHAR(32)          NULL COMMENT '도시', 
  STAT_NAT        VARCHAR(32)          NULL COMMENT '국가', 
  STAT_NAT_CD     VARCHAR(6)           NULL COMMENT '국가코드', 
  STAT_OS         VARCHAR(16)          NULL COMMENT '운영체제 종류', 
  STAT_BW         VARCHAR(16)          NULL COMMENT '브라우저 종류', 
  STAT_REFERER    VARCHAR(256)         NULL COMMENT '이전페이지 링크', 
  STAT_DT         DATETIME                  NULL COMMENT '기록일', 
  STAT_RADDR      VARCHAR(32)          NULL COMMENT '주소', 
  STAT_UID        VARCHAR(24)          NULL COMMENT 'UID', 
  CONTACT_CNT     INT       DEFAULT 1        NOT NULL COMMENT '접속 횟수', 
  	CONSTRAINT PK_CMS_COMM_STAT
    PRIMARY KEY ( STAT_KEY, STAT_SESSID )
)
;

ALTER TABLE CMS_COMM_STAT COMMENT '[시스템] 통계테이블';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_MAN_LOG
-- 만든 날짜 : 2015-03-17 오전 9:17:32
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:32
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_MAN_LOG (
  LOG_IDX         INT             NOT NULL COMMENT '일련번호', 
  LOG_KEY         VARCHAR(32)       NOT NULL COMMENT '로그 KEY', 
  LOG_KEY_NM      VARCHAR(64)           NULL COMMENT '로그 KEY 설명', 
  LOG_KEY_DEST    VARCHAR(1024)         NULL COMMENT '로그 상세', 
  LOG_JOB_GB      CHAR(1)                NULL COMMENT '작업구분', 
  LOG_RADDR       VARCHAR(32)           NULL COMMENT 'IP 주소', 
  LOG_UID         VARCHAR(24)           NULL COMMENT '행위자 ID', 
  LOG_DT          DATETIME                   NULL COMMENT '기록일', 
   CONSTRAINT PK_CMS_MAN_LOG	 
   PRIMARY KEY ( LOG_IDX )
)
;

ALTER TABLE CMS_MAN_LOG COMMENT '[시스템] 관리자 로그';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_MENU_AUTH
-- 만든 날짜 : 2015-03-17 오전 9:17:33
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:33
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_MENU_AUTH (
  AUTH_CD     CHAR(5)          NOT NULL COMMENT '권한코드', 
  MENU_IDX    VARCHAR(16)     NOT NULL COMMENT '메뉴 ID', 
  AUTH_YN     CHAR(1)         DEFAULT 'Y'          NOT NULL COMMENT '사용가능 여부', 
  WRITER      VARCHAR(24)         NULL COMMENT '등록자', 
  WDT         DATETIME                 NULL COMMENT '등록일', 
  MODIFIER    VARCHAR(24)         NULL COMMENT '수정자', 
  MDT         DATETIME                 NULL COMMENT '수정일시', 
    CONSTRAINT PK_CMS_MENU_AUTH
    PRIMARY KEY ( AUTH_CD, MENU_IDX )
)
;

ALTER TABLE CMS_MENU_AUTH COMMENT '[시스템] 권한별 사용가능 메뉴';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_POPUP
-- 만든 날짜 : 2015-03-17 오전 9:17:33
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_POPUP (
  POP_SEQ        INT         NOT NULL COMMENT '순번', 
  POP_TITLE      VARCHAR(200)      NOT NULL COMMENT '제목', 
  POP_TYPE       CHAR(1)            NOT NULL COMMENT '구분(W:창팝업/Z:팝업존)', 
  POP_FROM       VARCHAR(10)           NULL COMMENT '게시 시작일자', 
  POP_TO         VARCHAR(10)           NULL COMMENT '게시 종료일자', 
  POP_W          VARCHAR(10)           NULL COMMENT '팝업 너비', 
  POP_H          VARCHAR(10)           NULL COMMENT '팝업 높이', 
  POP_CONTENT    VARCHAR(4000)         NULL COMMENT '팝업 내용 - 텍스트', 
  POP_IMAGE      VARCHAR(200)          NULL COMMENT '팝업 내용 - 이미지', 
  POP_LINK       VARCHAR(250)          NULL COMMENT '팝업 링크 URL', 
  POP_TARGET     VARCHAR(10)           NULL COMMENT '링크 target', 
  USE_YN         CHAR(1)            NOT NULL COMMENT '사용 여부', 
  WRITER         VARCHAR(24)       NOT NULL COMMENT '등록자ID', 
  WDT            DATETIME               NOT NULL COMMENT '등록일시', 
  POP_X          VARCHAR(5)            NULL COMMENT '팝업 x좌표', 
  POP_Y          VARCHAR(5)            NULL COMMENT '팝업 y좌표', 
  POP_ALT        VARCHAR(250)          NULL COMMENT '팝업 이미지 alt 속성값', 
  POP_SORT       INT             NULL COMMENT '정렬값', 
    CONSTRAINT PK_CMS_POPUP
    PRIMARY KEY ( POP_SEQ )
)
;

ALTER TABLE CMS_POPUP COMMENT '[시스템] 팝업/팝업존';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_AUTH
-- 만든 날짜 : 2015-03-17 오전 9:17:34
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_AUTH (
  AUTH_CD       CHAR(5)          NOT NULL COMMENT '권한코드', 
  UP_AUTH_CD    CHAR(5)              NULL COMMENT '상위 권한 코드', 
  AUTH_NM       VARCHAR(32)         NULL COMMENT '권한명', 
  AUTH_LV       INT               NULL COMMENT '권한 레벨', 
  AUTH_ORD      INT               NULL COMMENT '권한 순서', 
  USE_YN        CHAR(1)         DEFAULT 'Y'          NOT NULL COMMENT '사용여부', 
  WRITER        VARCHAR(24)         NULL COMMENT '작성자', 
  WDT           DATETIME            	NULL COMMENT '작성일', 
  MODIFIER      VARCHAR(24)         NULL COMMENT '수정자', 
  MDT           DATETIME                 NULL COMMENT '수정일', 
    CONSTRAINT PK_CMS_SYS_AUTH
    PRIMARY KEY ( AUTH_CD )
)
;

ALTER TABLE CMS_SYS_AUTH COMMENT '[시스템] 사용자 권한';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_CODE
-- 만든 날짜 : 2015-03-17 오전 9:17:35
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:35
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_CODE (
  CODE_IDX       VARCHAR(16)      NOT NULL COMMENT '코드 ID', 
  UP_CODE_IDX    VARCHAR(16)          NULL COMMENT '상위코드 ID', 
  CODE_NM        VARCHAR(128)     NOT NULL COMMENT '코드 명', 
  CODE_ORD       INT                NULL COMMENT '코드 순서', 
  USE_YN         CHAR(1)          DEFAULT 'Y'           NOT NULL COMMENT '사용여부', 
  WRITER         VARCHAR(24)          NULL COMMENT '작성자', 
  WDT            DATETIME             NULL COMMENT '작성일', 
  MODIFIER       VARCHAR(24)          NULL COMMENT '수정자', 
  MDT            DATETIME                  NULL COMMENT '수정일', 
    CONSTRAINT PK_CMS_SYS_CODE
    PRIMARY KEY ( CODE_IDX )
)
;

ALTER TABLE CMS_SYS_CODE COMMENT '[시스템] 코드 관리';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_CTGRY
-- 만든 날짜 : 2015-03-17 오전 9:17:35
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:35
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_CTGRY (
  CTGRY_IDX       VARCHAR(16)      NOT NULL COMMENT '카테고리 ID', 
  UP_CTGRY_IDX    VARCHAR(16)          NULL COMMENT '상위카테고리 ID', 
  CTGRY_NM        VARCHAR(128)     NOT NULL COMMENT '카테고리 명', 
  CTGRY_ORD       INT                NULL COMMENT '카테고리 순서', 
  USE_YN          CHAR(1)          DEFAULT 'Y'           NOT NULL COMMENT '사용여부', 
  WRITER          VARCHAR(24)          NULL COMMENT '작성자', 
  WDT             DATETIME             NULL COMMENT '작성일', 
  MODIFIER        VARCHAR(24)          NULL COMMENT '수정자', 
  MDT             DATETIME                  NULL COMMENT '수정일', 
    CONSTRAINT PK_CMS_SYS_CTGRY
    PRIMARY KEY ( CTGRY_IDX )
)
;

ALTER TABLE CMS_SYS_CTGRY COMMENT '[시스템] 카테고리 관리';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_MENU
-- 만든 날짜 : 2015-03-17 오전 9:17:36
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:36
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_MENU (
  MENU_IDX            VARCHAR(16)      NOT NULL COMMENT '메뉴 ID', 
  UP_MENU_IDX         VARCHAR(16)          NULL COMMENT '상위메뉴 ID', 
  MENU_NM             VARCHAR(64)      NOT NULL COMMENT '메뉴 명', 
  MENU_NIX            VARCHAR(8)       NOT NULL COMMENT '메뉴 코드', 
  MENU_LINK           VARCHAR(256)         NULL COMMENT '메뉴 링크', 
  MENU_ORD            INT                NULL COMMENT '메뉴 순서', 
  MENU_IMG_PATH       VARCHAR(128)         NULL COMMENT '메인메뉴 이미지 경로 [이미지를 사용할 경우]', 
  LEFT_IMG_PATH       VARCHAR(128)         NULL COMMENT '레프트메뉴 이미지 경로', 
  TITLE_IMG_PATH      VARCHAR(128)         NULL COMMENT '타이틀 이미지 경로', 
  SITEMAP_IMG_PATH    VARCHAR(128)         NULL COMMENT '사이트맵 이미지 경로', 
  INFO01_IMG_PATH     VARCHAR(128)         NULL COMMENT '기타 이미지 경로 1', 
  INFO02_IMG_PATH     VARCHAR(128)         NULL COMMENT '기타 이미지 경로 2', 
  MU_GUB              CHAR(3)          DEFAULT 'USR'               NULL COMMENT '관리자/사용자 구분 [MAN : 관리자 / USR : 사용자]', 
  MU_SITE             CHAR(10)          DEFAULT 'CDIDX00002'               NULL COMMENT '사이트 구분 (대표웹 / 모바일 / 서브사이트)', 
  MU_LANG             CHAR(10)          DEFAULT 'CDIDX00022'               NULL COMMENT '언어 구분', 
  BLANK_YN            CHAR(1)          DEFAULT 'N'           NOT NULL COMMENT '새창열기 여부', 
  TABMENU_YN          CHAR(1)          DEFAULT 'N'           NOT NULL COMMENT '탭메뉴 여부', 
  MEMMENU_YN          CHAR(1)          DEFAULT 'N'           NOT NULL COMMENT '사용자 메뉴 여부 (상단 메뉴에 나타나지 않는 회원가입, 이용약관 등의 사이트 메뉴)', 
  USE_YN              CHAR(1)          DEFAULT 'Y'           NOT NULL COMMENT '사용여부', 
  WRITER              VARCHAR(24)          NULL COMMENT '작성자', 
  WDT                 DATETIME             NULL COMMENT '작성일', 
  MODIFIER            VARCHAR(24)          NULL COMMENT '수정자', 
  MDT                 DATETIME                  NULL COMMENT '수정일', 
  OWN_INFO            VARCHAR(512)         NULL COMMENT '제공부서, 담당자, 전화번호 등 정보', 
    CONSTRAINT PK_CMS_SYS_MENU
    PRIMARY KEY ( MENU_IDX )
)
;

ALTER TABLE CMS_SYS_MENU COMMENT '[시스템] 메뉴 관리';




/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_USR_CONTENTS
-- 만든 날짜 : 2015-03-18 오후 2:06:33
-- 마지막으로 수정한 날짜 : 2015-03-18 오후 2:06:33
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_USR_CONTENTS (
  UCONT_ID          VARCHAR(32)       NOT NULL COMMENT '컨텐츠 ID', 
  UCONT_VERSION     INT             NOT NULL COMMENT '컨텐츠 버전', 
  UCONT_SUBJECT     VARCHAR(512)      NOT NULL COMMENT '컨텐츠 제목', 
  UCONT_DFT         VARCHAR(512)      NOT NULL COMMENT '컨텐츠 설명', 
  UCONT_CSS         VARCHAR(4000)         NULL COMMENT 'CSS 정의 [CSS파일 또는 CSS코드]', 
  UCONT_CONT        TEXT               NOT NULL COMMENT '내용', 
  ALTER_IMG_ATCH    CHAR(1)           DEFAULT 'N'            NOT NULL COMMENT '[Y/N] 컨텐츠 내의 이미지를 (이름이 같은)첨부파일로 대체', 
  MU_SITE           CHAR(10)           DEFAULT 'CDIDX00002'            NOT NULL COMMENT '사이트 구분 (대표웹 / 모바일 / 서브사이트)', 
  MU_LANG           CHAR(10)           DEFAULT 'CDIDX00022'            NOT NULL COMMENT '언어 구분', 
  REF_MENU_NIX      VARCHAR(8)            NULL COMMENT '연결된 메뉴의 IDX', 
  WRITER            VARCHAR(24)           NULL COMMENT '작성자', 
  WDT               DATETIME              NULL COMMENT '작성일', 
  MODIFIER          VARCHAR(24)           NULL COMMENT '수정자', 
  MDT               DATETIME                   NULL COMMENT '수정일', 
    CONSTRAINT PK_CMS_USR_CONTENTS
    PRIMARY KEY ( UCONT_ID, UCONT_VERSION )
)
;

ALTER TABLE CMS_USR_CONTENTS COMMENT '[시스템] 사용자 추가 컨텐츠';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_USR_INFO
-- 만든 날짜 : 2015-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_USR_INFO (
  USER_ID          VARCHAR(24)      NOT NULL COMMENT '아이디', 
  USER_SCRT        VARCHAR(128)     NOT NULL COMMENT '패스워드', 
  USER_NM          VARCHAR(24)      NOT NULL COMMENT '이름', 
  USER_EMAIL       VARCHAR(128)         NULL COMMENT 'EMAIL', 
  USER_BIRTH       VARCHAR(10)          NULL COMMENT '생년월일', 
  USER_CP_1        VARCHAR(12)          NULL COMMENT '핸드폰 앞자리', 
  USER_CP_2        VARCHAR(12)          NULL COMMENT '핸드폰 가운데자리', 
  USER_CP_3        VARCHAR(12)          NULL COMMENT '핸드폰 끝자리', 
  USER_TEL_1       VARCHAR(12)          NULL COMMENT '전화번호 앞자리', 
  USER_TEL_2       VARCHAR(12)          NULL COMMENT '전화번호 가운데자리', 
  USER_TEL_3       VARCHAR(12)          NULL COMMENT '전화번호 끝자리', 
  USER_ZIP         VARCHAR(10)          NULL COMMENT '우편번호', 
  USER_ADDR_1      VARCHAR(256)         NULL COMMENT '주소1', 
  USER_ADDR_2      VARCHAR(128)         NULL COMMENT '주소2', 
  USER_DEPT        VARCHAR(128)         NULL COMMENT '부서', 
  USER_GRADE       VARCHAR(128)         NULL COMMENT '직위/직급', 
  USER_AUTH_CD     CHAR(5)           NOT NULL COMMENT '사용자 권한코드', 
  MAILING_YN       CHAR(1)          DEFAULT 'N'           NOT NULL COMMENT '메일링 서비스 이용여부', 
  VALID_YN         CHAR(1)          DEFAULT 'Y'           NOT NULL COMMENT '유효사용자 여부 [사용자 삭제시 N으로 변경]', 
  USER_DUP_INFO    VARCHAR(32)          NULL COMMENT '중복가입 정보', 
  USER_NAME_CHK    VARCHAR(32)          NULL COMMENT '실명인증정보', 
  ALLOW_IP         VARCHAR(24)     DEFAULT '*'      NOT NULL COMMENT '접속허용 IP규칙 [*는 모두 허용]', 
  WRITER           VARCHAR(24)          NULL COMMENT '등록자', 
  WDT              DATETIME             NULL COMMENT '등록일', 
  MODIFIER         VARCHAR(24)          NULL COMMENT '수정자', 
  MDT              DATETIME                  NULL COMMENT '수정일', 
    CONSTRAINT PK_CMS_USR_INFO
    PRIMARY KEY ( USER_ID )
)
;

ALTER TABLE CMS_USR_INFO COMMENT '[시스템] 사용자 정보';





/*------------------------------------------------------------------------------
-- 개체 이름 : IDX_CMS_COMM_STAT
-- 만든 날짜 : 2015-03-17 오전 9:17:31
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE INDEX IDX_CMS_COMM_STAT
ON CMS_COMM_STAT (STAT_UID, STAT_KEY, STAT_SESSID);


/*------------------------------------------------------------------------------
-- 개체 이름 : IK_POP_SORT
-- 만든 날짜 : 2015-03-17 오전 9:17:34
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE INDEX IDX_CMS_POPUP
ON CMS_POPUP (POP_SORT);


ALTER TABLE CMS_BRD_DRY_IDX_MH3H22JH ADD
    CONSTRAINT FK_BRD_DRY_MH3H22JH_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE 
;



ALTER TABLE CMS_BRD_FAQ_IDX_MP43Z23Q ADD
    CONSTRAINT FK_BRD_FAQ_MP43Z23Q_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE 
;


ALTER TABLE CMS_BRD_FAQ_IDX_MP43Z23Q ADD
    CONSTRAINT FK_BRD_FAQ_MP43Z23Q_CTGRY_IDX
    FOREIGN KEY ( CTGRY_IDX )
        REFERENCES CMS_SYS_CTGRY ( CTGRY_IDX )
        ON DELETE  SET NULL 
;


ALTER TABLE CMS_BRD_NWS_IDX_M3KMB33X ADD
    CONSTRAINT FK_BRD_NWS_M3KMB33X_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE 
;


ALTER TABLE CMS_BRD_NWS_IDX_M3KMB33X ADD
    CONSTRAINT FK_BRD_NWS_M3KMB33X_CTGRY_IDX
    FOREIGN KEY ( CTGRY_IDX )
        REFERENCES CMS_SYS_CTGRY ( CTGRY_IDX )
        ON DELETE  SET NULL 
;



ALTER TABLE CMS_BRD_THM_IDX_CF68M3GZ ADD
    CONSTRAINT FK_BRD_THM_CF68M3GZ_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE 
;



ALTER TABLE CMS_BRD_TXT_IDX_VXD5L880 ADD
  CONSTRAINT FK_BRD_TXT_VXD5L880_BRD_ID
  FOREIGN KEY (BRD_ID) 
	REFERENCES CMS_BRD_INFO(BRD_ID)
	ON DELETE CASCADE
;



ALTER TABLE CMS_BRD_TXT_IDX_VXD5L880 ADD
    CONSTRAINT FK_BRD_TXT_VXD5L880_CTGRY_IDX
    FOREIGN KEY ( CTGRY_IDX )
        REFERENCES CMS_SYS_CTGRY ( CTGRY_IDX )
        ON DELETE  SET NULL 
;



ALTER TABLE CMS_SYS_MENU ADD
    CONSTRAINT UNI_SYS_MENU_MENU_NIX
    UNIQUE ( MENU_NIX )
;


ALTER TABLE CMS_BRD_INFO ADD
    CONSTRAINT FK_BRD_INFO_REF_MENU_NIX
    FOREIGN KEY ( REF_MENU_NIX )
        REFERENCES CMS_SYS_MENU ( MENU_NIX )
        ON DELETE  SET NULL 
;



ALTER TABLE CMS_BRD_INFO ADD
    CONSTRAINT FK_BRD_INFO_CTGRY_IDX
    FOREIGN KEY ( CTGRY_IDX )
        REFERENCES CMS_SYS_CTGRY ( CTGRY_IDX )
        ON DELETE  SET NULL 
;



ALTER TABLE CMS_USR_CONTENTS ADD
    CONSTRAINT FK_USR_CONTENTS_REF_MENU_NIX
    FOREIGN KEY ( REF_MENU_NIX )
        REFERENCES CMS_SYS_MENU ( MENU_NIX )
        ON DELETE  SET NULL 
;



ALTER TABLE CMS_MENU_AUTH ADD
    CONSTRAINT FK_MENU_AUTH_AUTH_CD
    FOREIGN KEY ( AUTH_CD )
        REFERENCES CMS_SYS_AUTH ( AUTH_CD )
        ON DELETE  CASCADE 
;



ALTER TABLE CMS_MENU_AUTH ADD
    CONSTRAINT FK_MENU_AUTH_MENU_IDX
    FOREIGN KEY ( MENU_IDX )
        REFERENCES CMS_SYS_MENU ( MENU_IDX )
        ON DELETE  CASCADE 
;



ALTER TABLE CMS_BRD_REPLY_IDX_CF68M3GZ ADD
    CONSTRAINT FK_BRD_REPLY_CF68M3GZ_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE
;



ALTER TABLE CMS_BRD_REPLY_IDX_VXD5L880 ADD
    CONSTRAINT FK_BRD_REPLY_VXD5L880_BRD_ID
    FOREIGN KEY ( BRD_ID )
        REFERENCES CMS_BRD_INFO ( BRD_ID )
        ON DELETE  CASCADE
;


ALTER TABLE CMS_ACCESS_IP ADD
    CONSTRAINT FK_ACCESS_IP_AUTH_CD
    FOREIGN KEY ( AUTH_CD )
        REFERENCES CMS_SYS_AUTH ( AUTH_CD )
        ON DELETE CASCADE
;





INSERT INTO CMS_USR_INFO
  (USER_ID, USER_SCRT, USER_NM, USER_EMAIL, USER_BIRTH, USER_CP_1, USER_CP_2, USER_CP_3, USER_TEL_1, USER_TEL_2, USER_TEL_3, USER_ZIP, USER_ADDR_1, USER_ADDR_2, USER_DEPT, USER_GRADE, USER_AUTH_CD, MAILING_YN, VALID_YN, ALLOW_IP, WRITER, WDT)
VALUES
  ('nimdasys', 'sF0VDkoxpaXzKSscJTHDhWTey0zNyZR+Rv9rk2rcsBI=', '시스템관리자', 'ZmZmZjE4NDVAbmF2ZXIuY29t', '20131223', 'MDEw', 'Mjk1NQ==', 'MjIyMg==', 'MDI=', 'MzIxMg==', 'MTIyMQ==', '', '', 'U0003', '', '', 'M0001', 'N', 'Y', '*', 'planidev', NOW());
INSERT INTO CMS_USR_INFO
  (USER_ID, USER_SCRT, USER_NM, USER_EMAIL, USER_BIRTH, USER_CP_1, USER_CP_2, USER_CP_3, USER_TEL_1, USER_TEL_2, USER_TEL_3, USER_ZIP, USER_ADDR_1, USER_ADDR_2, USER_DEPT, USER_GRADE, USER_AUTH_CD, MAILING_YN, VALID_YN, ALLOW_IP, WRITER, WDT)
VALUES
  ('planidev', 'Vlhsk6ibLW+uOSUanK0pmlpprSAb7IypY/6iCVOHELY=', '관리자', 'YWRtaW5AcGxhbmkuY28ua3I=', '19850621', 'MDEw', 'MTIzNA==', 'Nzc3Nw==', 'MDI=', '', '', '305-500', '대전 유성구 용산동', '1111', '', '', 'D0001', 'Y', 'Y', '*', 'planidev', NOW());
  
  
  
  
  
  
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00001', '', '개발 도구', '81rD8pHA', '/modedv/modedvPage.do?srch_menu_nix=C43NP3ns', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00002', '', '사용자 관리', 'zumNR6AM', '/modeur/modeurList.do?srch_menu_nix=DF13IQ59', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00003', '', '메뉴관리', '9LR0b1N0', '/menuctgry/sysmenuList.do?srch_menu_nix=k94X9RH9', 3, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00004', '', '컨텐츠 관리', 'z0k797D5', '/modedg/modedgList.do?srch_menu_nix=ztPJqjMk', 4, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00005', '', '게시판 관리', '794x409U', '/modebd/modebdList.do?srch_menu_nix=wZ311Dfx', 5, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00006', '', '통계', 'Ap778PvY', '/modest/modestPage.do?srch_menu_nix=9afxGvI7', 6, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00007', '', '기타 관리', 'h92HwHjt', '/menuctgry/syscodeList.do?srch_menu_nix=2u427mHs', 7, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');


   
  
  
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00101', 'MNIDX00001', '개발도구', 'C43NP3ns', '/modedv/modedvPage.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00102', 'MNIDX00002', '권한관리', '5jS7h1Vh', '/menuctgry/sysauthList.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00103', 'MNIDX00002', '로그관리', 'iI9hxA9k', '/manlog/manlogList.do', 3, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00104', 'MNIDX00002', '사용자 관리', 'DF13IQ59', '/modeur/modeurList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00105', 'MNIDX00003', '관리자 메뉴', 'k94X9RH9', '/menuctgry/sysmenuList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00106', 'MNIDX00003', '사용자 메뉴', 'fCHJYUo1', '/menuctgry/sysmenuList.do?seltab_idx=1', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00107', 'MNIDX00004', '컨텐츠 목록', 'ztPJqjMk', '/modedg/modedgList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00108', 'MNIDX00004', '메뉴연결 보기', 'G0l5opl2', '/modedg/modedgmenuList.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00109', 'MNIDX00005', '게시판 목록', 'wZ311Dfx', '/modebd/modebdList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00110', 'MNIDX00005', '메뉴연결 보기', 'IR3T73EE', '/modebd/modebdmenuList.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00111', 'MNIDX00005', '카테고리 관리', 'SRMy889n', '/menuctgry/syscategoryList.do', 3, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00112', 'MNIDX00007', '코드 관리', '2u427mHs', '/menuctgry/syscodeList.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00113', 'MNIDX00007', '팝업 관리', '30k7Xy7k', '/popup/popupList.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'N', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00114', 'MNIDX00007', '첨부파일 관리', '0clH9575', '/modeatch/customAtchPage.do', 3, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00115', 'MNIDX00006', '통계', '9afxGvI7', '/modest/modestPage.do', 1, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00116', 'MNIDX00002', '접근IP관리', 'DHLViO3C', '/modeip/accessipList.do', 4, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00117', 'MNIDX00006', '페이지별통계', '3pDGzrP5', '/modest/modestpgPage.do', 2, '', '', '', '', '', '', 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', NOW(), '', null, '');


  
  


INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0000', '', '개발자', 0, 1, 'Y', '', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'D0000', '개발자', 0, 1, 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0000', '', '시스템관리자', 1, 2, 'Y', '', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'M0000', '시스템 총괄 관리자', 2, 1, 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('B0000', '', '컨텐츠관리자', 101, 3, 'N', '', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('B0001', 'B0000', '컨텐츠 총괄 관리자', 102, 1, 'N', 'planidev', NOW(), 'planidev', NOW());

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0000', '', '일반 사용자', 1001, 4, 'Y', '', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0002', 'U0000', '비회원', 9999, 7, 'N', 'planidev', NOW(), 'planidev', NOW());

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0003', 'U0000', '정회원', 1005, 4, 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('G0000', '', '손님', 10001, 5, 'N', '', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('G0001', 'G0000', '손님', 10002, 1, 'N', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0002', 'M0000', '시스템 부분 관리자', 3, 2, 'N', 'planidev', NOW(), 'planidev', NOW());

  
  
  

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00001', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00002', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00003', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00004', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00005', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00006', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00007', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00008', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00101', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00102', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00103', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00104', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00105', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00106', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00107', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00108', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00109', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00110', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00111', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00112', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00113', 'Y', 'planidev', NOW(), '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00114', 'Y', 'planidev', NOW(), '', NULL);

  INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00115', 'Y', 'planidev', NOW(), '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00116', 'Y', 'planidev', NOW(), '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00117', 'Y', 'planidev', NOW(), '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00118', 'Y', 'planidev', NOW(), '', NULL);
  
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00002', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00003', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00004', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00005', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00006', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00007', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00008', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00102', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00103', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00104', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00105', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00106', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00107', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00108', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00109', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00110', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00111', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00112', 'Y', 'planidev', NOW(), '', NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00113', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00114', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00115', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00116', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00117', 'Y', 'planidev', NOW(), '', NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00118', 'Y', 'planidev', NOW(), '', NULL);




  
  
INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00001', '', '사이트 구분', 1, 'Y', 'nimdasys', NOW(), '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00002', 'CDIDX00001', '대표웹', 1, 'Y', 'nimdasys', NOW(), '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00003', 'CDIDX00001', '모바일', 2, 'N', 'nimdasys', NOW(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00021', '', '언어구분', 2, 'Y', 'nimdasys', NOW(), '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00022', 'CDIDX00021', '한국어', 1, 'Y', 'nimdasys', NOW(), '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00023', 'CDIDX00021', '영어', 2, 'N', 'nimdasys', NOW(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00024', 'CDIDX00021', '중국어', 3, 'N', 'nimdasys', NOW(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00025', 'CDIDX00021', '일본어', 4, 'N', 'nimdasys', NOW(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00041', '', '게시판 종류', 3, 'Y', 'nimdasys', NOW(), '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00042', 'CDIDX00041', '일반 게시판 / 자료실', 1, 'Y', 'nimdasys', NOW(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00043', 'CDIDX00041', 'FAQ형 게시판', 2, 'Y', 'nimdasys', NOW(), '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00044', 'CDIDX00041', '이미지 게시판 / 갤러리', 3, 'Y', 'nimdasys', NOW(), '', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00045', 'CDIDX00041', '일정 게시판', 5, 'N', 'nimdasys', NOW(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00046', 'CDIDX00041', '익명 게시판', 4, 'N', 'nimdasys', NOW(), 'nimdasys', NULL);



