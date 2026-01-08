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
  File last update : 2025-05-25T16:26:14.000+02:00
  Signature : 011cc91487d653ec380bab115b26e08d1577dbcc
  ***************************************************************************
*)

unit uStyleDarkByDefault;

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
  TStyleDarkByDefault = class(T__StyleContainerAncestor)
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

class function TStyleDarkByDefault.GetStyleName: string;
begin
  result := 'Dark';
end;

class function TStyleDarkByDefault.GetStyleType: TProjectStyleType;
begin
  result := TProjectStyleType.dark;
end;

initialization

TStyleDarkByDefault.RegisterStyle;

end.
