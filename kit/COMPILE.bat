@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
echo ========================================
echo  Compilação de Tradução - ZanZarah
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
set "TEXTS_FILE=%KIT_ROOT%\texts.json"

REM Salvar caminhos em variáveis para uso em blocos if (evita problemas com parênteses)
set "CURRENT_DIR=%CD%"
set "DB_PATH_VAR=%DB_PATH%"
set "TEXTS_FILE_VAR=%TEXTS_FILE%"

REM Verificar se o arquivo de tradução existe
if not exist "%TEXTS_FILE_VAR%" (
    echo ERRO: Arquivo texts.json não encontrado!
    echo.
    echo Por favor, edite o arquivo texts.json e traduza os textos
    echo e traduza os textos antes de compilar.
    echo.
    echo Pasta atual: !CURRENT_DIR!
    echo.
    pause
    exit /b 1
)

REM Verificar se o banco de dados existe
if not exist "%DB_PATH_VAR%" (
    echo ERRO: Banco de dados não encontrado!
    echo.
    echo Execute primeiro o script EXTRACT.bat para gerar o banco de dados.
    echo.
    echo Caminho esperado: !DB_PATH_VAR!
    echo.
    pause
    exit /b 1
)

echo [1/3] Injetando textos traduzidos no banco de dados...
python "%SCRIPTS_DIR%\inject_texts.py"

if errorlevel 1 (
    echo.
    echo ERRO: Falha ao injetar textos!
    pause
    exit /b 1
)

echo.
echo [2/3] Compilando banco de dados para arquivos .fbs...
REM exportraw espera apenas os NOMES das tabelas (sem caminho)
REM Os arquivos .fbs serão gerados no diretório atual (KIT_ROOT)
"%TOOLS_DIR%\zzio_dbsqlite.exe" exportraw "%DB_PATH_VAR%" "_fb0x02" "_fb0x06"

if errorlevel 1 (
    echo.
    echo ERRO: Falha ao compilar arquivos .fbs!
    pause
    exit /b 1
)

echo.
echo [3/3] Concluído!
echo.
echo Arquivos .fbs gerados:
echo   - %KIT_ROOT%\_fb0x02.fbs
echo   - %KIT_ROOT%\_fb0x06.fbs
echo.
echo Próximo passo: Copie estes arquivos para a pasta Data do jogo.
echo   (Faça backup dos arquivos originais primeiro!)
echo.
pause

