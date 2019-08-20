#define AppName "SpeckleStructuralSuite"
#define GsaVersion GetFileVersion("SpeckleGSA\SpeckleGSA.dll")
#define CoreGeometryVersion  GetFileVersion("SpeckleCoreGeometry\SpeckleCoreGeometry.dll")
#define SpeckleStructuralVersion  GetFileVersion("SpeckleStructural\SpeckleStructural.dll")
#define AppPublisher "Speckle"
#define AppURL "http://torstrweb01/SpeckleGSA/"
#define SpeckleFolder "{localappdata}\Speckle"
#define SpeckleStructuralSuiteFolder "{localappdata}\SpeckleStructuralSuite"
#define AppExeName "SpeckleStructuralSuite.exe"

[Setup]
AppId={{C1D0E622-B491-46BD-99ED-A6A516496CA8}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={#SpeckleStructuralSuiteFolder}
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
Name: coregeometry; Description: Basic Geometry Object Model - v{#CoreGeometryVersion};  Types: full custom; Flags: fixed
Name: structural; Description: Structural Object Model - v{#SpeckleStructuralVersion};  Types: full custom; Flags: fixed

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Dirs]
Name: "{app}"; Permissions: everyone-full 

[Files]
;gsa
Source: "SpeckleGSA\*"; DestDir: "{localappdata}\SpeckleGSA"; Flags: ignoreversion recursesubdirs; Components: gsa  

;coregeometry
Source: "SpeckleCoreGeometry\*"; DestDir: "{localappdata}\SpeckleKits\SpeckleCoreGeometry"; Flags: ignoreversion recursesubdirs; Components: coregeometry  

;structural
Source: "SpeckleStructural\*"; DestDir: "{localappdata}\SpeckleKits\SpeckleStructural"; Flags: ignoreversion recursesubdirs; Components: structural  

[Icons]
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"
Name: "{group}\SpeckleGSA"; Filename: "{localappdata}\SpeckleGSA\SpeckleGSAUI.exe"
