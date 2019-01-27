--Cs5332 Project, Stage 3
--### Meghana Bodduluri ###

create or replace view q1 as
	 select * from (select (givenName||' '||familyName) as 		 name,salary
	 from employee e, party p 
	 where position='Underwriter' and e.id=p.id)
;

create or replace view q2 as
	select * from (select unique (givenName||' '||familyName) as 	name,
	(street||', '||suburb||' '||state||' '||postcode) as address
	from party p,holds h,covers c,ratingaction r
	where r.action='D' and r.coverage=c.coverage and c.policy = 	h.policy and h.client = p.id
	order by name);


create or replace view q3 as
	select (givenName||' '||familyName) as name
 	from party p, employee e, holds h, policy po
	where e.id=h.client and h.policy=po.id and po.status = 'OK' 	and  p.id=e.id;

create or replace view q4 as
	select sum(premium) as MoneyCollected from policy;

create or replace view q5 as
	select sum(amount) as MoneyPaid from claimaction where 	action='PO';


create or replace view q6 as
	select unique (givenName||' '||familyName) as name
	from party p, holds h,claim c, claimant c1
	where c.policy = h.policy and c1.id=h.client and 	h.client=p.id;


create or replace view q7 as
	select unique policy 
	from covers c, coveredItem c1, coverage c2 
	where c.item =c1.id and c.coverage=c2.id and 
	c2.covervalue>c1.marketvalue
	order by policy asc;



create or replace view q8 as
	select unique make , model , count(*) as NumberInsured
	from coveredItem c 
	group by make,model
	order by make;


create or replace view q9 as
	(select (p.givenname||' '||p.familyName) as policyholder, 	(p1.givenname||' '||p1.familyName) as Policyprocessor
 	from holds h, party p, party p1, policy po,employee e,  	underwritingaction u
	where h.client=e.id and e.id=p.id and h.policy=po.id and        	po.status='OK' and po.id=u.policy and  u.underwriter=p1.id)
        UNION
     (select (p.givenname||' '||p.familyName), 
	(p1.givenname||' '||p1.familyName)
	from holds h, party p, party p1, policy po,employee e,    	covers c
	where h.client=e.id and e.id=p.id and h.policy=po.id and        	po.status='OK' and po.id=c.policy and c.coverage In
     (select r.coverage from ratingaction r , covers c1
	where c1.coverage=r.coverage and p1.id=r.rater));


create or replace view q10 as 
	select distinct(policy),make,model 
	from coveredItem, (select item,policy,description from 	covers c,coverage c1 
	where c.coverage=c1.id 
	order by 	item,policy,description) T1
	where not exists 
	(select description from (select distinct(description) 
	from coverage) T2 
	MINUS 
	select description 
	from (select item,policy,description from covers c2,coverage  	where c2.coverage=id order by item,policy,description) 	 	T3
	where T3.policy = T1.policy)and covereditem.id=T1.item;


--Pl/SQL Procedures	

create or replace view EmployeePolicies as
	select (givenName||' '||familyName) as name, h.policy 	as 	policyid, po.premium as premium
 	from party p, employee e, holds h, policy po
	where h.client=e.id and e.id=p.id and h.policy=po.id and 	po.premium IS NOT NULL;


create or replace
procedure discount
is
 begin

update policy p 
set p.premium = (p.premium)-(p.premium/10)where p.premium in (select p.premium from holds h, employee e where h.client = e.id and h.policy=p.id);

end;
/


create or replace
procedure claims(policyID integer)
is
num_claims integer := 0;
Valid_policies integer := 0;
claim_ID integer := 0;
claimant_ID integer := 0;
l_date VARCHAR(40);
e_date VARCHAR(40);
cursor claimscursor IS select id, claimant, l_date, e_date, Reserve, Status from claim where claim.policy=policyId order by l_date;
Reserve REAL := 0;
Status VARCHAR(2);
Counter integer := 1;
C_A_Counter integer := 1;
claimant_Name VARCHAR(40);
no_Of_Claims integer := 0;
action VARCHAR(10);
happened VARCHAR(40);
amount REAL := 0;
cursor claimActioncursor IS select c1.actor, handler, c.id, action, happened, amount from claim c,claimaction c1 where c.policy=policyId and c.id=c1.claim order by c1.claim, happened ASC, amount DESC;
claimAct_Claim integer:= 0;
handler VARCHAR(40);
handler_Name VARCHAR(40);
actor VARCHAR(40);
actor_Name VARCHAR(40);

