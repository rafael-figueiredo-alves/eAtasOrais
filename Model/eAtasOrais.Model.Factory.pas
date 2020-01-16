unit eAtasOrais.Model.Factory;

interface

uses
  eAtasOrais.Model.Interfaces;

Type
  TModelFactory = Class(TInterfacedObject, iModelFactory)
    Private
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iModelFactory;
     Function Conexao : iModelConexaoSOP;
     Function Configuracao : iModelConfiguracao;
     Function Funcoes      : iModelFuncoes;
     Function Atas         : iModelAtas;
  End;

implementation

uses
  eAtasOrais.Model.Configuracao, eAtasOrais.Model.ConexaoBD, eAtasOrais.Model.ConexaoSOP,
  eAtasOrais.Model.Funcoes;

{ TModelFactory }

function TModelFactory.Atas: iModelAtas;
begin
    //Result := TModelAtas.new;
end;

function TModelFactory.Conexao : iModelConexaoSOP;
Var FTestes : Boolean;
begin
   FTestes := self.Configuracao.Testes;
   case FTestes of
    True  : Result := tModelConexaoBD.New;
    False : Result := tModelConexaoSOP.New;
   end;
end;

function TModelFactory.Configuracao: iModelConfiguracao;
begin
   Result := TModelConfiguracao.New;
end;

constructor TModelFactory.Create;
begin

end;

destructor TModelFactory.Destroy;
begin

  inherited;
end;

function TModelFactory.Funcoes: iModelFuncoes;
begin
   Result := tmodelfuncoes.New;
end;

class function TModelFactory.New: iModelFactory;
begin
   Result := Self.Create;
end;

end.
