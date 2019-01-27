----  Create an online survey database
--

-- Settings Description

set termout on
set feedback on
prompt Building Online Survey database.  Please wait ...
set termout off
set feedback off

-- / Settings Description

-- Drop Tables



drop table OS_USERS cascade constraint; 
drop table Participant cascade constraint; 
drop table Organiser cascade constraint; 
drop table Admin cascade constraint; 
drop table Category cascade constraint; 
drop table Survey cascade constraint; 
drop table Question cascade constraint; 
drop table Survey_question cascade constraint; 
drop table Checkbox cascade constraint; 
drop table Radio_button cascade constraint; 
drop table Text_box cascade constraint; 
drop table Audio_visual cascade constraint; 
drop table Participant_takes_survey cascade constraint; 
drop table Feedback cascade constraint; 
drop table Response cascade constraint; 
drop table Participant_score cascade constraint; 
drop table Report cascade constraint;

-- User table in Online Survey project : OS_Users 
 
CREATE TABLE OS_USERS ( 	 
 	PID VARCHAR(10), 
 	First_Name VARCHAR(10), 
 	Last_Name VARCHAR(10), 
 	Middle_Name VARCHAR(11), 
 	Name VARCHAR(20) AS (CONCAT(First_Name, Last_Name)), 	
 	Email VARCHAR(50) CONSTRAINT  valid_email CHECK (REGEXP_LIKE (Email, '^(\S+)\@(\S+)\.(\S+)$')), 	 
 	Phone_num number(10) CONSTRAINT valid_phone CHECK (REGEXP_LIKE (Phone_num, '^\d{10}$')), 
 	Address VARCHAR(150),  
 	CONSTRAINT os_users_PK PRIMARY KEY(PID) ); 	 
 
INSERT INTO OS_USERS (PID, First_Name, Last_Name, Email, Phone_num, Address) 
VALUES (2, 'Test', 'Tester', 'tester@test.com', 1122334455, 'San Macros, TX' );  

INSERT INTO OS_USERS (PID, First_Name, Last_Name, Email, Phone_num, Address) 
VALUES ('m_b733', 'Meghana', 'Bodduluri', 'mb733@txstate.edu', 7372306196, 'San Macros, TX' );  

INSERT INTO OS_USERS (PID, First_Name, Last_Name, Email, Phone_num, Address) 
VALUES ('p_b123', 'Pratiksha', 'Balakrishn', 'p_b153@txstate.com', 6308851601, 'San Macros, TX' ); 
 
INSERT INTO OS_USERS (PID, First_Name, Last_Name, Middle_Name, Email, Phone_num, Address) 
VALUES ('c_v123', 'Vineetha', 'Condoor', 'Vidya', 'c_v123@txstate.edu', 8888201590, 'Austin , TX' ); 
 
INSERT INTO OS_USERS (PID, First_Name, Last_Name, Email, Phone_num, Address) 
VALUES ('r_y35', 'Ravi', 'Yalagala', 'r_y35@txstate.edu', 1122334455, 'Dallas, TX' );  

INSERT INTO OS_USERS (PID, First_Name, Last_Name, Middle_Name, Email, Phone_num, Address) 
VALUES (4, 'Nagendra', 'Kammari', 'Achari', 'mb733@txstate.edu', 9490991302, 'San Macros, TX' ); 
 
INSERT INTO OS_USERS (PID, First_Name, Last_Name, Email, Phone_num, Address) 
VALUES ('J_s99', 'Jesuloluwa', 'Jes', 'js99@txstate.edu', 9456091302, 'XYZ, NY' );  
 
INSERT INTO OS_USERS (PID, First_Name, Last_Name, Email, Phone_num, Address) 
VALUES ('AN99', 'Anup', 'Girish', 'AN99@txstate.edu', 9234097702, 'XYZ, ARL' );  
---Table Participant-- 
 
CREATE TABLE Participant ( 
 	Part_PID VARCHAR(10), 
 	Role VARCHAR(8) CONSTRAINT ValidRole CHECK (Role IN ('Faculty',  'Student', 'Parent')), 
 	Part_username VARCHAR (15), 
 	Password VARCHAR(15), 
 	CONSTRAINT Participant_pk PRIMARY KEY(Part_username), 
 	FOREIGN KEY(Part_PID) REFERENCES OS_USERS(PID) 
); 
 
INSERT INTO Participant(Part_PID, Role, Part_username, Password) 
VALUES ('m_b733', 'Student', 'Meghana248', 'MyLife'); 
 
