unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cromis.DirectoryWatch, StdCtrls, FileCtrl, Grids, AdvObj, BaseGrid,
  AdvGrid, IniFiles, ExtCtrls;

const
   WM_PROGRAMSTART = WM_USER + 111;

const
   FIELD_CONTENTID = 0;
   FIELD_FILENAME = 1;
   FIELD_STARTDATETIME = 2;
   FIELD_ENDDATETIME = 3;
   FIELD_TOTALLENGTH = 4;
   FIELD_IMAGESTART = 5;
   FIELD_IMAGEEND = 6;
   FIELD_IMAGELENGTH = 7;
   FIELD_STATUS = 8;
   FIELD_REMARK = 9;
   FIELD_INI_FILENAME = 10;

type

  TForm1 = class(TForm)
    fileLst_History: TFileListBox;
    advListGrid: TAdvStringGrid;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure advListGridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    FDirectoryWatch: TDirectoryWatch;
    procedure OnNotify(const Sender: TObject;
                       const Action: TWatchAction;
                       const FileName: string);
    procedure GridClear(advGrid : TAdvStringGrid);
    procedure GridResize;
  public
    { Public declarations }
    FWndHandle    : HWND;
    lst_History : TStringList;
    procedure OnMyStartProgram(var Msg : TMessage); message WM_PROGRAMSTART;
    procedure LoadHistory;
    procedure ParsingHistory(sFileName : String);
    procedure AddData(strId, strFilename, strStart, strEnd, strMemo, strStatus, ininame, strThumbStart, strThumbEnd : String);
    procedure FirstAdd(strId, strFilename, strStart, strEnd, strMemo, strStatus, ininame, strThumbStart, strThumbEnd : String);
    procedure ModifyData(strId, strFilename, strStart, strEnd, strMemo, strStatus : String; iPos : Integer; ininame, strThumbStart, strThumbEnd : String);
    procedure RemoveData(sFilename : String);
  end;

type
   TDeleteHistory = class(TThread)
   public
      constructor Create;
      procedure Execute; override;
   end;

var
  Form1: TForm1;
  g_ProgramPath : String;

implementation
uses DateUtils;
{$R *.dfm}

{ TForm1 }

procedure TForm1.AddData(strId, strFilename, strStart, strEnd, strMemo,
  strStatus, ininame, strThumbStart, strThumbEnd: String);
var
   i : Integer;
   bExist : Boolean;
   iPosition : Integer;
begin
   bExist := False;
   iPosition := 0;
   for i := 1 to advListGrid.RowCount - 1 do
   begin
      if SameText(advListGrid.Cells[FIELD_CONTENTID, i], strId) then
      begin
         bExist := True;
         iPosition := i;
         break;
      end;
   end;

   if bExist then
   begin
      ModifyData(strId, strFilename, strStart, strEnd, strMemo, strStatus, iPosition, ininame, strThumbStart, strThumbEnd);
   end
   else begin
      FirstAdd(strId, strFilename, strStart, strEnd, strMemo, strStatus, ininame, strThumbStart, strThumbEnd);
   end;
end;

