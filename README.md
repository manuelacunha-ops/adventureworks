# Adventure Works - Modern Data Platform (Databricks + dbt Cloud)

Este repositório contém a implementação da plataforma de dados da **Adventure Works**, desenvolvida utilizando **Databricks SQL** e **dbt Cloud**. O projeto adota a arquitetura de **Modelagem Dimensional (Star Schema / Kimball)** e prioriza a governança, integridade de dados e auditoria contábil para suporte às decisões executivas.

---

## Visão Geral do Projeto

O objetivo principal deste projeto é estruturar a base de dados bruta da Adventure Works em um ambiente de Data Lakehouse na nuvem, garantindo a transformação dos dados brutos em uma camada analítica confiável (Marts) pronta para consumo em ferramentas de BI (como Power BI).

### Requisito de Auditoria Contábil (CEO Carlos Silveira)
Para garantir total alinhamento com a equipe de auditoria financeira, a plataforma inclui testes automatizados de qualidade de dados. O principal critério de aceite executivo é a validação do valor de **Vendas Brutas (Gross Sales) de 2011**, auditado em **\$12.646.112,16**.

---

## 🔗 Links Necessários

* 🐙 **Repositório GitHub:** `https://github.com/manuelacunha-ops/adventureworks`
* 📊 **Dashboard Executivo (Databricks BI):** `https://dbc-ee9d2bbc-7fea.cloud.databricks.com/dashboardsv3/01f1c152646513aab05581b226c25e51/published?o=7474651259282158`
* ☁️ **Databricks EDA Notebook:** `https://dbc-ee9d2bbc-7fea.cloud.databricks.com/editor/notebooks/3088418784279315?o=7474651259282158`

---

## Arquitetura de Dados

A solução adota a arquitetura em camadas no Databricks (`dev.adventure_works`):

Raw Data (CSVs / Delimitado por Tab) 
  └── Staging Layer (stg_*) ➔ Limpeza, padronização de tipos e renomeação de colunas.
       └── Marts Layer (dim_*, fct_*, bridge_*) ➔ Star Schema modelado para análise executiva.

---

## Modelagem Dimensional (Star Schema)

### Camada de Marts (`models/marts/`)

* **Tabela Fato:**
  * `fact_sales`: Tabela fato no nível de item de pedido (`sales_order_detail_id`). Contém métricas aditivas (`gross_sales`, `net_sales`, `order_qty`, `discount_amount`) e semi-aditivas (`subtotal`, `tax_amt`, `freight`, `total_due`).

* **Tabelas de Dimensão:**
  * `dim_date`: Dimensão de calendário gerada dinamicamente via `dbt_utils.date_spine` (Chave primária: `date_key` no formato `YYYYMMDD`).
  * `dim_product`: Informações de produtos, subcategorias e categorias.
  * `dim_customer`: Cadastros de clientes, pessoas e lojas físicas (`store`).
  * `dim_geography`: Localização geográfica integrada (endereços, cidades, estados e países).
  * `dim_creditcard`: Informações de cartões de crédito e bandeiras.
  * `dim_salesreason`: Motivos de venda associados aos pedidos.
  * `bridge_salesreason`: Tabela ponte para relacionamento N:N entre pedidos e motivos de venda.

---

## Qualidade e Testes de Dados

O projeto conta com uma suíte rigorosa de testes executada pelo dbt (`schema.yml` e testes singulares):

1. **Testes Genéricos (`schema.yml`):**
   * `not_null` e `unique` nas chaves primárias e substitutas de todas as dimensões e fato.
   * `relationships` para garantir a integridade referencial das chaves estrangeiras na `fact_sales` apontando para suas respectivas dimensões.

2. **Teste Singular de Auditoria (`tests/assert_gross_sales_2011.sql`):**
   * Valida se a soma do campo `gross_sales` em `fact_sales` para o ano de 2011 corresponde exatamente ao valor auditado (\$12.646.112,16).

---

## Estrutura de Diretórios

```text
├── models/
│   ├── staging/                 # Modelos de limpeza e padronização das tabelas brutas
│   │   ├── src_adventure_works.yml
│   │   ├── stg_salesorderheader.sql
│   │   ├── stg_salesorderdetail.sql
│   │   ├── stg_product.sql
│   │   └── ...
│   └── marts/                   # Camada final em Star Schema
│       ├── schema.yml           # Documentação de colunas e testes de integridade
│       ├── dim_date.sql         # Gerado via dbt_utils.date_spine
│       ├── dim_product.sql
│       ├── dim_customer.sql
│       ├── dim_geography.sql
│       ├── dim_creditcard.sql
│       ├── dim_salesreason.sql
│       ├── bridge_salesreason.sql
│       └── fact_sales.sql
├── tests/
│   └── assert_gross_sales_2011.sql # Teste singular de auditoria contábil ($12,646,112.16)
├── packages.yml                 # Pacote dbt_utils
├── dbt_project.yml              # Configuração global do projeto dbt
└── README.md                    # Documentação do projeto
```

---

## Como Executar o Projeto

1. **Instalar dependências de pacotes (`dbt_utils`):**
   ```bash
   dbt deps
   ```

2. **Executar a construção dos modelos no Databricks:**
   ```bash
   # Rodar todos os modelos do projeto
   dbt run

   # Rodar apenas a camada de staging
   dbt run --select staging

   # Rodar apenas a camada de marts
   dbt run --select marts
   ```

3. **Executar a suíte de testes de validação:**
   ```bash
   # Executar todos os testes (genéricos + singulares)
   dbt test

   # Executar pontualmente o teste de auditoria de vendas de 2011
   dbt test --select assert_gross_sales_2011
   ```

4. **Gerar a documentação e a Linhagem de Dados (DAG):**
   ```bash
   dbt docs generate
   ```

---

## Stack Tecnológica

* **Databricks SQL Warehouse:** Armazenamento e processamento escalável no Data Lakehouse.
* **dbt Cloud:** Transformação, testes automatizados, documentação e versionamento.
* **`dbt_utils`:** Gerenciamento de séries temporais para a dimensão de data.
* **Git & GitHub:** Controle de versão, pull requests e integração contínua.