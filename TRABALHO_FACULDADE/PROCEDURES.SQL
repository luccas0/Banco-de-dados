create or replace procedure restricao  (i_cd t_produtos.cd_produtos%type, 
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

begin
restricao (1, 1, 'C', 'Pepsi', 0, 'Bebidas');
exception
when value_error then
dbms_output.put_line('Valor inválido');
end;

select * from t_produtos;