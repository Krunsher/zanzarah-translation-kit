; Instalador da tradução PT-BR de ZanZarah: The Hidden Portal
; Compile com Inno Setup 6 (https://jrsoftware.org/isinfo.php).
; Fica em kit\installer e pega os .fbs compilados em kit (rode o COMPILE.bat antes). O .exe sai em installers.

#define MyAppName "ZanZarah - Tradução PT-BR"
#define MyAppVersion "1.0"

[Setup]
AppId={{6B1E4C2A-7F3D-4E8B-9A51-2C0D8E7F4A10}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=Hugo
DefaultDirName={code:GetGameDir}
DirExistsWarning=no
AppendDefaultDirName=no
DisableProgramGroupPage=yes
PrivilegesRequired=admin
OutputDir=..\..\installers
OutputBaseFilename=ZanZarah-PT-BR-Setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
UninstallFilesDir={app}\Data\TraducaoPTBR

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Files]
Source: "..\_fb0x02.fbs"; DestDir: "{app}\Data"; Flags: ignoreversion
Source: "..\_fb0x06.fbs"; DestDir: "{app}\Data"; Flags: ignoreversion

[Code]
function GetGameDir(Param: String): String;
var
  SteamPath: String;
begin
  Result := ExpandConstant('{commonpf32}\Steam\steamapps\common\ZanZarah');
  if RegQueryStringValue(HKLM, 'SOFTWARE\WOW6432Node\Valve\Steam', 'InstallPath', SteamPath) then
    if DirExists(SteamPath + '\steamapps\common\ZanZarah') then
      Result := SteamPath + '\steamapps\common\ZanZarah';
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if (CurPageID = wpSelectDir) and not DirExists(WizardDirValue + '\Data') then
  begin
    MsgBox('Não encontrei a pasta Data do ZanZarah em:' + #13#10 + WizardDirValue + #13#10 +
      'Escolha a pasta onde o jogo está instalado.', mbError, MB_OK);
    Result := False;
  end;
end;

procedure BackupFile(Name: String);
var
  Src, Bak: String;
begin
  Src := ExpandConstant('{app}\Data\') + Name;
  Bak := Src + '.bak';
  if FileExists(Src) and not FileExists(Bak) then
    FileCopy(Src, Bak, True);
end;

procedure RestoreFile(Name: String);
var
  Src, Bak: String;
begin
  Src := ExpandConstant('{app}\Data\') + Name;
  Bak := Src + '.bak';
  if FileExists(Bak) then
  begin
    DeleteFile(Src);
    RenameFile(Bak, Src);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then
  begin
    BackupFile('_fb0x02.fbs');
    BackupFile('_fb0x06.fbs');
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    RestoreFile('_fb0x02.fbs');
    RestoreFile('_fb0x06.fbs');
  end;
end;
