object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TranscoderM'
  ClientHeight = 105
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 16
    Width = 167
    Height = 19
    Caption = 'Transcoder Manager'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 48
    Width = 255
    Height = 13
    Caption = #51060' '#54532#47196#44536#47016#51008' '#53944#47004#49828#53076#46377#51012' '#50948#54620' Manager '#54532#47196#44536#47016
  end
  object Label3: TLabel
    Left = 32
    Top = 67
    Width = 257
    Height = 13
    Caption = ' '#51077#45768#45796'. '#53944#47004#49828#53076#46377#51012' '#50948#54644' '#54637#49884' '#44032#46041#46104#50612#50556' '#54633#45768#45796'.'
  end
  object lbl_Count: TLabel
    Left = 16
    Top = 80
    Width = 3
    Height = 13
  end
  object tmr_QueryTrans: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = tmr_QueryTransTimer
    Left = 104
    Top = 40
  end
  object XMLDocument1: TXMLDocument
    Left = 184
    Top = 24
    DOMVendorDesc = 'MSXML'
  end
end
