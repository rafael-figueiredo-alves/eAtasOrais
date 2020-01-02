unit eAtasOrais.Model.ConexaoSOP;

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
  FireDAC.Phys.MSSQL,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  Data.DB, FireDAC.Comp.Client;

Type
  TModelConexaoSOP = Class(TInterfacedObject, iModelConexaoSOP)
    Private
      FConexao : tfdconnection;
      Class var FConn : iModelConexaoSOP;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iModelConexaoSOP;
     Function Periodos: tfdmemtable;
     Function Turmas  (Periodo: string) : tfdmemtable;
     Function Turma   (Periodo, Turma: string) : tfdmemtable;
     Function Alunos  (periodo, Cod_cur, Num_niv, num_tur: string) : tfdmemtable;
     Function Professores  (Periodo: string) : tdataset;
  End;

implementation

uses
  eAtasOrais.Model.Configuracao, System.SysUtils, eAtasOrais.Model.Consts,
  FireDAC.Stan.Param;

{ TModelConexaoSOP }

function TModelConexaoSOP.Alunos(periodo, Cod_cur, Num_niv, num_tur: string): tfdmemtable;
Var
   SQL_ALUNOS1, SQL_ALUNOS2 : string;
begin

    //tentar achar outra solução para fazer a busca de alunos melhorar
    SQL_ALUNOS1 := 'SELECT DISTINCT Alu.Nom_alu, Mat.Cod_Coe from tbAlunos alu, tbMatricula Mat WHERE (Mat.Cod_cur = '+cod_cur+') and (mat.Num_niv = '+num_niv+') and (mat.num_tur = '+num_tur+') and (Mat.num_per = '+quotedstr(periodo)+') ';
    SQL_ALUNOS2 := 'and (Mat.flg_Mat = ''MP'') and (Alu.cod_alu = mat.cod_alu) ORDER BY Alu.Nom_alu';
    FConexao.ExecSQL(SQL_ALUNOS1+SQL_ALUNOS2, tdataset(Result));

end;

constructor TModelConexaoSOP.Create;
var Config: iModelConfiguracao;
begin
   FConexao := TFDConnection.Create(nil);
   Config := TModelConfiguracao.New;
   if (Config.Servidor <> '') and (config.UID <> '') and (Config.PWD <> '') then
    begin
      FConexao.DriverName := 'MSSQL';
      FConexao.Params.Database := 'SopGruPrd';
      FConexao.Params.UserName := Config.UID;
      FConexao.Params.Password := Config.PWD;
      FConexao.Params.Add('Server='+config.Servidor);
    end;
   FConexao.Connected := True;
end;

destructor TModelConexaoSOP.Destroy;
begin
  FConexao.DisposeOf;
  inherited;
end;

class function TModelConexaoSOP.New: iModelConexaoSOP;
begin
   if not Assigned(FConn) then
    Fconn := Self.Create;
   Result := FConn;
end;

function TModelConexaoSOP.Periodos: tfdmemtable;
begin
    FConexao.ExecSQl(SQL_PERIODOS, tdataset(Result));
end;

function TModelConexaoSOP.Professores(Periodo: string): tdataset;
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

function TModelConexaoSOP.Turma(Periodo, Turma: string): tfdmemtable;
var
   Parametros : tfdparams;
begin
   Parametros := TFDParams.Create;
   try
    parametros.Add('periodo', periodo);
    Parametros.Add('turma', turma);
    FConexao.ExecSQL(SQL_TURMAS1+SQL_TURMAS2, parametros, tdataset(Result));
   finally
    Parametros.DisposeOf;
   end;
end;

function TModelConexaoSOP.Turmas(periodo: string): tfdmemtable;
var
  Parametros : TFDParams;
begin
   Parametros := TFDParams.Create;
   try
    Parametros.Add('periodo', periodo);
    FConexao.ExecSQL(SQL_LISTA_TURMAS1+SQL_LISTA_TURMAS2, Parametros , tdataset(Result));
   finally
    Parametros.DisposeOf;
   end;
end;

end.
