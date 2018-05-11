unit Demo.Forms.Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Demo.Core.Rtti;

type
  [FrameTitle('Test')]
  TFrameTest = class(TFrame)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Demo.Core.Registry, Demo.Interfaces, Demo.Forms.GenericDialog;

procedure TFrameTest.Button1Click(Sender: TObject);
begin
  TFormGenericDialog.ShowDialog<ILookupFrame>('employee-list',
    procedure (ModalResult: TModalResult; AFrame: ILookupFrame)
    begin
      if ModalResult = mrOk then
        ShowMessage(IntToStr(AFrame.GetResultValue.AsInteger));
    end
  );
end;

procedure TFrameTest.Button2Click(Sender: TObject);
begin
  TFormGenericDialog.ShowDialog<IFrame>('employee-list');
end;

procedure TFrameTest.Button3Click(Sender: TObject);
begin
  TFormGenericDialog.ShowDialog<IEmployeeListFrame>;
end;

initialization
  TClassRegistry.Instance.RegisterClass(TFrameTest);

end.
