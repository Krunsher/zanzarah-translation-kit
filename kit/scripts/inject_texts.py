import sqlite3
import json
import os
import sys

# Get the script directory and kit root
script_dir = os.path.dirname(os.path.abspath(__file__))
kit_root = os.path.dirname(script_dir)

db_path = os.path.join(kit_root, 'base', 'zanzarah.db')
input_path = os.path.join(kit_root, 'texts.json')

if not os.path.exists(db_path):
    print(f"Erro: Banco de dados não encontrado: {db_path}")
    print("Execute primeiro o script EXTRACT.bat para gerar o banco de dados")
    sys.exit(1)

if not os.path.exists(input_path):
    print(f"Erro: Arquivo de tradução não encontrado: {input_path}")
    print("Edite o arquivo texts.json e traduza os textos")
    sys.exit(1)

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

with open(input_path, 'r', encoding='utf-8') as f:
    data = json.load(f)

count = 0
errors = 0
for table in data:
    for uid in data[table]:
        text = data[table][uid]
        # Update query
        # We need to update col_0_String
        try:
            cursor.execute(f"UPDATE {table} SET col_0_String = ? WHERE UID = ?", (text, uid))
            if cursor.rowcount > 0:
                count += 1
        except Exception as e:
            print(f"Erro ao atualizar {uid} em {table}: {e}")
            errors += 1

conn.commit()
conn.close()

print(f"Atualizados {count} registros no banco de dados.")
if errors > 0:
    print(f"Aviso: {errors} erros ocorreram durante a atualização.")
