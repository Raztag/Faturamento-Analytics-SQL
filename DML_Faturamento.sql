USE Faturamento_Operacional;
GO

/*Desligar o modo automático dos ID's*/
SET IDENTITY_INSERT Lojas ON;

INSERT INTO Lojas (ID_Loja, Nome_Loja, Cidade, UF, Tipo_Loja) VALUES
(1,   'Quero-Quero - CD Logístico', 'Cachoeirinha', 'RS', 'Centro de Distribuição'),
(10,  'Quero-Quero - Porto Alegre Centro', 'Porto Alegre', 'RS', 'Varejo'),
(11,  'Quero-Quero - Porto Alegre Zona Sul', 'Porto Alegre', 'RS', 'Varejo'),
(12,  'Quero-Quero - Porto Alegre Assis Brasil', 'Porto Alegre', 'RS', 'Varejo'),
(102, 'Quero-Quero - Passo Fundo Centro', 'Passo Fundo', 'RS', 'Varejo'),
(205, 'Quero-Quero - Santa Maria Bozano', 'Santa Maria', 'RS', 'Varejo'),
(310, 'Quero-Quero - Pelotas Dom Pedro', 'Pelotas', 'RS', 'Varejo'),
(450, 'Quero-Quero - Caxias Shopping', 'Caxias do Sul', 'RS', 'Varejo'),
(500, 'Quero-Quero - Viamão Centro', 'Viamão', 'RS', 'Varejo');

/*Aqui liga a configuração denovo*/
SET IDENTITY_INSERT Lojas OFF;

------------------------------------------------------------------------

INSERT INTO Erros_SEFAZ (Codigo_Erro, Descricao_Erro, Responsabilidade, Acao_Recomendada) VALUES
(100, 'Autorizado com Sucesso', 'Operacional', 'Nenhuma - Seguir fluxo de expedição'),
(225, 'Falha no Schema XML', 'TI / Sistemas', 'Acionar suporte técnico do ERP'),
(610, 'CPF do Destinatário Inválido', 'Cadastro / Loja', 'Solicitar documento e corrigir no ERP'),
(703, 'Data-Hora de Emissão Atrasada', 'Operacional / Faturamento', 'Sincronizar relógio do servidor ou reabrir turno'),
(539, 'Duplicidade de NF-e', 'TI', 'Verificar se a nota já foi transmitida anteriormente'),
(531, 'Erro de Cálculo: Total do ICMS difere dos Itens', 'TI / Fiscal', 'Revisar regras de tributação no ERP'),
(245, 'CNPJ do Cliente Inativo ou Irregular na SEFAZ', 'Cadastro / Cliente', 'Consultar Sintegra e solicitar regularização ao cliente');

-------------------------------------------------------------------------

/* Pra evitar conflito */ /*DELETE FROM Pedidos;*/
/* Pra ajustar o formato da data */ /*SET DATEFORMAT YMD;*/

INSERT INTO Pedidos (Status_NFe, ID_Loja, Codigo_Erro, Data_Pedido, Valor_Total) VALUES
('Autorizada', 1, 100, '2026-02-22 07:30:00', 45000.00), 
('Rejeitada', 1, 703, '2026-02-22 08:00:00', 12500.00),
('Autorizada', 10, 100, '2026-02-22 08:15:00', 1250.00),  
('Rejeitada', 11, 610, '2026-02-22 09:00:00', 3400.00),  
('Rejeitada', 12, 245, '2026-02-22 09:30:00', 8500.00),  
('Autorizada', 102, 100, '2026-02-22 10:45:00', 560.00),   
('Rejeitada', 205, 531, '2026-02-22 11:15:00', 2100.00),  
('Autorizada', 310, 100, '2026-02-22 12:00:00', 980.00),   
('Rejeitada', 1, 225, '2026-02-22 13:30:00', 32000.00), 
('Autorizada', 450, 100, '2026-02-22 14:15:00', 4500.00),  
('Rejeitada', 500, 610, '2026-02-22 15:00:00', 150.00),   
('Autorizada', 1, 100, '2026-02-22 15:30:00', 28000.00), 
('Rejeitada', 10, 245, '2026-02-22 16:00:00', 12000.00), 
('Rejeitada', 1, 531, '2026-02-22 16:45:00', 15600.00), 
('Autorizada', 11, 100, '2026-02-22 17:15:00', 3200.00),
('Autorizada', 1, 100, '2026-02-23 07:10:00', 52000.00),
('Rejeitada', 1, 703, '2026-02-23 07:45:00', 18500.00), 
('Autorizada', 10, 100, '2026-02-23 08:20:00', 2100.50),
('Rejeitada', 10, 610, '2026-02-23 08:45:00', 1500.00),
('Autorizada', 11, 100, '2026-02-23 09:15:00', 3800.00),
('Rejeitada', 102, 245, '2026-02-23 09:40:00', 12400.00), 
('Autorizada', 205, 100, '2026-02-23 10:00:00', 950.00),
('Rejeitada', 1, 225, '2026-02-23 10:30:00', 45000.00), 
('Autorizada', 310, 100, '2026-02-23 13:15:00', 450.00),
('Rejeitada', 450, 610, '2026-02-23 13:45:00', 3200.00),
('Autorizada', 500, 100, '2026-02-23 14:10:00', 1800.00),
('Rejeitada', 1, 531, '2026-02-23 14:30:00', 22000.00), 
('Autorizada', 12, 100, '2026-02-23 15:00:00', 6700.00),
('Rejeitada', 11, 610, '2026-02-23 15:30:00', 120.00),
('Autorizada', 102, 100, '2026-02-23 15:50:00', 4300.00),
('Rejeitada', 205, 703, '2026-02-23 16:10:00', 5600.00), 
('Autorizada', 310, 100, '2026-02-23 16:30:00', 1100.00),
('Rejeitada', 1, 245, '2026-02-23 17:00:00', 35000.00), 
('Autorizada', 450, 100, '2026-02-23 17:20:00', 2900.00),
('Autorizada', 1, 100, '2026-02-23 17:45:00', 60000.00), 
('Rejeitada', 10, 610, '2026-02-23 18:00:00', 300.00),
('Autorizada', 500, 100, '2026-02-23 18:15:00', 1450.00),
('Rejeitada', 12, 539, '2026-02-23 18:30:00', 900.00),  
('Autorizada', 1, 100, '2026-02-23 18:45:00', 15000.00),
('Rejeitada', 102, 610, '2026-02-23 19:00:00', 250.00),
('Autorizada', 205, 100, '2026-02-23 19:15:00', 3200.00),
('Rejeitada', 1, 225, '2026-02-23 19:30:00', 28000.00),
('Autorizada', 310, 100, '2026-02-23 19:45:00', 600.00),
('Rejeitada', 11, 245, '2026-02-23 20:00:00', 4100.00),
('Autorizada', 450, 100, '2026-02-23 20:15:00', 1200.00);