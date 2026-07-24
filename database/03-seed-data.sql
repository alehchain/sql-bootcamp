-- ============================================================
-- Dados fictícios para exercícios
-- ============================================================

INSERT ALL
    INTO categorias VALUES (1, 'Eletrônicos', 'Equipamentos e acessórios eletrônicos', 'S')
    INTO categorias VALUES (2, 'Informática', 'Computadores, componentes e periféricos', 'S')
    INTO categorias VALUES (3, 'Casa', 'Produtos para casa e cozinha', 'S')
    INTO categorias VALUES (4, 'Livros', 'Livros técnicos e literatura', 'S')
    INTO categorias VALUES (5, 'Esportes', 'Produtos esportivos', 'S')
SELECT 1 FROM dual;

INSERT ALL
    INTO fornecedores VALUES (1, 'Tech Supply Brasil Ltda', 'Tech Supply', '10.000.000/0001-10', 'contato@techsupply.example', '1130001000', 'S')
    INTO fornecedores VALUES (2, 'Casa Nova Distribuidora Ltda', 'Casa Nova', '20.000.000/0001-20', 'vendas@casanova.example', '1130002000', 'S')
    INTO fornecedores VALUES (3, 'Editora Saber Ltda', 'Editora Saber', '30.000.000/0001-30', 'comercial@saber.example', '1130003000', 'S')
    INTO fornecedores VALUES (4, 'Sport Max Comércio Ltda', 'Sport Max', '40.000.000/0001-40', 'pedidos@sportmax.example', '1130004000', 'S')
SELECT 1 FROM dual;

INSERT ALL
    INTO clientes VALUES (1, 'Ana Souza', 'ana.souza@example.com', '111.111.111-11', '11990000001', DATE '1992-04-18', DATE '2025-01-10', 'ATIVO')
    INTO clientes VALUES (2, 'Bruno Lima', 'bruno.lima@example.com', '222.222.222-22', '11990000002', DATE '1988-08-03', DATE '2025-01-15', 'ATIVO')
    INTO clientes VALUES (3, 'Carla Mendes', 'carla.mendes@example.com', '333.333.333-33', NULL, DATE '1995-12-11', DATE '2025-02-01', 'ATIVO')
    INTO clientes VALUES (4, 'Daniel Alves', 'daniel.alves@example.com', '444.444.444-44', '11990000004', NULL, DATE '2025-02-10', 'BLOQUEADO')
    INTO clientes VALUES (5, 'Eduarda Reis', 'eduarda.reis@example.com', '555.555.555-55', '11990000005', DATE '1984-07-29', DATE '2025-03-05', 'INATIVO')
    INTO clientes VALUES (6, 'Felipe Costa', 'felipe.costa@example.com', '666.666.666-66', NULL, DATE '1998-01-21', DATE '2025-03-15', 'ATIVO')
    INTO clientes VALUES (7, 'Gabriela Martins', 'gabriela.martins@example.com', '777.777.777-77', '11990000007', DATE '1990-09-09', DATE '2025-04-02', 'ATIVO')
    INTO clientes VALUES (8, 'Henrique Rocha', 'henrique.rocha@example.com', '888.888.888-88', '11990000008', DATE '1979-05-30', DATE '2025-04-18', 'ATIVO')
SELECT 1 FROM dual;

INSERT ALL
    INTO produtos VALUES (1, 1, 1, 'Smartphone Alpha', 'Smartphone intermediário 128 GB', 1899.90, 1350.00, 'ELE-SMA-001', DATE '2025-01-02', 'S')
    INTO produtos VALUES (2, 2, 1, 'Notebook Pro 15', 'Notebook com 16 GB de RAM', 4799.00, 3650.00, 'INF-NOT-001', DATE '2025-01-02', 'S')
    INTO produtos VALUES (3, 2, 1, 'Mouse Sem Fio', 'Mouse ergonômico sem fio', 129.90, 65.00, 'INF-MOU-001', DATE '2025-01-03', 'S')
    INTO produtos VALUES (4, 2, 1, 'Teclado Mecânico', 'Teclado ABNT2 com iluminação', 349.90, 210.00, 'INF-TEC-001', DATE '2025-01-03', 'S')
    INTO produtos VALUES (5, 3, 2, 'Cafeteira Elétrica', 'Cafeteira de 30 xícaras', 219.90, 140.00, 'CAS-CAF-001', DATE '2025-01-04', 'S')
    INTO produtos VALUES (6, 3, 2, 'Jogo de Panelas', 'Conjunto antiaderente com cinco peças', 399.90, 245.00, 'CAS-PAN-001', DATE '2025-01-04', 'S')
    INTO produtos VALUES (7, 4, 3, 'SQL na Prática', 'Livro introdutório de SQL', 89.90, 35.00, 'LIV-SQL-001', DATE '2025-01-05', 'S')
    INTO produtos VALUES (8, 4, 3, 'Oracle para Desenvolvedores', 'Livro de Oracle SQL e PL/SQL', 139.90, 55.00, 'LIV-ORA-001', DATE '2025-01-05', 'S')
    INTO produtos VALUES (9, 5, 4, 'Tênis de Corrida', 'Tênis leve para treinos diários', 499.90, 290.00, 'ESP-TEN-001', DATE '2025-01-06', 'S')
    INTO produtos VALUES (10, 5, 4, 'Óculos de Natação', 'Óculos com proteção UV', 119.90, 55.00, 'ESP-OCU-001', DATE '2025-01-06', 'S')
SELECT 1 FROM dual;

INSERT ALL
    INTO transportadoras VALUES (1, 'Entrega Rápida', '50.000.000/0001-50', '1131001000', 3, 'S')
    INTO transportadoras VALUES (2, 'Logística Nacional', '60.000.000/0001-60', '1131002000', 7, 'S')
