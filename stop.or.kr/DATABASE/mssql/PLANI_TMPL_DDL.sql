
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
DROP TABLE CMS_BRD_TXT_IDX_FAD1X223 CASCADE CONSTRAINTS;
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
DROP TABLE CMS_SYS_SEQ CASCADE CONSTRAINTS;


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ACCESS_IP
-- 만든 날짜 : 2016-03-25 오전 10:15:50
-- 마지막으로 수정한 날짜 : 2016-04-08 오후 12:05:31
-- 상태 : VALID
------------------------------------------------------------------------------*/


CREATE TABLE CMS_ACCESS_IP (
    AUTH_CD      CHAR(5) NOT NULL, 
    ACCESS_IP    VARCHAR(16) NOT NULL, 
    DESCRIPTION  VARCHAR(512), 
    WRITER       VARCHAR(24), 
    WDT          DATETIME NOT NULL DEFAULT (getdate()), 
    MODIFIER     VARCHAR(24), 
    MDT          DATETIME, 
 CONSTRAINT PK_CMS_ACCESS_IP 
   PRIMARY KEY CLUSTERED (AUTH_CD ASC, ACCESS_IP ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 접근 IP', N'schema', N'DBO', N'table', N'CMS_ACCESS_IP';

EXEC sp_addextendedproperty N'MS_Description', N'권한코드', N'schema', N'DBO', N'table', N'CMS_ACCESS_IP', N'column', N'AUTH_CD';

EXEC sp_addextendedproperty N'MS_Description', N'접근 IP', N'schema', N'DBO', N'table', N'CMS_ACCESS_IP', N'column', N'ACCESS_IP';

EXEC sp_addextendedproperty N'MS_Description', N'설명', N'schema', N'DBO', N'table', N'CMS_ACCESS_IP', N'column', N'DESCRIPTION';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_ACCESS_IP', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_ACCESS_IP', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_ACCESS_IP', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_ACCESS_IP', N'column', N'MDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ATACH
-- 만든 날짜 : 2015-03-17 오전 9:19:15
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:19:15
-- 상태 : VALID
------------------------------------------------------------------------------*/


CREATE TABLE CMS_ATACH (
    ATCKEY_1ST  VARCHAR(32) NOT NULL, 
    ATCKEY_2ND  VARCHAR(16) NOT NULL, 
    ATCKEY_3RD  INT NOT NULL DEFAULT ((1)), 
    ATCKEY_4TH  INT NOT NULL DEFAULT ((1)), 
    IS_THUMB    CHAR(1) NOT NULL DEFAULT ('N'), 
    VCHKCODE    CHAR(12) NOT NULL, 
    FPATH       VARCHAR(256), 
    FNAME       VARCHAR(256), 
    RNAME       VARCHAR(256), 
    FEXT        VARCHAR(16), 
    SIZE_KB     INT, 
    IMG_WIDTH   INT, 
    IMG_HEIGHT  INT, 
 CONSTRAINT PK_CMS_ATACH 
   PRIMARY KEY CLUSTERED (ATCKEY_1ST ASC, ATCKEY_2ND ASC, ATCKEY_3RD ASC, ATCKEY_4TH ASC, IS_THUMB ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 첨부파일', N'schema', N'DBO', N'table', N'CMS_ATACH';

EXEC sp_addextendedproperty N'MS_Description', N'1번째 키구분', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'ATCKEY_1ST';

EXEC sp_addextendedproperty N'MS_Description', N'2번째 키구분', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'ATCKEY_2ND';

EXEC sp_addextendedproperty N'MS_Description', N'3번째 키구분', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'ATCKEY_3RD';

EXEC sp_addextendedproperty N'MS_Description', N'4번째 키구분', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'ATCKEY_4TH';

EXEC sp_addextendedproperty N'MS_Description', N'썸네일 이미지인지 여부', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'IS_THUMB';

EXEC sp_addextendedproperty N'MS_Description', N'파일확인 키 (키값이 모두 노출되는 경우 아무파일이나 조회하는 것을 방지하기 위해 사용)', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'VCHKCODE';

EXEC sp_addextendedproperty N'MS_Description', N'파일 경로', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'FPATH';

EXEC sp_addextendedproperty N'MS_Description', N'변경된 파일 명', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'FNAME';

EXEC sp_addextendedproperty N'MS_Description', N'실제 파일 명', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'RNAME';

EXEC sp_addextendedproperty N'MS_Description', N'확장자', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'FEXT';

EXEC sp_addextendedproperty N'MS_Description', N'파일크기', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'SIZE_KB';

EXEC sp_addextendedproperty N'MS_Description', N'이미지파일의 경우 width', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'IMG_WIDTH';

EXEC sp_addextendedproperty N'MS_Description', N'이미지파일의 경우 height', N'schema', N'DBO', N'table', N'CMS_ATACH', N'column', N'IMG_HEIGHT';




/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_DRY_IDX_MH3H22JH
-- 만든 날짜 : 2015-03-17 오전 9:19:19
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:19:19
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_DRY_IDX_MH3H22JH (
    BRD_ID         VARCHAR(32) NOT NULL, 
    CONT_IDX       INT NOT NULL, 
    SUBJECT        VARCHAR(512), 
    BRD_CONT       VARCHAR(4000), 
    STARTDT        DATETIME NOT NULL, 
    ENDDT          DATETIME NOT NULL, 
    ALLDAY_YN      CHAR(1) NOT NULL DEFAULT ('N'), 
    REPEAT_YN      CHAR(1) NOT NULL DEFAULT ('N'), 
    HOLIDAY_YN     CHAR(1) NOT NULL DEFAULT ('N'), 
    REF_URL        VARCHAR(256), 
    WRITER         VARCHAR(24), 
    WDT            DATETIME, 
    MODIFIER       VARCHAR(24), 
    MDT            DATETIME, 
    REFERENCE_KEY  VARCHAR(100), 
 CONSTRAINT PK_CMS_BRD_DRY_IDX_MH3H22JH 
   PRIMARY KEY CLUSTERED (BRD_ID ASC, CONT_IDX ASC)
); 

EXEC sp_addextendedproperty N'MS_Description', N'[게시판] 일정 게시판', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 번호', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 순번', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'CONT_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'제목', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'SUBJECT';

EXEC sp_addextendedproperty N'MS_Description', N'내용', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'BRD_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'시작일시', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'STARTDT';

EXEC sp_addextendedproperty N'MS_Description', N'종료일시', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'ENDDT';

EXEC sp_addextendedproperty N'MS_Description', N'종일스케줄 여부', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'ALLDAY_YN';

EXEC sp_addextendedproperty N'MS_Description', N'반복여부', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'REPEAT_YN';

EXEC sp_addextendedproperty N'MS_Description', N'국경일 여부', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'HOLIDAY_YN';

EXEC sp_addextendedproperty N'MS_Description', N'참조 URL', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'REF_URL';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'MDT';

EXEC sp_addextendedproperty N'MS_Description', N'참조 키', N'schema', N'DBO', N'table', N'CMS_BRD_DRY_IDX_MH3H22JH', N'column', N'REFERENCE_KEY';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_FAQ_IDX_MP43Z23Q
-- 만든 날짜 : 2015-03-20 오후 2:27:47
-- 마지막으로 수정한 날짜 : 2015-03-20 오후 2:28:36
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_FAQ_IDX_MP43Z23Q (
    BRD_ID     VARCHAR(32) NOT NULL, 
    CONT_IDX   INT NOT NULL, 
    CTGRY_IDX  VARCHAR(16), 
    SUBJECT    VARCHAR(512) NOT NULL, 
    BRD_CONT   VARCHAR(4000) NOT NULL, 
    HITS       INT, 
    WRITER     VARCHAR(24), 
    WDT        DATETIME, 
    MODIFIER   VARCHAR(24), 
    MDT        DATETIME, 
    KOGL       VARCHAR(16), 
 CONSTRAINT PK_CMS_BRD_FAQ_IDX_MP43Z23Q 
   PRIMARY KEY CLUSTERED (BRD_ID ASC, CONT_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[게시판] FAQ게시판 컨텐츠', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 번호', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'게시물 순번', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'CONT_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'카테고리', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'CTGRY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'보고서제목', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'SUBJECT';

EXEC sp_addextendedproperty N'MS_Description', N'내용', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'BRD_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'조회수', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'HITS';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_BRD_FAQ_IDX_MP43Z23Q', N'column', N'MODIFIER';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_INFO
-- 만든 날짜 : 2016-02-26 오후 4:13:34
-- 마지막으로 수정한 날짜 : 2016-03-14 오전 10:27:19
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_INFO (
    BRD_ID             VARCHAR(32) NOT NULL, 
    TBL_NM             VARCHAR(32) NOT NULL, 
    BRD_NM             VARCHAR(256) NOT NULL, 
    MU_SITE            CHAR(10) NOT NULL DEFAULT ('CDIDX00002'), 
    MU_LANG            CHAR(10) NOT NULL DEFAULT ('CDIDX00022'), 
    BRD_DFT            VARCHAR(256), 
    BRD_DFT_SKIN       CHAR(1) NOT NULL DEFAULT ('A'), 
    BRD_CUST_SKIN      VARCHAR(16), 
    BRD_GB             CHAR(10) NOT NULL DEFAULT ('CDIDX00042'), 
    BRD_GB_SUB         CHAR(1) NOT NULL DEFAULT ('A'), 
    EDITOR_GB          CHAR(1) NOT NULL DEFAULT ('A'), 
    USE_CTGRY          CHAR(1) NOT NULL DEFAULT ('N'), 
    CTGRY_IDX          VARCHAR(16), 
    USE_NOTICE         CHAR(1) NOT NULL DEFAULT ('N'), 
    USE_SCRT           CHAR(1) NOT NULL DEFAULT ('N'), 
    USE_RCMND          CHAR(1) NOT NULL DEFAULT ('N'), 
    USE_RJCT           CHAR(1) NOT NULL DEFAULT ('N'), 
    USE_ATCH           CHAR(1) NOT NULL DEFAULT ('Y'), 
    USE_UPLOADIFY      CHAR(1) NOT NULL DEFAULT ('Y'), 
    USE_KOGL           CHAR(1) NOT NULL DEFAULT ('N'), 
    REPLY_GB           CHAR(1) NOT NULL DEFAULT ('N'), 
    ATTACH_CNT_LIMIT   INT DEFAULT ((1)), 
    ATTACH_SIZE_LIMIT  INT DEFAULT ((20)), 
    ATCL_PER_PG        INT DEFAULT ((15)), 
    PG_PER_NAVI        INT DEFAULT ((10)), 
    ON_VIEWMODE        CHAR(1) DEFAULT ('2'), 
    OFF_VIEWMODE       CHAR(1) DEFAULT ('1'), 
    CREATE_NEW_TABLE   CHAR(1) DEFAULT ('N'), 
    REF_MENU_NIX       VARCHAR(8), 
    BRD_AUTH_USR       VARCHAR(256), 
    INFO_CONT          VARCHAR(MAX), 
    WRITER             VARCHAR(24), 
    WDT                DATETIME DEFAULT (getdate()), 
    MODIFIER           VARCHAR(24), 
    MDT                DATETIME, 
 CONSTRAINT PK_CMS_BRD_INFO 
   PRIMARY KEY CLUSTERED (BRD_ID ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[게시판] 게시판 정보', N'schema', N'DBO', N'table', N'CMS_BRD_INFO';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 번호', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'테이블 명', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'TBL_NM';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 명', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'BRD_NM';

EXEC sp_addextendedproperty N'MS_Description', N'사이트구분 [코드 참조]', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'MU_SITE';

EXEC sp_addextendedproperty N'MS_Description', N'언어구분 [코드 참조]', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'MU_LANG';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 설명', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'BRD_DFT';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 기본 스킨', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'BRD_DFT_SKIN';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 사용자 정의 스킨', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'BRD_CUST_SKIN';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 구분 [코드 참조]', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'BRD_GB';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 마이너 구분', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'BRD_GB_SUB';

EXEC sp_addextendedproperty N'MS_Description', N'에디터 구분 (CLEDITOR, ELRTE)', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'EDITOR_GB';

EXEC sp_addextendedproperty N'MS_Description', N'카테고리 사용여부', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'USE_CTGRY';

EXEC sp_addextendedproperty N'MS_Description', N'카테고리 ID (사용할 경우)', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'CTGRY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'공지사항포함 여부', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'USE_NOTICE';

EXEC sp_addextendedproperty N'MS_Description', N'비밀글 사용 여부 (관리자와 본인만 조회 가능)', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'USE_SCRT';

EXEC sp_addextendedproperty N'MS_Description', N'게시물 추천 사용 여부', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'USE_RCMND';

EXEC sp_addextendedproperty N'MS_Description', N'게시물 반대 사용 여부', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'USE_RJCT';

EXEC sp_addextendedproperty N'MS_Description', N'첨부파일 사용 여부', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'USE_ATCH';

EXEC sp_addextendedproperty N'MS_Description', N'파일첨부를 위해 UPLOADIFY를 사용할지 여부 (사용하지 않으면 일반 폼 컨트롤사용)', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'USE_UPLOADIFY';

EXEC sp_addextendedproperty N'MS_Description', N'공공누리 적용 여부', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'USE_KOGL';

EXEC sp_addextendedproperty N'MS_Description', N'[A|R|N] A : 계단식 답글 형 게시판, R : 댓글형 게시판,  B : 답글 + 댓글, N : 댓글 없음', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'REPLY_GB';

EXEC sp_addextendedproperty N'MS_Description', N'첨부파일 개수 제한 [0: 제한없음]', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'ATTACH_CNT_LIMIT';

EXEC sp_addextendedproperty N'MS_Description', N'첨부파일 크기 제한', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'ATTACH_SIZE_LIMIT';

EXEC sp_addextendedproperty N'MS_Description', N'페이지당 게시물 개수', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'ATCL_PER_PG';

EXEC sp_addextendedproperty N'MS_Description', N'페이지 네비 개수', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'PG_PER_NAVI';

EXEC sp_addextendedproperty N'MS_Description', N'로그인한 사용자에 대한 공개 방식', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'ON_VIEWMODE';

EXEC sp_addextendedproperty N'MS_Description', N'로그인하지 않은 사용자에 대한 공개방', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'OFF_VIEWMODE';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 전용 테이블 생성 여부', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'CREATE_NEW_TABLE';

EXEC sp_addextendedproperty N'MS_Description', N'연결된 메뉴의 IDX', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'REF_MENU_NIX';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 관리자 목록 -> [ , ] 로 구분된 ID 문자열', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'BRD_AUTH_USR';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 컨텐츠', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'INFO_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_BRD_INFO', N'column', N'MDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_NWS_IDX_M3KMB33X
-- 만든 날짜 : 2015-03-17 오전 9:17:27
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:27
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_NWS_IDX_M3KMB33X (
    BRD_ID     VARCHAR(32) NOT NULL, 
    CONT_IDX   INT NOT NULL, 
    CTGRY_IDX  VARCHAR(16), 
    SUBJECT    VARCHAR(512) NOT NULL, 
    NEWS_LINK  VARCHAR(512) NOT NULL, 
    WRITER     VARCHAR(24), 
    WDT        DATETIME, 
    MODIFIER   VARCHAR(24), 
    MDT        DATETIME, 
 CONSTRAINT PK_CMS_BRD_NWS_IDX_M3KMB33X 
   PRIMARY KEY CLUSTERED (BRD_ID ASC, CONT_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[게시판] 뉴스링크 게시판 컨텐츠', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 번호', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'게시물 순번', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'CONT_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'카테고리', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'CTGRY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'제목', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'SUBJECT';

EXEC sp_addextendedproperty N'MS_Description', N'뉴스링크', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'NEWS_LINK';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_BRD_NWS_IDX_M3KMB33X', N'column', N'MDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_RCMND
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_RCMND (
    RCMND_IDX  INT NOT NULL, 
    BRD_ID     VARCHAR(32), 
    CONT_IDX   INT, 
    RCMND_ID   VARCHAR(24), 
    RCMND_GB   CHAR(1), 
    RDT        DATETIME, 
 CONSTRAINT PK_CMS_BRD_RCMND 
   PRIMARY KEY CLUSTERED (RCMND_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[게시판] 게시판 추천/반대 데이터', N'schema', N'DBO', N'table', N'CMS_BRD_RCMND';

EXEC sp_addextendedproperty N'MS_Description', N'순번', N'schema', N'DBO', N'table', N'CMS_BRD_RCMND', N'column', N'RCMND_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 ID', N'schema', N'DBO', N'table', N'CMS_BRD_RCMND', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'게시물순번', N'schema', N'DBO', N'table', N'CMS_BRD_RCMND', N'column', N'CONT_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'추천인/ 반대인 ID', N'schema', N'DBO', N'table', N'CMS_BRD_RCMND', N'column', N'RCMND_ID';

EXEC sp_addextendedproperty N'MS_Description', N'추천:R/반대:J 구분', N'schema', N'DBO', N'table', N'CMS_BRD_RCMND', N'column', N'RCMND_GB';

EXEC sp_addextendedproperty N'MS_Description', N'추천/반대 일시', N'schema', N'DBO', N'table', N'CMS_BRD_RCMND', N'column', N'RDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_REPLY_IDX_CF68M3GZ
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_REPLY_IDX_CF68M3GZ (
    BRD_ID      VARCHAR(32) NOT NULL, 
    CONT_IDX    INT NOT NULL, 
    REPLY_IDX   INT NOT NULL, 
    REPLY_CONT  VARCHAR(4000), 
    RCMND_CNT   INT, 
    WRITER      VARCHAR(24), 
    WDT         DATETIME, 
    MODIFIER    VARCHAR(24), 
    MDT         DATETIME, 
 CONSTRAINT PK_CMS_BRD_REPLY_IDX_CF68M3GZ 
   PRIMARY KEY CLUSTERED (BRD_ID ASC, CONT_IDX ASC, REPLY_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[게시판] 이미지 게시판 댓글', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 번호', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'게시물 순번', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'CONT_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'댓글 순번', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'REPLY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'내용', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'REPLY_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'추천수', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'RCMND_CNT';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_CF68M3GZ', N'column', N'MDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_REPLY_IDX_VXD5L880
-- 만든 날짜 : 2015-03-17 오전 9:17:28
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:28
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_REPLY_IDX_VXD5L880 (
    BRD_ID      VARCHAR(32) NOT NULL, 
    CONT_IDX    INT NOT NULL, 
    REPLY_IDX   INT NOT NULL, 
    REPLY_CONT  VARCHAR(4000), 
    RCMND_CNT   INT, 
    WRITER      VARCHAR(24), 
    WDT         DATETIME, 
    MODIFIER    VARCHAR(24), 
    MDT         DATETIME, 
    BRD_PWD     VARCHAR(128), 
 CONSTRAINT PK_CMS_BRD_REPLY_IDX_VXD5L880 
   PRIMARY KEY CLUSTERED (BRD_ID ASC, CONT_IDX ASC, REPLY_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 접근 IP', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 번호', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'게시물 순번', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'CONT_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'댓글 순번', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'REPLY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'내용', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'REPLY_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'추천수', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'RCMND_CNT';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'MDT';

EXEC sp_addextendedproperty N'MS_Description', N'댓글비밀번호', N'schema', N'DBO', N'table', N'CMS_BRD_REPLY_IDX_VXD5L880', N'column', N'BRD_PWD';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_THM_IDX_CF68M3GZ
-- 만든 날짜 : 2015-03-17 오전 9:17:29
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:29
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_THM_IDX_CF68M3GZ (
    BRD_ID       VARCHAR(32) NOT NULL, 
    CONT_IDX     INT NOT NULL, 
    SUBJECT      VARCHAR(512), 
    BRD_CONT     VARCHAR(MAX), 
    BRD_UTB      VARCHAR(512), 
    IMG_IDX      INT DEFAULT ((0)), 
    THM_IMG_IDX  INT DEFAULT ((0)), 
    HITS         INT, 
    IS_NOTICE    CHAR(1) DEFAULT ('N'), 
    WRITER       VARCHAR(24), 
    WDT          DATETIME, 
    MODIFIER     VARCHAR(24), 
    MDT          DATETIME, 
 CONSTRAINT PK_CMS_BRD_THM_IDX_CF68M3GZ 
   PRIMARY KEY CLUSTERED (BRD_ID ASC, CONT_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[게시판] 이미지(썸네일) 게시판 컨텐츠', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 번호', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'게시물 순번', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'CONT_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'제목', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'SUBJECT';

EXEC sp_addextendedproperty N'MS_Description', N'내용', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'BRD_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'유튜브 링크', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'BRD_UTB';

EXEC sp_addextendedproperty N'MS_Description', N'이미지 파일 번호', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'IMG_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'썸네일 이미지 파일 번호', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'THM_IMG_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'조회수', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'HITS';

EXEC sp_addextendedproperty N'MS_Description', N'공지사항 여부', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'IS_NOTICE';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_BRD_THM_IDX_CF68M3GZ', N'column', N'MDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_BRD_TXT_IDX_VXD5L880
-- 만든 날짜 : 2015-03-17 오전 9:17:30
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_BRD_TXT_IDX_VXD5L880 (
    BRD_ID       VARCHAR(32) NOT NULL, 
    CONT_IDX     INT NOT NULL, 
    CTGRY_IDX    VARCHAR(16), 
    SUBJECT      VARCHAR(512) NOT NULL, 
    BRD_CONT     VARCHAR(MAX) NOT NULL, 
    HITS         INT, 
    GRP_NO       INT, 
    GRP_LV       INT, 
    GRP_ORD      INT, 
    IS_NOTICE    CHAR(1) DEFAULT ('N'), 
    IS_SCRT      CHAR(1) DEFAULT ('N'), 
    ADD_INFO_01  VARCHAR(128), 
    ADD_INFO_02  VARCHAR(128), 
    ADD_INFO_03  VARCHAR(128), 
    ADD_INFO_04  VARCHAR(512), 
    ADD_INFO_05  VARCHAR(1024), 
    WRITER       VARCHAR(24), 
    WDT          DATETIME, 
    MODIFIER     VARCHAR(24), 
    MDT          DATETIME, 
    KOGL         VARCHAR(16), 
 CONSTRAINT PK_CMS_BRD_TXT_IDX_VXD5L880 
   PRIMARY KEY CLUSTERED (BRD_ID ASC, CONT_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[게시판] 텍스트 게시판 컨텐츠', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880';

EXEC sp_addextendedproperty N'MS_Description', N'게시판 번호', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'BRD_ID';

EXEC sp_addextendedproperty N'MS_Description', N'게시물 순번', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'CONT_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'카테고리', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'CTGRY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'제목', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'SUBJECT';

EXEC sp_addextendedproperty N'MS_Description', N'내용', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'BRD_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'조회수', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'HITS';

EXEC sp_addextendedproperty N'MS_Description', N'그룹번호', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'GRP_NO';

EXEC sp_addextendedproperty N'MS_Description', N'그룹레벨', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'GRP_LV';

EXEC sp_addextendedproperty N'MS_Description', N'그룹순번', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'GRP_ORD';

EXEC sp_addextendedproperty N'MS_Description', N'공지 여부', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'IS_NOTICE';

EXEC sp_addextendedproperty N'MS_Description', N'비밀글 여부', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'IS_SCRT';

EXEC sp_addextendedproperty N'MS_Description', N'추가정보 1', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'ADD_INFO_01';

EXEC sp_addextendedproperty N'MS_Description', N'추가정보 2', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'ADD_INFO_02';

EXEC sp_addextendedproperty N'MS_Description', N'추가정보 3', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'ADD_INFO_03';

EXEC sp_addextendedproperty N'MS_Description', N'추가정보 4', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'ADD_INFO_04';

EXEC sp_addextendedproperty N'MS_Description', N'추가정보 5', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'ADD_INFO_05';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'MDT';

EXEC sp_addextendedproperty N'MS_Description', N'공공누리 저작권 코드', N'schema', N'DBO', N'table', N'CMS_BRD_TXT_IDX_VXD5L880', N'column', N'KOGL';


/* 2018-05-18 CMS_BRD_TXT_IDX_FAD1X223 추가*/
CREATE TABLE CMS_BRD_TXT_IDX_FAD1X223 (
    BRD_ID       VARCHAR(32) NOT NULL, 
    CONT_IDX     INT NOT NULL, 
    CTGRY_IDX    VARCHAR(16), 
    SUBJECT      VARCHAR(512) NOT NULL, 
    BRD_CONT     VARCHAR(MAX) NOT NULL, 
    HITS         INT, 
    GRP_NO       INT, 
    GRP_LV       INT, 
    GRP_ORD      INT, 
    IS_NOTICE    CHAR(1) DEFAULT ('N'), 
    IS_SCRT      CHAR(1) DEFAULT ('N'), 
    ADD_INFO_01  VARCHAR(128), 
    ADD_INFO_02  VARCHAR(128), 
    ADD_INFO_03  VARCHAR(128), 
    ADD_INFO_04  VARCHAR(512), 
    ADD_INFO_05  VARCHAR(1024), 
    WRITER       VARCHAR(24), 
    WDT          DATETIME, 
    MODIFIER     VARCHAR(24), 
    MDT          DATETIME, 
    KOGL         VARCHAR(16), 
 CONSTRAINT PK_CMS_BRD_TXT_IDX_FAD1X223
   PRIMARY KEY CLUSTERED (BRD_ID ASC, CONT_IDX ASC)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_COMM_STAT
-- 만든 날짜 : 2015-03-17 오전 9:17:31
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_COMM_STAT (
    STAT_KEY      VARCHAR(32) NOT NULL, 
    STAT_SESSID   VARCHAR(64) NOT NULL, 
    STAT_KEY_NM   VARCHAR(64), 
    STAT_CITY     VARCHAR(32), 
    STAT_NAT      VARCHAR(32), 
    STAT_NAT_CD   VARCHAR(6), 
    STAT_OS       VARCHAR(16), 
    STAT_BW       VARCHAR(16), 
    STAT_REFERER  VARCHAR(256), 
    STAT_DT       DATETIME, 
    STAT_RADDR    VARCHAR(32), 
    STAT_UID      VARCHAR(24), 
    CONTACT_CNT   BIGINT NOT NULL DEFAULT ((1)), 
 CONSTRAINT PK_CMS_COMM_STAT 
   PRIMARY KEY CLUSTERED (STAT_KEY ASC, STAT_SESSID ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 통계테이블', N'schema', N'DBO', N'table', N'CMS_COMM_STAT';

EXEC sp_addextendedproperty N'MS_Description', N'통계 KEY', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_KEY';

EXEC sp_addextendedproperty N'MS_Description', N'세션 ID', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_SESSID';

EXEC sp_addextendedproperty N'MS_Description', N'통계 KEY 설명', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_KEY_NM';

EXEC sp_addextendedproperty N'MS_Description', N'도시', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_CITY';

EXEC sp_addextendedproperty N'MS_Description', N'국가', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_NAT';

EXEC sp_addextendedproperty N'MS_Description', N'국가코드', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_NAT_CD';

EXEC sp_addextendedproperty N'MS_Description', N'운영체제 종류', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_OS';

EXEC sp_addextendedproperty N'MS_Description', N'브라우저 종류', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_BW';

EXEC sp_addextendedproperty N'MS_Description', N'이전페이지 링크', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_REFERER';

EXEC sp_addextendedproperty N'MS_Description', N'기록일', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_DT';

EXEC sp_addextendedproperty N'MS_Description', N'주소', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_RADDR';

EXEC sp_addextendedproperty N'MS_Description', N'UID', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'STAT_UID';

EXEC sp_addextendedproperty N'MS_Description', N'접속 횟수', N'schema', N'DBO', N'table', N'CMS_COMM_STAT', N'column', N'CONTACT_CNT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_MAN_LOG
-- 만든 날짜 : 2015-03-17 오전 9:17:32
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:32
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_MAN_LOG (
    LOG_IDX       INT NOT NULL, 
    LOG_KEY       VARCHAR(32) NOT NULL, 
    LOG_KEY_NM    VARCHAR(64), 
    LOG_KEY_DEST  VARCHAR(1024), 
    LOG_JOB_GB    CHAR(1), 
    LOG_RADDR     VARCHAR(32), 
    LOG_UID       VARCHAR(24), 
    LOG_DT        DATETIME, 
 CONSTRAINT PK_CMS_MAN_LOG 
   PRIMARY KEY CLUSTERED (LOG_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 관리자 로그', N'schema', N'DBO', N'table', N'CMS_MAN_LOG';

EXEC sp_addextendedproperty N'MS_Description', N'일련번호', N'schema', N'DBO', N'table', N'CMS_MAN_LOG', N'column', N'LOG_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'로그 KEY', N'schema', N'DBO', N'table', N'CMS_MAN_LOG', N'column', N'LOG_KEY';

EXEC sp_addextendedproperty N'MS_Description', N'로그 KEY 설명', N'schema', N'DBO', N'table', N'CMS_MAN_LOG', N'column', N'LOG_KEY_NM';

EXEC sp_addextendedproperty N'MS_Description', N'로그 상세', N'schema', N'DBO', N'table', N'CMS_MAN_LOG', N'column', N'LOG_KEY_DEST';

EXEC sp_addextendedproperty N'MS_Description', N'작업구분', N'schema', N'DBO', N'table', N'CMS_MAN_LOG', N'column', N'LOG_JOB_GB';

EXEC sp_addextendedproperty N'MS_Description', N'IP 주소', N'schema', N'DBO', N'table', N'CMS_MAN_LOG', N'column', N'LOG_RADDR';

EXEC sp_addextendedproperty N'MS_Description', N'행위자 ID', N'schema', N'DBO', N'table', N'CMS_MAN_LOG', N'column', N'LOG_UID';

EXEC sp_addextendedproperty N'MS_Description', N'기록일', N'schema', N'DBO', N'table', N'CMS_MAN_LOG', N'column', N'LOG_DT';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_MENU_AUTH
-- 만든 날짜 : 2015-03-17 오전 9:17:33
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:33
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_MENU_AUTH (
    AUTH_CD   CHAR(5) NOT NULL, 
    MENU_IDX  VARCHAR(16) NOT NULL, 
    AUTH_YN   CHAR(1) NOT NULL DEFAULT ('Y'), 
    WRITER    VARCHAR(24), 
    WDT       DATETIME, 
    MODIFIER  VARCHAR(24), 
    MDT       DATETIME, 
 CONSTRAINT PK_CMS_MENU_AUTH 
   PRIMARY KEY CLUSTERED (AUTH_CD ASC, MENU_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 권한별 사용가능 메뉴', N'schema', N'DBO', N'table', N'CMS_MENU_AUTH';

EXEC sp_addextendedproperty N'MS_Description', N'권한코드', N'schema', N'DBO', N'table', N'CMS_MENU_AUTH', N'column', N'AUTH_CD';

EXEC sp_addextendedproperty N'MS_Description', N'메뉴 ID', N'schema', N'DBO', N'table', N'CMS_MENU_AUTH', N'column', N'MENU_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'사용가능 여부', N'schema', N'DBO', N'table', N'CMS_MENU_AUTH', N'column', N'AUTH_YN';

EXEC sp_addextendedproperty N'MS_Description', N'등록자', N'schema', N'DBO', N'table', N'CMS_MENU_AUTH', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'등록일', N'schema', N'DBO', N'table', N'CMS_MENU_AUTH', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_MENU_AUTH', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일시', N'schema', N'DBO', N'table', N'CMS_MENU_AUTH', N'column', N'MDT';





/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_POPUP
-- 만든 날짜 : 2015-03-17 오전 9:17:33
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_POPUP (
    POP_SEQ      BIGINT NOT NULL, 
    POP_TITLE    VARCHAR(200) NOT NULL, 
    POP_TYPE     CHAR(1) NOT NULL, 
    POP_FROM     VARCHAR(10), 
    POP_TO       VARCHAR(10), 
    POP_W        VARCHAR(10), 
    POP_H        VARCHAR(10), 
    POP_CONTENT  VARCHAR(4000), 
    POP_IMAGE    VARCHAR(200), 
    POP_LINK     VARCHAR(250), 
    POP_TARGET   VARCHAR(10), 
    USE_YN       CHAR(1) NOT NULL, 
    WRITER       VARCHAR(24) NOT NULL, 
    WDT          DATETIME NOT NULL, 
    POP_X        VARCHAR(5), 
    POP_Y        VARCHAR(5), 
    POP_ALT      VARCHAR(250), 
    POP_SORT     BIGINT, 
 CONSTRAINT PK_CMS_POPUP 
   PRIMARY KEY CLUSTERED (POP_SEQ ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 팝업/팝업존', N'schema', N'DBO', N'table', N'CMS_POPUP';

EXEC sp_addextendedproperty N'MS_Description', N'순번', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_SEQ';

EXEC sp_addextendedproperty N'MS_Description', N'제목', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_TITLE';

EXEC sp_addextendedproperty N'MS_Description', N'구분(W:창팝업/Z:팝업존)', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_TYPE';

EXEC sp_addextendedproperty N'MS_Description', N'게시 시작일자', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_FROM';

EXEC sp_addextendedproperty N'MS_Description', N'게시 종료일자', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_TO';

EXEC sp_addextendedproperty N'MS_Description', N'팝업 너비', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_W';

EXEC sp_addextendedproperty N'MS_Description', N'팝업 높이', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_H';

EXEC sp_addextendedproperty N'MS_Description', N'팝업 내용 - 텍스트', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_CONTENT';

EXEC sp_addextendedproperty N'MS_Description', N'팝업 내용 - 이미지', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_IMAGE';

EXEC sp_addextendedproperty N'MS_Description', N'팝업 링크 URL', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_LINK';

EXEC sp_addextendedproperty N'MS_Description', N'링크 target', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_TARGET';

EXEC sp_addextendedproperty N'MS_Description', N'사용 여부', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'USE_YN';

EXEC sp_addextendedproperty N'MS_Description', N'등록자ID', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'등록일시', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'팝업 x좌표', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_X';

EXEC sp_addextendedproperty N'MS_Description', N'팝업 y좌표', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_Y';

EXEC sp_addextendedproperty N'MS_Description', N'팝업 이미지 alt 속성값', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_ALT';

EXEC sp_addextendedproperty N'MS_Description', N'정렬값', N'schema', N'DBO', N'table', N'CMS_POPUP', N'column', N'POP_SORT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_AUTH
-- 만든 날짜 : 2015-03-17 오전 9:17:34
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_AUTH (
    AUTH_CD     CHAR(5) NOT NULL, 
    UP_AUTH_CD  CHAR(5), 
    AUTH_NM     VARCHAR(32), 
    AUTH_LV     INT, 
    AUTH_ORD    INT, 
    USE_YN      CHAR(1) NOT NULL DEFAULT ('Y'), 
    WRITER      VARCHAR(24), 
    WDT         DATETIME NOT NULL DEFAULT (getdate()), 
    MODIFIER    VARCHAR(24), 
    MDT         DATETIME, 
 CONSTRAINT PK_CMS_SYS_AUTH 
   PRIMARY KEY CLUSTERED (AUTH_CD ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 사용자 권한', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH';

EXEC sp_addextendedproperty N'MS_Description', N'권한코드', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'AUTH_CD';

EXEC sp_addextendedproperty N'MS_Description', N'상위 권한 코드', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'UP_AUTH_CD';

EXEC sp_addextendedproperty N'MS_Description', N'권한명', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'AUTH_NM';

EXEC sp_addextendedproperty N'MS_Description', N'권한 레벨', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'AUTH_LV';

EXEC sp_addextendedproperty N'MS_Description', N'권한 순서', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'AUTH_ORD';

EXEC sp_addextendedproperty N'MS_Description', N'사용여부', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'USE_YN';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_SYS_AUTH', N'column', N'MDT';




/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_CODE
-- 만든 날짜 : 2015-03-17 오전 9:17:35
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:35
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_SYS_CODE (
    CODE_IDX     VARCHAR(16) NOT NULL, 
    UP_CODE_IDX  VARCHAR(16), 
    CODE_NM      VARCHAR(128) NOT NULL, 
    CODE_ORD     INT, 
    USE_YN       CHAR(1) NOT NULL DEFAULT ('Y'), 
    WRITER       VARCHAR(24), 
    WDT          DATETIME NOT NULL DEFAULT (getdate()), 
    MODIFIER     VARCHAR(24), 
    MDT          DATETIME, 
 CONSTRAINT PK_CMS_SYS_CODE 
   PRIMARY KEY CLUSTERED (CODE_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 코드 관리', N'schema', N'DBO', N'table', N'CMS_SYS_CODE';

EXEC sp_addextendedproperty N'MS_Description', N'코드 ID', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'CODE_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'상위코드 ID', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'UP_CODE_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'코드 명', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'CODE_NM';

EXEC sp_addextendedproperty N'MS_Description', N'코드 순서', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'CODE_ORD';

EXEC sp_addextendedproperty N'MS_Description', N'사용여부', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'USE_YN';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_SYS_CODE', N'column', N'MDT';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_CTGRY
-- 만든 날짜 : 2015-03-17 오전 9:17:35
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:35
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_SYS_CTGRY (
    CTGRY_IDX     VARCHAR(16) NOT NULL, 
    UP_CTGRY_IDX  VARCHAR(16), 
    CTGRY_NM      VARCHAR(128) NOT NULL, 
    CTGRY_ORD     INT, 
    USE_YN        CHAR(1) NOT NULL DEFAULT ('Y'), 
    WRITER        VARCHAR(24), 
    WDT           DATETIME NOT NULL DEFAULT (getdate()), 
    MODIFIER      VARCHAR(24), 
    MDT           DATETIME, 
 CONSTRAINT PK_CMS_SYS_CTGRY 
   PRIMARY KEY CLUSTERED (CTGRY_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 카테고리 관리', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY';

EXEC sp_addextendedproperty N'MS_Description', N'카테고리 ID', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'CTGRY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'상위카테고리 ID', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'UP_CTGRY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'카테고리 명', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'CTGRY_NM';

EXEC sp_addextendedproperty N'MS_Description', N'카테고리 순서', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'CTGRY_ORD';

EXEC sp_addextendedproperty N'MS_Description', N'사용여부', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'USE_YN';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_SYS_CTGRY', N'column', N'MDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_MENU
-- 만든 날짜 : 2015-03-17 오전 9:17:36
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:36
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_SYS_MENU (
    MENU_IDX          VARCHAR(16) NOT NULL, 
    UP_MENU_IDX       VARCHAR(16), 
    MENU_NM           VARCHAR(64) NOT NULL, 
    MENU_NIX          VARCHAR(8) NOT NULL, 
    MENU_LINK         VARCHAR(256), 
    MENU_ORD          INT, 
    MENU_IMG_PATH     VARCHAR(128), 
    LEFT_IMG_PATH     VARCHAR(128), 
    TITLE_IMG_PATH    VARCHAR(128), 
    SITEMAP_IMG_PATH  VARCHAR(128), 
    INFO01_IMG_PATH   VARCHAR(128), 
    INFO02_IMG_PATH   VARCHAR(128), 
    MU_GUB            CHAR(3) DEFAULT ('USR'), 
    MU_SITE           CHAR(10) DEFAULT ('CDIDX00002'), 
    MU_LANG           CHAR(10) DEFAULT ('CDIDX00022'), 
    BLANK_YN          CHAR(1) NOT NULL DEFAULT ('N'), 
    TABMENU_YN        CHAR(1) NOT NULL DEFAULT ('N'), 
    MEMMENU_YN        CHAR(1) NOT NULL DEFAULT ('N'), 
    USE_YN            CHAR(1) NOT NULL DEFAULT ('Y'), 
    WRITER            VARCHAR(24), 
    WDT               DATETIME NOT NULL DEFAULT (getdate()), 
    MODIFIER          VARCHAR(24), 
    MDT               DATETIME, 
    OWN_INFO          VARCHAR(512), 
 CONSTRAINT PK_CMS_SYS_MENU 
   PRIMARY KEY CLUSTERED (MENU_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 메뉴 관리', N'schema', N'DBO', N'table', N'CMS_SYS_MENU';

EXEC sp_addextendedproperty N'MS_Description', N'메뉴 ID', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MENU_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'상위메뉴 ID', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'UP_MENU_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'메뉴 명', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MENU_NM';

EXEC sp_addextendedproperty N'MS_Description', N'메뉴 코드', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MENU_NIX';

EXEC sp_addextendedproperty N'MS_Description', N'메뉴 링크', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MENU_LINK';

EXEC sp_addextendedproperty N'MS_Description', N'메뉴 순서', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MENU_ORD';

EXEC sp_addextendedproperty N'MS_Description', N'메인메뉴 이미지 경로 [이미지를 사용할 경우]', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MENU_IMG_PATH';

EXEC sp_addextendedproperty N'MS_Description', N'레프트메뉴 이미지 경로', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'LEFT_IMG_PATH';

EXEC sp_addextendedproperty N'MS_Description', N'타이틀 이미지 경로', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'TITLE_IMG_PATH';

EXEC sp_addextendedproperty N'MS_Description', N'사이트맵 이미지 경로', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'SITEMAP_IMG_PATH';

EXEC sp_addextendedproperty N'MS_Description', N'기타 이미지 경로 1', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'INFO01_IMG_PATH';

EXEC sp_addextendedproperty N'MS_Description', N'기타 이미지 경로 2', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'INFO02_IMG_PATH';

EXEC sp_addextendedproperty N'MS_Description', N'관리자/사용자 구분 [MAN : 관리자 / USR : 사용자]', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MU_GUB';

EXEC sp_addextendedproperty N'MS_Description', N'사이트 구분 (대표웹 / 모바일 / 서브사이트)', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MU_SITE';

EXEC sp_addextendedproperty N'MS_Description', N'언어 구분', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MU_LANG';

EXEC sp_addextendedproperty N'MS_Description', N'새창열기 여부', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'BLANK_YN';

EXEC sp_addextendedproperty N'MS_Description', N'탭메뉴 여부', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'TABMENU_YN';

EXEC sp_addextendedproperty N'MS_Description', N'사용자 메뉴 여부 (상단 메뉴에 나타나지 않는 회원가입, 이용약관 등의 사이트 메뉴)', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MEMMENU_YN';

EXEC sp_addextendedproperty N'MS_Description', N'사용여부', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'USE_YN';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'MDT';

EXEC sp_addextendedproperty N'MS_Description', N'제공부서, 담당자, 전화번호 등 정보', N'schema', N'DBO', N'table', N'CMS_SYS_MENU', N'column', N'OWN_INFO';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_USR_CONTENTS
-- 만든 날짜 : 2015-03-18 오후 2:06:33
-- 마지막으로 수정한 날짜 : 2015-03-18 오후 2:06:33
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_USR_CONTENTS (
    UCONT_ID        VARCHAR(32) NOT NULL, 
    UCONT_VERSION   INT NOT NULL, 
    UCONT_SUBJECT   VARCHAR(512) NOT NULL, 
    UCONT_DFT       VARCHAR(512) NOT NULL, 
    UCONT_CSS       VARCHAR(4000), 
    UCONT_CONT      VARCHAR(MAX) NOT NULL, 
    ALTER_IMG_ATCH  CHAR(1) NOT NULL DEFAULT ('N'), 
    MU_SITE         CHAR(10) NOT NULL DEFAULT ('CDIDX00002'), 
    MU_LANG         CHAR(10) NOT NULL DEFAULT ('CDIDX00022'), 
    REF_MENU_NIX    VARCHAR(8), 
    WRITER          VARCHAR(24), 
    WDT             DATETIME DEFAULT (getdate()), 
    MODIFIER        VARCHAR(24), 
    MDT             DATETIME, 
 CONSTRAINT PK_CMS_USR_CONTENTS 
   PRIMARY KEY CLUSTERED (UCONT_ID ASC, UCONT_VERSION ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 사용자 추가 컨텐츠', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS';

EXEC sp_addextendedproperty N'MS_Description', N'컨텐츠 ID', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'UCONT_ID';

EXEC sp_addextendedproperty N'MS_Description', N'컨텐츠 버전', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'UCONT_VERSION';

EXEC sp_addextendedproperty N'MS_Description', N'컨텐츠 제목', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'UCONT_SUBJECT';

EXEC sp_addextendedproperty N'MS_Description', N'컨텐츠 설명', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'UCONT_DFT';

EXEC sp_addextendedproperty N'MS_Description', N'CSS 정의 [CSS파일 또는 CSS코드]', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'UCONT_CSS';

EXEC sp_addextendedproperty N'MS_Description', N'내용', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'UCONT_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'[Y/N] 컨텐츠 내의 이미지를 (이름이 같은)첨부파일로 대체', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'ALTER_IMG_ATCH';

EXEC sp_addextendedproperty N'MS_Description', N'사이트 구분 (대표웹 / 모바일 / 서브사이트)', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'MU_SITE';

EXEC sp_addextendedproperty N'MS_Description', N'언어 구분', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'MU_LANG';

EXEC sp_addextendedproperty N'MS_Description', N'연결된 메뉴의 IDX', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'REF_MENU_NIX';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_USR_CONTENTS', N'column', N'MDT';

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_USR_INFO
-- 만든 날짜 : 2015-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_USR_INFO (
    USER_ID        VARCHAR(24) NOT NULL, 
    USER_SCRT      VARCHAR(128) NOT NULL, 
    USER_NM        VARCHAR(24) NOT NULL, 
    USER_EMAIL     VARCHAR(128), 
    USER_BIRTH     VARCHAR(10), 
    USER_CP_1      VARCHAR(12), 
    USER_CP_2      VARCHAR(12), 
    USER_CP_3      VARCHAR(12), 
    USER_TEL_1     VARCHAR(12), 
    USER_TEL_2     VARCHAR(12), 
    USER_TEL_3     VARCHAR(12), 
    USER_ZIP       VARCHAR(10), 
    USER_ADDR_1    VARCHAR(256), 
    USER_ADDR_2    VARCHAR(128), 
    USER_DEPT      VARCHAR(128), 
    USER_GRADE     VARCHAR(128), 
    USER_AUTH_CD   CHAR(5) NOT NULL, 
    MAILING_YN     CHAR(1) NOT NULL DEFAULT ('N'), 
    VALID_YN       CHAR(1) NOT NULL DEFAULT ('Y'), 
    USER_DUP_INFO  VARCHAR(32), 
    USER_NAME_CHK  VARCHAR(32), 
    ALLOW_IP       VARCHAR(24) NOT NULL DEFAULT ('*'), 
    LAST_LOGIN     DATETIME, 
    WRITER         VARCHAR(24), 
    WDT            DATETIME DEFAULT (getdate()), 
    MODIFIER       VARCHAR(24), 
    MDT            DATETIME, 
    USR_LOGO	   VARCHAR(128),
 CONSTRAINT PK_CMS_USR_INFO 
   PRIMARY KEY CLUSTERED (USER_ID ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 사용자 정보', N'schema', N'DBO', N'table', N'CMS_USR_INFO';

EXEC sp_addextendedproperty N'MS_Description', N'아이디', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_ID';

EXEC sp_addextendedproperty N'MS_Description', N'패스워드', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_SCRT';

EXEC sp_addextendedproperty N'MS_Description', N'이름', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_NM';

EXEC sp_addextendedproperty N'MS_Description', N'EMAIL', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_EMAIL';

EXEC sp_addextendedproperty N'MS_Description', N'생년월일', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_BIRTH';

EXEC sp_addextendedproperty N'MS_Description', N'핸드폰 앞자리', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_CP_1';

EXEC sp_addextendedproperty N'MS_Description', N'핸드폰 가운데자리', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_CP_2';

EXEC sp_addextendedproperty N'MS_Description', N'핸드폰 끝자리', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_CP_3';

EXEC sp_addextendedproperty N'MS_Description', N'전화번호 앞자리', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_TEL_1';

EXEC sp_addextendedproperty N'MS_Description', N'전화번호 가운데자리', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_TEL_2';

EXEC sp_addextendedproperty N'MS_Description', N'전화번호 끝자리', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_TEL_3';

EXEC sp_addextendedproperty N'MS_Description', N'우편번호', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_ZIP';

EXEC sp_addextendedproperty N'MS_Description', N'주소1', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_ADDR_1';

EXEC sp_addextendedproperty N'MS_Description', N'주소2', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_ADDR_2';

EXEC sp_addextendedproperty N'MS_Description', N'부서', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_DEPT';

EXEC sp_addextendedproperty N'MS_Description', N'직위/직급', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_GRADE';

EXEC sp_addextendedproperty N'MS_Description', N'사용자 권한코드', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_AUTH_CD';

EXEC sp_addextendedproperty N'MS_Description', N'메일링 서비스 이용여부', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'MAILING_YN';

EXEC sp_addextendedproperty N'MS_Description', N'유효사용자 여부 [사용자 삭제시 N으로 변경]', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'VALID_YN';

EXEC sp_addextendedproperty N'MS_Description', N'중복가입 정보', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_DUP_INFO';

EXEC sp_addextendedproperty N'MS_Description', N'실명인증정보', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'USER_NAME_CHK';

EXEC sp_addextendedproperty N'MS_Description', N'접속허용 IP규칙 [*는 모두 허용]', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'ALLOW_IP';

EXEC sp_addextendedproperty N'MS_Description', N'마지막 접속일시', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'LAST_LOGIN';

EXEC sp_addextendedproperty N'MS_Description', N'등록자', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'등록일', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_USR_INFO', N'column', N'MDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SURVEY_MAIN
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/


CREATE TABLE CMS_SURVEY_MAIN (
    SRVY_IDX        INT NOT NULL, 
    SRVY_NM         VARCHAR(256) NOT NULL, 
    SRVY_CONT       VARCHAR(MAX), 
    SRVY_OPEN_YN    CHAR(1) NOT NULL DEFAULT ('N'), 
    SRVY_START      DATETIME, 
    SRVY_END        DATETIME, 
    SRVY_ALLOW_DUP  CHAR(1) NOT NULL DEFAULT ('Y'), 
    SRVY_MAX_ANS    INT NOT NULL DEFAULT ((0)), 
    WRITER          VARCHAR(24), 
    WDT             DATETIME, 
    MODIFIER        VARCHAR(24), 
    MDT             DATETIME, 
    SRVY_X          VARCHAR(5) DEFAULT ('50'), 
    SRVY_Y          VARCHAR(5) DEFAULT ('50'), 
    SRVY_W          VARCHAR(5) DEFAULT ('460'), 
    SRVY_H          VARCHAR(5) DEFAULT ('370'), 
    SRVY_POP_TYPE   CHAR(1) NOT NULL DEFAULT ('W'), 
 CONSTRAINT PK_CMS_SURVEY_MAIN 
   PRIMARY KEY CLUSTERED (SRVY_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[설문] 설문조사 메인', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN';

EXEC sp_addextendedproperty N'MS_Description', N'설문조사 번호', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'SRVY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'설문조사 명', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'SRVY_NM';

EXEC sp_addextendedproperty N'MS_Description', N'설문조사 내용', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'SRVY_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'현재시점 설문실시 여부[Y/N]', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'SRVY_OPEN_YN';

EXEC sp_addextendedproperty N'MS_Description', N'설문조사 시작일', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'SRVY_START';

EXEC sp_addextendedproperty N'MS_Description', N'설문조사 종료일', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'SRVY_END';

EXEC sp_addextendedproperty N'MS_Description', N'중복응답 허용여부 [Y/N]', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'SRVY_ALLOW_DUP';

EXEC sp_addextendedproperty N'MS_Description', N'선착순 설정 (0 : 제한없음)', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'SRVY_MAX_ANS';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_SURVEY_MAIN', N'column', N'MDT';




/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SURVEY_PART
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SURVEY_PART (
    SRVY_IDX       INT NOT NULL, 
    PART_IDX       INT NOT NULL, 
    PART_NM        VARCHAR(256) NOT NULL, 
    PART_TYPE      VARCHAR(16) NOT NULL, 
    PART_PSN_INFO  VARCHAR(4000), 
    WRITER         VARCHAR(24), 
    WDT            DATETIME, 
    MODIFIER       VARCHAR(24), 
    MDT            DATETIME, 
 CONSTRAINT PK_CMS_SURVEY_PART 
   PRIMARY KEY CLUSTERED (SRVY_IDX ASC, PART_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[설문] 설문조사 파트', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART';

EXEC sp_addextendedproperty N'MS_Description', N'설문조사 번호', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'SRVY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'파트 번호', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'PART_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'파트 명', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'PART_NM';

EXEC sp_addextendedproperty N'MS_Description', N'파트 구분 (개인정보 / 일반파트)', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'PART_TYPE';

EXEC sp_addextendedproperty N'MS_Description', N'개인정보 수집 안내', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'PART_PSN_INFO';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_SURVEY_PART', N'column', N'MDT';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SURVEY_QUESANS
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SURVEY_QUESANS (
    QUES_IDX      INT NOT NULL, 
    QUESANS_IDX   INT NOT NULL DEFAULT ((0)), 
    SRVY_IDX      INT NOT NULL, 
    PART_IDX      INT NOT NULL, 
    QUESANS_TYPE  CHAR(1) NOT NULL DEFAULT ('A'), 
    QUESANS_CONT  VARCHAR(1000) NOT NULL, 
    QUES_TYPE     VARCHAR(16) NOT NULL, 
    ANS_NEED_SPL  CHAR(1) NOT NULL DEFAULT ('N'), 
    ANS_ORD       INT NOT NULL DEFAULT ((0)), 
    WRITER        VARCHAR(24), 
    WDT           DATETIME, 
    MODIFIER      VARCHAR(24), 
    MDT           DATETIME, 
 CONSTRAINT PK_CMS_SURVEY_QUESANS 
   PRIMARY KEY CLUSTERED (QUES_IDX ASC, QUESANS_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[설문] 설문조사 질문/답변', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS';

EXEC sp_addextendedproperty N'MS_Description', N'질문 번호', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'QUES_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'질문내 질문 답변 번호 (설문결과 저장시 답변은 이값을 참조하지 않는다.. 답변값이 중간에 삭제될 수 있기 때문)', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'QUESANS_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'설문조사 번호', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'SRVY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'파트 번호', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'PART_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'질문 / 답변 구분', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'QUESANS_TYPE';

EXEC sp_addextendedproperty N'MS_Description', N'질문 / 답변 내용', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'QUESANS_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'질문 타입', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'QUES_TYPE';

EXEC sp_addextendedproperty N'MS_Description', N'보충답변 (Ex: 기타) 필요여부', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'ANS_NEED_SPL';

EXEC sp_addextendedproperty N'MS_Description', N'답변 번호 (중요! - 답변의 순서는 이 값에 의해 정해지며, 설문 결과 저장시 이 값을 참조한다..)', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'ANS_ORD';

EXEC sp_addextendedproperty N'MS_Description', N'작성자', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'WRITER';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'WDT';

EXEC sp_addextendedproperty N'MS_Description', N'수정자', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'MODIFIER';

EXEC sp_addextendedproperty N'MS_Description', N'수정일', N'schema', N'DBO', N'table', N'CMS_SURVEY_QUESANS', N'column', N'MDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SURVEY_DATA
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SURVEY_DATA (
    DATA_IDX     INT NOT NULL, 
    QUES_IDX     INT NOT NULL, 
    QUESSUB_IDX  INT NOT NULL DEFAULT ((1)), 
    SRVY_IDX     INT NOT NULL, 
    DATA_CONT    VARCHAR(1024) NOT NULL, 
    DATA_SPL     VARCHAR(1024), 
    DATA_ADDR    VARCHAR(64) NOT NULL, 
    WDT          DATETIME, 
 CONSTRAINT PK_CMS_SURVEY_DATA 
   PRIMARY KEY CLUSTERED (DATA_IDX ASC, QUES_IDX ASC, QUESSUB_IDX ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[설문] 설문조사 수집 데이터', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA';

EXEC sp_addextendedproperty N'MS_Description', N'데이터 번호 (설문조사 응답자 일련번호;시퀀스)', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA', N'column', N'DATA_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'질문 번호', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA', N'column', N'QUES_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'서브질문 번호 (만족도 평가 / 선호도선택 의 하위 항목에 사용)', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA', N'column', N'QUESSUB_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'설문 번호', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA', N'column', N'SRVY_IDX';

EXEC sp_addextendedproperty N'MS_Description', N'답변 저장 값', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA', N'column', N'DATA_CONT';

EXEC sp_addextendedproperty N'MS_Description', N'답변 저장 보충 값', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA', N'column', N'DATA_SPL';

EXEC sp_addextendedproperty N'MS_Description', N'답변자 식별값 (IP주소 등)', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA', N'column', N'DATA_ADDR';

EXEC sp_addextendedproperty N'MS_Description', N'작성일', N'schema', N'DBO', N'table', N'CMS_SURVEY_DATA', N'column', N'WDT';



/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SYS_SEQUENCE
-- 만든 날짜 : 2017-05-11 오전 10:40:50
-- 마지막으로 수정한 날짜 : 2015-05-11 오전 10:41:11
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE CMS_SYS_SEQUENCE (
    SEQ_NAME   VARCHAR(30) NOT NULL, 
    SEQ_VALUE  BIGINT NOT NULL, 
    SEQ_INC    INT NOT NULL DEFAULT ((1)), 
 CONSTRAINT PK_CMS_SYS_SEQUENCE 
   PRIMARY KEY CLUSTERED (SEQ_NAME ASC)
);

EXEC sp_addextendedproperty N'MS_Description', N'[시스템] 시퀀스 테이블', N'schema', N'DBO', N'table', N'CMS_SYS_SEQUENCE';

EXEC sp_addextendedproperty N'MS_Description', N'시퀀스 구분명', N'schema', N'DBO', N'table', N'CMS_SYS_SEQUENCE', N'column', N'SEQ_NAME';

EXEC sp_addextendedproperty N'MS_Description', N'시퀀스 값', N'schema', N'DBO', N'table', N'CMS_SYS_SEQUENCE', N'column', N'SEQ_VALUE';

EXEC sp_addextendedproperty N'MS_Description', N'증가값', N'schema', N'DBO', N'table', N'CMS_SYS_SEQUENCE', N'column', N'SEQ_INC';





/*------------------------------------------------------------------------------
-- 개체 이름 : IDX_CMS_BRD_TXT_SUBJECT
-- 만든 날짜 : 2015-03-17 오전 9:17:31
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE INDEX IDX_CMS_BRD_TXT_SUBJECT
ON CMS_BRD_TXT_IDX_VXD5L880 (SUBJECT)
;


/*------------------------------------------------------------------------------
-- 개체 이름 : IDX_CMS_COMM_STAT
-- 만든 날짜 : 2015-03-17 오전 9:17:31
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:31
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE INDEX IDX_CMS_COMM_STAT
ON CMS_COMM_STAT (STAT_UID, STAT_KEY, STAT_SESSID)
;


/*------------------------------------------------------------------------------
-- 개체 이름 : IK_POP_SORT
-- 만든 날짜 : 2015-03-17 오전 9:17:34
-- 마지막으로 수정한 날짜 : 2015-03-17 오전 9:17:34
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE INDEX IDX_CMS_POPUP
ON CMS_POPUP (POP_SORT)
;



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

ALTER TABLE CMS_SURVEY_PART ADD 

	CONSTRAINT FK_CMS_SURVEY_PART_SRVY_IDX 
	FOREIGN KEY (SRVY_IDX)
		REFERENCES CMS_SURVEY_MAIN(SRVY_IDX)
		ON DELETE CASCADE
;
	
ALTER TABLE CMS_SURVEY_QUESANS ADD 

	CONSTRAINT FK_CMS_SURVEY_QUESANS_SRVYPART 
	FOREIGN KEY (SRVY_IDX, PART_IDX)
		REFERENCES CMS_SURVEY_PART(SRVY_IDX, PART_IDX )
		ON DELETE CASCADE
;


ALTER TABLE CMS_SURVEY_QUESANS
ADD CONSTRAINT UNIQ_CMS_SURVEY_QUESANS UNIQUE (QUES_IDX, ANS_ORD);




INSERT INTO CMS_USR_INFO
  (USER_ID, USER_SCRT, USER_NM, USER_EMAIL, USER_BIRTH, USER_CP_1, USER_CP_2, USER_CP_3, USER_TEL_1, USER_TEL_2, USER_TEL_3, USER_ZIP, USER_ADDR_1, USER_ADDR_2, USER_DEPT, USER_GRADE, USER_AUTH_CD, MAILING_YN, VALID_YN, ALLOW_IP, WRITER, WDT)
VALUES
  ('nimdasys', 'sF0VDkoxpaXzKSscJTHDhWTey0zNyZR+Rv9rk2rcsBI=', '시스템관리자', 'ZmZmZjE4NDVAbmF2ZXIuY29t', '20131223', 'MDEw', 'Mjk1NQ==', 'MjIyMg==', 'MDI=', 'MzIxMg==', 'MTIyMQ==', NULL, NULL, 'U0003', NULL, NULL, 'M0001', 'N', 'Y', '*', 'planidev', GETDATE());
INSERT INTO CMS_USR_INFO
  (USER_ID, USER_SCRT, USER_NM, USER_EMAIL, USER_BIRTH, USER_CP_1, USER_CP_2, USER_CP_3, USER_TEL_1, USER_TEL_2, USER_TEL_3, USER_ZIP, USER_ADDR_1, USER_ADDR_2, USER_DEPT, USER_GRADE, USER_AUTH_CD, MAILING_YN, VALID_YN, ALLOW_IP, WRITER, WDT)
VALUES
  ('planidev', 'Vlhsk6ibLW+uOSUanK0pmlpprSAb7IypY/6iCVOHELY=', '관리자', 'YWRtaW5AcGxhbmkuY28ua3I=', '19850621', 'MDEw', 'MTIzNA==', 'Nzc3Nw==', 'MDI=', NULL, NULL, '305-500', '대전 유성구 용산동', '1111', NULL, NULL, 'D0001', 'Y', 'Y', '*', 'planidev', GETDATE());
  
   
  
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00001', NULL, '개발 도구', '81rD8pHA', '/modedv/modedvPage.do?srch_menu_nix=C43NP3ns', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00002', NULL, '사용자 관리', 'zumNR6AM', '/modeur/modeurList.do?srch_menu_nix=DF13IQ59', 2, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00003', NULL, '메뉴관리', '9LR0b1N0', '/menuctgry/sysmenuList.do?srch_menu_nix=k94X9RH9', 3, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00004', NULL, '컨텐츠 관리', 'z0k797D5', '/modedg/modedgList.do?srch_menu_nix=ztPJqjMk', 4, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00005', NULL, '게시판 관리', '794x409U', '/modebd/modebdList.do?srch_menu_nix=wZ311Dfx', 5, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00006', NULL, '통계', 'Ap778PvY', '/modest/modestPage.do?srch_menu_nix=9afxGvI7', 6, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00007', NULL, '기타 관리', 'h92HwHjt', '/menuctgry/syscodeList.do?srch_menu_nix=2u427mHs', 7, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);

INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00008',NULL,'설문 관리','9S3cQy1o','/manact/surveySrvymain/srvymainList.do?srch_menu_nix=Ei12sIt4',11,NULL,NULL,NULL,NULL,NULL,NULL,'MAN','CDIDX00002','CDIDX00022','N','N','N','N','planidev',GETDATE(),NULL,NULL,NULL);

  
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00101', 'MNIDX00001', '개발도구', 'C43NP3ns', '/modedv/modedvPage.do', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00102', 'MNIDX00002', '권한관리', '5jS7h1Vh', '/menuctgry/sysauthList.do', 2, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00103', 'MNIDX00002', '로그관리', 'iI9hxA9k', '/manlog/manlogList.do', 3, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00104', 'MNIDX00002', '사용자 관리', 'DF13IQ59', '/modeur/modeurList.do', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00105', 'MNIDX00003', '관리자 메뉴', 'k94X9RH9', '/menuctgry/sysmenuList.do', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00106', 'MNIDX00003', '사용자 메뉴', 'fCHJYUo1', '/menuctgry/sysmenuList.do?seltab_idx=1', 2, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00107', 'MNIDX00004', '컨텐츠 목록', 'ztPJqjMk', '/modedg/modedgList.do', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00108', 'MNIDX00004', '메뉴연결 보기', 'G0l5opl2', '/modedg/modedgmenuList.do', 2, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00109', 'MNIDX00005', '게시판 목록', 'wZ311Dfx', '/modebd/modebdList.do', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00110', 'MNIDX00005', '메뉴연결 보기', 'IR3T73EE', '/modebd/modebdmenuList.do', 2, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00111', 'MNIDX00005', '카테고리 관리', 'SRMy889n', '/menuctgry/syscategoryList.do', 3, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00112', 'MNIDX00007', '코드 관리', '2u427mHs', '/menuctgry/syscodeList.do', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00113', 'MNIDX00007', '팝업 관리', '30k7Xy7k', '/popup/popupList.do', 2, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'N', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00114', 'MNIDX00007', '첨부파일 관리', '0clH9575', '/modeatch/customAtchPage.do', 3, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00115', 'MNIDX00006', '통계', '9afxGvI7', '/modest/modestPage.do', 1, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00116', 'MNIDX00002', '접근IP관리', 'DHLViO3C', '/modeip/accessipList.do', 4, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);
INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00117', 'MNIDX00006', '페이지별통계', '3pDGzrP5', '/modest/modestpgPage.do', 2, NULL, NULL, NULL, NULL, NULL, NULL, 'MAN', 'CDIDX00002', 'CDIDX00022', 'N', 'N', 'N', 'Y', 'nimdasys', GETDATE(), NULL, NULL, NULL);

INSERT INTO CMS_SYS_MENU
  (MENU_IDX, UP_MENU_IDX, MENU_NM, MENU_NIX, MENU_LINK, MENU_ORD, MENU_IMG_PATH, LEFT_IMG_PATH, TITLE_IMG_PATH, SITEMAP_IMG_PATH, INFO01_IMG_PATH, INFO02_IMG_PATH, MU_GUB, MU_SITE, MU_LANG, BLANK_YN, TABMENU_YN, MEMMENU_YN, USE_YN, WRITER, WDT, MODIFIER, MDT, OWN_INFO)
VALUES
  ('MNIDX00118','MNIDX00008','설문 관리','Ei12sIt4','/manact/surveySrvymain/srvymainList.do',1,NULL,NULL,NULL,NULL,NULL,NULL,'MAN','CDIDX00002','CDIDX00022','N','N','N','N','planidev',GETDATE(), NULL,NULL,NULL);  

  
  

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0000', NULL, '개발자', 0, 1, 'Y', NULL, GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'D0000', '개발자', 0, 1, 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0000', NULL, '시스템관리자', 1, 2, 'Y', NULL, GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'M0000', '시스템 관리자', 2, 1, 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('B0000', NULL, '컨텐츠관리자', 101, 3, 'N', NULL, GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('B0001', 'B0000', '컨텐츠 관리자', 102, 1, 'N', 'planidev', GETDATE(), 'planidev', GETDATE());

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0000', NULL, '일반 사용자', 1001, 4, 'Y', NULL, GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0002', 'U0000', '비회원', 9999, 7, 'N', 'planidev', GETDATE(), 'planidev', GETDATE());

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('U0003', 'U0000', '정회원', 1005, 4, 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('G0000', NULL, '손님', 10001, 5, 'N', NULL, GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('G0001', 'G0000', '손님', 10002, 1, 'N', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_AUTH
  (AUTH_CD, UP_AUTH_CD, AUTH_NM, AUTH_LV, AUTH_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0002', 'M0000', '시스템 제한 관리자', 3, 2, 'N', 'planidev', GETDATE(), 'planidev', GETDATE());

  
    
  
  


INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00001', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00002', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00003', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00004', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00005', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00006', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00007', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00008', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00101', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00102', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00103', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00104', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00105', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00106', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00107', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00108', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00109', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00110', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00111', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00112', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00113', 'Y', 'planidev', GETDATE(), NULL, NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00114', 'Y', 'planidev', GETDATE(), NULL, NULL);

  INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00115', 'Y', 'planidev', GETDATE(), NULL, NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00116', 'Y', 'planidev', GETDATE(), NULL, NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00117', 'Y', 'planidev', GETDATE(), NULL, NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('D0001', 'MNIDX00118', 'Y', 'planidev', GETDATE(), NULL, NULL);
  
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00002', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00003', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00004', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00005', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00006', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00007', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00008', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00102', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00103', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00104', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00105', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00106', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00107', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00108', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00109', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00110', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00111', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00112', 'Y', 'planidev', GETDATE(), NULL, NULL);
  
INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00113', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00114', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00115', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00116', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00117', 'Y', 'planidev', GETDATE(), NULL, NULL);

INSERT INTO CMS_MENU_AUTH
  (AUTH_CD, MENU_IDX, AUTH_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('M0001', 'MNIDX00118', 'Y', 'planidev', GETDATE(), NULL, NULL);



  
  
INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00001', NULL, '사이트 구분', 1, 'Y', 'nimdasys', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00002', 'CDIDX00001', '대표웹', 1, 'Y', 'nimdasys', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00003', 'CDIDX00001', '모바일', 2, 'N', 'nimdasys', GETDATE(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00021', NULL, '언어구분', 2, 'Y', 'nimdasys', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00022', 'CDIDX00021', '한국어', 1, 'Y', 'nimdasys', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00023', 'CDIDX00021', '영어', 2, 'N', 'nimdasys', GETDATE(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00024', 'CDIDX00021', '중국어', 3, 'N', 'nimdasys', GETDATE(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00025', 'CDIDX00021', '일본어', 4, 'N', 'nimdasys', GETDATE(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00041', NULL, '게시판 종류', 3, 'Y', 'nimdasys', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00042', 'CDIDX00041', '일반 게시판 / 자료실', 1, 'Y', 'nimdasys', GETDATE(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00043', 'CDIDX00041', 'FAQ형 게시판', 2, 'Y', 'nimdasys', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00044', 'CDIDX00041', '이미지 게시판 / 갤러리', 3, 'Y', 'nimdasys', GETDATE(), NULL, NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00045', 'CDIDX00041', '일정 게시판', 5, 'N', 'nimdasys', GETDATE(), 'nimdasys', NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  ('CDIDX00046', 'CDIDX00041', '익명 게시판', 4, 'N', 'nimdasys', GETDATE(), 'nimdasys', NULL);



INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00061',NULL,'설문 파트 유형',4,'Y','nimdasys',GETDATE(),NULL,NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
 	('CDIDX00062','CDIDX00061','개인정보',1,'Y','nimdasys',GETDATE(),NULL,NULL);
   
INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00063','CDIDX00061','일반파트',2,'Y','nimdasys',GETDATE(),NULL,NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00081',NULL,'설문 질문 유형',5,'Y','nimdasys',GETDATE(),NULL,NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00082','CDIDX00081','객관식 단답형',1,'Y','nimdasys',GETDATE(),NULL,NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00083','CDIDX00081','객관식 복수형',2,'Y','nimdasys',GETDATE(),NULL,NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00084','CDIDX00081','주관식 단답형',3,'Y','nimdasys',GETDATE(),NULL,NULL);
	
INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
	('CDIDX00085','CDIDX00081','만족도 선택형',4,'Y','nimdasys',GETDATE(),NULL,NULL);

INSERT INTO CMS_SYS_CODE
  (CODE_IDX, UP_CODE_IDX, CODE_NM, CODE_ORD, USE_YN, WRITER, WDT, MODIFIER, MDT)
VALUES
  	('CDIDX00086','CDIDX00081','선호도 선택형',5,'Y','nimdasys',GETDATE(),NULL,NULL);
  
 
INSERT INTO CMS_SYS_SEQUENCE ( SEQ_NAME,SEQ_VALUE,SEQ_INC ) VALUES ( 'SEQ_SRVYDATA_IDX', 0, 1);

  	