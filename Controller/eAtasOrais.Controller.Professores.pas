unit eAtasOrais.Controller.Professores;

interface

uses
  eAtasOrais.Controller.interfaces, eAtasOrais.Model.Interfaces;

Type
  TControllerProfessores = Class(TInterfacedObject, iControllerProfessores)
    Private
      FConexaoSOP : imodelconexaoSop;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iControllerProfessores;
     Function Listar (periodo: string; Lista: Tobject) : iControllerProfessores;
  End;

implementation

uses
  Data.DB, FMX.ComboEdit, eAtasOrais.Model.Factory;

{ TControllerProfessores }

constructor TControllerProfessores.Create;
begin
   FConexaoSOP := tModelFactory.New.Conexao;
end;

destructor TControllerProfessores.Destroy;
begin

  inherited;
end;

function TControllerProfessores.Listar(periodo: string;
  Lista: Tobject): iControllerProfessores;
var
    FDados      :  Tdataset;
    FLista      : tcomboEdit;
begin
    Result := self;
    FLista := TComboEdit(lista);
    Flista.Items.Clear;
    FDados := FConexaoSOP.Professores(periodo);
    FDados.First;
    while not Fdados.eof do
     begin
       FLista.Items.Add(FDados.FieldByName('Nom_cop').AsString);
       FDados.Next;
     end;
    FDados.DisposeOf;
end;

class function TControllerProfessores.New: iControllerProfessores;
begin
    Result := Self.Create;
end;

end.
