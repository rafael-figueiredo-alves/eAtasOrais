program eAtasOrais;

uses
  System.StartUpCopy,
  FMX.Forms,
  eAtasOrais.view.principal in 'View\eAtasOrais.view.principal.pas' {FormPrincipal},
  eAtasOrais.Model.Interfaces in 'Model\eAtasOrais.Model.Interfaces.pas',
  eAtasOrais.Model.Configuracao in 'Model\eAtasOrais.Model.Configuracao.pas',
  eAtasOrais.Model.ConexaoSOP in 'Model\eAtasOrais.Model.ConexaoSOP.pas',
  eAtasOrais.Controller.interfaces in 'Controller\eAtasOrais.Controller.interfaces.pas',
  eAtasOrais.Model.Consts in 'Model\eAtasOrais.Model.Consts.pas',
  eAtasOrais.Controller.configuracao in 'Controller\eAtasOrais.Controller.configuracao.pas',
  eAtasOrais.Controller.periodos in 'Controller\eAtasOrais.Controller.periodos.pas',
  eAtasOrais.Model.ConexaoBD in 'Model\eAtasOrais.Model.ConexaoBD.pas',
  eAtasOrais.Controller.turmas in 'Controller\eAtasOrais.Controller.turmas.pas',
  eAtasOrais.Model.Consts2 in 'Model\eAtasOrais.Model.Consts2.pas',
  eAtasOrais.Controller.Alunos in 'Controller\eAtasOrais.Controller.Alunos.pas',
  eAtasOrais.Model.Factory in 'Model\eAtasOrais.Model.Factory.pas',
  eAtasOrais.Controller.Factory in 'Controller\eAtasOrais.Controller.Factory.pas',
  eAtasOrais.Model.Funcoes in 'Model\eAtasOrais.Model.Funcoes.pas',
  eAtasOrais.Controller.Funcoes in 'Controller\eAtasOrais.Controller.Funcoes.pas',
  eAtasOrais.Controller.Professores in 'Controller\eAtasOrais.Controller.Professores.pas',
  eAtasOrais.Model.ClasseAlunosConceitos in 'Model\eAtasOrais.Model.ClasseAlunosConceitos.pas',
  eAtasOrais.Controller.Atas in 'Controller\eAtasOrais.Controller.Atas.pas',
  eAtasOrais.Model.Atas in 'Model\eAtasOrais.Model.Atas.pas',
  eAtasOrais.Model.Consts3 in 'Model\eAtasOrais.Model.Consts3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
