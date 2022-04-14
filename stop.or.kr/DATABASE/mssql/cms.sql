/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ANNOUNCEMENT_GROUP (공고 그룹)
-- 만든 날짜 : 2018-06-27
-- 마지막으로 수정한 날짜 : 2018-06-27
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_ANNOUNCEMENT_GROUP (
    GROUP_ID        VARCHAR(32) NOT NULL, 
    NAME   VARCHAR(512) NOT NULL, 
    MU_SITE         CHAR(10) NOT NULL DEFAULT ('CDIDX00002'), 
    MU_LANG         CHAR(10) NOT NULL DEFAULT ('CDIDX00022'), 
    WRITER          VARCHAR(24), 
    WDT             DATETIME DEFAULT (getdate()), 
    MODIFIER        VARCHAR(24), 
    MDT             DATETIME, 
 CONSTRAINT PK_CMS_ANNOUNCEMENT_GROUP 
   PRIMARY KEY CLUSTERED (GROUP_ID ASC)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ANNOUNCEMENT_DATA (공고 데이터)
-- 만든 날짜 : 2018-06-27
-- 마지막으로 수정한 날짜 : 2018-06-27
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_ANNOUNCEMENT_DATA (
    DATA_ID        BIGINT NOT NULL,
    GROUP_ID        VARCHAR(32) NOT NULL, 
    IS_NOTICE 	CHAR(1) DEFAULT('N'),
    DATE_START 	DATETIME,
    DATE_END	DATETIME,
    SUBJECT   VARCHAR(512) NOT NULL, 
    CONTENT   VARCHAR(4000) NOT NULL, 
    WRITER          VARCHAR(24), 
    WDT             DATETIME DEFAULT (getdate()), 
    MODIFIER        VARCHAR(24), 
    MDT             DATETIME, 
 CONSTRAINT PK_CMS_ANNOUNCEMENT_DATA 
   PRIMARY KEY CLUSTERED (DATA_ID ASC)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_COMPLICITY_INFO (작품접수 기본정보)
-- 만든 날짜 : 2018-08-02
-- 마지막으로 수정한 날짜 : 2018-08-02
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_COMPLICITY_INFO (
    GROUP_ID        BIGINT identity(1, 1) NOT NULL, 
    NAME   VARCHAR(50) NOT NULL, 
    TEL   VARCHAR(50) NOT NULL, 
    EMAIL   VARCHAR(50) NOT NULL, 
    AGE   VARCHAR(50) NOT NULL, 
    BELONG   VARCHAR(50) NOT NULL, 
    SURVEY_GENDER   VARCHAR(50) NOT NULL, 
    SURVEY_AGE   VARCHAR(50) NOT NULL, 
    SURVEY_CITY   VARCHAR(50) NOT NULL, 
    SURVEY_FROM   VARCHAR(100) NOT NULL, 
    SURVEY_ETC   VARCHAR(4000) NOT NULL, 
    WRITER          VARCHAR(24), 
    WDT             DATETIME DEFAULT (getdate()), 
    MODIFIER        VARCHAR(24), 
    MDT             DATETIME, 
 	CONSTRAINT PK_CMS_COMPLICITY_INFO 
	PRIMARY KEY CLUSTERED (GROUP_ID ASC)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_COMPLICITY_INFO (출품작정보)
-- 만든 날짜 : 2018-08-02
-- 마지막으로 수정한 날짜 : 2018-08-02
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_COMPLICITY_ITEM (
    DATA_ID        VARCHAR(32) NOT NULL,
    GROUP_ID        VARCHAR(32) NOT NULL, 
    ITEM_DIVISION   VARCHAR(50) NOT NULL, 
    ITEM_TARGET   VARCHAR(50) NOT NULL, 
    ITEM_NAME   VARCHAR(50) NOT NULL, 
    ITEM_EXPLAIN   VARCHAR(50) NOT NULL,
    ITEM_STATE INT NOT NULL DEFAULT ((0)),
    ITEM_AWARDS VARCHAR(100) NOT NULL,
    MODIFIER        VARCHAR(24), 
    MDT datetime,
    CONSTRAINT PK_CMS_COMPLICITY_ITEM 
	PRIMARY KEY CLUSTERED (DATA_ID ASC)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_COMPANY (기관엑셀다운리스트) 
-- 작성자: ych
------------------------------------------------------------------------------*/
CREATE TABLE CMS_COMPANY (
	COM_IDX bigint NOT NULL,
	DIV varchar(50),
	NAME varchar(250),
	WDT datetime,
	CONSTRAINT PK_CMS_COMPANY PRIMARY KEY (COM_IDX)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_MAP (지원기관 지도 데이터) 
-- 작성자: ych
------------------------------------------------------------------------------*/
CREATE TABLE CMS_MAP (
	MAP_IDX bigint NOT NULL,
	SIDO varchar(100),
	GUGUN varchar(100),
	CATEGORY varchar(100),
	NAME varchar(250),
	ADDR varchar(250),
	TEL varchar(100),
	URLX varchar(100),
	URLY varchar(100),
	WDT datetime,
	MDT datetime,
	CONSTRAINT PK_CMS_MAP PRIMARY KEY (MAP_IDX)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_ZIPCODE (우편리스트) 
-- 작성자: ych
------------------------------------------------------------------------------*/
CREATE TABLE CMS_ZIPCODE (
	ZIP_IDX bigint NOT NULL,
	SIDO varchar(100),
	GUGUN varchar(100),
	CONSTRAINT PK_CMS_ZIPCODE PRIMARY KEY (ZIP_IDX)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_NEWSLETTER (메인 뉴스레터 정보) 
-- 작성자: ych
------------------------------------------------------------------------------*/
CREATE TABLE CMS_NEWSLETTER (
	NEW_IDX bigint NOT NULL,
	EMAIL varchar(250),
	MU_LANG char(10),
	WDT datetime,
	DELDT datetime,
	MDT datetime,
	CONSTRAINT PK_CMS_NEWSLETTER PRIMARY KEY (NEW_IDX)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_SCHEDULE (여성인권달력) 
-- 작성자: ych
------------------------------------------------------------------------------*/
CREATE TABLE CMS_SCHEDULE (
	SCH_IDX bigint NOT NULL,
	SUBJECT varchar(250),
	S_DATE date,
	E_DATE date,
	WDT datetime,
	MDT datetime,
	MU_LANG char(10),
	CONSTRAINT PK_CMS_SCHEDULE PRIMARY KEY (SCH_IDX)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_AWARDS_GROUP (수상작 그룹)
-- 만든 날짜 : 2018-08-13
-- 마지막으로 수정한 날짜 : 2018-08-13
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_AWARDS_GROUP (
    GROUP_ID        VARCHAR(32) NOT NULL, 
    NAME   VARCHAR(512) NOT NULL, 
    MU_SITE         CHAR(10) NOT NULL DEFAULT ('CDIDX00002'), 
    MU_LANG         CHAR(10) NOT NULL DEFAULT ('CDIDX00022'), 
    WRITER          VARCHAR(24), 
    WDT             DATETIME DEFAULT (getdate()), 
    MODIFIER        VARCHAR(24), 
    MDT             DATETIME, 
 CONSTRAINT PK_CMS_AWARDS_GROUP 
   PRIMARY KEY CLUSTERED (GROUP_ID ASC)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_AWARDS_DATA (수상작 데이터)
-- 만든 날짜 : 2018-08-13
-- 마지막으로 수정한 날짜 : 2018-08-13
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE CMS_AWARDS_DATA (
    DATA_ID        BIGINT NOT NULL,
    GROUP_ID        VARCHAR(32) NOT NULL,
    AWARDS VARCHAR(50) NOT NULL,
    AUTHOR VARCHAR(50) NOT NULL, 

    IS_NOTICE 	CHAR(1) DEFAULT('N'),
    DATE_START 	DATETIME,
    DATE_END	DATETIME,
    
    SUBJECT   VARCHAR(512) NOT NULL, 
    CONTENT   VARCHAR(4000) NOT NULL, 
    WRITER          VARCHAR(24), 
    WDT             DATETIME DEFAULT (getdate()), 
    MODIFIER        VARCHAR(24), 
    MDT             DATETIME, 
 CONSTRAINT PK_CMS_AWARDS_DATA 
   PRIMARY KEY CLUSTERED (DATA_ID ASC)
);

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_RELEASE (정보공개)
-- 만든 날짜 : 2018-08-20
-- 마지막으로 수정한 날짜 : 2018-08-20
-- 상태 : VALID
------------------------------------------------------------------------------*/
CREATE TABLE dbo.CMS_RELEASE (
    REL_SEQ      BIGINT NOT NULL, 
    REL_TITLE    VARCHAR(200) NOT NULL, 
    REL_CONTENT  VARCHAR(4000), 
    WDT          DATETIME NOT NULL, 
    IS_NOTICE    CHAR(5) NOT NULL CONSTRAINT DF__CMS_RELEA__IS_NO__640DD89F DEFAULT ('N'), 
 CONSTRAINT PK_CMS_RELEASE 
   PRIMARY KEY CLUSTERED (REL_SEQ ASC) ON [PRIMARY]
) ON [PRIMARY]

EXEC sp_addextendedproperty N'MS_Description', N'[정보공개목록]', N'schema', N'dbo', N'table', N'CMS_RELEASE';


/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_MULTI (정기간행물, 발간자료, 캠페인킷, WHRIK Publication)
-- 만든 날짜 : 2018-08-20
-- 마지막으로 수정한 날짜 : 2018-08-20
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE dbo.CMS_MULTI (
    MC_SEQ       BIGINT NOT NULL, 
    MC_TITLE     VARCHAR(200) NOT NULL, 
    MC_CONTENT   VARCHAR(4000), 
    WDT          DATETIME NOT NULL, 
    MC_CATEGORY  VARCHAR(100), 
    ISSUE        VARCHAR(20), 
 CONSTRAINT PK_CMS_MULTI 
   PRIMARY KEY CLUSTERED (MC_SEQ ASC) ON [PRIMARY]
) ON [PRIMARY]

EXEC sp_addextendedproperty N'MS_Description', N'[멀티게시물]', N'schema', N'dbo', N'table', N'CMS_MULTI';

EXEC sp_addextendedproperty N'MS_Description', N'pp -정기간행물 , pd -발간자료 , ck -캠페인킷     ', N'schema', N'dbo', N'table', N'CMS_MULTI', N'column', N'MC_CATEGORY';

EXEC sp_addextendedproperty N'MS_Description', N'발행일', N'schema', N'dbo', N'table', N'CMS_MULTI', N'column', N'ISSUE';

/*------------------------------------------------------------------------------
-- 개체 이름 : CMS_CARD_NEWS (카드뉴스)
-- 만든 날짜 : 2018-08-20
-- 마지막으로 수정한 날짜 : 2018-08-20
-- 상태 : VALID
------------------------------------------------------------------------------*/

CREATE TABLE dbo.CMS_CARD_NEWS (
    CN_SEQ      BIGINT NOT NULL, 
    CN_TITLE    VARCHAR(200) NOT NULL, 
    CN_CONTENT  VARCHAR(4000), 
    WDT         DATETIME NOT NULL, 
    IS_NOTICE   CHAR(5) NOT NULL CONSTRAINT DF__CMS_CARD___IS_NO__02925FBF DEFAULT ('N'), 
    HITS        INT CONSTRAINT Def_CMS_CARD_NEWS_HITS DEFAULT ((0)), 
 CONSTRAINT PK_CMS_CARD_NEWS 
   PRIMARY KEY CLUSTERED (CN_SEQ ASC) ON [PRIMARY]
) ON [PRIMARY]

EXEC sp_addextendedproperty N'MS_Description', N'[카드뉴스]', N'schema', N'dbo', N'table', N'CMS_CARD_NEWS';

