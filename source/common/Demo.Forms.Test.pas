unit Demo.Forms.Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Demo.Core.Rtti,
  Vcl.ExtCtrls;

type
  [FrameTitle('Test')]
  TFrameTest = class(TFrame)
    ButtonSeachEmpNo: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    EditEmpNo: TEdit;
    Panel2: TPanel;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure ButtonSeachEmpNoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  Demo.Core.Registry, Demo.Interfaces, Demo.Forms.GenericDialog;

procedure TFrameTest.ButtonSeachEmpNoClick(Sender: TObject);
begin
  TFormGenericDialog.ShowDialogWithParam<ILookupFrame>('employee-list',
    StrToIntDef(EditEmpNo.Text, -1),
    procedure (ModalResult: TModalResult; AFrame: ILookupFrame)
    begin
      if ModalResult = mrOk then
        EditEmpNo.Text := IntToStr(AFrame.GetResultValue.AsInteger);
    end
  );
end;

procedure TFrameTest.Button1Click(Sender: TObject);
var
  Calculator: ICalculator;
begin
  Calculator := TClassRegistry.Instance.GetClass<ICalculator>;
  Edit3.Text := Calculator.Calculate(StrToInt(Edit1.Text), StrToInt(Edit2.Text)).ToString;
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
