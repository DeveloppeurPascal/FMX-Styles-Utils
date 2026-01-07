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
  FMX.Memo.Types,
  FMX.StdCtrls,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Edit,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    edtStylesPath: TEdit;
    EllipsesEditButton1: TEllipsesEditButton;
    lbStyles: TListBox;
    mmoInfos: TMemo;
    Splitter1: TSplitter;
    procedure EllipsesEditButton1Click(Sender: TObject);
    procedure edtStylesPathChange(Sender: TObject);
    procedure lbStylesItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
  private protected procedure LoadStylesList(const Path: string);
    procedure ShowStyleInfos(const FilePath: string);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  FMX.Styles,
  System.IOUtils;

function SupportedPlatformHook(const PlatformTarget: string): Boolean;
begin
  Form1.mmoInfos.Lines.Add(platformtarget);
  result := true;
end;

procedure TForm1.edtStylesPathChange(Sender: TObject);
begin
  LoadStylesList(edtStylesPath.Text);
end;

procedure TForm1.EllipsesEditButton1Click(Sender: TObject);
var
  Directory: string;
begin
  if tdirectory.Exists(edtStylesPath.Text) then
    directory := edtStylesPath.Text
  else
    directory := '';
  if SelectDirectory('Path to your styles', tpath.getdocumentspath, directory) and (not directory.isempty) and
  tdirectory.Exists(directory) then
    edtStylesPath.Text := directory;
end;

procedure TForm1.lbStylesItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  if assigned(lbStyles.Selected) then
    ShowStyleInfos(lbStyles.Selected.TagString);
end;

procedure TForm1.LoadStylesList(const Path: string);
var
  Files: TStringDynArray;
  i: integer;
  Item: TListboxItem;
begin
  if path.IsEmpty then
    raise Exception.Create('Need a folder.');

  lbStyles.BeginUpdate;
  try
    lbStyles.Clear;
    Files := tdirectory.GetFiles(Path);
    for i := 0 to length(files) - 1 do
      if tpath.GetExtension(Files[i]).Equals('.style') then
      begin
        Item := TListboxItem.Create(self);
        item.Text := tpath.GetFileNameWithoutExtension(files[i]);
        item.TagString := files[i];
        lbStyles.AddObject(item);
      end;
  finally
    lbStyles.EndUpdate;
  end;
end;

procedure TForm1.ShowStyleInfos(const FilePath: string);
var
  Style: TStyleBook;
begin
  TStyleStreaming.SetSupportedPlatformHook(SupportedPlatformHook);
  try
    Style := TStyleBook.Create(nil);
    try
      style.SetDesign(true);
      mmoInfos.Lines.Add(tpath.GetFileNameWithoutExtension(filepath));
      style.LoadFromFile(filepath);
      mmoInfos.Lines.Add('--');
    finally
      style.Free;
    end;
  finally
    TStyleStreaming.SetSupportedPlatformHook(nil);
  end;
end;

end.

