unit eAtasOrais.Controller.Atas;

interface

uses
  eAtasOrais.Controller.interfaces, System.Generics.Collections, eAtasOrais.Model.ClasseAlunosConceitos,
  System.Classes;

Type
  TControllerAtas = Class(TInterfacedObject, iControllerAtas)
    Private
     FPeriodo         : string;
     FAlunos          : TStrings;
     FConceitos       : TStrings;
     FExaminador      : String;
     FTurma           : string;
     FDias            : string;
     Fhorario         : string;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iControllerAtas;
     Function Periodo (Value : String) : iControllerAtas;
     function Alunos (Value : TStrings) : iControllerAtas;
     function Conceitos (Value : TStrings) : iControllerAtas;
     Function Examinador (Value : String) : iControllerAtas;
     Function Turma (Value : string) : iControllerAtas;
     Function Dias (Value : String) : iControllerAtas;
     Function horario (Value : string) : iControllerAtas;
     Function Gerar : Boolean;
  End;

implementation

uses
  eAtasOrais.view.principal, eAtasOrais.Model.Atas, FMX.Dialogs;

{ TControllerAtas }


function TControllerAtas.Alunos(Value: TStrings): iControllerAtas;
begin
   Result := self;
   FAlunos := Value;
end;

function TControllerAtas.Conceitos(Value: TStrings): iControllerAtas;
begin
   Result := self;
   FConceitos := Value;
end;

constructor TControllerAtas.Create;
begin

end;

destructor TControllerAtas.Destroy;
begin

  inherited;
end;

function TControllerAtas.Dias(Value: String): iControllerAtas;
begin
    Result := self;
    FDias := Value;
end;

function TControllerAtas.Examinador(Value: String): iControllerAtas;
begin
    Result := self;
    FExaminador := Value;
end;

function TControllerAtas.Gerar: Boolean;
Var
  Periodo, Turma, Dias, Horario, Examinador : string;
  Alunos : TStrings;
  Conceitos : TStrings;
begin
  Periodo         := FPeriodo;
  Turma           := FTurma;
  Dias            := FDias;
  Horario         := Fhorario;
  Examinador      := FExaminador;
  Alunos          := FAlunos;
  Conceitos       := FConceitos;
  formprincipal.LayMsg.Visible := true;
  FormPrincipal.TabMensagem.ActiveTab := formprincipal.TabProcessando;
  FormPrincipal.MsgAnimation.Enabled := true;
  tthread.CreateAnonymousThread(
  Procedure
  var Teste : boolean;
  begin
   teste := tmodelAtas.New
                         .Periodo(Periodo)
                         .Turma(Turma)
                         .Dias(dias)
                         .horario(horario)
                         .Examinador(Examinador)
                         .Alunos(Alunos)
                         .Conceitos(Conceitos)
                         .Gerar;
   tthread.Synchronize(tthread.CurrentThread,
   Procedure
   begin
    if teste = true then
     begin
      FormPrincipal.MsgAnimation.Enabled := False;
      FormPrincipal.TabMensagem.Next();
      FormPrincipal.AnimaMsgFecha.Start;
     end;
   end
   );
  end
  ).Start;
  Result := True;
end;

function TControllerAtas.horario(Value: string): iControllerAtas;
begin
    Result := self;
    Fhorario := Value;
end;

class function TControllerAtas.New: iControllerAtas;
begin
  Result := Self.Create;
end;

function TControllerAtas.Periodo(Value: String): iControllerAtas;
begin
    Result := self;
    FPeriodo := Value;
end;

function TControllerAtas.Turma(Value: string): iControllerAtas;
begin
    Result := self;
    Fturma := Value;
end;

end.
