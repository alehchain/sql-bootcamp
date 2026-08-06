/******************************************************************************
 MÓDULO 03 — WHERE
******************************************************************************/

-- 01. Clientes ativos.
SELECT cliente_id, nome, status
FROM clientes
WHERE status = 'ATIVO';

-- 02. Produtos acima de 500.
SELECT produto_id, nome, preco
FROM produtos
WHERE preco > 500;

-- 03. Produtos até 150.
SELECT produto_id, nome, preco
FROM produtos
WHERE preco <= 150;

-- 04. Pedidos não cancelados.
SELECT pedido_id, status, valor_total
FROM pedidos
WHERE status <> 'CANCELADO';

-- 05. Produtos ativos e caros.
SELECT produto_id, nome, preco
FROM produtos
WHERE ativo = 'S'
  AND preco >= 500;

-- 06. Pedidos entregues ou enviados.
SELECT pedido_id, status
FROM pedidos
WHERE status = 'ENTREGUE'
   OR status = 'ENVIADO';

-- 07. Categorias 1 ou 2, somente ativas.
SELECT produto_id, nome, categoria_id, ativo
FROM produtos
WHERE (categoria_id = 1 OR categoria_id = 2)
  AND ativo = 'S';

-- 08. Pedidos a partir de junho de 2025.
SELECT pedido_id, data_pedido, status
FROM pedidos
WHERE data_pedido >= DATE '2025-06-01';

-- 09. Clientes ativos cadastrados a partir de março.
SELECT cliente_id, nome, data_cadastro
FROM clientes
WHERE status = 'ATIVO'
  AND data_cadastro >= DATE '2025-03-01';

-- 10. Margem mínima de 100.
SELECT produto_id, nome, preco, custo, preco - custo AS margem
FROM produtos
WHERE preco - custo >= 100;

-- 11. Funcionários com salário superior a 5000.
SELECT funcionario_id, nome, cargo, salario
FROM funcionarios
WHERE salario > 5000;

-- 12. Estoque crítico.
SELECT produto_id, quantidade_atual, quantidade_minima
FROM estoque
WHERE quantidade_atual <= quantidade_minima;

-- 13. Pagamentos aprovados parcelados.
SELECT pagamento_id, pedido_id, quantidade_parcelas
FROM pagamentos
WHERE status = 'APROVADO'
  AND quantidade_parcelas > 1;

-- 14. Produtos entre 100 e 500 sem BETWEEN.
SELECT produto_id, nome, preco
FROM produtos
WHERE preco >= 100
  AND preco <= 500;

-- 15. Pedidos com frete gratuito.
SELECT pedido_id, valor_frete, valor_total
FROM pedidos
WHERE valor_frete = 0;

-- 16. Clientes nascidos antes de 1990.
SELECT cliente_id, nome, data_nascimento
FROM clientes
WHERE data_nascimento < DATE '1990-01-01';

-- 17. Funcionários ativos que não são vendedores.
SELECT funcionario_id, nome, cargo
FROM funcionarios
WHERE ativo = 'S'
  AND cargo <> 'Vendedor'
  AND cargo <> 'Vendedora';

-- 18. Perfis diferentes de operador.
SELECT perfil_id, nome
FROM perfis
WHERE nome <> 'OPERADOR';

-- 19. Pedidos acima de 500.
SELECT pedido_id, cliente_id, valor_total
FROM pedidos
WHERE valor_total > 500;

-- 20. Uso de NOT.
SELECT pedido_id, status
FROM pedidos
WHERE NOT status = 'CANCELADO';
