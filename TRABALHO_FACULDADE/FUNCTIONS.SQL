create or replace function validar_admin (c_cd t_admin_mercado.cd_admin_mercado%type)
return number
is
v_cd t_admin_mercado.cd_admin_mercado%type;
begin

select cd_admin_mercado into v_cd from t_admin_mercado where cd_admin_mercado = c_cd;

return v_cd;

end validar_admin;

begin
if validar_admin (1) > 0 then
dbms_output.put_line('Administrador validado');
else
dbms_output.put_line('Administrador inválido');
end if;
exception
when no_data_found then
dbms_output.put_line('Código do administrador não encontrado para ser validado');
when value_error then
dbms_output.put_line('Apenas valores númericos são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end;


/* Função que verifica se o códio do cliente é valido ou inválido
*/

create or replace function validar_cliente (c_cd t_cliente.cd_cliente%type)
return number
is
v_cd t_cliente.cd_cliente%type;
begin

select cd_cliente into v_cd from t_cliente where cd_cliente = c_cd;

return v_cd;

end validar_cliente;

begin
if validar_cliente (0) > 0 then
dbms_output.put_line('Cliente validado');
else
dbms_output.put_line('Cliente inválido');
end if;
exception
when no_data_found then
dbms_output.put_line('Código do cliente não encontrado para ser validado');
when value_error then
dbms_output.put_line('Apenas valores númericos são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end;

/* Função que verifica se o códio do corredor é valido ou inválido
*/

create or replace function validar_corredor (c_cd t_corredor.cd_corredor%type)
return number
is
v_cd t_corredor.cd_corredor%type;
begin

select cd_corredor into v_cd from t_corredor where cd_corredor = c_cd;

return v_cd;

end validar_corredor;

begin
if validar_corredor (0) > 0 then
dbms_output.put_line('Corredor validado');
else
dbms_output.put_line('Corredor inválido');
end if;
exception
when no_data_found then
dbms_output.put_line('Código do corredor não encontrado para ser validado');
when value_error then
dbms_output.put_line('Apenas valores númericos são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end;

/* Função que verifica se o número do setor é valido ou inválido
*/

create or replace function validar_numero_setor (n_nr t_descricao_setor.nr_descricao_setor%type)
return number
is
v_nr t_descricao_setor.nr_descricao_setor%type;
begin

select nr_descricao_setor into v_nr from t_descricao_setor where nr_descricao_setor = n_nr;

return v_nr;

end validar_numero_setor;

begin
if validar_numero_setor (0) > 0 then
dbms_output.put_line('Número do corredor validado');
else
dbms_output.put_line('Número do corredor inválido');
end if;
exception
when no_data_found then
dbms_output.put_line('Número do corredor não encontrado para ser validado');
when value_error then
dbms_output.put_line('Apenas valores númericos são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end;

/* Função que verifica se o códio da lista é valido ou inválido
*/

create or replace function validar_lista (c_cd t_lista.cd_lista%type)
return number
is
v_cd t_lista.cd_lista%type;
begin

select cd_lista into v_cd from t_lista where cd_lista = c_cd;

return v_cd;

end validar_lista;

begin
if validar_lista (0) > 0 then
dbms_output.put_line('Lista validada');
else
dbms_output.put_line('Lista inválida');
end if;
exception
when no_data_found then
dbms_output.put_line('Código da lista não encontrado para ser validado');
when value_error then
dbms_output.put_line('Apenas valores númericos são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end;

/* Função que verifica se o códio do mercado é valido ou inválido
*/

create or replace function validar_mercado (c_cd t_mercado.cd_mercado%type)
return number
is
v_cd t_mercado.cd_mercado%type;
begin

select cd_mercado into v_cd from t_mercado where cd_mercado = c_cd;

return v_cd;

end validar_mercado;

begin
if validar_mercado (0) > 0 then
dbms_output.put_line('Mercado validado');
else
dbms_output.put_line('Mercado inválido');
end if;
exception
when no_data_found then
dbms_output.put_line('Código do Mercado não encontrado para ser validado');
when value_error then
dbms_output.put_line('Apenas valores númericos são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end;

/* Função que verifica se o códio do produto é valido ou inválido
*/

create or replace function validar_produto (c_cd t_produtos.cd_produtos%type)
return number
is
v_cd t_produtos.cd_produtos%type;
begin

select cd_produtos into v_cd from t_produtos where cd_produtos = c_cd;

return v_cd;

end validar_produto;

begin
if validar_produto (0) > 0 then
dbms_output.put_line('Produto validado');
else
dbms_output.put_line('Produto inválido');
end if;
exception
when no_data_found then
dbms_output.put_line('Código do produto não encontrado para ser validado');
when value_error then
dbms_output.put_line('Apenas valores númericos são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end;

/* Função que verifica se o códio do setor é valido ou inválido
*/

create or replace function validar_setor (c_cd t_setor.cd_setor%type)
return number
is
v_cd t_setor.cd_setor%type;
begin

select cd_setor into v_cd from t_setor where cd_setor = c_cd;

return v_cd;

end validar_setor;

begin
if validar_setor (0) > 0 then
dbms_output.put_line('Setor validado');
else
dbms_output.put_line('Setor inválido');
end if;
exception
when no_data_found then
dbms_output.put_line('Código do setor não encontrado para ser validado');
when value_error then
dbms_output.put_line('Apenas valores númericos são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end;

select * from t_admin_mercado;
select * from t_cliente;
select * from t_corredor;
select * from t_lista;
select * from t_descricao_setor;
select * from t_mercado;
select * from t_produtos;
select * from t_setor;