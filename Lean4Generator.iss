; 数学证明的Lean语言交互式转译器安装脚本
; 使用Inno Setup编译此脚本生成安装包

[Setup]
AppName=数学证明的Lean语言交互式转译器
AppVersion=1.0.0
AppPublisher=Lean4Generator Team
AppPublisherURL=https://example.com
AppSupportURL=https://example.com/support
AppUpdatesURL=https://example.com/updates
DefaultDirName={pf}\Lean4Generator
DefaultGroupName=Lean4Generator
OutputBaseFilename=Lean4Generator-Setup
Compression=lzma2/ultra64
SolidCompression=yes
PrivilegesRequired=lowest

[Languages]
Name: "chinese"; MessagesFile: "compiler:Default.isl"
Name: "chinesesimp"; MessagesFile: "compiler:Languages/ChineseSimplified.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "dist\Lean4Generator.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\数学证明的Lean语言交互式转译器"; Filename: "{app}\Lean4Generator.exe"
Name: "{group}\卸载 数学证明的Lean语言交互式转译器"; Filename: "{uninstallexe}"
Name: "{commondesktop}\数学证明的Lean语言交互式转译器"; Filename: "{app}\Lean4Generator.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\数学证明的Lean语言交互式转译器"; Filename: "{app}\Lean4Generator.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\Lean4Generator.exe"; Description: "{cm:LaunchProgram,数学证明的Lean语言交互式转译器}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[UninstallRun]
Filename: "{app}\Lean4Generator.exe"; Parameters: "--uninstall";

[Registry]
Root: "HKCU"; Subkey: "Software\Lean4Generator"; ValueType: string; ValueName: "InstallDir"; ValueData: "{app}"; Flags: uninsdeletevalue

[Code]
function InitializeSetup(): Boolean;
begin
  Result := True;
  // 可以在这里添加自定义初始化代码
end;
