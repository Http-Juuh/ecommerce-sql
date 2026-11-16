-- Receita mensal: somente pedidos entregues. Precos registrados no momento da venda.
SELECT substr(p.data,1,7) AS mes, COUNT(DISTINCT p.id) AS pedidos,
       SUM(i.quantidade*i.preco_centavos)/100.0 AS receita_reais
FROM pedidos p JOIN itens i ON i.pedido_id=p.id
WHERE p.status='entregue' GROUP BY mes ORDER BY mes;

-- Categorias: receita nao e lucro, custos nao estao disponiveis.
SELECT pr.categoria, SUM(i.quantidade*i.preco_centavos)/100.0 AS receita_reais
FROM itens i JOIN pedidos p ON p.id=i.pedido_id JOIN produtos pr ON pr.id=i.produto_id
WHERE p.status='entregue' GROUP BY pr.categoria ORDER BY receita_reais DESC;

-- Recorrencia: clientes com pelo menos dois pedidos entregues / clientes compradores.
WITH frequencia AS (
    SELECT cliente_id, COUNT(*) AS n FROM pedidos WHERE status='entregue' GROUP BY cliente_id
)
SELECT COUNT(*) AS compradores, SUM(CASE WHEN n>=2 THEN 1 ELSE 0 END) AS recorrentes,
       ROUND(100.0*SUM(CASE WHEN n>=2 THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0),2) AS percentual_recorrentes
FROM frequencia;

-- Prazo medio por estado: calcula no nivel do pedido para evitar duplicacao pelo JOIN de itens.
SELECT c.estado, COUNT(*) AS entregas, ROUND(AVG(julianday(p.entrega)-julianday(p.data)),2) AS dias_medios
FROM pedidos p JOIN clientes c ON c.id=p.cliente_id
WHERE p.status='entregue' AND p.entrega IS NOT NULL GROUP BY c.estado ORDER BY dias_medios;

-- Ticket medio: primeiro agrega os itens por pedido.
WITH totais AS (
    SELECT p.id, SUM(i.quantidade*i.preco_centavos) AS total_centavos
    FROM pedidos p JOIN itens i ON p.id=i.pedido_id WHERE p.status='entregue' GROUP BY p.id
)
SELECT COUNT(*) AS pedidos, ROUND(AVG(total_centavos)/100.0,2) AS ticket_medio_reais FROM totais;
