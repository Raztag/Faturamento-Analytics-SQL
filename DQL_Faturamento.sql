USE Faturamento_Operacional;
GO

/*Ranking de Responsabilidades por Erros de Rejeição*/
SELECT 
    E.Responsabilidade,
    COUNT(P.ID_Pedido) AS Total_Ocorrencias,
    FORMAT(SUM(P.Valor_Total), 'C', 'pt-BR') AS Valor_Total_Retido
FROM Pedidos P
JOIN Erros_SEFAZ E ON P.Codigo_Erro = E.Codigo_Erro
WHERE P.Status_NFe = 'Rejeitada'
GROUP BY E.Responsabilidade
ORDER BY SUM(P.Valor_Total) DESC;

-----------------------------------------------------------------------

/*Ranking de Lojas com Maior Volume de Rejeição*/
SELECT 
    L.Nome_Loja,
    L.Cidade,
    COUNT(P.ID_Pedido) AS Quantidade_Rejeicoes,
    FORMAT(SUM(P.Valor_Total), 'C', 'pt-BR') AS Valor_Total_Travado
FROM Pedidos P
JOIN Lojas L ON P.ID_Loja = L.ID_Loja
WHERE P.Status_NFe = 'Rejeitada'
GROUP BY L.Nome_Loja, L.Cidade
ORDER BY SUM(P.Valor_Total) DESC;

-----------------------------------------------------------------------

/*Ranking de Erros de Rejeição com Responsabilidade de TI*/
SELECT 
    E.Codigo_Erro,
    E.Descricao_Erro,
    COUNT(P.ID_Pedido) AS Frequencia
FROM Pedidos P
JOIN Erros_SEFAZ E ON P.Codigo_Erro = E.Codigo_Erro
WHERE E.Responsabilidade LIKE '%TI%'
GROUP BY E.Codigo_Erro, E.Descricao_Erro
ORDER BY Frequencia DESC;

-----------------------------------------------------------------------

/*Ranking de Erros de Rejeição por período do dia*/
SELECT 
    DATEPART(HOUR, Data_Pedido) AS Hora_do_Dia,
    COUNT(*) AS Total_Pedidos,
    SUM(CASE WHEN Status_NFe = 'Rejeitada' THEN 1 ELSE 0 END) AS Total_Rejeitados
FROM Pedidos
GROUP BY DATEPART(HOUR, Data_Pedido)
ORDER BY Hora_do_Dia;
