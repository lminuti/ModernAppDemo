unit Demo.Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormMain = class(TForm)
    PanelMenu: TPanel;
    PanelFrameContainer: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CreateMenuButton(const AFrameTitle: string; AFrameClass: TCustomFrameClass);
    procedure BuildMenu;
  public
    { Public declarations }
  end;

  TMenuButton = class(TButton)
  private
    FFrameClass: TCustomFrameClass;
    FFormParent: TWinControl;
  public
    procedure Click; override;
    property FrameClass: TCustomFrameClass read FFrameClass write FFrameClass;
    property FormParent: TWinControl read FFormParent write FFormParent;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
  Demo.Core.Registry, Demo.Modules.DBBuilder, Demo.Core.Rtti, Demo.Interfaces;

procedure TFormMain.CreateMenuButton(const AFrameTitle: string;
  AFrameClass: TCustomFrameClass);
var
  AButton: TMenuButton;
begin
  AButton := TMenuButton.Create(Self);
  AButton.FormParent := PanelFrameContainer;
  AButton.Caption := AFrameTitle;
  AButton.FrameClass := AFrameClass;
  AButton.AlignWithMargins := True;
  AButton.Align := alTop;
  AButton.Height := 50;
  AButton.Parent := PanelMenu;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  TDatabaseBuilder.Initialize;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  Caption := ExtractFileName(Application.ExeName);
  BuildMenu;
end;

procedure TFormMain.BuildMenu;
var
  FrameTitle: FrameTitleAttribute;
begin
  ClassRegistry.ForEach<IFrame>(
    procedure (ClassType: TClass)
    begin
      FrameTitle := TRttiUtils.FindAttribute<FrameTitleAttribute>(ClassType);
      if Assigned(FrameTitle) then
        CreateMenuButton(FrameTitle.Title, TCustomFrameClass(ClassType));
    end
  );
end;

{ TMenuButton }

procedure TMenuButton.Click;
var
  AFrame: TCustomFrame;
begin
  inherited;
  if FFormParent.ControlCount > 0 then
    FFormParent.Controls[0].Free;

  AFrame := FFrameClass.Create(Owner);
  AFrame.Align := alClient;
  AFrame.Parent := FFormParent;
end;

end.
