unit UnitGlobal;

interface
uses Windows, SysUtils, IniFiles, SyncObjs;

type
   PTranscodeInfo = ^RTranscodeInfo;
   RTranscodeInfo = record
      TITLE             : String;
      SUBTITLE          : String;
      TRANS_FILENAME    : String;
      CONTENT_ID        : String;
      STORAGE_PATH      : String;
      STORAGE_SUBPATH   : String;
      PRESETNAME        : string;
      TRANSCODE_STATE   : string;
   end;


procedure LoadIniFile;
function AttachDirSlash(sDirPath : String) : String;
procedure EventLog(classification, sData : String);
function GetProcessCount(sName : String) : Integer;

var
   g_ProgramPath  : String;
   g_SoapIP       : String;
   g_Sync         : TCriticalSection;
   g_WorkMax      : Integer;
implementation
uses TLHelp32;

procedure LoadIniFile;
var
   ConfigIni: TIniFile;
begin
   if FileExists(g_ProgramPath + 'CFG\config.ini') then begin
      ConfigIni := TIniFile.Create(g_ProgramPath + 'CFG\config.ini');
      try
         g_SoapIP := ConfigIni.ReadString( 'INFO', 'ENGINE_IP', '127.0.0.1' );
         g_WorkMax := ConfigIni.ReadInteger( 'INFO', 'WORK_MAX', 4);   //작업 최대 갯수
      finally
         FreeAndNil(ConfigIni);
      end;
   end;
end;

function AttachDirSlash(sDirPath : String) : String;
const
   SLASH = '\';
   EMPTY = 0;
var
   SourcePath : String;
   ChrCount   : Integer;
   Character  : String;
begin
   SourcePath  := sDirPath;
   ChrCount    := Length(SourcePath);
   if ChrCount = EMPTY then
   begin
      Result := '';
   end
   else begin
      Character := Copy(SourcePath, ChrCount, 1);
      if Character = SLASH then
         Result := SourcePath
      else
         Result := SourcePath + '\';
   end;
end;

procedure EventLog(classification, sData : String);
var
   sTime : String;
   sPath : String;
   sFileNameWrite  : TextFile;
begin
   sTime := FormatDateTime('hh:nn:ss', now);
   sPath := g_ProgramPath + 'Log\TranscodeM\' + FormatDateTime('yymmdd', now);
   g_Sync.Acquire;
   Try

      if FileExists(sPath + 'TranscodeM.txt') then  begin
         AssignFile(sFileNameWrite, sPath + 'TranscodeM.txt');
         Append(sFileNameWrite)
      end
      else begin
         AssignFile(sFileNameWrite, sPath + 'TranscodeM.txt');
         Rewrite(sFileNameWrite);
      end;
      if classification = 'err' then
      begin
         Writeln(sFileNameWrite, '[' + sTime + '] [ERR] - ' + sData);
      end
      else if classification = 'evt' then
      begin
         Writeln(sFileNameWrite, '[' + sTime + '] [EVT] - ' + sData);
      end
      else if classification = 'log' then
      begin
         Writeln(sFileNameWrite, '[' + sTime + '] [LOG] - ' + sData);
      end
      else begin
         Writeln(sFileNameWrite, '[' + sTime + '] [DEBUG] - ' + sData);
      end;
      Flush(sFileNameWrite);
   finally
      CloseFile(sFileNameWrite);
      g_Sync.Release;
   end;
end;

//프로세스 갯수를 구한다.
function GetProcessCount(sName : String) : Integer;
var
   iResult : Integer;
   handler : THandle;
   data: TProcessEntry32;
   sProcessName : String;
begin
   iResult := 0;
   handler := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
   try
      data.dwSize := SizeOf(data);
      if Process32First(handler, data) then
         while Process32Next(handler, data) do
         begin
            sProcessName := data.szExeFile;
            if sProcessName = PChar(sName) then
            begin
               Inc(iResult);
            end;
         end;
   finally
      CloseHandle(handler);
   end;
   Result := iResult;
end;


end.
