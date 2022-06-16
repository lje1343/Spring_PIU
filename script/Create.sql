CREATE SEQUENCE SEQ_USER;
CREATE SEQUENCE SEQ_PRODUCT;
CREATE SEQUENCE SEQ_PROJECT;
CREATE SEQUENCE SEQ_COMPANY;
CREATE SEQUENCE SEQ_PRODUCT_REVIEW;
CREATE SEQUENCE SEQ_PROJECT_REVIEW;
CREATE SEQUENCE SEQ_PROJECT_REVIEW_COMMENT;
CREATE SEQUENCE SEQ_APPLY;
CREATE SEQUENCE SEQ_JJIM;
CREATE SEQUENCE SEQ_LATEST;
CREATE SEQUENCE SEQ_ORDER;
CREATE SEQUENCE SEQ_PRODUCT_QNA;
CREATE SEQUENCE SEQ_PROJECT_QNA;
CREATE SEQUENCE SEQ_PROJECT_QNA_COMMENT;
CREATE SEQUENCE SEQ_PRODUCT_QNA_COMMENT;





DROP SEQUENCE SEQ_PRODUCT;
DROP SEQUENCE SEQ_ORDER;

CREATE TABLE TBL_USER(
   NUM NUMBER PRIMARY KEY,
   EMAIL VARCHAR2(2000) NOT NULL,
   PASSWORD VARCHAR2(2000) NOT NULL,
   NICKNAME VARCHAR2(2000) NOT NULL,
   PHONE VARCHAR2(2000) NOT NULL,
   ADDRESS VARCHAR2(2000),
   PROFILE_FILE_NAME VARCHAR2(2000),
   PROFILE_UPLOAD_PATH VARCHAR2(2000),
   POINT NUMBER DEFAULT 0,
   REGIST_DATE DATE DEFAULT SYSDATE,
   STATUS CHAR(1) DEFAULT '1'
);



CREATE TABLE TBL_PRODUCT(
   NUM NUMBER PRIMARY KEY,
   NAME VARCHAR2(2000) NOT NULL,
   CONTENT VARCHAR2(2000) NOT NULL,
   CATEGORY VARCHAR2(2000) NOT NULL,
   PRICE NUMBER NOT NULL,
   STOCK NUMBER NOT NULL,
   ORIGIN VARCHAR2(2000) NOT NULL,
   MANUFACTURER VARCHAR2(2000) NOT NULL,
   SUPPLIER VARCHAR2(2000) NOT NULL,
   REGIST_DATE DATE DEFAULT SYSDATE,
   STATUS CHAR(1) DEFAULT '1'
);

CREATE TABLE TBL_COMPANY(
	NUM NUMBER PRIMARY KEY ,
	EMAIL VARCHAR2(2000) NOT NULL ,
	PASSWORD VARCHAR2(2000) NOT NULL ,
	NAME VARCHAR2(2000) NOT NULL ,
	PHONE VARCHAR2(2000) ,
	BUSINESS_PHONE VARCHAR2(2000) NOT NULL ,
	ADDRESS VARCHAR2(2000) ,
	BUSINESS_NUMBER VARCHAR2(2000) NOT NULL ,
	APPROVAL CHAR(1) DEFAULT '0' ,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1'
);


CREATE TABLE TBL_PROJECT(
   NUM NUMBER PRIMARY KEY,
   TITLE VARCHAR2(2000) NOT NULL,
   CONTENT VARCHAR2(4000) NOT NULL,
   COURSE VARCHAR2(2000) NOT NULL,
   TERRAIN NUMBER NOT NULL,
   ADDRESS NUMBER NOT NULL,
   POINT NUMBER NOT NULL,
   APPROVAL CHAR(1) DEFAULT '0' ,
   STARTTIME DATE ,
   ENDTIME	DATE , 
   MANUFACTURER VARCHAR2(2000) NOT NULL,
   SUPPLIER VARCHAR2(2000) NOT NULL,
   REGIST_DATE DATE DEFAULT SYSDATE,
   UPDATE_DATE DATE DEFAULT SYSDATE,
   STATUS CHAR(1) DEFAULT '1' ,
   COMPANY_NUM NUMBER,
   USER_NUM NUMBER ,
   CONSTRAINT FK_PROJECT_COMPANY_NUM FOREIGN KEY(COMPANY_NUM)
   REFERENCES TBL_COMPANY(NUM) ON DELETE CASCADE,
   CONSTRAINT FK_PROJECT_USER_NUM FOREIGN KEY(USER_NUM)
   REFERENCES TBL_USER(NUM) ON DELETE CASCADE
);


