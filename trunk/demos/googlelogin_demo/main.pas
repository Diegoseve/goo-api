﻿unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uGoogleLogin,TypInfo, ComCtrls, ExtCtrls;

type
  TForm11 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EmailEdit: TEdit;
    PassEdit: TEdit;
    Button1: TButton;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    ComboBox1: TComboBox;
    Label6: TLabel;
    AuthEdit: TEdit;
    ResultEdit: TEdit;
    Button2: TButton;
    Edit1: TEdit;
    Label7: TLabel;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    Label9: TLabel;
    Label10: TLabel;
    imgCaptcha: TImage;
    edtCaptcha: TEdit;
    Button3: TButton;
    Label11: TLabel;
    Label12: TLabel;
    GoogleLogin1: TGoogleLogin;
    procedure Button1Click(Sender: TObject);
    procedure GoogleLogin1Autorization(const LoginResult: TLoginResult;
      Result: TResultRec);
    procedure GoogleLogin1Error(const ErrorStr: string);
    procedure Button2Click(Sender: TObject);
    procedure GoogleLogin1Disconnect(const ResultStr: string);
    procedure GoogleLogin1ProgressAutorization(const Progress, MaxProgress: Integer);
    procedure GoogleLogin1AutorizCaptcha(PicCaptcha: TPicture);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}


procedure TForm11.Button1Click(Sender: TObject);
begin
if not Assigned(GoogleLogin1) then
begin
  ShowMessage('Уже убили');
  Exit;
end;

GoogleLogin1.Email:=EmailEdit.Text;
GoogleLogin1.Password:=PassEdit.Text;
GoogleLogin1.Service:=TServices(ComboBox1.ItemIndex);
Memo1.Clear;//очистка лога
GoogleLogin1.Login();
end;

procedure TForm11.Button2Click(Sender: TObject);
begin
  GoogleLogin1.Destroy;
end;

procedure TForm11.Button3Click(Sender: TObject);
begin
  if edtCaptcha.Text<>'' then
  begin
    imgCaptcha.Picture:=nil;
    GoogleLogin1.Email:=EmailEdit.Text;
    GoogleLogin1.Password:=PassEdit.Text;
    GoogleLogin1.Captcha:=edtCaptcha.Text;
  end;
end;

procedure TForm11.GoogleLogin1Autorization(const LoginResult: TLoginResult;Result: TResultRec);
var
  temp:string;
begin
  ResultEdit.Text:=Result.LoginStr;
  AuthEdit.Text:=Result.Auth;
  temp:=GetEnumName(TypeInfo(TLoginResult),Integer(LoginResult));
  Edit1.Text:=temp;
  if LoginResult =lrOk then
    ShowMessage('Мы в гугле!!!!!!!!!')
  else
    ShowMessage('Мы НЕ в гугле!!!!!!!!!');

end;

procedure TForm11.GoogleLogin1AutorizCaptcha(PicCaptcha: TPicture);
begin
  imgCaptcha .Picture:=PicCaptcha;
end;

procedure TForm11.GoogleLogin1Disconnect(const ResultStr: string);
begin
  ShowMessage('Disconnect');
end;

procedure TForm11.GoogleLogin1Error(const ErrorStr: string);
begin
  ShowMessage(ErrorStr);
end;

procedure TForm11.GoogleLogin1ProgressAutorization(const Progress, MaxProgress: Integer);
begin
  ProgressBar1.Position:=Progress;
  ProgressBar1.Max:=MaxProgress;
  Memo1.Lines.Add('////////');
  Memo1.Lines.Add('Progress '+IntToStr(Progress));
  Memo1.Lines.Add('MaxProgress '+IntToStr(MaxProgress));
end;

end.
