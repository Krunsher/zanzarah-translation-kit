import sqlite3
import json
import os
import sys

# Get the script directory and kit root
script_dir = os.path.dirname(os.path.abspath(__file__))
kit_root = os.path.dirname(script_dir)

db_path = os.path.join(kit_root, 'base', 'zanzarah.db')
output_path = os.path.join(kit_root, 'texts.json')

if not os.path.exists(db_path):
    print(f"Erro: Banco de dados não encontrado: {db_path}")
    print("Execute primeiro o script EXTRACT.bat para gerar o banco de dados a partir dos arquivos .fbs")
    sys.exit(1)

conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

data = {
    "_fb0x02": {},
    "_fb0x06": {}
}

# Extract from _fb0x02 (UI, Items, etc)
# col_0_String: Text
cursor.execute("SELECT UID, col_0_String FROM _fb0x02 WHERE col_0_String IS NOT NULL AND col_0_String != ''")
for row in cursor.fetchall():
    data["_fb0x02"][row['UID']] = row['col_0_String']

# Extract from _fb0x06 (Dialogs)
# col_0_String: Text
cursor.execute("SELECT UID, col_0_String FROM _fb0x06 WHERE col_0_String IS NOT NULL AND col_0_String != ''")
for row in cursor.fetchall():
    data["_fb0x06"][row['UID']] = row['col_0_String']

conn.close()

with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print(f"Extraídos {len(data['_fb0x02'])} textos de _fb0x02 e {len(data['_fb0x06'])} textos de _fb0x06.")
print(f"Arquivo salvo em: {output_path}")
