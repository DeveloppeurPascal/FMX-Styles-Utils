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
  File last update : 2025-05-25T16:26:12.914+02:00
  Signature : b046416df1439a068a140f6cf54d3e5a4c13dc50
  ***************************************************************************
*)

program DarkLightSample;

uses
  System.StartUpCopy,
  FMX.Forms,
  fMain in 'fMain.pas' {Form1},
  _StyleContainerAncestor in '..\..\src\_StyleContainerAncestor.pas' {__StyleContainerAncestor: TDataModule},
  uStyleManager in '..\..\src\uStyleManager.pas',
  uStyleDarkByDefault in 'uStyleDarkByDefault.pas' {StyleDarkByDefault: TDataModule},
  uStyleLightByDefault in 'uStyleLightByDefault.pas' {StyleLightByDefault: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
