unit eAtasOrais.Model.Consts2;

interface

uses
  System.SysUtils;

Const

 SQL_PERIODOS : string = 'Select Num_per from tbperiodos Where Num_per <> ''9999/9'' order by Num_per Desc';
 SQL_LISTA_TURMAS1  : string = 'SELECT DISTINCT Niv.Sgl_niv & ''.'' & cint(Tur.Num_tur) as Turma from tbNiveis Niv, tbTurmas Tur ';
 SQL_LISTA_TURMAS2  : string = 'WHERE ((niv.Cod_cur = tur.cod_cur) and (niv.num_niv = tur.num_niv)) and (tur.Cod_pro is not null) and (tur.num_per = :periodo) ORDER BY Niv.Sgl_niv & ''.'' & cint(Tur.Num_tur)';
 SQL_TURMAS1        : string = 'SELECT DISTINCT Tur.Cod_cur, tur.num_niv, tur.Num_tur, tur.hor_ini, tur.hor_fim, tur.flg_diaAul, prof.Nom_cop from tbTurmas Tur, tbNiveis Niv, tbProfessor prof ';
 SQL_TURMAS2        : string = 'WHERE ((niv.Cod_cur = tur.cod_cur) and (niv.num_niv = tur.num_niv)) and (prof.Cod_pro = tur.Cod_pro) and (tur.num_per = :periodo) and (Niv.Sgl_niv & ''.'' & cint(Tur.Num_tur) = :turma)';
 SQL_PROFESSORES1   : string = 'SELECT DISTINCT Prof.Nom_cop FROM tbTurmas Tur, tbProfessor Prof ';
 SQL_PROFESSORES2   : string = 'WHERE (Tur.Num_per = :periodo) and (Prof.Cod_pro = Tur.Cod_pro) GROUP BY Prof.Nom_cop ORDER BY Prof.Nom_cop';

implementation

end.
