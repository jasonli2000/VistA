object frmSignonMsg: TfrmSignonMsg
  Left = 194
  Top = 16
  Width = 766
  Height = 630
  Caption = 'Signon Message'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 758
    Height = 562
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 3
    Caption = 'Panel1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object mmoMsg: TXWBRichEdit
      Left = 4
      Top = 4
      Width = 750
      Height = 554
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Fixedsys'
      Font.Style = [fsBold]
      URLDetect = True
      HideScrollBars = False
      Lines.Strings = (
        
          '1234567891123456789212345678931234567894123456789512345678961234' +
          '5678971234567898      '#13)
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 562
    Width = 758
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    OnResize = Panel2Resize
    object BitBtn1: TBitBtn
      Left = 342
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Close'
      Default = True
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        BE060000424DBE06000000000000360400002800000024000000120000000100
        0800000000008802000000000000000000000001000000010000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
        FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
        800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
        FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
        800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
        FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
        800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
        FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
        800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
        FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
        800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A600F0FBFF00A4A0A000808080000000FF0000FF000000FFFF00FF000000FF00
        FF00FFFF0000FFFFFF0000000000000080000080000000808000800000008000
        800080800000C0C0C000C0DCC000F0CAA600F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
        800000800000008080008000000080008000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030C0C0C0C0C
        0C0C0C0C0707130713070C07130C0C0C0C0C0C0C0C0C0C030303030303130404
        04040400000C0C0C13131304040404040C0C0C0C0C0C0C0C0C0C130303031313
        0C130303030304110500000713131304030303030C0C0C0C0C0C0C0C0C0C0303
        030C0C0C0C13030303030405110500131313130403030303030303030C130C0C
        0C130303030C1303031303030303041105110013131313040303030303030303
        0C0C070C0C130303030C13030313030303030405110500131213120403030303
        030303030C130C070C130303030C130303130303030304110511001313131304
        03030303030303030C0C070C0C130303030C1303031303030303040511050013
        1213120403030303030303030C130C070C130303030C13030313030303030411
        051100131313130403030303030303030C0C070C0C130303030C130303130303
        03030405110500131213120403030303030303030C130C070C130303030C1303
        0313030303030411051100121312130403030303030303030C0C070C0C130303
        030C13030313030303030405110500131213120403030303030303030C130C07
        0C130303030C1303031303030303041105110012131213040303030303030303
        0C0C070C0C130303030C13030313030303030404040404040404040403030303
        030303030C130C130C131313130C130303130303030303030303030303030303
        03030303030303030C0C0C0C0C0C0C0C0C0C0303031303030303030300000000
        0000030303030303030303030303031313131313130303030313030303030303
        000E0E0E0E000303030303030303030303030C0C0C0C0C0C1303030303130303
        030303030000000000000303030303030303030303030C131313130C13030303
        0313}
      NumGlyphs = 2
    end
  end
end