CREATE TABLE TBL_PROJECT_FILE(
	UUID VARCHAR2(1000) PRIMARY KEY ,
	UPLOAD_PATH VARCHAR2(1000) NOT NULL ,
	FILE_NAME VARCHAR2(2000) NOT NULL ,
	PROJECT_NUM NUMBER,
	CONSTRAINT FK_FILE_PROJECT_NUM FOREIGN KEY(PROJECT_NUM)
   REFERENCES TBL_PROJECT(NUM) ON DELETE CASCADE
);

CREATE TABLE TBL_PRODUCT_FILE(
	UUID VARCHAR2(1000) PRIMARY KEY ,
	UPLOAD_PATH VARCHAR2(1000) NOT NULL ,
	FILE_NAME VARCHAR2(2000) NOT NULL ,
	PRODUCT_NUM NUMBER,
	CONSTRAINT FK_FILE_PRODUCT_NUM FOREIGN KEY(PRODUCT_NUM)
   REFERENCES TBL_PRODUCT(NUM) ON DELETE CASCADE
);

CREATE TABLE TBL_PRODUCT_REVIEW(
	NUM NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(4000) NOT NULL,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	UPDATE_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	PRODUCT_NUM NUMBER ,
	CONSTRAINT FK_REVIEW_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_REVIEW_PRODUCT_NUM FOREIGN KEY(PRODUCT_NUM)
   	REFERENCES TBL_PRODUCT(NUM) ON DELETE CASCADE 
);

CREATE TABLE TBL_PRODUCT_REVIEW_FILE(
	UUID VARCHAR2(1000) PRIMARY KEY ,
	UPLOAD_PATH VARCHAR2(1000) NOT NULL ,
	FILE_NAME VARCHAR2(2000) NOT NULL ,
	REVIEW_NUM NUMBER,
	CONSTRAINT FK_FILE_PRODUCT_REVIEW_NUM FOREIGN KEY(REVIEW_NUM)
   REFERENCES TBL_PRODUCT_REVIEW(NUM) ON DELETE CASCADE
);


CREATE TABLE TBL_PROJECT_REVIEW(
	NUM NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(4000) NOT NULL,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	UPDATE_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	PROJECT_NUM NUMBER ,
	CONSTRAINT FK_PROJECT_RE_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_PROJECT_RE_PROJECT_NUM FOREIGN KEY(PROJECT_NUM)
   	REFERENCES TBL_PROJECT(NUM) ON DELETE CASCADE 
);

CREATE TABLE TBL_PROJECT_REVIEW_FILE(
	UUID VARCHAR2(1000) PRIMARY KEY ,
	UPLOAD_PATH VARCHAR2(1000) NOT NULL ,
	FILE_NAME VARCHAR2(2000) NOT NULL ,
	REVIEW_NUM NUMBER,
	CONSTRAINT FK_FILE_PROJECT_REVIEW_NUM FOREIGN KEY(REVIEW_NUM)
  	REFERENCES TBL_PROJECT_REVIEW(NUM) ON DELETE CASCADE
);