SELECT 1 FROM dual;

INSERT INTO funcionarios VALUES (1, NULL, 'Mariana Torres', 'Diretora Comercial', 18500, DATE '2020-01-10', 'mariana.torres@loja.example', 'S');
INSERT INTO funcionarios VALUES (2, 1, 'Ricardo Nunes', 'Gerente de Vendas', 10500, DATE '2021-03-15', 'ricardo.nunes@loja.example', 'S');
INSERT INTO funcionarios VALUES (3, 2, 'Laura Freitas', 'Vendedora', 4800, DATE '2023-06-01', 'laura.freitas@loja.example', 'S');
INSERT INTO funcionarios VALUES (4, 2, 'Marcelo Dias', 'Vendedor', 4600, DATE '2024-02-12', 'marcelo.dias@loja.example', 'S');

INSERT ALL
    INTO pedidos VALUES (1, 1, 1, 3, DATE '2025-05-02', 'ENTREGUE', 2029.80, 25.00, 50.00, 2004.80, NULL)
    INTO pedidos VALUES (2, 2, 2, 4, DATE '2025-05-05', 'ENTREGUE', 4799.00, 0, 200.00, 4599.00, 'Retirada promocional')
    INTO pedidos VALUES (3, 3, 1, 3, DATE '2025-05-12', 'CANCELADO', 219.90, 20.00, 0, 239.90, 'Cancelado pelo cliente')
    INTO pedidos VALUES (4, 1, 1, 4, DATE '2025-06-01', 'PAGO', 489.80, 18.00, 0, 507.80, NULL)
    INTO pedidos VALUES (5, 6, 2, 3, DATE '2025-06-08', 'ENVIADO', 499.90, 30.00, 25.00, 504.90, NULL)
    INTO pedidos VALUES (6, 7, NULL, 4, DATE '2025-06-15', 'ABERTO', 279.80, 0, 0, 279.80, NULL)
SELECT 1 FROM dual;

INSERT ALL
    INTO itens_pedido VALUES (1, 1, 1, 1, 1899.90, 0)
    INTO itens_pedido VALUES (2, 1, 3, 1, 129.90, 0)
    INTO itens_pedido VALUES (3, 2, 2, 1, 4799.00, 0)
    INTO itens_pedido VALUES (4, 3, 5, 1, 219.90, 0)
    INTO itens_pedido VALUES (5, 4, 7, 2, 89.90, 0)
    INTO itens_pedido VALUES (6, 4, 8, 1, 139.90, 0)
    INTO itens_pedido VALUES (7, 4, 10, 1, 119.90, 0)
    INTO itens_pedido VALUES (8, 5, 9, 1, 499.90, 0)
    INTO itens_pedido VALUES (9, 6, 8, 2, 139.90, 0)
SELECT 1 FROM dual;

INSERT ALL
    INTO pagamentos VALUES (1, 1, 'PIX', 'APROVADO', 2004.80, DATE '2025-05-02', 1)
    INTO pagamentos VALUES (2, 2, 'CARTAO', 'APROVADO', 4599.00, DATE '2025-05-05', 10)
    INTO pagamentos VALUES (3, 3, 'BOLETO', 'ESTORNADO', 239.90, DATE '2025-05-13', 1)
    INTO pagamentos VALUES (4, 4, 'PIX', 'APROVADO', 507.80, DATE '2025-06-01', 1)
    INTO pagamentos VALUES (5, 5, 'CARTAO', 'APROVADO', 504.90, DATE '2025-06-08', 3)
    INTO pagamentos VALUES (6, 6, 'BOLETO', 'PENDENTE', 279.80, NULL, 1)
SELECT 1 FROM dual;

INSERT ALL
    INTO estoque VALUES (1, 1, 18, 5, DATE '2025-06-20')
    INTO estoque VALUES (2, 2, 7, 3, DATE '2025-06-20')
    INTO estoque VALUES (3, 3, 42, 10, DATE '2025-06-20')
    INTO estoque VALUES (4, 4, 12, 5, DATE '2025-06-20')
    INTO estoque VALUES (5, 5, 4, 5, DATE '2025-06-20')
    INTO estoque VALUES (6, 6, 9, 4, DATE '2025-06-20')
    INTO estoque VALUES (7, 7, 30, 8, DATE '2025-06-20')
    INTO estoque VALUES (8, 8, 16, 6, DATE '2025-06-20')
    INTO estoque VALUES (9, 9, 3, 5, DATE '2025-06-20')
    INTO estoque VALUES (10, 10, 25, 8, DATE '2025-06-20')
SELECT 1 FROM dual;

INSERT ALL
    INTO perfis VALUES (1, 'ADMINISTRADOR', 'Acesso completo ao sistema')
    INTO perfis VALUES (2, 'GERENTE', 'Acesso a relatórios e gestão')
    INTO perfis VALUES (3, 'OPERADOR', 'Acesso operacional')
SELECT 1 FROM dual;

INSERT ALL
    INTO usuarios VALUES (1, 1, 1, 'mariana.torres', 'mariana.torres@loja.example', 'HASH_FICTICIO_1', 'S', DATE '2025-06-20')
    INTO usuarios VALUES (2, 2, 2, 'ricardo.nunes', 'ricardo.nunes@loja.example', 'HASH_FICTICIO_2', 'S', DATE '2025-06-19')
    INTO usuarios VALUES (3, 3, 3, 'laura.freitas', 'laura.freitas@loja.example', 'HASH_FICTICIO_3', 'S', NULL)
SELECT 1 FROM dual;

COMMIT;
