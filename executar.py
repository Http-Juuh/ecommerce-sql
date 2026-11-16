"""Cria SQLite em memoria e exporta cinco consultas para Markdown."""
from pathlib import Path
import sqlite3

BASE = Path(__file__).resolve().parent

def main():
    with sqlite3.connect(':memory:') as db:
        db.executescript((BASE / 'schema.sql').read_text(encoding='utf-8'))
        db.executescript((BASE / 'seed.sql').read_text(encoding='utf-8'))
        assert db.execute('PRAGMA foreign_key_check').fetchall() == []
        queries = (BASE / 'consultas.sql').read_text(encoding='utf-8').split(';')
        names = ['Receita mensal','Receita por categoria','Recorrencia','Prazo por estado','Ticket medio']
        lines = ['# Resultados SQL', '', 'Dados ficticios, valores monetarios em reais.', '']
        for name, sql in zip(names, [q for q in queries if q.strip()]):
            cursor = db.execute(sql)
            columns = [d[0] for d in cursor.description]
            lines += [f'## {name}', '', '| ' + ' | '.join(columns) + ' |', '| ' + ' | '.join(['---'] * len(columns)) + ' |']
            lines += ['| ' + ' | '.join(str(v) for v in row) + ' |' for row in cursor.fetchall()]
            lines.append('')
        lines += ['## Interpretacao', '',
                  '- Compare receita por categoria com custos antes de decidir onde investir: receita alta nao implica margem alta.',
                  '- A recorrencia e elevada por construcao da base sintetica; nao e um benchmark comercial.',
                  '- Prazos medios ocultam variabilidade e nao medem atraso sem uma data prometida.',
                  '- A consulta de ticket agrega os itens antes da media, evitando contar um pedido varias vezes.']
        (BASE / 'RESULTADOS.md').write_text('\n'.join(lines) + '\n', encoding='utf-8')
        print('5 consultas executadas; integridade referencial verificada.')

if __name__ == '__main__':
    main()
