{ =============================================================================|
  |������: Google API � Delphi                                                 |
  |============================================================================|
  |unit: GTranslate                                                            |
  |============================================================================|
  |��������: ������ ��� ������ � ������������ Google.                          |
  |============================================================================|
  |�����������:                                                                |
  |1. ��� �������� JSON-���������� ������������ ���������� SuperObject         |
  |============================================================================|
  | �����: Vlad. (vlad383@gmail.com)                                           |
  | ����: 09.08.2010                                                           |
  | ������: ��. ����                                                           |
  | Copyright (c) 2009-2010 WebDelphi.ru                                       |
  |============================================================================|
  | ������������ ����������                                                    |
  |============================================================================|
  | ������ ����������� ����������� ��������������� ���� ���ܻ, ��� ������ ���� |
  | ��������, ���� ���������� ��� ���������������, �������, �� �� �������������|
  | ���������� �������� �����������, ������������ �� ��� ����������� ����������|
  | � ����������� ����. �� � ����� ������ ������ ��� ��������������� �� �����  |
  | ��������������� �� ����� � ���������� ������, ������� ��� ������ ����������|
  | �� ����������� ����������, �������� ��� �����, ��������� ��, �������       |
  | �������� ��� ��������� � ����������� ������������ ��� ��������������       |
  | ������������ ����������� ��� ����� ���������� � ����������� ������������.  |
  |                                                                            |
  | This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF      |
  | ANY KIND, either express or implied.                                       |
  |============================================================================|
  | ���������� ����������                                                      |
  |============================================================================|
  | ��������� ���������� ������ GFeedBurner ����� ����� � ����������� �� ������:|
  | http://github.com/googleapi                                                |
  |============================================================================|
  | ������� ������                                                             |
  |============================================================================|
  |v. 0.2                                                                      |
  | + ��������� API v.2                                                        |
  | + �������� key: string - ���� ������� � API                                |
  |============================================================================ }
unit GTranslate;

interface

uses windows, superobject, classes, variants, sysutils, typinfo,synacode,
     ssl_openssl,httpsend,Dialogs;

resourcestring
  rsLangUnknown = '����������� ����';
  rsLangAuto = '���������������';
  rsLang_en = '����������';
  rsLang_ru = '�������';
  rsLang_it = '�����������';
  rsLang_az = '���������������';
  rsLang_sq = '���������';
  rsLang_ar = '��������';
  rsLang_hy = '���������';
  rsLang_af = '���������';
  rsLang_eu = '��������';
  rsLang_be = '�����������';
  rsLang_bg = '����������';
  rsLang_cy = '����������';
  rsLang_hu = '����������';
  rsLang_vi = '�����������';
  rsLang_gl = '�����������';
  rsLang_nl = '�����������';
  rsLang_el = '���������';
  rsLang_ka = '����������';
  rsLang_da = '�������';
  rsLang_iw = '�����';
  rsLang_yi = '����';
  rsLang_id = '�������������';
  rsLang_ga = '����������';
  rsLang_is = '����������';
  rsLang_es = '���������';
  rsLang_ca = '�����������';
  rsLang_zh_CN = '���������';
  rsLang_ko = '���������';
  rsLang_ht = '���������� (�����)';
  rsLang_lv = '���������';
  rsLang_lt = '���������';
  rsLang_mk = '�����������';
  rsLang_ms = '���������';
  rsLang_mt = '�����������';
  rsLang_de = '��������';
  rsLang_no = '����������';
  rsLang_fa = '����������';
  rsLang_pl = '��������';
  rsLang_pt = '�������������';
  rsLang_ro = '���������';
  rsLang_sr = '��������';
  rsLang_sk = '���������';
  rsLang_sl = '����������';
  rsLang_sw = '�������';
  rsLang_tl = '����������';
  rsLang_th = '�������';
  rsLang_tr = '��������';
  rsLang_uk = '����������';
  rsLang_ur = '����';
  rsLang_fi = '�������';
  rsLang_fr = '�����������';
  rsLang_hi = '�����';
  rsLang_hr = '����������';
  rsLang_cs = '�������';
  rsLang_sv = '��������';
  rsLang_et = '���������';
  rsLang_ja = '��������';

  rsErrorDestLng = '������� ���������� �.�. �� ��������� ���� ��������';
  rsErrorTrnsl = '�� ����� �������� ��������� ������';
  rsErrLagrgeReq =
    '���������� �������� � ������ ��� �������� ��������� ���������� �������� � 5000';

