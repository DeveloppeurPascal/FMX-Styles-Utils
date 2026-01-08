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
  File last update : 2025-05-25T16:26:12.994+02:00
  Signature : d172d7dc4f7a1af8ac6e96681e852c8160f60ad8
  ***************************************************************************
*)

unit uStyleManager;

interface

uses
  System.Types,
  System.Generics.Collections,
  System.Messaging;

type
{$SCOPEDENUMS ON}
  /// <summary>
  /// Style types available in the projects depending on ths system or user choice.
  /// </summary>
  TProjectStyleType = (light, dark, other);

  /// <summary>
  /// Style item class used for each style registered in the project.
  /// </summary>
  TProjectStyleItem = class
  private
    FStyleType: TProjectStyleType;
    FStyleName: string;
    procedure SetStyleName(const Value: string);
    procedure SetStyleType(const Value: TProjectStyleType);
  protected
  public
    /// <summary>
    /// Contains the name of the style (given by GetStyleName() of the style
    /// container class during its registration).
    /// </summary>
    property StyleName: string read FStyleName write SetStyleName;
    /// <summary>
    /// Contains the type of the style (given by GetStyleType() of the style
    /// container class during its registration).
    /// </summary>
    property StyleType: TProjectStyleType read FStyleType write SetStyleType;
    /// <summary>
    /// Instance constructor method for this class.
    /// </summary>
    constructor Create(const StyleName: string;
      const StyleType: TProjectStyleType);
  end;

  /// <summary>
  /// Collection of registered style items.
  /// </summary>
  TProjectStylesList = class(TObjectList<TProjectStyleItem>)
  end;

  /// <summary>
  /// Message used to broadcast a style change in the project with the RTL
  /// messaging system.
  /// </summary>
  TProjectStyleChangeMessage = class(tmessage<string>)
  end;

  /// <summary>
  /// A singleton to manage current style in the project and get its properties.
  /// </summary>
  /// <remarks>
  /// Don't create or destroy instances of this class. Only use "Current()"
  /// method to access to its global unique instance.
  /// </remarks>
  TProjectStyle = class
  private
    FStyleName: string;
    FStyles: TProjectStylesList;
    procedure SetStyleName(const Value: string);
    function GetStyleCount: integer;
    function GetStyle(const Index: integer): TProjectStyleItem;
  protected
    /// <summary>
    /// Instance constructor method for this class.
    /// </summary>
    constructor Create;
  public
    /// <summary>
    /// Name of the current style.
    /// </summary>
    property StyleName: string read FStyleName write SetStyleName;
    /// <summary>
    /// Number of available registered styles.
    /// </summary>
    property StylesCount: integer read GetStyleCount;
    /// <summary>
    /// Give access to each registered styles as style item instances.
    /// </summary>
    property Styles[const Index: integer]: TProjectStyleItem read GetStyle;
    /// <summary>
    /// Returns an array of strings corresponding on registered styles name.
    /// </summary>
    function GetStyles(const StyleType: TProjectStyleType): TStringDynArray;
    /// <summary>
    /// Add a style to the available styles for this project.
    /// </summary>
    procedure RegisterStyle(const StyleName: string;
      const StyleType: TProjectStyleType = TProjectStyleType.other);
    /// <summary>
    /// Returns the global TProjectStyle singleton class.
    /// </summary>
    /// <remarks>
    /// Never try to "Free()" the instance given by the "Current()" method.
    /// You will have access violations in your program and memory leaks !
    /// </remarks>
    class function Current: TProjectStyle;
    /// <summary>
    /// Instance destructor method for this class. don't call it.
    /// Use ".Free()" or "FreeAndNil()".
    /// </summary>
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils,
  System.Classes;

var
  ProjectStyle: TProjectStyle;

constructor TProjectStyle.Create;
begin
  inherited;
  FStyles := TProjectStylesList.Create;
end;

class function TProjectStyle.Current: TProjectStyle;
begin
  if not assigned(ProjectStyle) then
    ProjectStyle := TProjectStyle.Create;
  result := ProjectStyle;
end;

destructor TProjectStyle.Destroy;
begin
  FStyles.Free;
  inherited;
end;

function TProjectStyle.GetStyle(const Index: integer): TProjectStyleItem;
begin
  if (index < 0) or (index >= FStyles.Count) then
    result := nil
  else
    result := FStyles[index];
end;

function TProjectStyle.GetStyleCount: integer;
begin
  result := FStyles.Count;
end;

function TProjectStyle.GetStyles(const StyleType: TProjectStyleType)
  : TStringDynArray;
var
  i, nb, idx: integer;
begin
  nb := 0;
  for i := 0 to FStyles.Count - 1 do
    if FStyles[i].StyleType = StyleType then
      inc(nb);

  setlength(result, nb);
  idx := 0;
  for i := 0 to FStyles.Count - 1 do
    if FStyles[i].StyleType = StyleType then
    begin
      result[idx] := FStyles[i].StyleName;
      inc(idx);
    end;
end;

procedure TProjectStyle.RegisterStyle(const StyleName: string;
  const StyleType: TProjectStyleType);
begin
  if StyleName.trim.isempty then
    exit;

  FStyles.Add(TProjectStyleItem.Create(StyleName, StyleType));
end;

procedure TProjectStyle.SetStyleName(const Value: string);
begin
  FStyleName := Value;

  tthread.queue(nil,
    procedure
    begin
      TMessageManager.DefaultManager.SendMessage(nil,
        TProjectStyleChangeMessage.Create(FStyleName));
    end);
end;

constructor TProjectStyleItem.Create(const StyleName: string;
const StyleType: TProjectStyleType);
begin
  inherited Create;
  FStyleName := StyleName;
  FStyleType := StyleType;
end;

procedure TProjectStyleItem.SetStyleName(const Value: string);
begin
  FStyleName := Value;
end;

procedure TProjectStyleItem.SetStyleType(const Value: TProjectStyleType);
begin
  FStyleType := Value;
end;

initialization

ProjectStyle := nil;

finalization

ProjectStyle.Free;

end.
