Unit ModuleApp;

Interface
uses Objects, Drivers, Views, Menus, App, ModuleTasks;

type
  TMyApp = object(TApplication)
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure InitMenuBar; virtual;
    procedure InitStatusLine; virtual;
  end;
  
Implementation

procedure TMyApp.HandleEvent(var Event: TEvent);
begin
  TApplication.HandleEvent(Event);
  if Event.What = evCommand then
  begin
    case Event.Command of
      ShowTask : 
        InsertWindow(New(PTaskDialog, Init));
    else
      Exit;
    end;
    ClearEvent(Event);
  end;
end;

procedure TMyApp.InitMenuBar;
var R: TRect;
begin
  GetExtent(R);
  R.B.Y := R.A.Y + 1;
  MenuBar:=New(PMenuBar, Init(R,NewMenu(
    NewItem('~S~tart','F3',kbF3 ,ShowTask,hcNoContext,
    NewItem('~E~xit','Alt-X',kbAltX,cmQuit,hcNoContext,
    nil))
  )));
end;

procedure TMyApp.InitStatusLine;
var R: TRect;
begin
  GetExtent(R);
  R.A.Y := R.B.Y - 1;
  StatusLine := New(PStatusLine, Init(R,
    NewStatusDef(0, $FFFF,
      NewStatusKey('', kbF10, cmMenu,
      NewStatusKey('~Alt-X~ End', kbAltX, cmQuit,
      NewStatusKey('~F3~ Start', kbF3, ShowTask,
      nil))),
    nil)
  ));
end;

end.