type
  TLanguageEnum = (unknown, lng_af, lng_sq, lng_ar, lng_hy, lng_az, lng_eu,
    lng_be, lng_bg, lng_my, lng_ca, lng_zh, lng_zh_CN, lng_zh_TW, lng_hr,
    lng_cs, lng_da, lng_nl, lng_en, lng_et, lng_tl, lng_fi, lng_fr, lng_gl,
    lng_ka, lng_de, lng_el, lng_gu, lng_ht, lng_iw, lng_hi, lng_hu, lng_is,
    lng_id, lng_iu, lng_ga, lng_it, lng_ja, lng_jw, lng_kn, lng_kk, lng_km,
    lng_ko, lng_ku, lng_ky, lng_lo, lng_la, lng_lv, lng_lt, lng_lb, lng_mk,
    lng_ms, lng_ml, lng_mt, lng_mi, lng_mr, lng_mn, lng_ne, lng_no, lng_oc,
    lng_or, lng_ps, lng_fa, lng_pl, lng_pt, lng_pt_PT, lng_pa, lng_qu, lng_ro,
    lng_ru, lng_sa, lng_gd, lng_sr, lng_sd, lng_si, lng_sk, lng_sl, lng_es,
    lng_su, lng_sw, lng_sv, lng_syr, lng_tg, lng_ta, lng_tt, lng_te, lng_th,
    lng_to, lng_tr, lng_uk, lng_ur, lng_uz, lng_ug, lng_vi, lng_cy, lng_yi,
    lng_yo);

  TLanguageRec = record
    Name: string;
    Ident: TLanguageEnum;
  end;

  TSpecials = set of AnsiChar;

const
  Languages: array [0 .. 57] of TLanguageRec =
    ((Name: rsLangAuto; Ident: unknown),
    (Name: rsLang_en; Ident: lng_en), (Name: rsLang_ru; Ident: lng_ru),
    (Name: rsLang_it; Ident: lng_it), (Name: rsLang_az; Ident: lng_az),
    (Name: rsLang_sq; Ident: lng_sq), (Name: rsLang_ar; Ident: lng_ar),
    (Name: rsLang_hy; Ident: lng_hy), (Name: rsLang_af; Ident: lng_af),
    (Name: rsLang_eu; Ident: lng_eu), (Name: rsLang_be; Ident: lng_be),
    (Name: rsLang_bg; Ident: lng_bg), (Name: rsLang_cy; Ident: lng_cy),
    (Name: rsLang_hu; Ident: lng_hu), (Name: rsLang_vi; Ident: lng_vi),
    (Name: rsLang_gl; Ident: lng_gl), (Name: rsLang_nl; Ident: lng_nl),
    (Name: rsLang_el; Ident: lng_el), (Name: rsLang_ka; Ident: lng_ka),
    (Name: rsLang_da; Ident: lng_da), (Name: rsLang_iw; Ident: lng_iw),
    (Name: rsLang_yi; Ident: lng_yi), (Name: rsLang_id; Ident: lng_id),
    (Name: rsLang_ga; Ident: lng_ga), (Name: rsLang_is; Ident: lng_is),
    (Name: rsLang_es; Ident: lng_es), (Name: rsLang_ca; Ident: lng_ca),
    (Name: rsLang_zh_CN; Ident: lng_zh_CN), (Name: rsLang_ko; Ident: lng_ko),
    (Name: rsLang_ht; Ident: lng_ht), (Name: rsLang_lv; Ident: lng_lv),
    (Name: rsLang_lt; Ident: lng_lt), (Name: rsLang_mk; Ident: lng_mk),
    (Name: rsLang_ms; Ident: lng_ms), (Name: rsLang_mt; Ident: lng_mt),
    (Name: rsLang_de; Ident: lng_de), (Name: rsLang_no; Ident: lng_no),
    (Name: rsLang_fa; Ident: lng_fa), (Name: rsLang_pl; Ident: lng_pl),
    (Name: rsLang_pt; Ident: lng_pt), (Name: rsLang_ro; Ident: lng_ro),
    (Name: rsLang_sr; Ident: lng_sr), (Name: rsLang_sk; Ident: lng_sk),
    (Name: rsLang_sl; Ident: lng_sl), (Name: rsLang_sw; Ident: lng_sw),
    (Name: rsLang_tl; Ident: lng_tl), (Name: rsLang_th; Ident: lng_th),
    (Name: rsLang_tr; Ident: lng_tr), (Name: rsLang_uk; Ident: lng_uk),
    (Name: rsLang_ur; Ident: lng_ur), (Name: rsLang_fi; Ident: lng_fi),
    (Name: rsLang_fr; Ident: lng_fr), (Name: rsLang_hi; Ident: lng_hi),
    (Name: rsLang_hr; Ident: lng_hr), (Name: rsLang_cs; Ident: lng_cs),
    (Name: rsLang_sv; Ident: lng_sv), (Name: rsLang_et; Ident: lng_et),
    (Name: rsLang_ja; Ident: lng_ja));

  cTranslateURL = 'https://www.googleapis.com/language/translate/v';
  cMaxGet = 2000;
  cMaxPost = 5000;

  APIVersion = '2';
  TranslatorVersion = '0.2';
