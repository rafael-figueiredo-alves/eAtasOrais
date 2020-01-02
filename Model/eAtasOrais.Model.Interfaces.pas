unit eAtasOrais.Model.Interfaces;

interface

uses
  FireDAC.Comp.Client, System.Classes, Data.DB;


Type

  iModelConexaoSOP = Interface
    ['{8F2718BD-31FA-452B-83C9-325F3D7D9153}']
     Function Periodos : tfdmemtable;
     Function Turmas  (Periodo: string) : tfdmemtable;
     Function Turma   (Periodo, Turma: string) : tfdmemtable;
     Function Alunos  (periodo, Cod_cur, Num_niv, num_tur: string) : tfdmemtable;
     Function Professores  (Periodo: string) : tdataset;
  End;

  iModelConfiguracao = Interface
    ['{DA649233-8D44-4B75-9036-67216DB10DDE}']
    Function GravaConfiguracoes : iModelConfiguracao;
    Function Servidor : String; Overload;
    Function Servidor (Servidor: String) : iModelConfiguracao; Overload;
    Function PastaAtas : String; Overload;
    Function PastaAtas (Pasta: String) : iModelConfiguracao; Overload;
    Function UID : String; Overload;
    Function UID (UID: String) : iModelConfiguracao; Overload;
    Function PWD : String; Overload;
    Function PWD (PWD: String) : iModelConfiguracao; Overload;
    Function Unidade : String; Overload;
    Function Unidade (Unidade: String) : iModelConfiguracao; Overload;
    Function Banco : string; Overload;
    Function Banco (Value: string) : iModelConfiguracao; overload;
    Function Testes : Boolean; Overload;
    Function Testes (Value: Boolean) : iModelConfiguracao; overload;
  End;

  iModelFuncoes = interface
    ['{089B3CE7-9466-49B3-9BE8-18480FFD7F8F}']
    Function RemoveAsterisco (Value : string) : string;
    Function TrocaBarra (Value : string) : string;
    Function RemoveParenteses (Value : string) : string;
    Function RemoveEspacosBrancos (Value : string) : string;
    Function Mes (Value : integer) : string;
    Function FormataNomeAluno (Value : string) : string;
    Function FormataNomeProfessor (Value : string) : string;
    Function FormataNomeTurma (Value : string) : string;
  end;

  iModelFactory = interface
    ['{994703F6-90A1-4E6C-973E-AA21ACF756E9}']
    Function Conexao      : iModelConexaoSOP;
    Function Configuracao : iModelConfiguracao;
    Function Funcoes      : iModelFuncoes;
  end;


implementation

end.
