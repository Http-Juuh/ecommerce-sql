PRAGMA foreign_keys = ON;
CREATE TABLE clientes (id INTEGER PRIMARY KEY, estado TEXT NOT NULL);
CREATE TABLE produtos (id INTEGER PRIMARY KEY, nome TEXT NOT NULL, categoria TEXT NOT NULL, preco_centavos INTEGER NOT NULL CHECK(preco_centavos > 0));
CREATE TABLE pedidos (id INTEGER PRIMARY KEY, cliente_id INTEGER NOT NULL REFERENCES clientes(id), data TEXT NOT NULL, entrega TEXT, status TEXT NOT NULL CHECK(status IN ('entregue','cancelado')));
CREATE TABLE itens (pedido_id INTEGER REFERENCES pedidos(id), produto_id INTEGER REFERENCES produtos(id), quantidade INTEGER NOT NULL CHECK(quantidade > 0), preco_centavos INTEGER NOT NULL CHECK(preco_centavos > 0), PRIMARY KEY(pedido_id,produto_id));