//  URLSpecialChar: TSpecials = [#$00 .. #$20, '_', '<', '>', '"', '%', '{', '}',
//    '|', '\', '^', '~', '[', ']', '`', #$7F .. #$FF];

type
  TOnTranslate = procedure(const SourceStr, TranslateStr: string;
    LangDetected: TLanguageEnum) of object;
  TOnTranslateError = procedure(const Code: integer; Status: string) of object;

  TTranslator = class(TComponent)
  private
    FVersion: string;
    FSourceLang: TLanguageEnum;
    FDestLang: TLanguageEnum;
    FKey: string;
    FOnTranslate: TOnTranslate;
    FOnTranslateError: TOnTranslateError;
    function GetDetectedLanguage(const DetectStr: string): TLanguageEnum;
    function GetRequestURL(SourceStr: string): string;
    function GetVersion: string;
    function GetParams(const Text: TStringList): string;
    function SendRequest(const aText: TStringList;
      var Response: string): boolean;
    function ParseError(const Response:string):boolean;
  public
    constructor Create(AOwner: TComponent); override;
    function Translate(const SourceStr: string): string;
    function GetLanguagesNames: TStringList;
    function GetLangByName(const aName: string): TLanguageEnum;
  published
    property SourceLang: TLanguageEnum read FSourceLang write FSourceLang;
    property DestLang: TLanguageEnum read FDestLang write FDestLang;
    property Key: string read FKey write FKey;
    property OnTranslate: TOnTranslate read FOnTranslate write FOnTranslate;
    property OnTranslateError: TOnTranslateError read FOnTranslateError write
      FOnTranslateError;
    property Version: string read GetVersion;
  end;

procedure Register;
//function EncodeURL(const Value: AnsiString): AnsiString; inline;
//function EncodeTriplet(const Value: AnsiString; Delimiter: AnsiChar;
//  Specials: TSpecials): AnsiString; inline;

implementation

procedure Register;
begin
  RegisterComponents('WebDelphi.ru', [TTranslator]);
end;

//function EncodeTriplet(const Value: AnsiString; Delimiter: AnsiChar;
//  Specials: TSpecials): AnsiString; inline;
//var
//  n, l: integer;
//  s: AnsiString;
//  c: AnsiChar;
//begin
//  SetLength(Result, Length(Value) * 3);
//  l := 1;
//  for n := 1 to Length(Value) do
//    begin
//      c := Value[n];
//      if c in Specials then
//        begin
//          Result[l] := Delimiter;
//          Inc(l);
//          s := IntToHex(Ord(c), 2);
//          Result[l] := s[1];
//          Inc(l);
//          Result[l] := s[2];
//          Inc(l);
//        end
//      else
//        begin
//          Result[l] := c;
//          Inc(l);
//        end;
//    end;
//  Dec(l);
//  SetLength(Result, l);
//end;

//function EncodeURL(const Value: AnsiString): AnsiString; inline;
//begin
//  Result := EncodeTriplet(Value, '%', URLSpecialChar);
//end;

{ TTranslator }

constructor TTranslator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSourceLang := unknown;
  FDestLang := lng_ru;
end;

function TTranslator.GetDetectedLanguage(const DetectStr: string)
  : TLanguageEnum;
var
  aName: string;
  idx: integer;
begin
  aName := 'lng_' + StringReplace(DetectStr, '-', '_', [rfReplaceAll]);
  idx := GetEnumValue(TypeInfo(TLanguageEnum), aName);
  if idx > -1 then
    Result := TLanguageEnum(idx)
  else
    Result := unknown;
end;

function TTranslator.GetLangByName(const aName: string): TLanguageEnum;
var
  i: integer;
