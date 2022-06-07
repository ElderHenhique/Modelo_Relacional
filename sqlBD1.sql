DROP TABLE IF EXISTS ENTREGA ,FORNECEM, FORNECEDORES, CONTEM, INCLUEM, VENDAS, COMPRAM, PRODUTOS, TRABALHAM_NO, SETORES, TEM, Tempo_de_Trabalho, ENDERECO, CLIENTE, FUNCIONARIO ,PESSOA;

CREATE TABLE PESSOA(
	cpf CHAR(11),
    sexo VARCHAR(20),
    nome VARCHAR(50),
    PRIMARY KEY(cpf)
    );

CREATE TABLE FUNCIONARIO(
	cpf_pessoa CHAR(11),
	cargo VARCHAR(50),
    informacoes_de_contrato VARCHAR(100),
    salario REAL,
    PRIMARY KEY(cpf_pessoa),
    FOREIGN KEY(cpf_pessoa) REFERENCES PESSOA(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CLIENTE(
	cpf_pessoa CHAR(11),
	preferencia VARCHAR(50),
    cadastro VARCHAR(100),
    classe_social VARCHAR(50),
    PRIMARY KEY(cpf_pessoa),
    FOREIGN KEY(cpf_pessoa) REFERENCES PESSOA(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ENDERECO(
	cidade VARCHAR(100),
    rua VARCHAR(100),
    numero INTEGER,
    cpf_pessoa CHAR(11),
    PRIMARY KEY(cidade, cpf_pessoa),
    FOREIGN KEY(cpf_pessoa) REFERENCES PESSOA(cpf) ON DELETE CASCADE
);

CREATE TABLE Tempo_de_Trabalho(
	id INTEGER,
    desde DATE,
    ate DATE,
    PRIMARY KEY(id),
    cpf_pessoa CHAR(11),
    FOREIGN KEY(cpf_pessoa) REFERENCES FUNCIONARIO(cpf_pessoa)
);

CREATE TABLE TEM(
	cpf_func CHAR(11),
	id_tempo INTEGER,
    PRIMARY KEY(cpf_func, id_tempo),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIO(cpf_pessoa),
	FOREIGN KEY(id_tempo) REFERENCES Tempo_de_Trabalho(id)
);

CREATE TABLE SETORES(
	tipo_de_produto VARCHAR(50),
	nome VARCHAR(50),
    informacoes VARCHAR(100),
    PRIMARY KEY(tipo_de_produto)
);

CREATE TABLE TRABALHAM_NO(
	tipo_de_produto VARCHAR(50),
    cpf_func CHAR(11),
    PRIMARY KEY(tipo_de_produto, cpf_func),
    FOREIGN KEY(tipo_de_produto) REFERENCES SETORES(tipo_de_produto),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIO(cpf_pessoa)
);

CREATE TABLE PRODUTOS(
	codigo INTEGER,
    nome VARCHAR(50),
    preco REAL,
    PRIMARY KEY(codigo)
);

CREATE TABLE COMPRAM(
	cpf_cliente CHAR(11),
	codigo_prod INTEGER,
    PRIMARY KEY(cpf_cliente, codigo_prod),
    FOREIGN KEY(cpf_cliente) REFERENCES CLIENTE(cpf_pessoa),
    FOREIGN KEY(codigo_prod) REFERENCES PRODUTOS(codigo)
);

CREATE TABLE VENDAS(
	id INTEGER,
    valor REAL,
    detalhes VARCHAR(100),
    id_vendas INTEGER,
    PRIMARY KEY(id),
	FOREIGN KEY(id_vendas) REFERENCES VENDAS(id)
);

CREATE TABLE INCLUEM(
	codigo_produtos INTEGER,
	id_vendas INTEGER,
    qtde INTEGER,
    tipo_de_pagamento VARCHAR(50),
    PRIMARY KEY(codigo_produtos, id_vendas),
    FOREIGN KEY(codigo_produtos) REFERENCES PRODUTOS(codigo),
    FOREIGN KEY(id_vendas) REFERENCES VENDAS(id)
);

CREATE TABLE CONTEM(
	tipo_de_produto VARCHAR(50),
	codigo INTEGER,
    qtde INTEGER,
    PRIMARY KEY(tipo_de_produto, codigo),
    FOREIGN KEY(tipo_de_produto) REFERENCES SETORES(tipo_de_produto),
    FOREIGN KEY(codigo) REFERENCES PRODUTOS(codigo)
);

CREATE TABLE FORNECEDORES(
	cod_forn INTEGER,
	nome VARCHAR(50),
    localizacao VARCHAR(50),
    PRIMARY KEY(cod_forn)
);

CREATE TABLE FORNECEM(
	codigo INTEGER,
	cod_forn INTEGER,
    PRIMARY KEY(codigo, cod_forn),
    FOREIGN KEY(codigo) REFERENCES PRODUTOS(codigo),
	FOREIGN KEY(cod_forn) REFERENCES FORNECEDORES(cod_forn)
);

CREATE TABLE ENTREGA(
	cpf_func CHAR(11),
    id_vendas INTEGER,
    telefone VARCHAR(50),
    tempo_estimado VARCHAR(50),
    numero_da_entrega INTEGER,
    PRIMARY KEY(numero_da_entrega, id_vendas),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIO(cpf_pessoa),
    FOREIGN KEY(id_vendas) REFERENCES VENDAS(id) ON DELETE CASCADE
);
