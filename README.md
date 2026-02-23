# 📊 Monitoramento de Rejeições Fiscais - Estudo de Caso: Lojas Quero-Quero

## 📋 Sobre o Projeto
Este projeto simula um ambiente real de faturamento e logística da rede **Lojas Quero-Quero**. O objetivo é identificar gargalos operacionais que impedem a emissão de Notas Fiscais de Saída, causando retenção de mercadorias no Centro de Distribuição (Cachoeirinha) e nas filiais.

A solução utiliza **SQL Server** para estruturar os dados e classificar os erros da SEFAZ por **Responsabilidade**, permitindo ações rápidas das equipes de TI, Cadastro ou Operacional.

## 🏗️ Estrutura do Banco de Dados (Modelagem)
O banco foi estruturado seguindo o modelo estrela (Star Schema):
- **Pedidos:** Contém o histórico de transações, valores e status das NF-e.
- **Lojas:** Cadastro real das filiais (Porto Alegre, Cachoeirinha, Passo Fundo, etc).
- **Erros_SEFAZ:** Dicionário estratégico de rejeições (703, 610, 245, etc) com definição de quem deve resolver o problema.

## 🛠️ Tecnologias Utilizadas
- **SQL Server:** Construção do banco (DDL), inserção de dados (DML) e consultas analíticas (DQL).
- **brModelo:** Modelagem conceitual e lógica.
- **Power BI (Em breve):** Dashboards para visualização de impacto financeiro.

## 🚀 Desafios Superados (Aprendizados)
- **Integridade Referencial:** Configuração de Chaves Estrangeiras (FK) para garantir que nenhum pedido seja registrado com uma loja ou erro inexistente.
- **Gestão de Identidade:** Uso de `IDENTITY(1,1)` para automação de IDs e tratamento de erros de inserção (`SET IDENTITY_INSERT`).
- **Saneamento de Dados:** Ajuste de tipos de dados (`VARCHAR`) para evitar truncamento de descrições longas.
- **Domínio de Negócio:** Entendimento do fluxo de **Turno Aberto** e validação de **CNPJ/CPF** para evitar rejeições da SEFAZ.

## 📈 Exemplo de Insight Gerado
Através da consulta de agregação, identificamos que a **Rejeição 703 (Data-Hora de Emissão Atrasada)** no CD de Cachoeirinha é o principal fator de retenção de carga por valor financeiro, indicando a necessidade de treinamento operacional no fechamento/abertura de turnos.

## 🔍 Análise de Impacto Financeiro (A Query Principal)

O coração da análise de dados deste projeto reside em identificar não apenas **quais** erros ocorrem, mas **quanto** dinheiro eles estão travando na expedição. 

A consulta abaixo cruza as transações da tabela Fato com o Dicionário de Erros (Dimensão), filtrando apenas as notas rejeitadas. Em seguida, os dados são agrupados por departamento responsável, gerando um ranking do maior para o menor impacto financeiro.

---------------

Feature Visualização com Python

## 🛠️ Tecnologias Utilizadas
* **Banco de Dados:** SQL Server (Scripts DDL, DML e DQL)
* **Linguagem:** Python 3.12
* **Bibliotecas:** Pandas (Tratamento), PyODBC (Conexão), Matplotlib/Seaborn (Visualização)

----------------

## 📂 Como utilizar
1. Execute os scripts `.sql` na ordem numérica para criar e popular o banco.
2. Configure a conexão no arquivo `.py` com os dados do seu servidor.
3. Rode o script Python para atualizar os insights visuais.

----------------

Projeto desenvolvido para fins de estudo e portfólio.


```sql
SELECT 
    E.Responsabilidade,
    COUNT(P.ID_Pedido) AS Total_Ocorrencias,
    FORMAT(SUM(P.Valor_Total), 'C', 'pt-BR') AS Valor_Total_Retido
FROM Pedidos P
JOIN Erros_SEFAZ E ON P.Codigo_Erro = E.Codigo_Erro
WHERE P.Status_NFe = 'Rejeitada'
GROUP BY E.Responsabilidade
ORDER BY SUM(P.Valor_Total) DESC;
