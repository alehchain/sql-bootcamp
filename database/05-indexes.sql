-- Índices adicionais para filtros e relacionamentos frequentes.
CREATE INDEX ix_pedidos_cliente_data ON pedidos (cliente_id, data_pedido);
CREATE INDEX ix_pedidos_status ON pedidos (status);
CREATE INDEX ix_produtos_categoria ON produtos (categoria_id);
CREATE INDEX ix_produtos_fornecedor ON produtos (fornecedor_id);
CREATE INDEX ix_itens_pedido_produto ON itens_pedido (produto_id);
CREATE INDEX ix_pagamentos_pedido_status ON pagamentos (pedido_id, status);
CREATE INDEX ix_auditoria_data ON auditoria (data_operacao);