INSERT INTO Participant(Part_PID, Role, Part_username, Password) 
VALUES ('p_b123', 'Student', 'Pratiksha007', 'ASDFG'); 
 
INSERT INTO Participant(Part_PID, Role, Part_username, Password) 
VALUES (2, 'Student', 'Test23', 'qwerty'); 
 
INSERT INTO Participant(Part_PID, Role, Part_username, Password) 
VALUES ('r_y35', 'Student', 'Ravi248', 'mypasword');  

INSERT INTO Participant(Part_PID, Role, Part_username, Password) 
VALUES (4, 'Faculty', 'Naggi', 'zxcvb'); 
 

---Table Organiser-- 
 
CREATE TABLE Organiser ( 
 	Org_PID VARCHAR(10),  
 	Role VARCHAR(8) CONSTRAINT Valid_Role CHECK (Role IN ('Faculty', 'Student', 'Parent')), 
 	Org_username VARCHAR (15), 
 	Password VARCHAR(15), 
 	CONSTRAINT Organiser_pk PRIMARY KEY( Org_username), 
 	FOREIGN KEY(Org_PID) REFERENCES OS_USERS(PID) 
); 
 
INSERT INTO Organiser(Org_PID, Role, Org_username, Password) 
VALUES ('r_y35', 'Faculty', 'Ravi248', 'mypasword'); 
 
INSERT INTO Organiser(Org_PID, Role, Org_username, Password) 
VALUES ('p_b123', 'Faculty', 'Pratiksha007', 'ASDFG'); 
 
 
INSERT INTO Organiser(Org_PID, Role, Org_username, Password) 
VALUES ('AN99', 'Faculty', 'ANUP99', 'ASDFG'); 
 
INSERT INTO Organiser(Org_PID, Role, Org_username, Password) 
VALUES ( 'J_s99', 'Faculty', 'Jesuloluwa99', 'lkjh'); 
 
INSERT INTO Organiser(Org_PID, Role, Org_username, Password) 
VALUES (4, 'Faculty', 'Naggi10', 'cdfg'); 
 
---Table Admin-- 
 
CREATE TABLE Admin ( 
 	SerialNum Number(5), 
 	Admin_PID VARCHAR(10), 
 	Admin_username VARCHAR (15), 
 	Password VARCHAR(15), 
 	Parti_username VARCHAR (15), 
 	Orga_username VARCHAR (15), 
 	CONSTRAINT Admin_pk PRIMARY KEY(SerialNum, Admin_PID ,Admin_username), 
 	FOREIGN KEY(Admin_PID) REFERENCES OS_USERS(PID), 
 	FOREIGN KEY(Parti_username) REFERENCES Participant(Part_username), 
 	FOREIGN KEY(Orga_username) REFERENCES Organiser(Org_username) );  
INSERT INTO Admin(SerialNum, Admin_PID, Admin_username, Password, Parti_username, Orga_username) 
VALUES (1, 'c_v123', 'Vinie', 'mypasword' , 'Meghana248' , 'Ravi248'); 
 
INSERT INTO Admin(SerialNum, Admin_PID, Admin_username, Password, Parti_username, Orga_username) 
VALUES (2, 'c_v123', 'Vinie', 'mypasword' , 'Pratiksha007', 'Ravi248'); 
 
INSERT INTO Admin(SerialNum, Admin_PID, Admin_username, Password, Parti_username, Orga_username) 
VALUES (3, 'c_v123', 'Vinie', 'mypasword' , 'Test23', 'Ravi248'); 
 
INSERT INTO Admin(SerialNum, Admin_PID, Admin_username, Password, Parti_username, Orga_username) 
VALUES (4, 'c_v123', 'Vinie', 'mypasword' , 'Naggi', 'Ravi248'); 
 

INSERT INTO Admin(SerialNum, Admin_PID, Admin_username, Password, Parti_username, Orga_username) 
VALUES (5, 'c_v123', 'Vinie', 'mypasword' , 'Ravi248', 'Ravi248');
 
---Table Category— 
 
 
CREATE TABLE Category ( 
 	Category_name VARCHAR(20), 
 	Category_desc VARCHAR(100), 
 	CONSTRAINT Category_PK PRIMARY KEY(Category_name) 
); 
 
INSERT INTO Category (Category_name, Category_desc) 
VALUES ('Education',  ' student satisfaction survey template about administration ');  

