set serveroutput on;
set verify off;

CREATE TABLE t_admin_mercado (
    cd_admin_mercado  NUMBER(4) NOT NULL,
    cd_mercado        NUMBER(3) NOT NULL,
    ds_email          VARCHAR2(100) NOT NULL,
    ds_senha          VARCHAR2(100) NOT NULL
);

SELECT * FROM t_cliente;

COMMENT ON COLUMN t_admin_mercado.cd_admin_mercado IS
    'CHAVE PRIMARIA';

CREATE UNIQUE INDEX t_admin_mercado__idx ON
    t_admin_mercado (
        cd_mercado
    ASC );

ALTER TABLE t_admin_mercado ADD CONSTRAINT pk_t_admin_mercado PRIMARY KEY ( cd_admin_mercado );

CREATE TABLE t_cliente (
    cd_cliente     NUMBER(5) NOT NULL,
    nm_cliente     VARCHAR2(50) NOT NULL,
    ds_email       VARCHAR2(100) NOT NULL,
    ds_genero      VARCHAR2(100),
    ds_senha       VARCHAR2(100) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    nr_telefone    NUMBER(11),
    ds_cpf         VARCHAR2(11) NOT NULL
);

COMMENT ON COLUMN t_cliente.cd_cliente IS
    'CHAVE PRIMARIA';

ALTER TABLE t_cliente ADD CONSTRAINT pk_t_cliente PRIMARY KEY ( cd_cliente );

ALTER TABLE t_cliente ADD CONSTRAINT un_ds_email UNIQUE ( ds_email
                                                         );

ALTER TABLE t_cliente ADD CONSTRAINT un_ds_cpf UNIQUE ( ds_cpf );

CREATE TABLE t_corredor (
    cd_corredor           NUMBER(3) NOT NULL,
    in_sessao_corredor    CHAR(1) NOT NULL,
    cd_setor              NUMBER(3) NOT NULL,
    nr_corredor           NUMBER(2) NOT NULL,
    dt_cadastro_corredor  DATE NOT NULL
);

COMMENT ON COLUMN t_corredor.cd_corredor IS
    'CHAVE PRIAMRIA';

COMMENT ON COLUMN t_corredor.in_sessao_corredor IS
    'CHAVE PRIMARIA';

ALTER TABLE t_corredor ADD CONSTRAINT pk_t_corredor PRIMARY KEY ( cd_corredor,
                                                                  in_sessao_corredor );

