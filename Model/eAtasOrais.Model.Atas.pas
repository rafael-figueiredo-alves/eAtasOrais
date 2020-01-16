unit eAtasOrais.Model.Atas;

interface

uses
  eAtasOrais.Model.Interfaces, System.Generics.Collections, eAtasOrais.Model.ClasseAlunosConceitos,
  System.Classes;

Type
  TModelAtas = Class(TInterfacedObject, iModelAtas)
    Private
     FPeriodo         : string;
     FPastaPDF        : String;
     FPastaXLSX       : string;
     FAlunos          : TStrings;
     FConceitos       : TStrings;
     FExaminador      : String;
     FTurma           : string;
     FDias            : string;
     Fhorario         : string;
     FUnidade         : string;
     FModelo          : string;
     FExcel           : Variant;
     Function AtaExiste (Value : string) : Boolean;
     Procedure DefinePastaAtas;
     Procedure DefineModelo;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iModelAtas;
     Function Periodo (Value : String) : iModelAtas;
     Function Alunos (Value : TStrings) : iModelAtas;
     Function Conceitos (Value : TStrings) : iModelAtas;
     Function Examinador (Value : String) : iModelAtas;
     Function Turma (Value : string) : iModelAtas;
     Function Dias (Value : String) : iModelAtas;
     Function horario (Value : string) : iModelAtas;
     Function Gerar : Boolean;
  End;

implementation

uses
  eAtasOrais.Model.Factory, ComObj, Winapi.ActiveX, System.Variants,
  System.SysUtils, eAtasOrais.Model.Consts3, FMX.Dialogs;

{ TModelAtas }

function GetStrNumber(const S: string): string;
var
  vText : PChar;
begin
  vText := PChar(S);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;


function TModelAtas.Alunos(Value: TStrings): iModelAtas;
begin
    Result := self;
    FAlunos := Value;
end;

function TModelAtas.AtaExiste(Value: string): Boolean;
begin
   Result := FileExists(Value);
end;

function TModelAtas.Conceitos(Value: TStrings): iModelAtas;
begin
  Result := self;
  FConceitos := Value;
end;

constructor TModelAtas.Create;
var Config : iModelConfiguracao;
begin
   Config     := TModelFactory.New.Configuracao;
   Funidade   := Config.Unidade;
   FPastaPDF  := Config.PastaAtas;
   FPastaXLSX := Config.PastaAtas;
   CoInitializeEx(nil, COINIT_APARTMENTTHREADED);
   FExcel :=  CreateOleObject('Excel.Application');
   FExcel.displayalerts:= false;
end;

procedure TModelAtas.DefineModelo;
var Arquivo_Modelo : string;
begin
    if POS('TEEN', UpperCase(FTurma)) > 0 then
     begin
       if pos('PRETEEN', UpperCase(FTurma)) > 0 then
        Arquivo_Modelo := Modelo_Kids
       else
        begin
          if pos('TEEN/ADULT', UpperCase(FTurma)) > 0 then
           Arquivo_Modelo := Modelo_Master
          else
           Arquivo_Modelo := Modelo_Teen;
        end;
     end
    Else
     if Pos('ENGLISH', UpperCase(FTurma)) > 0 then
      Arquivo_Modelo := Modelo_English
     else
      if Pos('ESPAÑOL', UpperCase(FTurma)) > 0 then
       Arquivo_Modelo := Modelo_Espanol
      else
       Arquivo_Modelo := Modelo_Kids;

    FModelo := extractfilepath(paramstr(0))+'modelos\' + Arquivo_Modelo;
end;