INSERT INTO Category (Category_name, Category_desc) 
VALUES ('Research statistics',  'To collect, analyze, and disseminate statistics and other information related to research '); 
 
INSERT INTO Category (Category_name, Category_desc) 
VALUES ('Parent research',  'To know about parental information and financial status '); 
 
INSERT INTO Category (Category_name, Category_desc) 
VALUES ('Library survey',  'Reviews on library resources '); 
 
INSERT INTO Category (Category_name, Category_desc) 
VALUES ('Food Quality',  ' Feedback about food quality supplied in school '); 
 
 
---Table Survey— 
 
CREATE TABLE Survey ( 
 	Survey_ID VARCHAR(10), 
 	Org_username VARCHAR (15), 
 	Survey_name  VARCHAR (15), 
 	Category_name VARCHAR(20), 
 	Date_creation  DATE , 
 	Start_date DATE, 
 	End_date DATE, 
 	CONSTRAINT Survey_PK PRIMARY KEY(Survey_ID), 
 	FOREIGN KEY(Org_username) REFERENCES Organiser(Org_username), 
 	FOREIGN KEY(Category_name) REFERENCES Category (Category_name) 	 
);  
INSERT INTO Survey (Survey_ID, Org_username, Survey_name, Category_name, Date_creation , Start_date, End_date) 
VALUES ('Sur_100',  'Ravi248' , 'Edu_Survey', 'Education', '20-OCT-18', '1-NOV-18', '30-NOV18');  

INSERT INTO Survey (Survey_ID, Org_username, Survey_name, Category_name, Date_creation , Start_date, End_date) 
VALUES ('Sur_110',  'Jesuloluwa99', 'Statistics', 'Research statistics', '20-Nov-18', '1-dec18', '30-dec-18'); 
 
INSERT INTO Survey (Survey_ID, Org_username, Survey_name, Category_name, Date_creation , Start_date, End_date) 
VALUES ('Sur_120',  'Naggi10', 'Parent_Sur', 'Parent research', '22-OCT-18', '1-NOV-18', '30-NOV-18'); 
 
INSERT INTO Survey (Survey_ID, Org_username, Survey_name, Category_name, Date_creation , Start_date, End_date) 
VALUES ('Sur_130',  'ANUP99', 'Edu_Survey', 'Education', '26-OCT-18', '1-NOV-18', '15-NOV-18');  

INSERT INTO Survey (Survey_ID, Org_username, Survey_name, Category_name, Date_creation , Start_date, End_date) 
VALUES ('Sur_140',  'Ravi248' , 'lIB_Survey', 'Library survey', '29-OCT-18', '1-NOV-18', '10-NOV-18'); 
 
---Table Question— 
 
 
CREATE TABLE Question ( 
 	Question_name   VARCHAR(5), 
 	Question_info VARCHAR(100), 
 	Question_type VARCHAR(10), 
 	Mark_for_question NUMBER, 
 	CONSTRAINT Question_PK PRIMARY KEY(Question_name) 
); 
 
INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('1', 'Does the faculty recognize your achievement?', 'mcq', 1); 
 
INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('2', 'Are you satisfied by the availability of resources?', 'mcq', 1); 
 
INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('3', 'Are you satisfied by the department leadership?', 'T/F', 1);  

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('4', 'Are you satisfied by the opportunities for professional development?', 'T/F', 1);  

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('5', 'Do you have any other queries?', 'text_box', 1); 

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('6', 'What is the slope of the following line?y = x + 4', 'text_box', 1);

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('7', 'What is the simplified form of this expression?8y+x-y', 'text_box', 1);

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('8', 'Find the volume of a cuboid with length, width heightare 4,6,8 feet', 'text_box', 1);

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('9', '(a+b)2, where a=2,b=3?', 'text_box', 1);

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('10', 'sinX/CosX=?', 'text_box', 1);

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('11', 'Your opinion on democracy?', 'Audio', 5);

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('12', 'Identify the picture?', 'Audio', 5); 

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('13', 'Understand the conversation and answer', 'Audio', 5);

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('14', 'Solve the puzzle given in picture', 'Audio', 5);

INSERT INTO Question (Question_name, Question_info, Question_type, Mark_for_question) 
VALUES ('15', 'Find the missing item in picture?', 'Audio', 5);

 
---Table Survey_question— 
 
 
CREATE TABLE Survey_question ( 
 	Survey_ID VARCHAR(10), 
 	Question_name   VARCHAR(5), 
	CONSTRAINT Survey_question_PK PRIMARY KEY(Survey_ID, Question_name), 
 	FOREIGN KEY(Survey_ID) REFERENCES Survey(Survey_ID), 
	FOREIGN KEY(Question_name) REFERENCES Question(Question_name) 
); 
 
