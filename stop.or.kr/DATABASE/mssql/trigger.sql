SET DEFINE OFF;

CREATE OR REPLACE
TRIGGER TGR_CMS_SURVEY_MAIN
AFTER INSERT OR DELETE 
ON CMS_SURVEY_MAIN
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

/******************************************************************************
   TRIGGER NAME :       TGR_CMS_SURVEY_MAIN
   Author		:		ByunghanHan
   NOTE         :       설문이 등록되면 개인정보 수집 파트와 일반 파트 1개를
                        자동으로 생성한다.
******************************************************************************/
BEGIN

  IF INSERTING THEN
  
  
  	INSERT INTO CMS_SURVEY_PART ( SRVY_IDX,PART_IDX,PART_NM,PART_TYPE,PART_PSN_INFO,WRITER,WDT)
		VALUES ( 
        :NEW.SRVY_IDX, 
        1, 
        '개인정보수집',
        'CDIDX00062', 
        '정보수집 안내메시지를 입력해 주십시오', 
        :NEW.writer, 
        SYSDATE 
        );

  	INSERT INTO CMS_SURVEY_PART ( SRVY_IDX,PART_IDX,PART_NM,PART_TYPE,PART_PSN_INFO,WRITER,WDT)
		VALUES ( 
        :NEW.SRVY_IDX, 
        2, 
        '파트',
        'CDIDX00063', 
        '', 
        :NEW.writer, 
        SYSDATE 
        );


	END IF;
    
   	EXCEPTION
    	WHEN OTHERS THEN
       	-- Consider logging the error and then re-raise
       	RAISE;
        
END  TGR_CMS_SURVEY_MAIN;




SET DEFINE OFF;

CREATE OR REPLACE
TRIGGER TGR_CMS_SURVEY_QUESANS
AFTER INSERT OR DELETE 
ON CMS_SURVEY_QUESANS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

/******************************************************************************
   TRIGGER NAME :       TGR_CMS_SURVEY_QUESANS
   Author		:		ByunghanHan
   NOTE         :       설문 질문이 삭제되면
                        관련 데이터들도 삭제한다.
******************************************************************************/
BEGIN

  IF DELETING THEN
  	
  	/* 질문이 삭제될 경우 답변들도 모두 삭제한다 */
  	IF :OLD.QUESANS_TYPE = 'Q' THEN
     
	  	DELETE FROM CMS_SURVEY_DATA
    	WHERE QUES_IDX = :OLD.QUES_IDX;    
    
    	/* 첨부파일도 삭제 */
        DELETE FROM CMS_ATACH 
        WHERE ATCKEY_1ST = 'SRVY_QUESANS' AND ATCKEY_2ND = :OLD.SRVY_IDX AND ATCKEY_3RD = :OLD.QUES_IDX;
    
    ELSE
    
	  	DELETE FROM CMS_SURVEY_DATA
    	WHERE QUES_IDX = :OLD.QUES_IDX AND QUESSUB_IDX = :OLD.ANS_ORD;    
    
    	/* 첨부파일도 삭제 */
        DELETE FROM CMS_ATACH 
        WHERE ATCKEY_1ST = 'SRVY_QUESANS' AND ATCKEY_2ND = :OLD.SRVY_IDX AND ATCKEY_3RD = :OLD.QUES_IDX AND ATCKEY_4TH = :OLD.ANS_ORD;

		/* 첨부파일도 중간 번호가 비게 되므로 중간번호를 채워준다 */
		UPDATE CMS_ATACH SET ATCKEY_4TH = ATCKEY_4TH - 1
        WHERE ATCKEY_1ST = 'SRVY_QUESANS' AND ATCKEY_2ND = :OLD.SRVY_IDX AND ATCKEY_3RD = :OLD.QUES_IDX AND ATCKEY_4TH > :OLD.ANS_ORD;

    
    END IF;    
    
  END IF;
    
   	EXCEPTION
    	WHEN OTHERS THEN
       	-- Consider logging the error and then re-raise
       	RAISE;
        
END  TGR_CMS_SURVEY_QUESANS;