procedure TModelAtas.DefinePastaAtas;
Var PastaPeriodo, PastaDias, PastaHorario : string;
begin
   //prepara pasta periodo
   pastaperiodo := Fperiodo;
   pastaperiodo := TModelFactory.New.Funcoes.TrocaBarra(pastaperiodo);
   pastaperiodo := pastaperiodo + '\';

   //Prepara pasta dias
   PastaDias := FDias + '\';

   //Prepara Pasta Horários
   PastaHorario := TModelFactory.New.Funcoes.TrocaHoras(Fhorario) + '\';

   //Pastas Finais
   FPastaPDF  := FPastaPDF + PastaPeriodo + PastaDias + PastaHorario + 'PDF\';
   FPastaXLSX := FPastaXLSX + PastaPeriodo + PastaDias + PastaHorario + 'Excel\';

   //Criar pastas se for necessário
   ForceDirectories(FPastaPDF);
   ForceDirectories(FPastaXLSX);
end;

destructor TModelAtas.Destroy;
begin
  FExcel.quit;
  FExcel := Unassigned;
  inherited;
end;

function TModelAtas.Dias(Value: String): iModelAtas;
begin
   Result := self;
   FDias := Value;
end;

function TModelAtas.Examinador(Value: String): iModelAtas;
begin
  Result := self;
  FExaminador := Value;
end;

function TModelAtas.Gerar: Boolean;
Var
    VersaoExcel      : string;
    ArquivoFinalPDF  : string;
    ArquivoFinalXLSX : string;
    PrimeiraLinhaAta : Integer;
    Aluno            : string;
begin
    //Definir pastas e Modelo
    DefinePastaAtas;
    DefineModelo;

    //Processo de criação
    ArquivoFinalPDF  := '';
    ArquivoFinalXLSX := '';
    ArquivoFinalPDF  := FPastaPDF + TModelFactory.New.Funcoes.FormataNomeTurma2(FTurma)+ '.pdf';
    ArquivoFinalXLSX := FPastaXLSX + TModelFactory.New.Funcoes.FormataNomeTurma2(FTurma)+ '.xlsx';

    if (not AtaExiste(ArquivoFinalPDF)) and (not AtaExiste(ArquivoFinalXLSX)) then
     begin
       //abre o modelo
       FExcel.workbooks.open(FModelo);
       //Preenchendo Cabeçalho
       FExcel.workbooks[1].sheets[1].cells[2,16] := FPeriodo;
       FExcel.workbooks[1].sheets[1].cells[5,2]  := FUnidade;
       FExcel.workbooks[1].sheets[1].cells[5,7]  := FTurma;
       FExcel.workbooks[1].sheets[1].cells[5,16] := FExaminador;
       PrimeiraLinhaAta := 8;
       for Aluno in FAlunos do
        begin
         FExcel.workbooks[1].sheets[1].cells[PrimeiraLinhaAta,1] := Aluno;
         FExcel.workbooks[1].sheets[1].cells[PrimeiraLinhaAta,6] := FConceitos[FAlunos.IndexOf(Aluno)];
         PrimeiraLinhaAta := PrimeiraLinhaAta + 1;
        end;
       //Testa versão do Excel para salvar arquivo corretamente
       VersaoExcel:= GetStrNumber(FExcel.version);
       if VersaoExcel.ToInteger < 120 then
        begin
          FExcel.workbooks[1].saveas(ArquivoFinalXLSX);
          FExcel.workbooks[1].ExportAsFixedFormat(0, ArquivoFinalPDF);
        end
       else
        begin
          FExcel.workbooks[1].saveas(ArquivoFinalXLSX, 51);
          FExcel.workbooks[1].ExportAsFixedFormat(0, ArquivoFinalPDF);
        end;
       //Fecha Modelo Excel para reabrir
       Fexcel.workbooks[1].close(False);
     end;
    Result := true;
end;

function TModelAtas.horario(Value: string): iModelAtas;
begin
   Result := self;
   Fhorario := Value;
end;

class function TModelAtas.New: iModelAtas;
begin
  Result := Self.Create;
end;

function TModelAtas.Periodo(Value: String): iModelAtas;
begin
   Result := self;
   FPeriodo := Value;
end;

function TModelAtas.Turma(Value: string): iModelAtas;
begin
   Result := self;
   FTurma := Value;
end;

end.
