#define AppName "SpeckleStructuralSuite"
#define AppVersion {#MyAppVersion}
#define GsaVersion GetFileVersion("SpeckleGSA\SpeckleGSA.dll")
#define EtabsVersion GetFileVersion("SpeckleETABS\SpeckleETABS2017.dll")
#define StructuresVersion GetFileVersion("SpeckleStructures\SpeckleStructures.dll")
#define AppPublisher "Speckle"
#define AppURL "http://torstrweb01/SpeckleGSA/"
#define SpeckleFolder "{localappdata}\Speckle"
#define AppExeName "SpeckleStructuralSuite.exe"
#define ETABSSettings "{localappdata}\Computers and Structures\ETABS 17\ETABS.ini"

[Setup]
AppId={{C1D0E622-B491-46BD-99ED-A6A516496CA8}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={#SpeckleFolder}
DisableDirPage=yes
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
DisableWelcomePage=no
OutputDir="."
OutputBaseFilename=SpeckleStructuralSuite
SetupIconFile=Assets\icon.ico
Compression=lzma
SolidCompression=yes
WizardImageFile=Assets\installer.bmp
ChangesAssociations=yes
PrivilegesRequired=lowest
VersionInfoVersion={#AppVersion}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Components]
Name: gsa; Description: Speckle for GSA 10 - v{#GsaVersion}; Types: full
Name: etabs; Description: Speckle for ETABS 2017 - v{#EtabsVersion}; Types: full
Name: structures; Description: Speckle structural object model - v{#StructuresVersion}; Types: full  

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Dirs]
Name: "{app}"; Permissions: everyone-full 

[Files]
;gsa
Source: "SpeckleGSA\*"; DestDir: "{localappdata}\SpeckleGSA"; Flags: ignoreversion recursesubdirs; Components: gsa  

;etabs
Source: "SpeckleETABS\*"; DestDir: "{localappdata}\SpeckleETABS"; Flags: ignoreversion recursesubdirs; Components: etabs

;structures
Source: "SpeckleStructures\*"; DestDir: "{localappdata}\SpeckleKits\SpeckleStructures"; Flags: ignoreversion recursesubdirs; Components: structures
  

[Icons]
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"
Name: "{group}\SpeckleGSA"; Filename: "{localappdata}\SpeckleGSA\SpeckleGSAUI.exe"

[Code]

procedure Explode(var Dest: TArrayOfString; Text: String; Separator: String);
var
  i, p: Integer;
begin
  i := 0;
  repeat
    SetArrayLength(Dest, i+1);
    p := Pos(Separator,Text);
    if p > 0 then begin
      Dest[i] := Copy(Text, 1, p-1);
      Text := Copy(Text, p + Length(Separator), Length(Text));
      i := i + 1;
    end else begin
      Dest[i] := Text;
      Text := '';
    end;
  until Length(Text)=0;
end;

function IsDotNetDetected(version: string; service: cardinal): boolean;
var
    key: string;
    install, release, serviceCount: cardinal;
    check45, success: boolean;
begin
    // .NET 4.5 installs as update to .NET 4.0 Full
    if version = 'v4.5' then begin
        version := 'v4\Full';
        check45 := true;
    end else
        check45 := false;

    // installation key group for all .NET versions
    key := 'SOFTWARE\Microsoft\NET Framework Setup\NDP\' + version;

    // .NET 3.0 uses value InstallSuccess in subkey Setup
    if Pos('v3.0', version) = 1 then begin
        success := RegQueryDWordValue(HKLM, key + '\Setup', 'InstallSuccess', install);
    end else begin
        success := RegQueryDWordValue(HKLM, key, 'Install', install);
    end;

    // .NET 4.0/4.5 uses value Servicing instead of SP
    if Pos('v4', version) = 1 then begin
        success := success and RegQueryDWordValue(HKLM, key, 'Servicing', serviceCount);
    end else begin
        success := success and RegQueryDWordValue(HKLM, key, 'SP', serviceCount);
    end;

    // .NET 4.5 uses additional value Release
    if check45 then begin
        success := success and RegQueryDWordValue(HKLM, key, 'Release', release);
        success := success and (release >= 378389);
    end;

    result := success and (install = 1) and (serviceCount >= service);
end;

function IsSpeckleInstalled(): boolean;
begin
  result := FileExists(ExpandConstant('{#SpeckleFolder}\SpeckleUpdater.exe'));
end;

function AddETABS(): Boolean;
var
    TempStringArr: TArrayOfString;
    LineCount: Integer;
    SectionLine: Integer;
    FileLines: TArrayOfString;
begin
    if FileExists(ExpandConstant('{#ETABSSettings}')) then begin
        if LoadStringsFromFile(ExpandConstant('{#ETABSSettings}'), FileLines) then begin
          SaveStringToFile(ExpandConstant('{#ETABSSettings}') + '.tmp', '', false);
          LineCount := GetArrayLength(FileLines);
          for SectionLine := 0 to LineCount - 1 do
          begin
              SaveStringToFile(ExpandConstant('{#ETABSSettings}') + '.tmp', FileLines[SectionLine] + #13#10, true);
              if FileLines[SectionLine] = '[PlugIn]' then begin
                  SectionLine := SectionLine + 1;
                  Explode(TempStringArr, FileLines[SectionLine], '=');
                  SaveStringToFile(ExpandConstant('{#ETABSSettings}') + '.tmp', TempStringArr[0] + '=' + IntToStr(StrToInt(TempStringArr[1]) + 1) + #13#10, true);
                  SaveStringToFile(ExpandConstant('{#ETABSSettings}') + '.tmp', ' PlugInName=SpeckleETABS2017'#13#10, true);
                  SaveStringToFile(ExpandConstant('{#ETABSSettings}') + '.tmp', ' PlugInMenuText=SpeckleETABS2017'#13#10, true); 
                  SaveStringToFile(ExpandConstant('{#ETABSSettings}') + '.tmp', ExpandConstant(' PlugInPath={localappdata}\SpeckleETABS\SpeckleETABS2017.dll'#13#10), true);
              end else begin
                if FileLines[SectionLine] = ' PlugInName=SpeckleETABS2017' then begin
                  DeleteFile(ExpandConstant('{#ETABSSettings}') + '.tmp');
                  result := true;
                  exit;
                end;
              end;
          end;
          DeleteFile(ExpandConstant('{#ETABSSettings}'));
          RenameFile(ExpandConstant('{#ETABSSettings}') + '.tmp', ExpandConstant('{#ETABSSettings}'));
          result := true;
        end else
          result := false;
    end else            
        result := false;
end;

function InitializeSetup(): Boolean;
var
    ErrCode: integer;
begin
    if not IsSpeckleInstalled() then begin
        if MsgBox('{#AppName} requires Speckle to be installed.'#13#13
            'Download the latest Speckle build from https://speckleworks.github.io/builds/'#13
            'Would you like to me download it?',  mbConfirmation, MB_YESNO) = IDYES
            then begin
                ShellExec('open', 'https://github.com/speckleworks/SpeckleInstaller/releases/latest/download/Speckle.exe', '', '', SW_SHOW, ewNoWait, ErrCode);
            end;
        result := false
    end else
    begin
        if not IsDotNetDetected('v4.5', 0) then begin
            if  MsgBox('{#AppName} requires Microsoft .NET Framework 4.5.'#13#13
                'Do you want me to open http://www.microsoft.com/net'#13
                'so you can download it?',  mbConfirmation, MB_YESNO) = IDYES
                then begin
                    ShellExec('open', 'http://www.microsoft.com/net',
                        '', '', SW_SHOW, ewNoWait, ErrCode);
                end;
            result := false;
        end else
            result := true;
    end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  I: Integer;
  Tag: string;
  Line: string;
  TagPos: Integer;
  FileLines: TStringList;
begin
  if CurStep = ssInstall then
      if IsComponentSelected('etabs') then
        MsgBox('SpeckleETABS is a highly experimental plugin which requires ETABS 2017.'#13#13
            'It is assumed that ETABS 2017 is already installed.'#13
            'NOT INTENDED FOR PROJECT USE', mbInformation, MB_OK);
  if CurStep = ssPostInstall then
      if IsComponentSelected('etabs') then
        AddETABS();
end;