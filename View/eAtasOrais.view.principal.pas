unit eAtasOrais.view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.ListBox,
  FMX.Edit, FMX.SearchBox, FMX.Effects, FMX.MultiView, FMX.DateTimeCtrls,
  FMX.ComboEdit, FMX.Filter.Effects, FMX.TabControl, FMX.Ani, FMX.ScrollBox,
  FMX.Memo;

type
  TFormPrincipal = class(TForm)
    Estilos: TStyleBook;
    LayPrincipal: TLayout;
    Barra: TToolBar;
    BtMenu: TButton;
    ImgMenu: TPath;
    ImgPrincipal: TImage;
    LayTitulo: TLayout;
    TituloMain: TLabel;
    VersaoTitulo: TLabel;
    BtGerarAtas: TButton;
    ImgGerarRams: TPath;
    ComboPeriodo: TComboBox;
    ListaTurmasLayout: TRectangle;
    SombraTurmas: TShadowEffect;
    LayListaTurmas: TLayout;
    BarraTurmas: TLayout;
    ListaTurmas: TListBox;
    BuscaTurmas: TSearchBox;
    BtRefreshTurmas: TButton;
    ImgRefresh: TPath;
    LabelListaTurmas: TLabel;
    SombraBarra: TShadowEffect;
    LayAlunosInfo: TLayout;
    LayAlunos1: TLayout;
    LayAlunos2: TLayout;
    LayAlunos3: TLayout;
    LayAlunos4: TLayout;
    ListaAlunos: TListBox;
    SombraListaAlunos: TShadowEffect;
    CabecalhoAlunos: TListBoxHeader;
    LabelListaAlunos: TLabel;
    BtRefreshAlunos: TButton;
    img_refreshAlunos: TPath;
    LabelTurma: TLabel;
    Turma: TLabel;
    LabelHorario: TLabel;
    Horario: TLabel;
    LabelDias: TLabel;
    Dias: TLabel;
    Labelexaminador: TLabel;
    BtRefreshPeriodos: TButton;
    Img_refresfperiodos: TPath;
    LabelProf: TLabel;
    Professor: TLabel;
    MenuPrincipal: TMultiView;
    Config_title: TLayout;
    Img_setup: TPath;
    LabelConfigTitle: TLabel;
    LinhaDiv: TLine;
    LayoutConfig1: TLayout;
    LabelCFG1: TLabel;
    EdCFGServidor: TEdit;
    LayoutConfig2: TLayout;
    LabelCFG2: TLabel;
    EdCFGUID: TEdit;
    LayoutConfig3: TLayout;
    LabelCFG3: TLabel;
    EdCFGPWD: TEdit;
    LayoutConfig4: TLayout;
    LabelCFG4: TLabel;
    EdCFGPasta: TEdit;
    LayoutConfig5: TLayout;
    LabelCFG5: TLabel;
    EdCFGUnidade: TEdit;
    LayoutConfig10: TLayout;
    LabelCFG10: TLabel;
    EdCFGBanco: TEdit;
    BtSalvaConfig: TButton;
    PasswordEditButton1: TPasswordEditButton;
    ClearEditButton1: TClearEditButton;
    LayoutHorario: TLayout;
    BtFechar: TButton;
    imgFechar: TPath;
    Line2: TLine;
    FillRGBEffect1: TFillRGBEffect;
    CaixaSobre: TMultiView;
    LaySobre1: TLayout;
    LaySobre2: TLayout;
    ImgSobre: TImage;
    LaySobre3: TLayout;
    LabelSobre1: TLabel;
    LabelSobre2: TLabel;
    LabelSobre3: TLabel;
    LaySobre4: TLayout;
    LabelSobre4: TLabel;
    LineSobre: TLine;
    LabelSobre5: TLabel;
    LayMsg: TLayout;
    Sombra: TRectangle;
    TabMensagem: TTabControl;
    TabProcessando: TTabItem;
    TabGerado: TTabItem;
    LayMsg2: TLayout;
    LabelMsg2: TLabel;
    LayMsg1: TLayout;
    LabelMsg1: TLabel;
    ImgSucessoMsg: TRectangle;
    LayoutConfig11: TLayout;
    LabelCFG11: TLabel;
    EdCFGTestes: TSwitch;
    TabErro: TTabItem;
    LayoutMsg3: TLayout;
    LabelMsgErro: TLabel;
    imgMsgErro: TRectangle;
    MsgAnimation: TAniIndicator;
    AnimaMsgAbre: TFloatAnimation;
    AnimaMsgFecha: TFloatAnimation;
    RecCombo3: TRectangle;
    ListBoxItem1: TListBoxItem;
    Examinador: TComboEdit;
    procedure MenuPrincipalStartShowing(Sender: TObject);
    procedure BtSalvaConfigClick(Sender: TObject);
    procedure BtRefreshPeriodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtRefreshTurmasClick(Sender: TObject);
    procedure ListaTurmasItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure ComboPeriodoChange(Sender: TObject);
    procedure BtRefreshAlunosClick(Sender: TObject);
    procedure BtFecharClick(Sender: TObject);
    procedure ImgPrincipalClick(Sender: TObject);
    procedure BtGerarAtasClick(Sender: TObject);
    procedure AnimaMsgFechaFinish(Sender: TObject);
    procedure ExaminadorTyping(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPeriodo    : string;
    FTurma      : string;
    FCod_cur    : string;
    FNum_niv    : string;
    FNum_tur    : string;
    FDias       : string;
    FHorario    : string;
    FProfessor  : string;
    FAlunos     : TStrings;
    FConceitos  : TStrings;
    Procedure ExibeSobre;
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  eAtasOrais.Controller.Factory, eAtasOrais.Controller.interfaces;

{$R *.fmx}

procedure TFormPrincipal.AnimaMsgFechaFinish(Sender: TObject);
begin
     LayMsg.Visible := False;
end;

procedure TFormPrincipal.BtFecharClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TFormPrincipal.BtGerarAtasClick(Sender: TObject);
var i : integer;
begin
    FAlunos.Clear;
    FConceitos.Clear;
    for I := 0 to ListaAlunos.Items.Count-1 do
     begin
      Falunos.Add(ListaAlunos.ListItems[i].ItemData.Text);
      FConceitos.Add(listaalunos.ListItems[i].ItemData.Detail);
     end;
    TControllerFactory.New.Atas
                               .Periodo(FPeriodo)
                               .Alunos(Falunos)
                               .Conceitos(FConceitos)
                               .Examinador(FProfessor)
                               .Dias(Dias.Text)
                               .horario(Horario.Text)
                               .Turma(FTurma)
                               .Gerar;
end;

procedure TFormPrincipal.BtRefreshAlunosClick(Sender: TObject);
begin
    TControllerFactory.New.alunos.Listar(Fperiodo, FCod_cur, fNum_Niv, FNum_Tur, ListaAlunos);
end;

procedure TFormPrincipal.BtRefreshPeriodosClick(Sender: TObject);
begin
    TControllerFactory.New.Periodos.Listar(ComboPeriodo);
end;

procedure TFormPrincipal.BtRefreshTurmasClick(Sender: TObject);
begin
    TControllerFactory.New.turmas.Listar(ComboPeriodo.Selected.Text, listaturmas);
    TControllerFactory.New.Funcoes.LimpaTela;
    BtRefreshTurmas.Enabled := True;
end;

procedure TFormPrincipal.BtSalvaConfigClick(Sender: TObject);
begin
    TControllerFactory.New.Configuracao
     .Servidor(EdCFGServidor.Text)
     .UID(EdCFGUID.Text)
     .PWD(EdCFGPWD.Text)
     .Pasta(EdCFGPasta.Text)
     .Unidade(EdCFGUnidade.Text)
     .Banco(EdCFGBanco.Text)
     .Testes(EdCFGTestes.IsChecked)
     .Gravar;
    MenuPrincipal.HideMaster;
    ShowMessage('Configurações salvas com sucesso!');
end;

procedure TFormPrincipal.ComboPeriodoChange(Sender: TObject);
begin
    if ComboPeriodo.ItemIndex <> -1 then
     begin
      TControllerFactory.New.turmas.Listar(ComboPeriodo.Selected.Text, listaturmas);
      FPeriodo := ComboPeriodo.Selected.Text;
      TControllerFactory.New.Professores.Listar(FPeriodo, Examinador);
      BtRefreshTurmas.Enabled := True;
      TControllerFactory.New.Funcoes.LimpaTela;
      BtGerarAtas.Enabled := (ListaAlunos.Items.Count > 0);
     end;
end;

procedure TFormPrincipal.ExaminadorTyping(Sender: TObject);
begin
    Examinador.Text := UpperCase(Examinador.Text);
end;

procedure TFormPrincipal.ExibeSobre;
begin
    CaixaSobre.ShowMaster;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
    FAlunos := TStringList.Create;
    FConceitos := TStringList.Create;
    formprincipal.BtRefreshAlunos.Enabled := false;
    formprincipal.BtRefreshTurmas.Enabled := False;
    TControllerFactory.New.Funcoes.LimpaTela;
    ReportMemoryLeaksOnShutdown := true;
    TControllerFactory.New.Periodos.Listar(ComboPeriodo);
end;

procedure TFormPrincipal.FormDestroy(Sender: TObject);
begin
    FAlunos.DisposeOf;
    FConceitos.DisposeOf;
end;

procedure TFormPrincipal.ImgPrincipalClick(Sender: TObject);
begin
     ExibeSobre;
end;

procedure TFormPrincipal.ListaTurmasItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var Fturmas : icontrollerturmas;
begin
    Fturmas              :=  TControllerFactory.New.turmas.Buscar(FPeriodo, item.Text);
    FTurma               :=  FTurmas.Turma;
    FCod_cur             :=  Fturmas.Cod_cur;
    FNum_niv             :=  Fturmas.Num_Niv;
    FNum_tur             :=  Fturmas.Num_Tur;
    FDias                :=  Fturmas.Dias;
    FHorario             :=  Fturmas.Horario;
    FProfessor           :=  Fturmas.Professor;
    Turma.Text           :=  FTurmas.Turma;
    Horario.Text         :=  FTurmas.Horario;
    Professor.Text       :=  FTurmas.Professor;
    Examinador.Text      :=  FTurmas.Professor;
    Dias.Text            :=  FTurmas.DiasApresentar;
    BtRefreshAlunos.Enabled := true;
    Examinador.Enabled := True;
    TControllerFactory.New.alunos.Listar(fperiodo, fcod_cur, fnum_niv, fnum_tur, ListaAlunos);
    BtGerarAtas.Enabled := (ListaAlunos.Items.Count > 0);
end;

procedure TFormPrincipal.MenuPrincipalStartShowing(Sender: TObject);
begin
    TControllerFactory.New.Configuracao
     .Servidor(EdCFGServidor)
     .UID(EdCFGUID)
     .PWD(EdCFGPWD)
     .Pasta(EdCFGPasta)
     .Unidade(EdCFGUnidade)
     .Banco(EdCFGBanco)
     .Testes(EdCFGTestes);
end;


end.
