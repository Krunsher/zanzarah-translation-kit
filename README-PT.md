# ZanZarah Translation Kit

Um kit para traduzir **ZanZarah: The Hidden Portal** para qualquer idioma, com traduções e instaladores prontos.

> 🇺🇸 **[Read in English](README.md)**

---

## 💡 Como funciona

Todo o texto do jogo fica em dois arquivos da pasta `Data` do jogo: `_fb0x02.fbs` (interface, itens, feitiços, menus) e `_fb0x06.fbs` (diálogos dos personagens). O kit transforma esses dois arquivos num único **`texts.json`**, fácil de editar, e depois compila esse arquivo de volta para o formato do jogo.

Ou seja, **uma tradução inteira é só um arquivo `texts.json`**. Cada idioma deste repositório é guardado assim, e qualquer pessoa pode criar um idioma novo traduzindo esse único arquivo.

## 📁 Estrutura do repositório

```
zanzarah-translation-kit/
├── kit/                     # O kit de tradução
│   ├── EXTRACT.bat          # .fbs originais → texts.json
│   ├── COMPILE.bat          # texts.json → .fbs traduzidos
│   ├── tools/
│   │   └── zzio_dbsqlite.exe    # conversor .fbs ↔ SQLite (baseado no zzio)
│   ├── scripts/             # scripts Python usados pelos .bat
│   ├── base/                # banco intermediário (gerado)
│   └── installer/
│       └── ZanZarah-PTBR.iss    # script do Inno Setup para gerar o instalador
├── installers/              # instaladores prontos, um por idioma
│   └── ZanZarah-PT-BR-Setup.exe
└── languages/               # uma pasta por idioma, cada uma com seu texts.json
    └── pt-BR/
        └── texts.json
```

## 🌍 Idiomas disponíveis

| Idioma | Sigla | Situação | Autor |
|---|---|---|---|
| Português (Brasil) | `pt-BR` | ✅ Completo | [@Krunsher](https://github.com/Krunsher) |

---

## 🎮 Instalando uma tradução

### Opção 1: instalador (mais fácil)

Baixe o instalador do seu idioma na pasta [`installers/`](installers/) e execute. Ele encontra o jogo da Steam sozinho (ou deixa você escolher a pasta) e faz backup dos arquivos originais como `.bak`. Para voltar ao inglês, desinstale pelas configurações de "Aplicativos" do Windows.

### Opção 2: compilar você mesmo

Use esta opção se ainda não houver instalador para o seu idioma ou se preferir fazer à mão. Você precisa de Windows e do [Python 3](https://www.python.org/) (marque "Add Python to PATH" ao instalar).

1. Copie os `_fb0x02.fbs` e `_fb0x06.fbs` **originais** da pasta `Data` do jogo (ex.: `C:\Program Files (x86)\Steam\steamapps\common\ZanZarah\Data`) para `kit/`.
2. Execute `kit/EXTRACT.bat`. Isso prepara o banco de dados do kit.
3. Copie o `texts.json` de `languages/<seu-idioma>/` para `kit/`, substituindo o que acabou de ser criado.
4. Execute `kit/COMPILE.bat`. Os `_fb0x02.fbs` e `_fb0x06.fbs` traduzidos são gerados em `kit/`.
5. Faça backup dos originais na pasta `Data` do jogo e copie os dois arquivos novos para lá.

---

## 🛠️ Traduzindo para um novo idioma

1. Siga os passos 1 e 2 acima. O `EXTRACT.bat` cria o `kit/texts.json` com o texto original do jogo, em inglês.
   *Dica: se for mais fácil, você pode partir do `texts.json` de outro idioma da pasta `languages/`.*
2. Traduza o `kit/texts.json` num editor de texto como VS Code ou Notepad++. Ele tem duas seções: `"_fb0x02"` (interface e itens, 943 textos) e `"_fb0x06"` (diálogos, 1140 textos). Traduza só os textos e:
   - nunca altere os IDs (ex.: `"802A94A1"`);
   - mantenha as tags de formatação exatamente como estão: `{4*Nome}`, `{5*Título}`, `~~`.
3. Execute o `COMPILE.bat`, copie os dois `.fbs` para a pasta `Data` do jogo e confira a tradução no jogo.

> ⚠️ O `EXTRACT.bat` recria o `kit/texts.json` do zero. Depois de começar a traduzir, guarde uma cópia do seu arquivo e rode só o `COMPILE.bat`, senão você perde o trabalho.

### Gerando um instalador

Os instaladores são feitos com o [Inno Setup 6](https://jrsoftware.org/isinfo.php). Rode o `COMPILE.bat` antes, abra o `kit/installer/ZanZarah-PTBR.iss`, ajuste o nome e o idioma para a sua tradução e clique em **Build > Compile**. O instalador é gerado em `installers/`.

---

## 🤝 Contribuindo com um novo idioma

Qualquer pessoa pode adicionar um idioma por Pull Request. Basta enviar o seu `texts.json`:

1. Faça um **fork** deste repositório (botão *Fork* no canto superior direito).
2. No seu fork, crie `languages/<sigla>/texts.json` com a sigla do idioma, ex.: `es`, `fr`, `it`, `de`, `pt-PT`.
3. Abra um **Pull Request** para este repositório descrevendo a tradução.

Depois de revisado e aceito, seu idioma entra na tabela acima. Mexa apenas na pasta do seu idioma.

---

## 🙏 Créditos

- **Kit de tradução e tradução para português do Brasil:** Hugo ([@Krunsher](https://github.com/Krunsher))
- **[zzio](https://github.com/Helco/zzio)**, de [Helco](https://github.com/Helco): reimplementação open source da engine de ZanZarah e conjunto de ferramentas para os formatos do jogo. O conversor `zzio_dbsqlite.exe` deste kit é baseado no zzio. Este projeto não existiria sem ele. Obrigado!
- **ZanZarah: The Hidden Portal** © Funatics Development / THQ Nordic. Este é um projeto de fãs, sem fins lucrativos e sem vínculo com os detentores dos direitos do jogo. Você precisa ter uma cópia original do jogo para usar as traduções.
