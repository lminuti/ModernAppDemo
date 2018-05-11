unit Demo.Forms.GenericDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Demo.Interfaces;

type
  TResponseProc<T> = reference to procedure (AModalResult: TModalResult; AFrame: T);

  TFormGenericDialog = class(TForm)
    PanelFooter: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    class procedure ShowDialog<T: IFrame>(const AClassOrAlias: string; AProc: TResponseProc<T>); overload;
    class procedure ShowDialog<T: IFrame>(AProc: TResponseProc<T>); overload;
    class procedure ShowDialog<T: IFrame>(const AClassOrAlias: string); overload;
    class procedure ShowDialog<T: IFrame>; overload;
  end;

var
  FormGenericDialog: TFormGenericDialog;

implementation

{$R *.dfm}

uses
  Demo.Core.Registry;

procedure TFormGenericDialog.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFormGenericDialog.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

class procedure TFormGenericDialog.ShowDialog<T>(const AClassOrAlias: string);
begin
  ShowDialog<T>(AClassOrAlias, nil);
end;

class procedure TFormGenericDialog.ShowDialog<T>(AProc: TResponseProc<T>);
begin
  ShowDialog<T>('', AProc);
end;

class procedure TFormGenericDialog.ShowDialog<T>;
begin
  ShowDialog<T>('', nil);
end;

class procedure TFormGenericDialog.ShowDialog<T>(const AClassOrAlias: string; AProc: TResponseProc<T>);
const
  Margin = 5;
var
  Frame: T;
  Dialog: TFormGenericDialog;
  ModalResult: TModalResult;
  Rect: TRect;
begin
  Frame := TClassRegistry.Instance.GetClass<T>(AClassOrAlias);
  Dialog := TFormGenericDialog.Create(nil);
  try
    Rect := Frame.GetClientRect;
    Frame.SetParent(Dialog);
    Dialog.ClientWidth := Rect.Width + Margin;
    Dialog.ClientHeight := Rect.Height + Dialog.PanelFooter.Height + Margin;
    ModalResult := Dialog.ShowModal;
    if Assigned(AProc) then
      AProc(ModalResult, Frame);
  finally
    Dialog.Free;
  end;
end;

end.
