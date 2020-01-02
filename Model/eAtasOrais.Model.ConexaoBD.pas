unit eAtasOrais.Model.ConexaoBD;

interface

uses
  eAtasOrais.Model.Interfaces,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSAccDef,
  FireDAC.Phys.MSAcc,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.Client;

Type
  TModelConexaoBD = Class(TInterfacedObject, iModelConexaoSOP)
    Private
      FConexao : tfdconnection;
      Class var FConn : iModelConexaoSOP;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iModelConexaoSOP;
     Function Periodos : tfdmemtable;
     Function Turmas  (Periodo: string) : tfdmemtable;
     Function Turma   (Periodo, Turma: string) : tfdmemtable;
     Function Alunos  (periodo, Cod_cur, Num_niv, num_tur: string) : tfdmemtable;
     Function Professores  (Periodo: string) : tdataset;
  End;

implementation

uses
  eAtasOrais.Model.Configuracao, System.SysUtils, eAtasOrais.Model.Consts2,
  FireDAC.Stan.Param, FMX.Dialogs;

{ TModelConexaoSOP }

function TModelConexaoBD.Alunos(periodo, Cod_cur, Num_niv, num_tur: string): tfdmemtable;
var
   teste1: string;
   teste2: string;
begin

    //tentar achar outra solução para fazer a busca de alunos melhorar
    Teste1 := 'SELECT DISTINCT Alu.Nom_alu, Mat.Cod_Coe from tbAlunos alu, tbMatricula Mat WHERE (Mat.Cod_cur = '+cod_cur+') and (mat.Num_niv = '+num_niv+') and (mat.num_tur = '+Num_tur+') and (Mat.num_per = '+quotedstr(periodo)+') ';
    teste2 := 'and (Mat.flg_Mat = ''MP'') and (Alu.cod_alu = mat.cod_alu) ORDER BY Alu.Nom_alu';
    FConexao.ExecSQL(teste1+teste2, tdataset(Result));

end;

constructor TModelConexaoBD.Create;
var Config: iModelConfiguracao;
begin
   FConexao := TFDConnection.Create(nil);
   Config := TModelConfiguracao.New;
   FConexao.DriverName := 'MSAcc';
   FConexao.Params.Database := Config.Banco + 'eAtasOrais.base.mdb';
   FConexao.LoginPrompt := false;
end;

destructor TModelConexaoBD.Destroy;
begin
  FConexao.DisposeOf;
  inherited;
end;

class function TModelConexaoBd.New: iModelConexaoSOP;
begin
   if not Assigned(FConn) then
    Fconn := Self.Create;
   Result := FConn;
end;

function TModelConexaoBd.Periodos: tfdmemtable;
begin
   FConexao.ExecSQl(SQL_PERIODOS, tdataset(Result));
end;

function TModelConexaoBD.Professores(Periodo: string): tdataset;
var
  Parametros : TFDParams;
begin
   Parametros := TFDParams.Create;
   try
    Parametros.Add('periodo', periodo);
    FConexao.ExecSQL(SQL_PROFESSORES1+SQL_PROFESSORES2, Parametros , TDataSet(Result));
   finally
    Parametros.DisposeOf;
   end;
end;

function TModelConexaoBD.Turma(Periodo, Turma: string): tfdmemtable;
var
   Parametros : tfdparams;
begin
   Parametros := TFDParams.Create;
   try
    parametros.Add('periodo', periodo);
    Parametros.Add('turma', Turma, ptInput);
    FConexao.ExecSQL(SQL_TURMAS1+SQL_TURMAS2, parametros, tdataset(Result));
   finally
    Parametros.DisposeOf;
   end;
end;

function TModelConexaoBD.Turmas(periodo: string): tfdmemtable;
var
  Parametros : TFDParams;
begin
   Parametros := TFDParams.Create;
   try
    Parametros.Add('periodo', periodo);
    FConexao.ExecSQL(SQL_Lista_TURMAS1+SQL_Lista_TURMAS2, Parametros , TDataSet(Result));
   finally
    Parametros.DisposeOf;
   end;
end;

end.
