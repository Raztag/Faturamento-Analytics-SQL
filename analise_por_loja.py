import pyodbc
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

server = r'MTZNOTFS061617\SQLEXPRESS'
database = 'Faturamento_Operacional'
conn_str = f"Driver={{SQL Server}};Server={server};Database={database};Trusted_Connection=yes;"

try:
    conn = pyodbc.connect(conn_str)

    #Query do banco
    query = """
            SELECT ID_Loja, \
                   COUNT(*)         AS Total_Rejeitadas, \
                   SUM(Valor_Total) AS Valor_Total_Impactado
            FROM Pedidos
            WHERE Status_NFe = 'Rejeitada'
            GROUP BY ID_Loja
            ORDER BY Valor_Total_Impactado DESC \
            """

    df = pd.read_sql(query, conn)

    # Grafico
    plt.figure(figsize=(12, 6))
    sns.set_theme(style="whitegrid")

    #Ajuste na cor para mais escuro
    grafico = sns.barplot(
        data=df,
        x='ID_Loja',
        y='Valor_Total_Impactado',
        palette='Oranges_r'
    )

    #Ajuste 2 insere rótulos de valor para melhorar visualização
    for p in grafico.patches:
        grafico.annotate(f'R$ {p.get_height():.2f}',
                         (p.get_x() + p.get_width() / 2., p.get_height()),
                         ha='center', va='center',
                         xytext=(0, 9),
                         textcoords='offset points')

    plt.title('Ranking de Lojas por Impacto Financeiro (Notas Rejeitadas)', fontsize=18)
    plt.ylabel('Valor em R$', fontsize=12)
    plt.xlabel('Número da Loja (Filial)', fontsize=16)

    plt.tight_layout()
    plt.savefig('grafico_impacto_por_loja.png', dpi=300)
    print("Gráfico de impacto por loja gerado com sucesso!")

except Exception as e:
    print(f" Erro: {e}")
finally:
    if 'conn' in locals(): conn.close()