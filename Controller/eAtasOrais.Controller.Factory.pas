unit eAtasOrais.Controller.Factory;

interface

uses
  eAtasOrais.Controller.interfaces;

Type
  TControllerFactory = Class(TInterfacedObject, iControllerFactory)
    Private
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iControllerFactory;
     Function Configuracao : iControllerConfiguracao;
     Function Periodos     : iControllerPeriodos;
     Function turmas       : iControllerTurmas;
     Function alunos       : iControllerAlunos;
     Function Funcoes      : iControllerFuncoes;
     Function Professores  : iControllerProfessores;
     Function Atas         : iControllerAtas;
  End;

implementation

uses
  eAtasOrais.Controller.Alunos,
  eAtasOrais.Controller.configuracao, eAtasOrais.Controller.periodos,
  eAtasOrais.Controller.turmas, eAtasOrais.Controller.Funcoes,
  eAtasOrais.Controller.Professores, eAtasOrais.Controller.Atas;

{ TControllerFactory }

function TControllerFactory.alunos: iControllerAlunos;
begin
    Result := tControllerAlunos.New;
end;

function TControllerFactory.Atas: iControllerAtas;
begin
   Result := tControllerAtas.new;
end;

function TControllerFactory.Configuracao: iControllerConfiguracao;
begin
   Result := tControllerConfiguracao.New;
end;

constructor TControllerFactory.Create;
begin

end;

destructor TControllerFactory.Destroy;
begin

  inherited;
end;

function TControllerFactory.Funcoes: iControllerFuncoes;
begin
    Result := tcontrollerfuncoes.new;
end;

class function TControllerFactory.New: iControllerFactory;
begin
    Result := Self.Create;
end;

function TControllerFactory.Periodos: iControllerPeriodos;
begin
   Result := tcontrollerPeriodos.New;
end;

function TControllerFactory.Professores: iControllerProfessores;
begin
     result := tcontrollerProfessores.New;
end;

function TControllerFactory.turmas: iControllerTurmas;
begin
   Result := tControllerTurmas.New;
end;

end.
