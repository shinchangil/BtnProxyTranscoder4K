object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'TranscoderC'
  ClientHeight = 108
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 444
    Height = 29
    Align = alTop
    Alignment = taCenter
    Caption = 'Transcoding Client'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 194
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 58
    Height = 16
    Caption = #53080#53584#52768' ID: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 62
    Width = 53
    Height = 16
    Caption = #54028#51068' '#51060#47492':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl_ContentId: TLabel
    Left = 104
    Top = 40
    Width = 4
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl_FileName: TLabel
    Left = 104
    Top = 62
    Width = 4
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 91
    Width = 444
    Height = 17
    Align = alBottom
    Smooth = True
    Step = 1
    TabOrder = 0
  end
  object FileListBox1: TFileListBox
    Left = 112
    Top = 0
    Width = 145
    Height = 97
    ImeName = 'Microsoft IME 2010'
    ItemHeight = 13
    TabOrder = 1
    Visible = False
  end
  object FFEncoder1: TFFEncoder
    OnProgress = FFEncoder1Progress
    OnTerminate = FFEncoder1Terminate
    Left = 256
    Top = 8
  end
  object XMLDocument1: TXMLDocument
    Left = 336
    Top = 8
    DOMVendorDesc = 'MSXML'
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 368
    Top = 8
  end
  object FFDecoder1: TFFDecoder
    Left = 32
    Top = 32
  end
end