INSERT INTO Survey_question (Survey_ID , Question_name) 
VALUES ('Sur_100', '1' ); 
 
INSERT INTO Survey_question (Survey_ID , Question_name) 
VALUES ('Sur_100', '2' ); 
 
INSERT INTO Survey_question (Survey_ID , Question_name) 
VALUES ('Sur_100', '3' ); 
 
INSERT INTO Survey_question (Survey_ID , Question_name) 
VALUES ('Sur_100', '4' ); 
 
INSERT INTO Survey_question (Survey_ID , Question_name) 
VALUES ('Sur_100', '5' ); 
 
 
---Table Checkbox— 
 
CREATE TABLE Checkbox ( 
 	Question_name   VARCHAR(5), 
 	Option_number  NUMBER, 
 	Value_of_eachOption VARCHAR(15), 
        Correct_ans VARCHAR(1) check (Correct_ans in ('Y','N')), 
 	Score_for_qes  NUMBER 
);  
INSERT INTO Checkbox (Question_name, Option_number, Value_of_eachOption, Correct_ans, Score_for_qes) 
VALUES ( '1', 1, 'very satisfied', 'Y' ,1  ); 

INSERT INTO Checkbox (Question_name, Option_number, Value_of_eachOption, Correct_ans, Score_for_qes) 
VALUES ( '1', 2, 'satisfied', 'N' ,0  ); 
INSERT INTO Checkbox (Question_name, Option_number, Value_of_eachOption, Correct_ans, 
Score_for_qes) 
VALUES ( '1', 1, 'Not satisfied', 'Y' ,0 ); 
 
INSERT INTO Checkbox (Question_name, Option_number, Value_of_eachOption, Correct_ans, 
Score_for_qes) 
VALUES ( '2', 1, 'very satisfied', 'Y' ,1  ); 
INSERT INTO Checkbox (Question_name, Option_number, Value_of_eachOption, Correct_ans, 
Score_for_qes) 
VALUES ( '2', 2, 'satisfied', 'N' ,0  ); 
INSERT INTO Checkbox (Question_name, Option_number, Value_of_eachOption, Correct_ans, 
Score_for_qes) 
VALUES ( '2', 1, 'Not satisfied', 'Y' ,0 ); 
 
 
---Table Radio_button— 
 
CREATE TABLE Radio_button ( 
 	Question_name   VARCHAR(5), 
 	Option_number  NUMBER, 
 	Value_of_eachOption VARCHAR(15), 
        Correct_ans VARCHAR(1) check (Correct_ans in ('Y','N')), 
 	Score_for_qes  NUMBER 
); 
 
INSERT INTO Radio_button (Question_name, Option_number, Value_of_eachOption, Correct_ans, Score_for_qes) 
VALUES ( '3', 2, 'False', 'N' ,0  ); 
 
INSERT INTO Radio_button (Question_name, Option_number, Value_of_eachOption, Correct_ans, Score_for_qes) 
VALUES ( '3', 1, 'True', 'Y' ,1 ); 
 
INSERT INTO Radio_button (Question_name, Option_number, Value_of_eachOption, Correct_ans, Score_for_qes) 
VALUES ( '4', 2, 'False', 'N' ,0  ); 
 
INSERT INTO Radio_button (Question_name, Option_number, Value_of_eachOption, Correct_ans, Score_for_qes) 
VALUES ( '4', 1, 'True', 'Y' ,1 ); 
 
---Table Text_box— 
 
CREATE TABLE Text_box ( 
 	Question_name   VARCHAR(5), 
 	Text_Ans VARCHAR(100), 
        Score_award  NUMBER, 
        Url VARCHAR(20) 
); 
 
INSERT INTO Text_box (Question_name, Text_Ans, Score_award  , Url) 
VALUES ( '5', 'Administrators can boost educational outcomes by assessing instructors', 1 , 'www.survey.com'); 

INSERT INTO Text_box (Question_name, Text_Ans, Score_award  , Url) 
VALUES ( '6', '1', 1 , 'www.slopes.com'); 

INSERT INTO Text_box (Question_name, Text_Ans, Score_award  , Url) 
VALUES ( '7', 'x+7y', 1 , 'www.algebra.com');

