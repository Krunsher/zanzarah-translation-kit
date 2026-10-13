# Kit de Tradução ZanZarah

Este kit contém todas as ferramentas necessárias para traduzir **ZanZarah: The Hidden Portal** para qualquer idioma.

## 📋 Conteúdo do Kit

O kit inclui os seguintes arquivos e pastas:

```
ZanZarah_PTBR_Translation_Kit/
├── README.md                 # Este arquivo (documentação)
├── EXTRACT.bat               # Script para extrair textos dos arquivos .fbs
├── COMPILE.bat               # Script para compilar tradução em arquivos .fbs
├── tools/
│   ├── zzio_dbsqlite.exe    # Ferramenta standalone para converter .fbs ↔ SQLite
│   ├── SQLite.Interop.dll   # DLL necessária para SQLite
│   └── sni.dll              # DLL necessária para .NET
├── scripts/
│   ├── extract_texts.py     # Script Python para extrair textos do banco de dados
│   └── inject_texts.py      # Script Python para injetar textos no banco de dados
└── base/                     # Pasta para banco de dados intermediário (vazia inicialmente)
```

### Arquivos Gerados Durante o Processo de Tradução

Os seguintes arquivos são **gerados automaticamente** quando você executa os scripts (eles **não estão incluídos** no kit inicial):

1. **`texts.json`** (na raiz do kit)
   - Gerado por: `EXTRACT.bat`
   - Propósito: Contém todos os textos do jogo em formato JSON
   - Ação: Edite e traduza este arquivo

2. **`base/zanzarah.db`** (na pasta `base/`)
   - Gerado por: `EXTRACT.bat`
   - Propósito: Banco de dados SQLite intermediário (arquivo temporário)
   - Ação: Nenhuma ação necessária (usado automaticamente pelos scripts)

3. **`_fb0x02.fbs` e `_fb0x06.fbs`** (na raiz do kit)
   - **Importante**: Você deve primeiro copiar os arquivos **originais** `.fbs` da pasta `Data` do jogo para a raiz do kit antes de executar `EXTRACT.bat`
   - Gerado por: `COMPILE.bat` (cria as versões **traduzidas**)
   - Propósito: Arquivos do jogo traduzidos prontos para uso
   - Ação: **Copie estes arquivos traduzidos de volta para a pasta `Data` do jogo** para aplicar a tradução

Este kit permite traduzir o jogo para qualquer idioma de forma independente, sem precisar instalar o .NET SDK ou clonar o repositório zzio.

### Pré-requisitos

- **Python 3** instalado (disponível em https://www.python.org/)
- **Windows** (o executável `zzio_dbsqlite.exe` é para Windows)

### Guia Rápido

#### Passo 1: Extrair Textos

1. **Copie os arquivos `.fbs` originais do jogo para a pasta do kit:**
   - Vá até a pasta `Data` do jogo (ex: `C:\Program Files (x86)\Steam\steamapps\common\ZanZarah\Data`)
   - Copie `_fb0x02.fbs` → cole na raiz da pasta do kit
   - Copie `_fb0x06.fbs` → cole na raiz da pasta do kit
   - **Nota**: Estes arquivos originais serão usados pelo `EXTRACT.bat` e depois substituídos pelas versões traduzidas do `COMPILE.bat`

2. Execute `EXTRACT.bat`:
   - Ele converterá os arquivos `.fbs` originais para SQLite
   - Extrairá os textos para `texts.json`
   - Aguarde a extração terminar

#### Passo 2: Traduzir

1. Abra `texts.json` em um editor de texto (recomendado: VS Code, Notepad++)

2. Traduza os textos mantendo:
   - ✅ A estrutura JSON (chaves, vírgulas, etc.)
   - ✅ Os UIDs (ex: `"802A94A1"`) - **NÃO altere**
   - ✅ Tags de formatação como `{4*Nome}`, `{5*Título}` - **preserve exatamente**

3. Exemplo de tradução:
   ```json
   {
     "_fb0x02": {
       "802A94A1": "Tinezard",           ← Nome próprio, pode manter ou adaptar
       "8053E1B1": "Acerto crítico - oponente não causa acertos críticos"
     }
   }
   ```

4. Salve o arquivo

#### Passo 3: Compilar

1. Execute `COMPILE.bat`:
   - Ele injetará os textos traduzidos no banco de dados
   - Compilará os arquivos `.fbs` finais

2. Os arquivos `.fbs` traduzidos estarão na raiz do kit:
   - `_fb0x02.fbs` (Interface/Itens)
   - `_fb0x06.fbs` (Diálogos)

3. **Aplique a tradução ao jogo:**
   - Vá até a pasta `Data` do jogo (ex: `C:\Program Files (x86)\Steam\steamapps\common\ZanZarah\Data`)
   - **Faça backup** dos arquivos originais primeiro (renomeie para `.bak`)
   - Copie os arquivos traduzidos `_fb0x02.fbs` e `_fb0x06.fbs` da raiz do kit para a pasta `Data`
   - Inicie o jogo e aproveite a tradução!

### Estrutura dos Arquivos

- **`_fb0x02.fbs`**: Contém textos da interface do jogo, nomes de itens, feitiços, menus, etc.
- **`_fb0x06.fbs`**: Contém todos os diálogos dos personagens (NPCs).

**Importante**: Apenas estes dois arquivos contêm textos traduzíveis. Os outros arquivos `.fbs` (`_fb0x00`, `_fb0x01`, `_fb0x03`, `_fb0x04`, `_fb0x05`) contêm dados técnicos e não devem ser modificados.

### Tags de Formatação

O jogo usa tags especiais para formatação. **Preserve-as exatamente**:

- `{4*Texto}` - Formatação de cor/nome
- `{5*Texto}` - Formatação de título
- `~~` - Separador de linha
- `{n*...}` - Outras formatações numéricas

Exemplo:
```json
"8A42BCB1": "09{5*International Brand Manager}~~Rebecca Lester~~{5*Assistant Brand Manager}~~Sarah Nicholson"
```

### Solução de Problemas

**Erro: "Banco de dados não encontrado"**
- Execute primeiro `EXTRACT.bat` para gerar o banco de dados

**Erro: "Python não encontrado"**
- Instale Python 3 de https://www.python.org/
- Certifique-se de marcar "Add Python to PATH" durante a instalação

**Erro ao executar zzio_dbsqlite.exe**
- Verifique se o arquivo existe em `tools/zzio_dbsqlite.exe`
- Tente executar manualmente para ver a mensagem de erro

### Notas Técnicas

- O kit é **standalone**: não precisa do .NET SDK ou do repositório zzio
- O `zzio_dbsqlite.exe` é um executável auto-contido
- O banco de dados `zanzarah.db` é gerado automaticamente pelo `EXTRACT.bat`
- Os scripts Python usam caminhos relativos, funcionando de qualquer local
- O banco de dados é **sobrescrito** cada vez que `EXTRACT.bat` é executado (começa do zero com os `.fbs` originais)
- O banco de dados é **atualizado** (não sobrescrito) quando `COMPILE.bat` é executado (apenas os textos são alterados)

### Contribuindo

Se você criou uma tradução para outro idioma e quer compartilhar:

1. Mantenha a estrutura do kit
2. Inclua os arquivos `.fbs` traduzidos
3. Inclua o `texts.json` (com textos originais) como referência, se desejar
4. Atualize o README com informações do seu idioma

---

**Divirta-se traduzindo ZanZarah!** 🎮✨

