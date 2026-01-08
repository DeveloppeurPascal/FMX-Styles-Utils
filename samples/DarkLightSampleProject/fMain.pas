(* C2PP
  ***************************************************************************

  FMX Styles Utils
  Copyright (c) 2025-2026 Patrick PREMARTIN

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Affero General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN and Serge GIRARD

  Site :
  https://fmxstylesutils.developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/FMX-Styles-Utils

  ***************************************************************************
  File last update : 2025-05-25T16:26:12.931+02:00
  Signature : ab84a682ad76ba313191a19cb84cb9ac6df897eb
  ***************************************************************************
*)

unit fMain;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Edit,
  FMX.ListBox,
  FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TForm1 = class(TForm)
    btnLightStyle: TButton;
    btnDarkStyle: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    EditButton1: TEditButton;
    GridPanelLayout1: TGridPanelLayout;
    procedure EditButton1Click(Sender: TObject);
    procedure btnLightStyleClick(Sender: TObject);
    procedure btnDarkStyleClick(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  uStyleManager;

procedure TForm1.btnDarkStyleClick(Sender: TObject);
begin
  TProjectStyle.Current.StyleName := 'Dark';
end;

procedure TForm1.btnLightStyleClick(Sender: TObject);
begin
  TProjectStyle.Current.StyleName := 'Light';
end;

procedure TForm1.EditButton1Click(Sender: TObject);
begin
  if not Edit1.text.trim.IsEmpty then
    ListBox1.items.add(Edit1.text);
  Edit1.SetFocus;
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}

end.