INSERT INTO Text_box (Question_name, Text_Ans, Score_award  , Url) 
VALUES ( '8', '192', 1 , 'www.geometry.com');

INSERT INTO Text_box (Question_name, Text_Ans, Score_award  , Url) 
VALUES ( '9', '10', 1 , 'www.expressions.com');

INSERT INTO Text_box (Question_name, Text_Ans, Score_award  , Url) 
VALUES ( '10', 'TanX', 1 , 'www.trignometry.com');

---Table Audio/Visual— 
 
CREATE TABLE Audio_visual ( 
 	Question_name   VARCHAR(5), 
 	Picture BLOB, 
        Score_award  NUMBER, 
        Url VARCHAR(20) 
); 
 
INSERT INTO Audio_visual (Question_name, Picture, Score_award  , Url) 
VALUES ( '11', '', 5 , 'D:/Audio');


INSERT INTO Audio_visual (Question_name, Picture, Score_award  , Url) 
VALUES ( '12', '', 5 , '');


INSERT INTO Audio_visual (Question_name, Picture, Score_award  , Url) 
VALUES ( '13', '', 5 , 'D:/Audio');


INSERT INTO Audio_visual (Question_name, Picture, Score_award  , Url) 
VALUES ( '14', '', 5 , '');


INSERT INTO Audio_visual (Question_name, Picture, Score_award  , Url) 
VALUES ( '15', '', 5 , '');
 
 
---Table Participant_takes_survey-- 
 
CREATE TABLE Participant_takes_survey ( 
 	Part_username VARCHAR (15), 
 	Survey_ID VARCHAR(10), 
 	Response_Date DATE, 
 	Reward_points NUMBER, 
	CONSTRAINT Part_takes_sur_PK PRIMARY KEY(Part_username, Survey_ID, Response_Date), 
 	FOREIGN KEY(Survey_ID) REFERENCES Survey(Survey_ID), 
	FOREIGN KEY(Part_username) REFERENCES Participant(Part_username) 
); 
 
INSERT INTO Participant_takes_survey (Part_username, Survey_ID, Response_Date, Reward_points) 
VALUES ( 'Meghana248', 'Sur_100', '20-Nov-18' , 10); 
 
INSERT INTO Participant_takes_survey (Part_username, Survey_ID, Response_Date, Reward_points) 
VALUES ( 'Pratiksha007', 'Sur_100', '20-Nov-18' , 10); 
 
INSERT INTO Participant_takes_survey (Part_username, Survey_ID, Response_Date, Reward_points) 
VALUES ( 'Test23', 'Sur_100', '20-Nov-18' , 10); 
 
INSERT INTO Participant_takes_survey (Part_username, Survey_ID, Response_Date, Reward_points) 
VALUES ( 'Naggi', 'Sur_100', '20-Nov-18' , 10); 
 
INSERT INTO Participant_takes_survey (Part_username, Survey_ID, Response_Date, Reward_points)
VALUES ( 'Ravi248', 'Sur_100', '20-Nov-18' , 10); 
 
 
 
---Table Feedback-- 
 
CREATE TABLE Feedback ( 
 	Part_username VARCHAR (15), 
 	Survey_ID VARCHAR(10), 
 	Feedback_text VARCHAR(50), 
	CONSTRAINT Feedback_PK PRIMARY KEY(Part_username, Survey_ID), 
 	FOREIGN KEY(Survey_ID) REFERENCES Survey(Survey_ID), 
	FOREIGN KEY(Part_username) REFERENCES Participant(Part_username) 
); 
 
INSERT INTO Feedback (Part_username, Survey_ID, Feedback_text) 
VALUES ( 'Meghana248', 'Sur_100', 'quality of the customer service is good.');  

INSERT INTO Feedback (Part_username, Survey_ID, Feedback_text) 
VALUES ( 'Pratiksha007', 'Sur_100', 'quality of the customer service is bad.');  

INSERT INTO Feedback (Part_username, Survey_ID, Feedback_text) 
VALUES ( 'Test23', 'Sur_100', 'quality of the customer service is good.');
  
INSERT INTO Feedback (Part_username, Survey_ID, Feedback_text) 
VALUES ( 'Naggi', 'Sur_100', 'quality of the customer service is bad.'); 
 
INSERT INTO Feedback (Part_username, Survey_ID, Feedback_text) 
VALUES ( 'Ravi248', 'Sur_100', 'quality of the customer service is good.'); 
 
 
---Table Response-- 
 
