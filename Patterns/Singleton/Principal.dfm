object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 262
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 121
    Height = 41
    Caption = 'Pessoa Fisica'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 143
    Top = 16
    Width = 121
    Height = 42
    Caption = 'Pessoa Juridica'
    TabOrder = 1
    OnClick = Button2Click
  end
end