begin
  Result := unknown;
  for i := 0 to High(Languages) - 1 do
    begin
      if AnsiLowerCase(Trim(aName)) = AnsiLowerCase
        (Trim(Languages[i].Name)) then
        begin
          Result := Languages[i].Ident;
          break
        end;
    end;
end;

function TTranslator.GetLanguagesNames: TStringList;
var
  i: integer;
begin
  Result := TStringList.Create;
  for i := 0 to High(Languages) - 1 do
    Result.Add(Languages[i].Name);
end;

function TTranslator.GetParams(const Text: TStringList): string;
var
  i: integer;
  source, dest: string;
begin
  source := '';
  if SourceLang <> unknown then
    begin
      source := StringReplace
        (GetEnumName(TypeInfo(TLanguageEnum), Ord(FSourceLang)), '_', '-',
        [rfReplaceAll]);
      Delete(source, 1, 4);
    end;
  dest := StringReplace(GetEnumName(TypeInfo(TLanguageEnum), Ord(FDestLang)),
    '_', '-', [rfReplaceAll]);
  Delete(dest, 1, 4);
  Result := 'key=' + Key;
  for i := 0 to Text.Count - 1 do
    Result := Result + '&q=' + Text[i];
  if SourceLang <> unknown then
    Result := Result + '&source=' + source;
  if DestLang <> unknown then
    Result := Result + '&target=' + dest;
  Result:=EncodeURL(AnsiString(Result));
end;

function TTranslator.GetRequestURL(SourceStr: string): string;
var
  source, dest: string;
begin
  source := '';
  if SourceLang <> unknown then
    begin
      source := StringReplace
        (GetEnumName(TypeInfo(TLanguageEnum), Ord(FSourceLang)), '_', '-',
        [rfReplaceAll]);
      Delete(source, 1, 4);
    end;
  dest := StringReplace(GetEnumName(TypeInfo(TLanguageEnum), Ord(FDestLang)),
    '_', '-', [rfReplaceAll]);
  Delete(dest, 1, 4);
  Result := cTranslateURL + APIVersion + '?key=' + Key + '&q=' +
    UTF8Encode(SourceStr);
  if SourceLang <> unknown then
    Result := Result + '&source=' + source;
  if DestLang <> unknown then
    Result := Result + '&target=' + dest;
  EncodeURL(Result);
end;

function TTranslator.GetVersion: string;
begin
  Result := APIVersion;
end;

function TTranslator.ParseError(const Response: string): boolean;
var obj: ISuperObject;
    s: PSOChar;
begin
  s := PwideChar(Response);
  obj := TSuperObject.ParseString(s, true);
  if not Assigned(obj) then Exit;
  ShowMessage(obj.AsObject.GetNames.AsString);
end;

function TTranslator.SendRequest(const aText: TStringList;
  var Response: string): boolean;
var
  i: integer;
  PostData: TStringStream;
  source, dest: string;
begin
  Result := false;
  PostData := TStringStream.Create;
  if (aText = nil) OR (aText.Count = 0) then
    Exit;
   with THTTPSend.Create do
     begin
       if HTTPMethod('GET', cTranslateURL + Version + '?' +
          GetParams(aText)) then
          begin
            PostData.LoadFromStream(Document);
            Result := true;
            Response := PostData.DataString;
            ParseError(Response)
          end
    end;
end;

function TTranslator.Translate(const SourceStr: string): string;
var
  obj: ISuperObject;
  s: PSOChar;
  Text: TStringList;
  Resp: string;
begin
  if FDestLang = unknown then
    raise Exception.Create(rsErrorDestLng);
  Text := TStringList.Create;
  Text.Add(SourceStr);

  if SendRequest(Text, Resp) then
    begin
      s := PwideChar(Resp);
      obj := TSuperObject.ParseString(s, true);
      try
        Result := UTF8ToString(obj.A['data.translations'].O[0].s['translatedText']);
        if Assigned(FOnTranslate) then
          begin
            // if FSourceLang <> unknown then
            FOnTranslate(SourceStr, Result, FSourceLang)
            // else
            // FOnTranslate(SourceStr, Result, GetDetectedLanguage
            // (obj.s[cDetectedLangPath]))
          end;
      except
        Text.Clear;
        Text.Add(Resp);
        Text.SaveToFile('Error.txt');
        raise Exception.Create(rsErrorTrnsl+' :'+Resp);

      end;
    end
    else
      raise Exception.Create(Resp);

end;

end.