BEGIN

select count(*) into no_Of_Claims from claim c,claimaction c1 where c.policy=policyId and c.id=c1.claim;
select count(id) into Valid_policies from policy where id=policyId;
select count(id) into num_claims from claim where policy=policyId;
if Valid_policies = 0 then
dbms_output.put_line('There is no policy: '||policyId);
else if num_claims = 0 then
dbms_output.put_line('Policy '||policyId||' has 0 claims.');
else 
dbms_output.put_line('Policy '||policyId||' has '||num_claims||' claims');
OPEN claimscursor;
while Counter <= num_claims loop
fetch claimscursor into claim_ID, claimant_ID, l_date, e_date, Reserve, Status;
dbms_output.put_line(Counter ||'. Claim '||claim_ID);
select (givenname||' '||familyname) into claimant_Name from party p where p.id=claimant_ID;
dbms_output.put_line('Lodged by : '||claimant_Name||' on '||l_date);
dbms_output.put_line('Event Date: '||e_date);
dbms_output.put_line('Reserve at: '||to_char(Reserve,'$9999990.00'));
dbms_output.put('Status    : ');
if Status LIKE 'A ' then dbms_output.put_line('open');
else 
if Status LIKE 'Z ' then dbms_output.put_line('closed');
end if;end if;
dbms_output.put_line('Activity  : ');
OPEN claimActioncursor;
C_A_Counter := 1;
while C_A_Counter <= no_Of_Claims loop
fetch claimActioncursor into actor, handler, claimAct_Claim, action, happened, amount;
if( claimAct_Claim = claim_ID ) then
select givenname||' '||familyname into handler_Name from party where party.id=handler;
if action = 'OP' then
dbms_output.put_line('Claim opened by '||handler_Name||' on '||happened||' with Reserve set to '||to_char(amount,'$9999990.00') );
else 
if action = 'PO' then
select givenname||' '||familyname into actor_Name from party where party.id=actor;
dbms_output.put_line(' '||to_char(amount,'$9999990.00')||' paid out to '||actor_Name||' by '||handler_Name||' on '||happened );
else 
if action = 'CL' then
dbms_output.put_line('Claim closed by '||handler_Name||' on '||happened );
end if;end if;end if;end if;
C_A_Counter := C_A_Counter + 1;
end loop;
close claimActioncursor;
dbms_output.put_line('---------------');
Counter := Counter + 1;
end loop;
close claimscursor;
end if;end if;
end;
/

create or replace
procedure policy_rework_list 

is

nofReworkedPolicy INTEGER := 0;
reRated INTEGER := 0;

begin

	select count(policy) into nofReworkedPolicy from (
	(select unique policy from ratingaction r, covers c where 	r.rate=0 and r.action='D'and c.coverage=r.coverage) UNION
	(select policy from underwritingaction where action = 'D'));
	
	dbms_output.put_line('Total number of reworked policies : 	'||nofReworkedPolicy );

	select count(policy) into reRated 
	from (
	(select unique policy from ratingaction r, covers c 	where 	r.rate=0 and r.action='D'and c.coverage=r.coverage and 	policy =(select policy from covers c1, ratingaction r1 where 	c1.coverage=r1.coverage and r1.action ='A' and 	r.coverage=r1.coverage )));

	dbms_output.put_line('Total number of re-Rated or re-	underwritten policies : '||reRated );

	
	
end;
/

--Format for output

column name format a20;
column salary format $9999990.00;
select * from q1;

column name format a20;
column address format a40;
select * from q2;

column name format a20;
select * from q3;

column MoneyCollected format $9999990.00;
column MoneyCollected heading "Total|Money|Collected";
select * from q4;

column MoneyPaid format $9999990.00;
column MoneyPaid heading "Total|Money|Paid Out";
select * from q5;

column name format a20;
select * from q6;


select * from q7;

column make format a12;
column model format a12;
column NumberInsured format 999 heading "#";
select * from q8;

column PolicyHolder format a20
column PolicyHolder heading "Employee|Holding|Policy"
column PolicyProcessor format a20
column PolicyProcessor heading "Employee|Processing|Policy"
select * from q9;

column id heading "Policy#"
column make heading "Make"
column model heading "Model"
select * from q10;

column premium format $999990.00
column name format a20
select * from EmployeePolicies;

set serveroutput on
exec discount


select * from EmployeePolicies;


exec claims(555555)
exec claims(547966)
exec claims(545128)

exec policy_rework_list 


