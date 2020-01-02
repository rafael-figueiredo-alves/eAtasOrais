unit eAtasOrais.Model.Configuracao;

interface

uses
  eAtasOrais.Model.Interfaces;

Type
  TModelConfiguracao = Class(TInterfacedObject, iModelConfiguracao)
    Private
     Fservidor  : string;
     FPastaAtas : string;
     FUID       : String;
     FPWD       : string;
     FUnidade   : String;
     FBanco     : String;
     FTestes    : Boolean;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iModelConfiguracao;
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

implementation

{ TModelConfiguracao }

Uses inifiles, System.SysUtils;

function TModelConfiguracao.Banco(Value: string): iModelConfiguracao;
begin
    Result := self;
    FBanco := Value;
end;

function TModelConfiguracao.Banco: string;
begin
   Result := FBanco;
end;

constructor TModelConfiguracao.Create;
var cfg: tinifile;
    arq: string;
    PastaAtas, PastaBanco : string;
begin
   PastaAtas := ExtractFilePath(ParamStr(0)) + 'AtasOrais\';
   PastaBanco := ExtractFilePath(ParamStr(0)) + 'BD\';
   arq := Extractfilepath(ParamStr(0))+'eAtasOrais.config.ini';
   cfg := TIniFile.Create(arq);
   try
     fservidor  := cfg.ReadString('SOP', 'Servidor', '');
     FUID       := cfg.ReadString('SOP', 'UID', '');
     FPWD       := cfg.ReadString('SOP', 'PWD', '');
     FPastaAtas := cfg.ReadString('Base', 'Pasta', PastaAtas);
     FUnidade   := cfg.ReadString('Dados', 'Unidade', 'Escola Teste');
     FBanco     := cfg.ReadString('Conexao', 'Banco', PastaBanco);
     FTestes    := cfg.ReadBool('Desenvolvimento', 'Testes', true);
   finally
     cfg.DisposeOf;
   end;
end;

destructor TModelConfiguracao.Destroy;
begin

  inherited;
end;

function TModelConfiguracao.GravaConfiguracoes: iModelConfiguracao;
var cfg: tinifile;
    arq: string;
begin
   Result := Self;
   arq := Extractfilepath(ParamStr(0))+'eAtasOrais.config.ini';
   cfg := TIniFile.Create(arq);
   try
     cfg.WriteString('SOP', 'Servidor', fservidor);
     cfg.WriteString('SOP', 'UID', FUID);
     cfg.WriteString('SOP', 'PWD', FPWD);
     cfg.WriteString('Base', 'Pasta', FPastaAtas);
     cfg.WriteString('Dados', 'Unidade', FUnidade);
     cfg.WriteString('Conexao', 'Banco', FBanco);
     cfg.WriteBool('Desenvolvimento', 'Testes', FTestes);
   finally
     cfg.DisposeOf;
   end;
end;

class function TModelConfiguracao.New: iModelConfiguracao;
begin
    Result := Self.Create;
end;

function TModelConfiguracao.PastaAtas(Pasta: String): iModelConfiguracao;
begin
    Result := Self;
    FPastaAtas := Pasta;
end;

function TModelConfiguracao.PastaAtas: String;
begin
   Result := FPastaAtas;
end;

function TModelConfiguracao.PWD(PWD: String): iModelConfiguracao;
begin
  Result := Self;
  FPWD := PWD;
end;

function TModelConfiguracao.PWD: String;
begin
   Result := FPWD;
end;

function TModelConfiguracao.Servidor(Servidor: String): iModelConfiguracao;
begin
   Result := Self;
   Fservidor := Servidor;
end;

function TModelConfiguracao.Servidor: String;
begin
   Result := Fservidor;
end;

function TModelConfiguracao.Testes(Value: Boolean): iModelConfiguracao;
begin
    Result := Self;
    FTestes := Value;
end;

function TModelConfiguracao.Testes: Boolean;
begin
   Result := FTestes;
end;

function TModelConfiguracao.UID: String;
begin
   Result := FUID;
end;

function TModelConfiguracao.UID(UID: String): iModelConfiguracao;
begin
   Result := Self;
   FUID := UID;
end;

function TModelConfiguracao.Unidade: String;
begin
   Result := FUnidade;
end;

function TModelConfiguracao.Unidade(Unidade: String): iModelConfiguracao;
begin
   Result := Self;
   FUnidade := Unidade;
end;

end.
