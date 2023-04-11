/* 
Empacotamento do procedimento e das funções da ultima entrega.
*/

CREATE OR REPLACE PACKAGE pacote 
as
function validar_admin (c_cd t_admin_mercado.cd_admin_mercado%type)
return number;
function validar_cliente (c_cd t_cliente.cd_cliente%type)
return number;
function validar_corredor (c_cd t_corredor.cd_corredor%type)
return number;
function validar_numero_setor (n_nr t_descricao_setor.nr_descricao_setor%type)
return number;
function validar_lista (c_cd t_lista.cd_lista%type)
return number;
function validar_mercado (c_cd t_mercado.cd_mercado%type)
return number;
function validar_produto (c_cd t_produtos.cd_produtos%type)
return number;
function validar_setor (c_cd t_setor.cd_setor%type)
return number;
END pacote;


CREATE OR REPLACE PACKAGE BODY pacote
AS
function validar_admin (c_cd t_admin_mercado.cd_admin_mercado%type)
return number
is
v_cd t_admin_mercado.cd_admin_mercado%type;
begin
select cd_admin_mercado into v_cd from t_admin_mercado where cd_admin_mercado = c_cd;
return v_cd;
end validar_admin;
function validar_cliente (c_cd t_cliente.cd_cliente%type)
return number
is
v_cd t_cliente.cd_cliente%type;
begin
select cd_cliente into v_cd from t_cliente where cd_cliente = c_cd;
return v_cd;
end validar_cliente;
function validar_corredor (c_cd t_corredor.cd_corredor%type)
return number
is
v_cd t_corredor.cd_corredor%type;
begin
select cd_corredor into v_cd from t_corredor where cd_corredor = c_cd;
return v_cd;
end validar_corredor;
function validar_numero_setor (n_nr t_descricao_setor.nr_descricao_setor%type)
return number
is
v_nr t_descricao_setor.nr_descricao_setor%type;
begin
select nr_descricao_setor into v_nr from t_descricao_setor where nr_descricao_setor = n_nr;
return v_nr;
end validar_numero_setor;
function validar_lista (c_cd t_lista.cd_lista%type)
return number
is
v_cd t_lista.cd_lista%type;
begin
select cd_lista into v_cd from t_lista where cd_lista = c_cd;
return v_cd;
end validar_lista;
function validar_mercado (c_cd t_mercado.cd_mercado%type)
return number
is
v_cd t_mercado.cd_mercado%type;
begin
select cd_mercado into v_cd from t_mercado where cd_mercado = c_cd;
return v_cd;
end validar_mercado;
function validar_produto (c_cd t_produtos.cd_produtos%type)
return number
is
v_cd t_produtos.cd_produtos%type;
begin
select cd_produtos into v_cd from t_produtos where cd_produtos = c_cd;
return v_cd;
end validar_produto;
function validar_setor (c_cd t_setor.cd_setor%type)
return number
is
v_cd t_setor.cd_setor%type;
begin
select cd_setor into v_cd from t_setor where cd_setor = c_cd;
return v_cd;
end validar_setor;
procedure restricao  (i_cd t_produtos.cd_produtos%type, 
i_corredor t_produtos.cd_corredor%type, i_sessao t_produtos.in_sessao_corredor%type, 
i_nm t_produtos.nm_produtos%type, i_preco t_produtos.vl_produtos%type, 
i_tp t_produtos.tp_produtos%type)
is
begin
if i_preco > 0.00 then
insert into t_produtos (cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, 
vl_produtos, tp_produtos) values (i_cd, i_corredor, i_sessao, i_nm, i_preco, i_tp);
else
dbms_output.put_line('Não é permitido inserir um produto com um valor abaixo ou igual a 0.00');
end if;
exception
when dup_val_on_index then
DBMS_OUTPUT.PUT_LINE('Valores duplicados não são permitidos');
when others then
DBMS_OUTPUT.PUT_LINE('Por favor aguarde, um dos nossos operadores ira atende-lo');
end restricao;

end pacote;
