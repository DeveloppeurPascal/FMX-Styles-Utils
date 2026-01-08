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
  File last update : 2025-11-19T16:25:18.000+01:00
  Signature : 8d6413064dd0f9dd91b8dab18e5cc15c3a4d4edd
  ***************************************************************************
*)

unit uStyleLightByDefault;

interface

uses
  System.SysUtils,
  System.Classes,
  _StyleContainerAncestor,
  FMX.Types,
  FMX.Controls,
  uStyleManager;

type
  /// <summary>
  /// The "light" FireMonkey style from Embarcadero embed in a style book.
  /// </summary>
  TStyleLightByDefault = class(T__StyleContainerAncestor)
  private
  public
    /// <summary>
    /// Returns the name of this style as a user friendly string.
    /// </summary>
    class function GetStyleName: string; override;
    /// <summary>
    /// Returns the type (light, dark, other) of this style .
    /// </summary>
    class function GetStyleType: TProjectStyleType; override;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

class function TStyleLightByDefault.GetStyleName: string;
begin
  result := 'Light';
end;

class function TStyleLightByDefault.GetStyleType: TProjectStyleType;
begin
  result := TProjectStyleType.light;
end;

initialization

TStyleLightByDefault.RegisterStyle;

end.