CREATE TABLE TBL_PROJECT_REVIEW_COMMENT(
	NUM NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(1000) NOT NULL,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	UPDATE_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	COMPANY_NUM NUMBER ,
	REVIEW_NUM NUMBER ,
	CONSTRAINT FK_PROJECT_RE_CO_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_PROJECT_RE_CO_NUM FOREIGN KEY(COMPANY_NUM)
   	REFERENCES TBL_COMPANY(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_PROJECT_RE_NUM FOREIGN KEY(REVIEW_NUM)
   	REFERENCES TBL_PROJECT_REVIEW(NUM) ON DELETE CASCADE 
);

CREATE TABLE TBL_JJIM(
	NUM NUMBER PRIMARY KEY,
	CATEGORY CHAR(1) NOT NULL ,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	PROJECT_NUM NUMBER ,
	PRODUCT_NUM NUMBER ,
	CONSTRAINT FK_JJIM_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_JJIM_PROJECT_NUM FOREIGN KEY(PROJECT_NUM)
   	REFERENCES TBL_PROJECT(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_JJIM_PRODUCT_NUM FOREIGN KEY(PRODUCT_NUM)
   	REFERENCES TBL_PRODUCT(NUM) ON DELETE CASCADE 
);

CREATE TABLE TBL_LATEST(
	NUM NUMBER PRIMARY KEY,
	CATEGORY CHAR(1) NOT NULL ,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	PROJECT_NUM NUMBER ,
	PRODUCT_NUM NUMBER ,
	CONSTRAINT FK_LATEST_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_LATEST_PROJECT_NUM FOREIGN KEY(PROJECT_NUM)
   	REFERENCES TBL_PROJECT(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_LATEST_PRODUCT_NUM FOREIGN KEY(PRODUCT_NUM)
   	REFERENCES TBL_PRODUCT(NUM) ON DELETE CASCADE 
);

CREATE TABLE TBL_ORDER(
	NUM NUMBER PRIMARY KEY,
	TOTAL NUMBER ,
	COUNTING NUMBER ,
	STATUS CHAR(1) DEFAULT '1',
	REGIST_DATE DATE DEFAULT SYSDATE,
	PRODUCT_NUM NUMBER ,
	USER_NUM NUMBER ,
	CONSTRAINT FK_ORDER_PRODUCT_NUM FOREIGN KEY(PRODUCT_NUM)
   	REFERENCES TBL_PRODUCT(NUM) ON DELETE CASCADE ,
   	CONSTRAINT FK_ORDER_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE 	
)

CREATE TABLE TBL_APPLY(
	NUM NUMBER PRIMARY KEY,
	APPROACH CHAR(1) ,
	REGIST_DATE DATE DEFAULT SYSDATE,
	PROJECT_NUM NUMBER ,
	USER_NUM NUMBER ,
   	CONSTRAINT FK_APPLY_PROJECT_NUM FOREIGN KEY(PROJECT_NUM)
   	REFERENCES TBL_PROJECT(NUM) ON DELETE CASCADE ,
   	CONSTRAINT FK_APPLY_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE 	
)


CREATE TABLE TBL_PROJECT_QNA(
	NUM NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(4000) NOT NULL,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	UPDATE_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	PROJECT_NUM NUMBER ,
	CONSTRAINT FK_QNA_RE_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_QNA_RE_PROJECT_NUM FOREIGN KEY(PROJECT_NUM)
   	REFERENCES TBL_PROJECT(NUM) ON DELETE CASCADE 
);

CREATE TABLE TBL_PROJECT_QNA_COMMENT(
	NUM NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(1000) NOT NULL,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	UPDATE_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	COMPANY_NUM NUMBER ,
	QNA_NUM NUMBER ,
	CONSTRAINT FK_PROJECT_CO_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_PROJECT_CO_COMPANY_NUM FOREIGN KEY(COMPANY_NUM)
   	REFERENCES TBL_COMPANY(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_PROJECT_CO_QNA_NUM FOREIGN KEY(QNA_NUM)
   	REFERENCES TBL_PROJECT_QNA(NUM) ON DELETE CASCADE 
);


CREATE TABLE TBL_PRODUCT_QNA(
	NUM NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(4000) NOT NULL,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	UPDATE_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	PRODUCT_NUM NUMBER ,
	CONSTRAINT FK_QNA_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_QNA_PRODUCT_NUM FOREIGN KEY(PRODUCT_NUM)
   	REFERENCES TBL_PRODUCT(NUM) ON DELETE CASCADE 
);



CREATE TABLE TBL_PRODUCT_QNA_COMMENT(
	NUM NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(1000) NOT NULL,
	REGIST_DATE DATE DEFAULT SYSDATE ,
	UPDATE_DATE DATE DEFAULT SYSDATE ,
	STATUS CHAR(1) DEFAULT '1' ,
	USER_NUM NUMBER ,
	QNA_NUM NUMBER ,
	CONSTRAINT FK_CO_USER_NUM FOREIGN KEY(USER_NUM)
   	REFERENCES TBL_USER(NUM) ON DELETE CASCADE ,
	CONSTRAINT FK_CO_QNA_NUM FOREIGN KEY(QNA_NUM)
   	REFERENCES TBL_PRODUCT_QNA(NUM) ON DELETE CASCADE 
);









