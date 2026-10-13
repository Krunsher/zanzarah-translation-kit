@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
echo ========================================
echo  Extração de Textos - ZanZarah
echo ========================================
echo.

set "KIT_ROOT=%~dp0"
REM Remove barra final se existir
if "%KIT_ROOT:~-1%"=="\" set "KIT_ROOT=%KIT_ROOT:~0,-1%"

REM Mudar para o diretório do kit (resolve problemas com espaços no caminho)
cd /d "%KIT_ROOT%"
if errorlevel 1 (
    echo ERRO: Não foi possível mudar para o diretório do kit!
    pause
    exit /b 1
)

set "TOOLS_DIR=%KIT_ROOT%\tools"
set "SCRIPTS_DIR=%KIT_ROOT%\scripts"
set "BASE_DIR=%KIT_ROOT%\base"
set "DB_PATH=%BASE_DIR%\zanzarah.db"

REM Verificar se os arquivos .fbs originais existem
REM Nota: Se os arquivos não existirem, o zzio_dbsqlite.exe vai reportar erro
echo Verificando arquivos .fbs na pasta...
set "CURRENT_DIR=%CD%"
if not exist "_fb0x02.fbs" (
    echo ERRO: Arquivo _fb0x02.fbs não encontrado!
    echo.
    echo Por favor, copie os arquivos .fbs originais do jogo para esta pasta.
    echo Pasta atual: !CURRENT_DIR!
    echo.
    pause
    exit /b 1
)
if not exist "_fb0x06.fbs" (
    echo ERRO: Arquivo _fb0x06.fbs não encontrado!
    echo.
    echo Por favor, copie os arquivos .fbs originais do jogo para esta pasta.
    echo Pasta atual: !CURRENT_DIR!
    echo.
    pause
    exit /b 1
)
echo Arquivos .fbs encontrados: _fb0x02.fbs, _fb0x06.fbs
echo.

REM Definir caminhos completos para uso posterior
set "FBS02=!CURRENT_DIR!\_fb0x02.fbs"
set "FBS06=!CURRENT_DIR!\_fb0x06.fbs"

echo [1/3] Convertendo arquivos .fbs para banco SQLite...
"%TOOLS_DIR%\zzio_dbsqlite.exe" importraw "%DB_PATH%" "%FBS02%" "%FBS06%"

if errorlevel 1 (
    echo.
    echo ERRO: Falha ao converter arquivos .fbs para SQLite!
    pause
    exit /b 1
)

echo.
echo [2/3] Extraindo textos do banco de dados para JSON...
python "%SCRIPTS_DIR%\extract_texts.py"

if errorlevel 1 (
    echo.
    echo ERRO: Falha ao extrair textos!
    pause
    exit /b 1
)

echo.
echo [3/3] Concluído!
echo.
echo Arquivos gerados:
echo   - %BASE_DIR%\zanzarah.db (banco de dados)
echo   - %KIT_ROOT%\texts.json (textos extraídos)
echo.
echo Próximo passo: Edite texts.json e traduza os textos.
echo.
pause

