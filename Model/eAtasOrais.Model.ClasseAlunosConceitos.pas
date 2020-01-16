unit eAtasOrais.Model.ClasseAlunosConceitos;

interface

Type
   tAlunosConceitos = class
     Private
      FConceito: string;
      FAluno: string;
      procedure SetAluno(const Value: string);
      procedure SetConceito(const Value: string);
     Public
      Property Aluno    : string read FAluno write SetAluno;
      Property Conceito : string read FConceito write SetConceito;
   end;

implementation

uses
  eAtasOrais.Model.Factory;

{ tAlunosConceitos }

procedure tAlunosConceitos.SetAluno(const Value: string);
begin
  FAluno := tmodelFactory.New.Funcoes.FormataNomeAluno(Value);
end;

procedure tAlunosConceitos.SetConceito(const Value: string);
begin
  FConceito := Value;
end;

end.