CREATE TABLE Response ( 
 	Part_username VARCHAR (15), 
 	Survey_ID VARCHAR(10), 
 	Question_name   VARCHAR(5), 
	Option_number  NUMBER, 
	Ans_by_part VARCHAR(100), 
	Score_awarded NUMBER, 
	CONSTRAINT Response_PK PRIMARY KEY(Part_username, Survey_ID, Question_name), 
 	FOREIGN KEY(Survey_ID) REFERENCES Survey(Survey_ID), 
	FOREIGN KEY(Part_username) REFERENCES Participant(Part_username), 
	FOREIGN KEY(Question_name) REFERENCES Question(Question_name)
 ); 

INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Meghana248', 'Sur_100', '1',1,'',1); 
 
INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Meghana248', 'Sur_100', '2',1,'',1); 
 
INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Meghana248', 'Sur_100', '3',1,'',1); 
 
INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Meghana248', 'Sur_100', '4',1,'',1); 
 
INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Meghana248', 'Sur_100', '5',0,'Administrators can boost educational outcomes by assessing instructors',1); 
 
INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Pratiksha007', 'Sur_100', '3',1,'',1); 
 
INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Pratiksha007', 'Sur_100', '4',2,'',0); 
 
INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Test23', 'Sur_100', '3',2,'',0); 
 
INSERT INTO Response (Part_username, Survey_ID, Question_name, Option_number, Ans_by_part,  Score_awarded ) 
VALUES ( 'Test23', 'Sur_100', '4',1,'',1); 
 
 
---Table Participant_score-- 
 
CREATE TABLE Participant_score ( 
 	Part_username VARCHAR (15), 
 	Survey_ID VARCHAR(10), 
 	Score VARCHAR(5), 
	CONSTRAINT Participant_score_PK PRIMARY KEY(Part_username, Survey_ID), 
 	FOREIGN KEY(Survey_ID) REFERENCES Survey(Survey_ID), 
	FOREIGN KEY(Part_username) REFERENCES Participant(Part_username) 
); 
 
INSERT INTO Participant_score (Part_username, Survey_ID, Score) 
VALUES ( 'Meghana248', 'Sur_100', '5'); 
 
INSERT INTO Participant_score (Part_username, Survey_ID, Score) 
VALUES ( 'Pratiksha007', 'Sur_100', '4'); 
 
INSERT INTO Participant_score (Part_username, Survey_ID, Score) 
VALUES ( 'Test23', 'Sur_100', '2'); 
 
INSERT INTO Participant_score (Part_username, Survey_ID, Score) 
VALUES ( 'Naggi', 'Sur_100', '5'); 
 
INSERT INTO Participant_score (Part_username, Survey_ID, Score) 
VALUES ( 'Ravi248', 'Sur_100', '3'); 
 
 
---Table Report-- 
 
CREATE TABLE Report ( 
 	Survey_ID VARCHAR(10), 
 	Participant_count NUMBER, 
	Average NUMBER, 
	MaxScore NUMBER, 
	MinScore NUMBER, 
	CONSTRAINT Report_PK PRIMARY KEY(Survey_ID), 
 	FOREIGN KEY(Survey_ID) REFERENCES Survey(Survey_ID) 
); 
 
INSERT INTO Report (Survey_ID, Participant_count, Average, MaxScore, MinScore) 
VALUES ( 'Sur_100',5,2.5,5,2); 
 
 
INSERT INTO Report (Survey_ID, Participant_count, Average, MaxScore, MinScore) 
VALUES ( 'Sur_110',6,4.5,5,3); 
 
INSERT INTO Report (Survey_ID, Participant_count, Average, MaxScore, MinScore) 
VALUES ( 'Sur_120',7,5.5,7,4); 
 
INSERT INTO Report (Survey_ID, Participant_count, Average, MaxScore, MinScore) 
VALUES ( 'Sur_130',8,7.5,8,3); 
 
INSERT INTO Report (Survey_ID, Participant_count, Average, MaxScore, MinScore) 
VALUES ( 'Sur_140',9,7.5,9,5);


--Query that will count the number of "True" responses to a true/false question 

SELECT COUNT(*) AS True_Responses
FROM Response res
WHERE res.Question_name IN ( SELECT que.Question_name FROM Question que
WHERE que.Question_type = 'T/F') 
AND res.Option_number = 1;
