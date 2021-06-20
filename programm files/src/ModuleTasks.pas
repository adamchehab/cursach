Unit ModuleTasks;

Interface
uses Objects, Drivers, Dialogs;

const
  ShowTask =  1000;
  cmConvert = 1001;
  cmRUB =     1002;
  cmUSD =     1003;
  cmLBP =     1004;
  cmExit =    1005;
  
  USD =  72.39;
  LBP =  0.047;

type
  PTaskDialog = ^TTaskDialog;
  TTaskDialog = object(TDialog)
    sIn, sOutRUB, sOutUSD, sOutLBP, sCurrency: PInputLine;
    constructor Init();
    procedure HandleEvent(var Event : TEvent); virtual;
  private
    currency:string;
    procedure Action; 
  end;

Implementation

procedure TTaskDialog.HandleEvent(var Event : TEvent);
begin
  inherited HandleEvent(Event); 
  if Event.What = evCommand then
  begin
    case Event.Command of
      cmRUB:      begin currency:='RUB'; sCurrency^.SetData(currency); end;
      cmUSD:      begin currency:='USD'; sCurrency^.SetData(currency); end;
      cmLBP:      begin currency:='LBP'; sCurrency^.SetData(currency); end;
      cmConvert:  begin Action; sCurrency^.SetData(currency); end;
      cmExit:     Close;
    end;
    ClearEvent(Event);
  end;
end;

constructor TTaskDialog.Init; 
var
  R : TRect;
begin
  R.Assign(15, 5, 73, 18);
  inherited Init(R, 'CONVERTER');
  
  R.Assign(6, 3, 15, 5);
  Insert(New(PButton, Init(R, 'RUB', cmRUB, bfNormal)));
  R.Assign(6, 5, 15, 7);
  Insert(New(PButton, Init(R, 'USD', cmUSD, bfNormal)));
  R.Assign(6, 7, 15, 9);
  Insert(New(PButton, Init(R, 'LBP', cmLBP, bfNormal)));
  
  R.Assign(18, 3, 37, 4);
  Insert(New(PStaticText, Init(R, 'Current:')));
  R.Assign(28, 5, 34, 6);
  sCurrency:=New(PInputLine, Init(R, 15));
  Insert(sCurrency);
  currency:='RUB';
  sCurrency^.SetData(currency);
  
  R.Assign(18, 5, 27, 6);
  sIn := New(PInputLine, Init(R, 15));
  Insert(sIn);
  
  R.Assign(36, 3, 40, 4);
  Insert(New(PStaticText, Init(R, 'RUB:')));
  R.Assign(41, 3, 51, 4);
  sOutRUB := New(PInputLine, Init(R, 15));
  Insert(sOutRUB);
  R.Assign(36, 5, 40, 6);
  Insert(New(PStaticText, Init(R, 'USD:')));
  R.Assign(41, 5, 51, 6);
  sOutUSD := New(PInputLine, Init(R, 15));
  Insert(sOutUSD);
  R.Assign(36, 7, 40, 8);
  Insert(New(PStaticText, Init(R, 'LBP:')));
  R.Assign(41, 7, 51, 8);
  sOutLBP := New(PInputLine, Init(R, 15));
  Insert(sOutLBP);
  
  R.Assign(16, 10, 27, 12);
  Insert(New(PButton, Init(R, 'CONVERT', cmConvert, bfNormal)));
  R.Assign(32, 10, 43, 12);
  Insert(New(PButton, Init(R, 'CLOSE', cmExit, bfNormal)));
end;

procedure TTaskDialog.Action;

function FloatToStr(f : real) : string;
  var s : string;
  begin
    Str(f:0:3, s);
    FloatToStr := s;
  end;
  function StrToFloat(s : string) : real;
  var
    f : real;
    Code : Integer;
  begin
    Val(s, f, Code);
    StrToFloat := f;
  end;

var
  x,a:real;
  s:string;
begin

  sIn^.GetData(s);
  x:=StrToFloat(s);
  
  If (currency = 'USD')
  then 
    x:=x*USD
  else 
    If (currency = 'LBP')
    then
      x:=x*LBP;
  
  s:=FloatToStr(x);
  sOutRUB^.SetData(s);
  
  a:=x/USD;
  s:=FloatToStr(a);
  sOutUSD^.SetData(s);
  
  a:=x/LBP;
  s:=FloatToStr(a);
  sOutLBP^.SetData(s);
end;

end.