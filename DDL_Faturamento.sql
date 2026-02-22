CREATE DATABASE Faturamento_Operacional;

USE Faturamento_Operacional;

CREATE TABLE Lojas (
 ID_Loja INT PRIMARY KEY IDENTITY(1,1),
	Nome_Loja VARCHAR(55),
	Cidade VARCHAR(60),
	UF CHAR(2),
	Tipo_Loja VARCHAR(20)
);

/* Alter table pra adicionar mais caracteres na coluna Nome_Loja*/
ALTER TABLE Lojas ALTER COLUMN Tipo_Loja VARCHAR(50);

------------------------------------------------------------------------

CREATE TABLE Erros_SEFAZ (
 Codigo_Erro INT PRIMARY KEY,
	Descricao_Erro VARCHAR(255),
	Responsabilidade VARCHAR(50),
	Acao_Recomendada VARCHAR(255)
	);

------------------------------------------------------------------------

CREATE TABLE Pedidos (
 ID_Pedido INT PRIMARY KEY IDENTITY(1,1),
	Status_Nfe VARCHAR(20),
	ID_Loja INT,
	Codigo_Erro INT,
	Data_Pedido DATETIME,
	Valor_Total DECIMAL(10,2),
CONSTRAINT FK_Pedidos_Lojas FOREIGN KEY (ID_Loja) REFERENCES Lojas(ID_Loja),
CONSTRAINT FK_Pedidos_Erros FOREIGN KEY (Codigo_Erro) REFERENCES Erros_SEFAZ(Codigo_Erro)
);


