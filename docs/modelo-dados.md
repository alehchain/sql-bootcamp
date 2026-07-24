# Modelo de dados — Loja Virtual

## Visão geral

O banco foi criado para suportar exercícios de consulta, manipulação, modelagem, PL/SQL, auditoria e performance.

```mermaid
erDiagram
    CATEGORIAS {
        NUMBER categoria_id PK
        VARCHAR2 nome UK
        VARCHAR2 descricao
        CHAR ativo
    }
    FORNECEDORES {
        NUMBER fornecedor_id PK
        VARCHAR2 razao_social
        VARCHAR2 cnpj UK
        VARCHAR2 email
    }
    PRODUTOS {
        NUMBER produto_id PK
        NUMBER categoria_id FK
        NUMBER fornecedor_id FK
        VARCHAR2 nome
        NUMBER preco
        NUMBER custo
        CHAR ativo
    }
    CLIENTES {
        NUMBER cliente_id PK
        VARCHAR2 nome
        VARCHAR2 email UK
        VARCHAR2 cpf UK
        DATE data_cadastro
    }
    PEDIDOS {
        NUMBER pedido_id PK
        NUMBER cliente_id FK
        NUMBER transportadora_id FK
        DATE data_pedido
        VARCHAR2 status
        NUMBER valor_total
    }
    ITENS_PEDIDO {
        NUMBER item_pedido_id PK
        NUMBER pedido_id FK
        NUMBER produto_id FK
        NUMBER quantidade
        NUMBER preco_unitario
    }
    CATEGORIAS ||--o{ PRODUTOS : possui
    FORNECEDORES ||--o{ PRODUTOS : fornece
    CLIENTES ||--o{ PEDIDOS : realiza
    PEDIDOS ||--|{ ITENS_PEDIDO : contém
    PRODUTOS ||--o{ ITENS_PEDIDO : vendido_em
```

## Convenções

- Chaves primárias terminam com `_id`.
- Datas de criação usam `DEFAULT SYSDATE`.
- Flags utilizam `CHAR(1)` e `CHECK` com valores `S` e `N`.
- Valores monetários utilizam `NUMBER(12,2)`.
- Nomes de objetos não utilizam acentos.
