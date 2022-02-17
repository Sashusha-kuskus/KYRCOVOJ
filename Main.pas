unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons, Vcl.StdCtrls;

type
  TMapForm = class(TForm)
    Panel1: TPanel;
    Map: TImage;
    Button_animals: TButton;
    Button_pravila: TButton;
    Button_ecology: TButton;
    Button_plants: TButton;
    Label1: TLabel;
    StationsLabel: TLabel;
    procedure Button_animalsClick(Sender: TObject);
    procedure Button_pravilaClick(Sender: TObject);
    procedure Button_ecologyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MapForm: TMapForm;
  isTestPass:bool;
  stations:integer;


implementation

{$R *.dfm}

uses Test;

 //животные
procedure TMapForm.Button_animalsClick(Sender: TObject);
begin
  activeTestFile:='animals.txt';
end;

//экология
procedure TMapForm.Button_ecologyClick(Sender: TObject);
begin
   activeTestFile:='ecology.txt';
end;

// правила безопасности
procedure TMapForm.Button_pravilaClick(Sender: TObject);
begin
  activeTestFile:='pravila.txt';
end;

procedure TMapForm.FormCreate(Sender: TObject);
begin
   stations:=1;
end;

end.
