unit eAtasOrais.Controller.interfaces;

interface

uses
  eAtasOrais.Model.Interfaces, FMX.ListBox,
  System.Classes;

Type

  iControllerConfiguracao = interface
    ['{D57BC02A-63D7-441C-9706-9A2CD5782BAA}']
    Function Servidor(Value: String): iControllerConfiguracao; Overload;
    Function Servidor(Value: TObject): iControllerConfiguracao; Overload;
    Function UID(Value: String): iControllerConfiguracao; Overload;
    Function UID(Value: tobject): iControllerConfiguracao; Overload;
    Function PWD(Value: String): iControllerConfiguracao; Overload;
    Function PWD(Value: tobject): iControllerConfiguracao; Overload;
    Function Pasta(Value: String): iControllerConfiguracao; Overload;
    Function Pasta(Value: tobject): iControllerConfiguracao; Overload;
    Function Unidade(Value: String): iControllerConfiguracao; Overload;
    Function Unidade(Value: tobject): iControllerConfiguracao; Overload;
    Function Banco(Value: String): iControllerConfiguracao; Overload;
    Function Banco(Value: tobject): iControllerConfiguracao; Overload;
    Function Testes(Value: Boolean): iControllerConfiguracao; Overload;
    Function Testes(Value: tobject): iControllerConfiguracao; Overload;
    Function Gravar : iControllerConfiguracao;
  end;

 iControllerPeriodos = interface
    ['{D02EEFC3-BEBE-44AD-A4A6-21295090E847}']
    Function Listar (Lista: TObject) : iControllerPeriodos;
  end;

 iControllerTurmas = interface
    ['{E06D8F19-363C-4A73-BB44-F36947371507}']
    Function Listar (periodo: string; Lista: Tlistbox) : iControllerTurmas;
    Function Buscar (periodo, Turma : String) : iControllerTurmas;
    Function Cod_cur : string;
    Function Num_Niv : string;
    Function Num_Tur : string;
    Function Dias : string;
    Function Horario : string;
    Function Turma : string;
    Function Periodo : string;
    Function Professor : string;
    Function DiasApresentar : string;
  end;

  iControllerAlunos = interface
    ['{11FF69F6-70F4-418D-9C54-644C2CDD0486}']
    Function Listar (periodo, Cod_cur, num_niv, num_tur: string;Lista : TListBox) : iControllerAlunos;
  end;

  iControllerFuncoes = interface
    ['{F8F36078-44F3-44F5-8941-4CC0604DE1D9}']
    Function LimpaTela : iControllerFuncoes;
  end;

  iControllerProfessores = interface
    ['{6D794D2D-5068-48CD-BC78-054C5AA5D7E9}']
    Function Listar (periodo: string; Lista: Tobject) : iControllerProfessores;
  end;

  iControllerFactory = interface
    ['{3CAFBD7C-9C8D-4D07-B206-D16D882A2959}']
    Function Configuracao : iControllerConfiguracao;
    Function Periodos     : iControllerPeriodos;
    Function turmas       : iControllerTurmas;
    Function alunos       : iControllerAlunos;
    Function Funcoes      : iControllerFuncoes;
    Function Professores  : iControllerProfessores;
  end;

implementation

end.
