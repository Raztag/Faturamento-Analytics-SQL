import pyodbc
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 1. Configurações de Conexão
server = r'MTZNOTFS061617\SQLEXPRESS'
database = 'Faturamento_Operacional'
conn_str = f"Driver={{SQL Server}};Server={server};Database={database};Trusted_Connection=yes;"

try:
    # 2. Conectar e buscar dados
    conn = pyodbc.connect(conn_str)
    query = """
            SELECT E.Responsabilidade, \
                   SUM(P.Valor_Total) AS Valor_Total_Retido
            FROM Pedidos P
                     JOIN Erros_SEFAZ E ON P.Codigo_Erro = E.Codigo_Erro
            WHERE P.Status_NFe = 'Rejeitada'
            GROUP BY E.Responsabilidade \
            """
    df = pd.read_sql(query, conn)

    # 3. Criar o Visual (Sem letras encavaladas)
    plt.figure(figsize=(10, 6))
    sns.set_theme(style="whitegrid")

    # Criando o gráfico e corrigindo o aviso de 'palette'
    grafico = sns.barplot(
        data=df,
        x='Responsabilidade',
        y='Valor_Total_Retido',
        hue='Responsabilidade',
        palette='Reds_d',
        legend=False
    )

    # A MÁGICA PARA AS LETRAS: Inclinando 45 graus
    plt.xticks(rotation=45, ha='right')

    plt.title('Impacto Financeiro por Responsabilidade (Notas Rejeitadas)', fontsize=14)
    plt.ylabel('Total Retido (R$)', fontsize=12)
    plt.xlabel('Departamento Responsável', fontsize=12)

    # Ajusta o gráfico para não cortar as legendas inclinadas
    plt.tight_layout()

    # 4. Salvar (Substitui o arquivo antigo automaticamente)
    plt.savefig('grafico_impacto_financeiro.png', dpi=300)
    print("🚀 Sucesso! O gráfico atualizado foi gerado na pasta do projeto.")

except Exception as e:
    print(f"❌ Erro detectado: {e}")

finally:
    if 'conn' in locals():
        conn.close()