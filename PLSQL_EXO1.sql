create procedure affich_el_id(id eleve.E_id%type) IS
v_data eleve%rowtype;
BEGIN
select E_nom,E_prenom,E_date_naiss into v_data.E_nom,v_data.E_prenom,v_data.E_date_naiss from eleve where E_id=id;
dbms_output.put_line('NOM => '||v_data.E_nom||' PRENOM => '||v_data.E_prenom||' DATE DE NAISSANCE => '||v_data.E_date_naiss);
Exception
when no_data_found THEN
dbms_output.put_line(' Eleve inexistant ');
end;
/