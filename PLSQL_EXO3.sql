create  procedure inscrire_conduite(id eleve.E_id%type,nom eleve.E_nom%type,prenom eleve.E_prenom%type,dateN eleve.E_date_naiss%type,tel eleve.E_tel%type,dateD eleve.E_date_dossier%type,dateC eleve.E_date_code%type,Iid inscription.I_id%type,idE inscription.E_id%type,typeI inscription.I_type%type,dateI inscription.I_date_insc%type,num inscription.I_num%type) as
nombre varchar(2);
ELEVE_INCONNU exception;
PB_AGE exception;
PAS_DE_CODE exception;
v_id varchar(25);
v_long number(10);
v_age number(2);
v_test number(1);
v_test1  number(1);
v_nb number(2);
BEGIN
select coltype into v_id  from col where tname='ELEVE' and cname='E_ID' ;
select length(id) into v_long from dual;
select trunc(months_between (sysdate,dateN)/12) into v_age from dual;
select count(*) into v_test1 from eleve where E_id=id ;

if v_id != 'NUMBER' or v_long > 4 or v_test1=1 or id is null THEN
raise ELEVE_INCONNU;
elsif v_age < 18 and typeI='Anticipe' THEN
Raise PB_AGE;
elsif dateC is null then 
raise PAS_DE_CODE;
else
insert into eleve values(id,nom,dateN,tel,dateD,dateC,prenom);
dbms_output.put_line('eleve '||nom||' insere avec succes');
insert into inscription(I_id,E_id,I_type,I_date_insc,I_num) values(Iid,idE,typeI,dateI,num);
dbms_output.put_line(' Inscription  de'||nom||' reussi');
select count(*) into v_test from inscription where E_id=idE ;
dbms_output.put_line('le nombre d inscription de '||nom||' est '||v_test);
end if;
exception
when ELEVE_INCONNU THEN
dbms_output.put_line('Identifient de l eleve incorrect');
when PB_AGE THEN
dbms_output.put_line('age non conforme au type d apprentissage');
when PAS_DE_CODE THEN
dbms_output.put_line('pas de code');
end;
/


