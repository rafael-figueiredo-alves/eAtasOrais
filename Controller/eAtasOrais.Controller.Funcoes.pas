unit eAtasOrais.Controller.Funcoes;

interface

uses
  eAtasOrais.Controller.interfaces;

Type
  TControllerFuncoes = Class(TInterfacedObject, iControllerFuncoes)
    Private
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iControllerFuncoes;
     Function LimpaTela : iControllerFuncoes;
  End;

implementation

{ TControllerFuncoes }

Uses eAtasOrais.View.principal, FMX.ListBox, System.SysUtils;

constructor TControllerFuncoes.Create;
begin

end;

destructor TControllerFuncoes.Destroy;
begin

  inherited;
end;

function TControllerFuncoes.LimpaTela: iControllerFuncoes;
begin
    formprincipal.Turma.Text         := '';
    formprincipal.Dias.Text          := '';
    formprincipal.Horario.Text       := '';
    formprincipal.Professor.Text     := '';
    formprincipal.examinador.Enabled := false;
    formprincipal.examinador.Text    := '';
    FormPrincipal.ListaAlunos.Items.Clear;
end;

class function TControllerFuncoes.New: iControllerFuncoes;
begin
   Result := Self.Create;
end;

end.
