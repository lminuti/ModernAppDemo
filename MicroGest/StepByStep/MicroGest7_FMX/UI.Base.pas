unit UI.Base;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, System.Actions, FMX.ActnList;

type
  TUIBase = class(TFrame)
    ToolBarTop: TToolBar;
    SpeedButton1: TSpeedButton;
    ActionList1: TActionList;
    acBack: TAction;
    Title: TLabel;
    procedure acBackExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  UI.Start;

{$R *.fmx}

{ TFrame1 }

procedure TUIBase.acBackExecute(Sender: TObject);
var
  LLastTabIndex: Integer;
begin
  StartForm.PreviousTabAction1.Execute;
  LLastTabIndex := StartForm.MainTabControl.TabCount -1;
  StartForm.MainTabControl.Delete(LLastTabIndex);
end;

end.
