Unit ModuleTasks;

Interface
uses Objects, Drivers, Dialogs;

const
  ShowTask = 1000;
  cmConvert = 1001;
  cmRub = 1002;
  cmDollar = 1003;
  cmEuro = 1004;
  cmExit = 1005;
  
  // курс валют (можно float)
  Dollar = 73;
  Euro = 89;

type
  PTaskDialog = ^TTaskDialog;
  TTaskDialog = object(TDialog)
    sIn, sOutRub, sOutDollar, sOutEuro, sCurrency: PInputLine;
    constructor Init();
    procedure HandleEvent(var Event : TEvent); virtual;
  private
    currency:string;
    procedure Action; 
  end;

Implementation

procedure TTaskDialog.HandleEvent(var Event : TEvent);
begin
  inherited HandleEvent(Event);   // обработка ст. команд
  if Event.What = evCommand then  // обработка новых команд  , если какая то кнопка нажата
  begin
    case Event.Command of
      // задаем текущюю валюту
      cmRub: begin currency:='Rubble'; sCurrency^.SetData(currency); end;
      cmDollar: begin currency:='Dollar'; sCurrency^.SetData(currency); end;
      cmEuro: begin currency:='Euro'; sCurrency^.SetData(currency); end;
      cmConvert : begin Action; sCurrency^.SetData(currency); end;
      cmExit : Close;
    end;
    ClearEvent(Event);
  end;
end;

constructor TTaskDialog.Init; 
var
  R : TRect;
begin
  // 4 числа тк 2 - коорд верхней левой точки
  // куда вставляем
  R.Assign(15, 5, 75, 20);
  // что мы вставляем
  inherited Init(R, 'Task');
  // Зеленые кнопки слева создаем
  R.Assign(3,3,14,5);
  Insert(New(PButton, Init(R, 'Rubble', cmRub, bfNormal)));
  R.Assign(3,6,14,8);
  Insert(New(PButton, Init(R, 'Dollar', cmDollar, bfNormal)));
  R.Assign(3,9,14,11);
  Insert(New(PButton, Init(R, 'Euro', cmEuro, bfNormal)));
  
  R.Assign(18, 3, 37,4);
  Insert(New(PStaticText, Init(R, 'Input amount')));
  R.Assign(18, 5, 27,6);
  sCurrency:=New(PInputLine, Init(R, 15));
  Insert(sCurrency);
  currency:='Rubble';
  sCurrency^.SetData(currency);
  
  R.Assign(18,7,27,8);
  sIn := New(PInputLine, Init(R, 15));
  Insert(sIn);
  
  R.Assign(35, 3, 42,4);
  Insert(New(PStaticText, Init(R, 'Rubble:')));
  R.Assign(43,3,55,4);
  sOutRub := New(PInputLine, Init(R, 15));
  Insert(sOutRub);
  R.Assign(35, 5, 42,6);
  Insert(New(PStaticText, Init(R, 'Dollar:')));
  R.Assign(43,5,55,6);
  sOutDollar := New(PInputLine, Init(R, 15));
  Insert(sOutDollar);
  R.Assign(35, 7, 42,8);
  Insert(New(PStaticText, Init(R, 'Euro:')));
  R.Assign(43,7,55,8);
  sOutEuro := New(PInputLine, Init(R, 15));
  Insert(sOutEuro);
  
  R.Assign(18,12,29,14);
  Insert(New(PButton, Init(R, 'Close', cmExit, bfNormal)));
  R.Assign(18,9,29,11);
  Insert(New(PButton, Init(R, 'Convert', cmConvert, bfNormal)));
end;

procedure TTaskDialog.Action;

function FloatToStr(f : real) : string;
  var s : string;
  begin
    Str(f:0:3, s);  // 3 знака после запятой
    FloatToStr := s;
  end;
  function StrToFloat(s : string) : real;
  var
    f : real;
    Code : Integer; // рузультата операции 0 или 1
  begin
    Val(s, f, Code);  // s что кладем, f - получаем
    StrToFloat := f;
  end;

var
  x,a:real;
  s:string;
begin

  sIn^.GetData(s);
  x:=StrToFloat(s);
  
  If (currency = 'Dollar')
  then 
    x:=x*Dollar
  else 
    If (currency = 'Euro')
    then
      x:=x*Euro;
  
  s:=FloatToStr(x);
  sOutRub^.SetData(s);
  
  a:=x/Dollar;
  s:=FloatToStr(a);
  sOutDollar^.SetData(s);
  
  a:=x/Euro;
  s:=FloatToStr(a);
  sOutEuro^.SetData(s);
end;

end.