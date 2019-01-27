--
-- Clean up the Survey demo database
--
set termout on
prompt Removing sample Survey database. Please wait ...
set termout off
set feedback off
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