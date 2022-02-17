unit Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type

  // Запись
  TTest = record
    vopr, otv1, otv2, otv3, rightOtv: string;
  end;

type
  TTestForm = class(TForm)
    Question_label: TLabel;
    Button_verify: TButton;
    Variants: TRadioGroup;
    chermark_image: TImage;
    GoodAnswers: TLabel;
    CroosImage: TImage;
    BadAnswers: TLabel;
    Timer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button_verifyClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestForm: TTestForm;
  arrOfTests: array of TTest;
  activeTestFile, rightAnswer: string;
  nowTestNumber, goodAnswersNum, badAnswersNum: integer;

implementation

{$R *.dfm}

uses Main;

// Показать ответ
procedure readFromFile(FileName: string);
var
  f: textFile;
  title: string;
  amountOfTests, i: integer;

begin
  assign(f, FileName);
  reset(f);
  readln(f, title);
  TestForm.Caption := title;

  readln(f, amountOfTests);
  SetLength(arrOfTests, amountOfTests);

  for i := 1 to amountOfTests do
  begin
    with arrOfTests[i - 1] do
    begin
      readln(f, vopr);
      readln(f, otv1);
      readln(f, otv2);
      readln(f, otv3);
      readln(f, rightOtv);
    end;
  end;

  close(f);
end;

// Загрузить тест
procedure DownloadTest(num: integer);
begin
  with TestForm do
  begin
    Variants.Items.Clear;
    Variants.ItemIndex := -1;
    with arrOfTests[num - 1] do
    begin
      Question_label.Width := 500;
      Question_label.Caption := vopr;
      Variants.Items.Add(otv1);
      Variants.Items.Add(otv2);
      Variants.Items.Add(otv3);
      rightAnswer := rightOtv;
    end;
  end;
end;

// Проверка на правильность
procedure TTestForm.Button_verifyClick(Sender: TObject);
begin
  if Variants.ItemIndex >= 0 then
  begin
    with arrOfTests[nowTestNumber] do
    begin
      // Правильно ответили
      if (Variants.Items[Variants.ItemIndex]) = rightAnswer then
      begin
        goodAnswersNum := goodAnswersNum + 1;
        GoodAnswers.Caption := IntToStr(goodAnswersNum);
        TestForm.Color := clGreen;
        Timer.Enabled := True;
      end
      // Неправильно ответили
      else
      begin
        badAnswersNum := badAnswersNum + 1;
        BadAnswers.Caption := IntToStr(badAnswersNum);
        TestForm.Color := rgb(194, 62, 45);
        Timer.Enabled := True;
      end;
      // Если не последний тест
      if nowTestNumber < length(arrOfTests) then
      begin
        nowTestNumber := nowTestNumber + 1;
        DownloadTest(nowTestNumber);
      end
      //Последний тест
      else
      begin
        // проверка на прохождение всей станции
        if ((goodAnswersNum / length(arrOfTests)) >= 0.5) then
        begin
          showMessage('Поздравляю! Станция пройдена');
          with mapForm do
          begin
            if stations = 1 then
            begin
              Button_ecology.Enabled := True;
              Button_animals.Enabled := False;
              Map.Picture.LoadFromFile('karta_rumlevo-1.png');
            end
            else if stations = 2 then
            begin
              Button_pravila.Enabled := True;
              Button_ecology.Enabled := False;
              Map.Picture.LoadFromFile('karta_rumlevo-2.png');
            end
            else if stations = 3 then
            begin
              button_plants.Enabled := True;
              Button_pravila.Enabled := False;
              Map.Picture.LoadFromFile('karta_rumlevo-3.png');
            end
            else if stations = 4 then
            begin
               button_plants.Enabled := False;
            end;
            StationsLabel.Caption:='Пройдено станций: '+IntToStr(stations)+' из 4';
          end;

          stations := stations + 1;
          hide();
        end
        else
        begin
          showMessage('К сожалению станция не пройдена(');
          hide();
        end;
      end;
    end;
  end;
end;

// При создании формы
procedure TTestForm.FormCreate(Sender: TObject);
begin
  nowTestNumber := 1;
  goodAnswersNum := 0;
  badAnswersNum := 0;
  BadAnswers.Caption:='0';
  GoodAnswers.Caption:='0';
  Question_label.Caption := '';

  readFromFile(activeTestFile);

  DownloadTest(nowTestNumber);

end;

// таймер
procedure TTestForm.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  TestForm.Color := clWhite;
end;

end.