procedure TForm1.advListGridGetCellColor(Sender: TObject; ARow, ACol: Integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
   if ACol = FIELD_STATUS then
   begin
      if SameText(advListGrid.Cells[FIELD_STATUS, ARow], '성공') then
      begin
         ABrush.Color := clAqua;
      end
      else if SameText(advListGrid.Cells[FIELD_STATUS, ARow], '실패') then
      begin
         ABrush.Color := clRed;
      end
      else if SameText(advListGrid.Cells[FIELD_STATUS, ARow], '진행중') then
      begin
         ABrush.Color := clYellow;
      end;

   end;
end;

procedure TForm1.FirstAdd(strId, strFilename, strStart, strEnd, strMemo,
  strStatus, ininame, strThumbStart, strThumbEnd: String);
var
   iRow : Integer;
   startTime, endTime : TDateTime;
   timeLength : TTime;
begin
   iRow := 1;
   if not SameText(advListGrid.Cells[FIELD_CONTENTID, 1], '') then
   begin
      advListGrid.InsertRows(1, 1);
   end;

   advListGrid.Cells[FIELD_CONTENTID, iRow] := strId;
   advListGrid.Cells[FIELD_FILENAME, iRow] := strFilename;
   advListGrid.Cells[FIELD_STARTDATETIME, iRow] := strStart;
   advListGrid.Cells[FIELD_ENDDATETIME, iRow] := strEnd;
   advListGrid.Cells[FIELD_IMAGESTART, iRow] := strThumbStart;
   advListGrid.Cells[FIELD_IMAGEEND, iRow] := strThumbEnd;
   advListGrid.Cells[FIELD_STATUS, iRow] := strStatus;
   advListGrid.Cells[FIELD_REMARK, iRow] := strMemo;
   advListGrid.Cells[FIELD_INI_FILENAME, iRow] := ininame;

   if (CompareText(strStart, '') <> 0) and (CompareText(strEnd, '') <> 0) then
   begin
      startTime := StrToDateTime(strStart);
      endTime := StrToDateTime(strEnd);
      timeLength := endTime - startTime;
      advListGrid.Cells[FIELD_TOTALLENGTH, iRow] := FormatDateTime('hh:mm:ss', timeLength);
   end;

   if (CompareText(strThumbStart, '') <> 0) and (CompareText(strThumbEnd, '') <> 0) then
   begin
      startTime := StrToDateTime(strThumbStart);
      endTime := StrToDateTime(strThumbEnd);
      timeLength := endTime - startTime;
      advListGrid.Cells[FIELD_IMAGELENGTH, iRow] := FormatDateTime('hh:mm:ss', timeLength);
   end;
end;

procedure TForm1.GridResize;
begin
  advListGrid.AutoSize := True;
  advListGrid.AutoSize := False;
  advListGrid.ColumnSize.StretchColumn := FIELD_REMARK;
  advListGrid.ColumnSize.Stretch := True;
  advListGrid.ColumnSize.Stretch := False;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   FDirectoryWatch.Stop;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   g_ProgramPath := ExtractFilePath( Application.ExeName );
   FDirectoryWatch := TDirectoryWatch.Create;
   FDirectoryWatch.OnNotify := OnNotify;
   advListGrid.HideColumn(FIELD_INI_FILENAME);
   PostMessage(handle, WM_PROGRAMSTART, 0, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   DeallocateHWnd(FWndHandle);
   FreeAndNil(FDirectoryWatch);
end;



procedure TForm1.FormResize(Sender: TObject);
begin
   GridResize;
end;

procedure TForm1.GridClear(advGrid: TAdvStringGrid);
var
   iFixedRow : Integer;
   iRangeRow : Integer;
begin
   if advGrid.RowCount > 1 then
   begin
      iFixedRow := advGrid.FixedRows;
      iRangeRow := advGrid.RowCount - iFixedRow;
      advGrid.ClearRows(iFixedRow, iRangeRow);
      advGrid.RowCount := 2;
   end
   else if advGrid.RowCount = 1 then
   begin
      advGrid.ClearRows(1, 1);
      advGrid.RowCount := 2;
   end;
end;

procedure TForm1.LoadHistory;
begin
   fileLst_History.Directory := g_ProgramPath + 'History';
   fileLst_History.Update;
end;

procedure TForm1.ModifyData(strId, strFilename, strStart, strEnd, strMemo,
  strStatus: String; iPos : Integer; ininame, strThumbStart, strThumbEnd : String);
var
   startTime, endTime : TDateTime;
   timeLength : TTime;
begin
   advListGrid.Cells[FIELD_FILENAME, iPos] := strFilename;
   advListGrid.Cells[FIELD_STARTDATETIME, iPos] := strStart;
   advListGrid.Cells[FIELD_ENDDATETIME, iPos] := strEnd;
   advListGrid.Cells[FIELD_IMAGESTART, iPos] := strThumbStart;
   advListGrid.Cells[FIELD_IMAGEEND, iPos] := strThumbEnd;
   advListGrid.Cells[FIELD_STATUS, iPos] := strStatus;
   advListGrid.Cells[FIELD_REMARK, iPos] := strMemo;
   advListGrid.Cells[FIELD_INI_FILENAME, iPos] := ininame;
   if (CompareText(strStart, '') <> 0) and (CompareText(strEnd, '') <> 0) then
   begin
      startTime := StrToDateTime(strStart);
      endTime := StrToDateTime(strEnd);
      timeLength := endTime - startTime;
      advListGrid.Cells[FIELD_TOTALLENGTH, iPos] := FormatDateTime('hh:mm:ss', timeLength);
   end;

   if (CompareText(strThumbStart, '') <> 0) and (CompareText(strThumbEnd, '') <> 0) then
   begin
      startTime := StrToDateTime(strThumbStart);
      endTime := StrToDateTime(strThumbEnd);
      timeLength := endTime - startTime;
      advListGrid.Cells[FIELD_IMAGELENGTH, iPos] := FormatDateTime('hh:mm:ss', timeLength);
   end;
   GridResize;
end;

procedure TForm1.OnMyStartProgram(var Msg: TMessage);
var
   i : Integer;
begin
   //LoadIni
   LoadHistory;
   if fileLst_History.Items.Count > 0 then
   begin
      for i := 0 to fileLst_History.Items.Count - 1 do
      begin
         ParsingHistory(fileLst_History.Items[i]);
      end;
      GridResize;
   end;
   FDirectoryWatch.Directory := g_ProgramPath + 'History';
   FDirectoryWatch.WatchSubTree := False;
   FDirectoryWatch.Start;
   Timer1.Enabled := True;
end;

procedure TForm1.OnNotify(const Sender: TObject; const Action: TWatchAction;
  const FileName: string);
begin
   case Integer(Action) of
      Ord(TWatchAction.waAdded) :
      begin
         //ParsingHistory(FileName);
      end;

      Ord(TWatchAction.waModified) :
      begin
         ParsingHistory(FileName)
      end;

      Ord(TWatchAction.waRemoved) :
      begin
         RemoveData(FileName);
      end;
   end;
end;

procedure TForm1.ParsingHistory(sFileName: String);
var
   ConfigIni: TIniFile;
   strId, strFilename, strStart, strEnd, strMemo, strStatus, strIniName, strThumbStart, strThumbEnd : String;
begin
   if FileExists(g_ProgramPath + 'History\' + sFileName) then begin
      ConfigIni := TIniFile.Create(g_ProgramPath + 'History\' + sFileName);
      try
         strId := ConfigIni.ReadString( 'INFO', 'ID', '' );
         strFilename := ConfigIni.ReadString( 'INFO', 'FILENAME', '' );
         strStart := ConfigIni.ReadString( 'INFO', 'START', '' );
         strEnd := ConfigIni.ReadString( 'INFO', 'END', '' );
         strThumbStart := ConfigIni.ReadString( 'INFO', 'THUMB_START', '' );
         strThumbEnd := ConfigIni.ReadString( 'INFO', 'THUMB_END', '' );
         strMemo := ConfigIni.ReadString( 'INFO', 'MEMO', '' );
         strStatus := ConfigIni.ReadString( 'INFO', 'STATUS', '' );
         strIniName := sFileName;
         AddData(strId, strFilename, strStart, strEnd, strMemo, strStatus, strIniName, strThumbStart, strThumbEnd);
      finally
         FreeAndNil(ConfigIni);
      end;
   end;
end;

procedure TForm1.RemoveData(sFilename : String);
var
   i : Integer;
begin
   if advListGrid.RowCount > 2 then
   begin
      for i := 1 to advListGrid.RowCount - 1 do
      begin
         if SameText(advListGrid.Cells[FIELD_INI_FILENAME, i], sFilename) then
         begin
            advListGrid.RemoveRows(i, 1);
         end;
      end;
   end
   else begin
      GridClear(advListGrid);
   end;
   advListGrid.Repaint;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
   threadWork1 : TDeleteHistory;
begin
   Timer1.Interval := 1000 * 60 * 60 * 10;

   //Timer1.Interval := 1000 * 60;

   threadWork1 := TDeleteHistory.Create;
end;

{ TDeleteHistory }

constructor TDeleteHistory.Create;
begin
   FreeOnTerminate := True;
   inherited Create(False);
end;

procedure TDeleteHistory.Execute;
var
   searchResult : TSearchRec;
   ifilehandle : Integer;
   t3DayAfter : TDateTime;
   syyyymmdd : String;
   sFileyyyymmdd : String;
   sDir : String;
begin
   while Not Terminated do
   begin
      t3DayAfter := IncDay(now, -4);
      syyyymmdd := FormatDateTime('YYYYMMdd', t3DayAfter);
      if FindFirst( g_ProgramPath + 'history\*', faAnyFile or faDirectory, searchResult ) = 0 then
      begin
         try
            repeat
               //File
               if (( searchResult.Attr and faDirectory ) = 0) and SameText(ExtractFileExt(searchResult.Name), '.ini') then begin
                  ifilehandle := FileOpen( g_ProgramPath + 'history\' + searchResult.Name, fmOpenWrite or fmShareDenyNone or fmOpenRead );
                  if ifilehandle > 0 then
                  begin
                     FileClose(ifilehandle);
                     sFileyyyymmdd := Copy(searchResult.Name, 0, 8);
                     sDir := Copy(searchResult.Name, 0, 6);
                     if StrToInt(sFileyyyymmdd) < StrToInt(syyyymmdd) then
                     begin
                        //DeleteFile(g_ProgramPath + 'history\' + searchResult.Name);
                        if not SysUtils.DirectoryExists(g_ProgramPath + 'history\' + sDir) then
                        begin
                           CreateDir(g_ProgramPath + 'history\' + sDir);
                        end;
                        try
                           DeleteFile(g_ProgramPath + 'history\' + sDir + '\' + searchResult.Name);
                           MoveFile( PWChar( g_ProgramPath + 'history\' + searchResult.Name ),
                                    PWChar( g_ProgramPath + 'history\' + sDir + '\' + searchResult.Name ) );
                        except

                        end;
                     end;
                  end;

               end;
            until FindNext( searchResult ) <> 0;
         finally
            FindClose( searchResult );
         end;
      end;
      break;
   end;
end;

end.