CREATE TABLE t_descricao_setor (
    nr_descricao_setor  NUMBER(2) NOT NULL,
    nm_descricao_setor  VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN t_descricao_setor.nr_descricao_setor IS
    'CHAVE PRIMARIA';

ALTER TABLE t_descricao_setor ADD CONSTRAINT pk_t_descricao_setor PRIMARY KEY ( nr_descricao_setor );

CREATE TABLE t_lista (
    cd_lista           NUMBER(6) NOT NULL,
    cd_cliente         NUMBER(5) NOT NULL,
    cd_produtos        NUMBER(4) NOT NULL,
    vl_total_produtos  FLOAT(10) NOT NULL,
    qt_produtos        NUMBER(2) NOT NULL
);

COMMENT ON COLUMN t_lista.cd_lista IS
    'CHAVE PRIMARIA';

ALTER TABLE t_lista
    ADD CONSTRAINT ck_qt_produtos CHECK ( qt_produtos > 0
                                          AND qt_produtos < 70 );

ALTER TABLE t_lista
    ADD CONSTRAINT pk_t_lista PRIMARY KEY ( cd_lista,
                                            cd_cliente,
                                            cd_produtos );

CREATE TABLE t_mercado (
    cd_mercado           NUMBER(3) NOT NULL,
    cd_admin_mercado     NUMBER(4) NOT NULL,
    nm_mercado           VARCHAR2(50) NOT NULL,
    ds_endereco          VARCHAR2(100) NOT NULL,
    ds_mercado           VARCHAR2(100),
    dt_cadastro_mercado  DATE NOT NULL
);

COMMENT ON COLUMN t_mercado.cd_mercado IS
    'CHAVE PRIAMRIA';

CREATE UNIQUE INDEX t_mercado__idx ON
    t_mercado (
        cd_admin_mercado
    ASC );

ALTER TABLE t_mercado ADD CONSTRAINT pk_t_mercado PRIMARY KEY ( cd_mercado );

CREATE TABLE t_produtos (
    cd_produtos         NUMBER(4) NOT NULL,
    cd_corredor         NUMBER(3) NOT NULL,
    in_sessao_corredor  CHAR(1) NOT NULL,
    nm_produtos         VARCHAR2(50) NOT NULL,
    vl_produtos         FLOAT(10) NOT NULL,
    tp_produtos         VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN t_produtos.cd_produtos IS
    'CHAVE PRIMARIA';

ALTER TABLE t_produtos ADD CONSTRAINT pk_t_produtos PRIMARY KEY ( cd_produtos );

CREATE TABLE t_setor (
    cd_setor            NUMBER(3) NOT NULL,
    cd_mercado          NUMBER(3) NOT NULL,
    nr_descricao_setor  NUMBER(2) NOT NULL,
    nm_setor            VARCHAR2(50) NOT NULL,
    ds_setor            VARCHAR2(100),
    dt_cadastro_setor   DATE NOT NULL
);

COMMENT ON COLUMN t_setor.cd_setor IS
    'CHAVE PRIAMRIA';

CREATE UNIQUE INDEX t_setor__idx ON
    t_setor (
        nr_descricao_setor
    ASC );

ALTER TABLE t_setor ADD CONSTRAINT pk_t_setor PRIMARY KEY ( cd_setor );

ALTER TABLE t_admin_mercado
    ADD CONSTRAINT fk_mercado_admin_mercado FOREIGN KEY ( cd_mercado )
        REFERENCES t_mercado ( cd_mercado );


ALTER TABLE t_lista
    ADD CONSTRAINT fk_t_cliente_lista FOREIGN KEY ( cd_cliente )
        REFERENCES t_cliente ( cd_cliente );

ALTER TABLE t_produtos
    ADD CONSTRAINT fk_t_corredor_produtos FOREIGN KEY ( cd_corredor,
                                                        in_sessao_corredor )
        REFERENCES t_corredor ( cd_corredor,
                                in_sessao_corredor );

ALTER TABLE t_setor
    ADD CONSTRAINT fk_t_desc_setor FOREIGN KEY ( nr_descricao_setor )
        REFERENCES t_descricao_setor ( nr_descricao_setor );

ALTER TABLE t_setor
    ADD CONSTRAINT fk_t_mercado_setor FOREIGN KEY ( cd_mercado )
        REFERENCES t_mercado ( cd_mercado );

ALTER TABLE t_lista
    ADD CONSTRAINT fk_t_produtos_lista FOREIGN KEY ( cd_produtos )
        REFERENCES t_produtos ( cd_produtos );

ALTER TABLE t_corredor
    ADD CONSTRAINT fk_t_setor_corredor FOREIGN KEY ( cd_setor )
        REFERENCES t_setor ( cd_setor );

-- tabela t_cliente
insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(1,'João Pedro', 'joao@rmail.com', 'M', '1233214!@#$','22121997', 11965465465, 12345678978 );
insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(2,'Paulo henrique', 'paulo@rmail.com', 'M', '654987#$*&','14051985', 11966666666, 78945612345 );
insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(3,'Maria clara', 'maria@rmail.com', 'F', 'oqwjd8*#$#','01012000', 11945613254, 11122233345 );
insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(0,'Maria clara', 'maria@rmuil.com', 'F', 'oqwjd8*#$#','01012000', 11945613333, 11122234444 );





-- tabela t_descricao_setor
insert into t_descricao_setor(nr_descricao_setor, nm_descricao_setor) values
(1,'Bolachas e biscoitos');

insert into t_descricao_setor(nr_descricao_setor, nm_descricao_setor) values
(2,'Laticínios e derivados');

insert into t_descricao_setor(nr_descricao_setor, nm_descricao_setor) values
(3,'Massas e grãos');

insert into t_descricao_setor(nr_descricao_setor, nm_descricao_setor) values
(0,'Bebidas');








-- tabela t_mercado
insert into t_mercado(cd_mercado, cd_admin_mercado, nm_mercado, ds_endereco, ds_mercado,dt_cadastro_mercado )
values(1,1,'Dia Av Paulista', 'Avenida Paulista nr 2','Mercado localisado na av paulista simples e completo', '20052022');

insert into t_mercado(cd_mercado, cd_admin_mercado, nm_mercado, ds_endereco, ds_mercado,dt_cadastro_mercado )
values(2,2,'Extra da Lapa', 'Rua josé inácio 123','Hipermercado localizado na Lapa', '22052022');

insert into t_mercado(cd_mercado, cd_admin_mercado, nm_mercado, ds_endereco, ds_mercado,dt_cadastro_mercado )
values(3,3,'Carrefour na aclimação', 'rua da aclimação numero 72','Mercado localizado na aclimação com todos os produtos que precisa', '20052022');

insert into t_mercado(cd_mercado, cd_admin_mercado, nm_mercado, ds_endereco, ds_mercado,dt_cadastro_mercado )
values(0,0,'Carrefour na aclimação', 'rua da aclimação numero 72','Mercado localizado na aclimação com todos os produtos que precisa', '20052022');




--tabela t_admin_mercado
insert into t_admin_mercado(cd_admin_mercado, cd_mercado, ds_email, ds_senha)values
(1,1,'diamercadopaulista@email.com','123456789123124');

insert into t_admin_mercado(cd_admin_mercado, cd_mercado, ds_email, ds_senha)values
(2,2,'dmercadolapa@email.com','12awdasd45wd7ad');

insert into t_admin_mercado(cd_admin_mercado, cd_mercado, ds_email, ds_senha)values
(3,3,'mercadoaclimacao@email.com','123456adwda@#!@$d');

insert into t_admin_mercado(cd_admin_mercado, cd_mercado, ds_email, ds_senha)values
(0,0,'mercadocarrefour@email.com','123456agoid@#!@$d');

-- tabela t_setor

insert into t_setor(cd_setor, cd_mercado, nr_descricao_setor, nm_setor, ds_setor, dt_cadastro_setor)
values(1,1,1,'Bolachas e biscoitos','Setor destinado a bolachas e biscoitos', '20052022');

insert into t_setor(cd_setor, cd_mercado, nr_descricao_setor, nm_setor, ds_setor, dt_cadastro_setor)
values(2,1,2,'Laticínios e Derivados','Setor destinado a Laticínios e seus derivados', '22052022');

insert into t_setor(cd_setor, cd_mercado, nr_descricao_setor, nm_setor, ds_setor, dt_cadastro_setor)
values(3,1,3,'Massas e grãos','Setor destinado a Massas, grãos e seus derivados', '20052022');

insert into t_setor(cd_setor, cd_mercado, nr_descricao_setor, nm_setor, ds_setor, dt_cadastro_setor)
values(0,1,0,'Bebidas','Setor destinado a Bbidas e seus derivados', '20052022');






-- teabela t_corredor
insert into t_corredor(cd_corredor, in_sessao_corredor, cd_setor, nr_corredor, dt_cadastro_corredor)
values(1,'A',1,1,'20052022');

insert into t_corredor(cd_corredor, in_sessao_corredor, cd_setor, nr_corredor, dt_cadastro_corredor)
values(2,'B',2,6,'22052022');

insert into t_corredor(cd_corredor, in_sessao_corredor, cd_setor, nr_corredor, dt_cadastro_corredor)
values(3,'C',3,5,'22052022');

insert into t_corredor(cd_corredor, in_sessao_corredor, cd_setor, nr_corredor, dt_cadastro_corredor)
values(0,'F',3,5,'22052022');





--tabela t_produtos
insert into t_produtos(cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, vl_produtos, tp_produtos)
values
(1,1,'A','Bolacha maizena', 2.45,'bolachas e biscoitos');

insert into t_produtos(cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, vl_produtos, tp_produtos)
values
(2,2,'B','Requeijão aviação', 7.85,'Laticínios e derivados');

insert into t_produtos(cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, vl_produtos, tp_produtos)
values
(3,3,'C','Macarrão vitarella', 5.45,'Massas e grãos');

insert into t_produtos(cd_produtos, cd_corredor, in_sessao_corredor, nm_produtos, vl_produtos, tp_produtos)
values
(0,0,'F','Suco de laranja', 5.45,'Bebidas');





--tabela t_lista

insert into t_lista(cd_lista, cd_cliente, cd_produtos, vl_total_produtos, qt_produtos) values
(1,1,1,3.85, 1);

insert into t_lista(cd_lista, cd_cliente, cd_produtos, vl_total_produtos, qt_produtos) values
(2,2,2,7.85, 1);

insert into t_lista(cd_lista, cd_cliente, cd_produtos, vl_total_produtos, qt_produtos) values
(3,3,3,5.45, 1);

insert into t_lista(cd_lista, cd_cliente, cd_produtos, vl_total_produtos, qt_produtos) values
(0,0,0,5.45, 1);


UPDATE t_cliente 
SET nm_cliente = 'José ricardo' 
WHERE cd_cliente = 1;

update t_produtos set vl_produtos = 8.99
where cd_produtos = 3;

update t_setor set ds_setor = 'Setor destinado a produtos perecíveis'
where cd_setor = 1;

delete from t_lista where cd_cliente = 1;

delete from t_cliente where cd_cliente = 1;

delete from t_produtos where cd_produtos = 1;

select vl_produtos, nr_corredor , dt_cadastro_corredor, nm_setor, ds_setor from t_produtos pd inner join t_corredor cd on
pd.cd_corredor = cd.cd_corredor inner join  t_setor s on cd.cd_setor = s.cd_setor  order by nr_corredor;

DECLARE
v_cd_prod NUMBER(4) := 4;

BEGIN

SELECT cd_produtos INTO v_cd_prod FROM t_produtos WHERE cd_produtos = v_cd_prod;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Produto não encontrado!');


/* Procedimento que impede o usúario de deixar o valor de um produto de graça
*/

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

/* Função que verifica se o códio do administrador do mercado é valido ou inválido
*/

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


set serveroutput on;
set verify off;

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

/*
Gatilho que permite a alteração da tabela t_cliente entre as seis da manhã de meia-noite.
*/

create or replace trigger horario before update on t_cliente
begin

if to_char (sysdate, 'HH24') not between '06' and '18' then
RAISE_APPLICATION_ERROR(-20205, 'Não é permitido alterar essa tabela a partir desse horário!');
end if;
end horario;

update t_cliente set ds_senha = 'oqwjd8*#$#123'
where cd_cliente = 3;

select * from t_cliente;

CREATE TABLE t_cliente (
    cd_cliente     NUMBER(5) NOT NULL,
    nm_cliente     VARCHAR2(50) NOT NULL,
    ds_email       VARCHAR2(100) NOT NULL,
    ds_genero      VARCHAR2(100),
    ds_senha       VARCHAR2(100) NOT NULL,
    dt_nascimento  DATE NOT NULL,
    nr_telefone    NUMBER(11),
    ds_cpf         VARCHAR2(11) NOT NULL
);

CREATE TABLE armazenamento_dados (cd_cliente number(5),
nm_cliente varchar2(50),
ds_email varchar2(100),
ds_genero varchar2(100),
ds_senha varchar2(100),
dt_nascimento date,
nr_telefone number(11),
ds_cpf number(11));

/*
Gatilho que realiza as operações de INSERT em uma entidade associativa.
*/
create or replace trigger verifica_cliente after insert or update or delete on t_cliente for each row
declare

begin

if inserting then

insert into armazenamento_dados (cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha,
dt_nascimento, nr_telefone, ds_cpf) values (:new.cd_cliente, :new.nm_cliente, :new.ds_email, 
:new.ds_genero, :new.ds_senha, :new.dt_nascimento, :new.nr_telefone, :new.ds_cpf);

elsif updating then

insert into armazenamento_dados (cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha,
dt_nascimento, nr_telefone, ds_cpf) values (:old.cd_cliente, :new.nm_cliente, :new.ds_email, 
:new.ds_genero, :new.ds_senha, :old.dt_nascimento, :new.nr_telefone, :old.ds_cpf);

elsif deleting then

insert into armazenamento_dados (cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha,
dt_nascimento, nr_telefone, ds_cpf) values (:old.cd_cliente, :new.nm_cliente, :new.ds_email, 
:new.ds_genero, :new.ds_senha, :new.dt_nascimento, :new.nr_telefone, :new.ds_cpf);

end if;

end verifica_cliente;

insert into t_cliente(cd_cliente, nm_cliente, ds_email, ds_genero, ds_senha, dt_nascimento, nr_telefone, ds_cpf)
values(4,'Ana Silva', 'ana@rmorl.com', 'F', 'oqipd8*#$#','01012120', 11235517333, 12142238744 );

update t_cliente set nm_cliente ='Paulo henrique', ds_email ='paulo123@rmail.com' , ds_genero='M',
ds_senha='654987#$*&', dt_nascimento ='14051985', nr_telefone=11966666666, ds_cpf =10945612345
where cd_cliente = 2;

delete from t_cliente where cd_cliente  = 4;

select * from t_cliente;
select * from armazenamento_dados;

