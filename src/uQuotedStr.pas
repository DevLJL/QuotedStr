unit uQuotedStr;

interface

uses
  System.Classes;

type
  TDBDriver = (dbFB, dbMSSQL, dbMYSQL, dbSQLITE, dbORACLE, dbPG);

  function Quo(const AValue: String): String; overload;
  function Quo(const AValue: Integer): String; overload;
  function Quo(const AValue: Int64): String; overload;
  function Quo(const AValue: Double; const ADecimalPlaces: Integer = 2): String; overload;
  function Quo(const AValue: Currency; const ADecimalPlaces: Integer = 2): String; overload;
  function Quo(const AValue: TDate; const ADBName: TDBDriver): String; overload;
  function Quo(const AValue: TDateTime; const ADBName: TDBDriver): String; overload;
  function QuoNull(const AValue: Integer): String; overload;
  function QuoNull(const AValue: Int64): String; overload;
  function DateToSQLFormat(const AValue: TDate; const ADBName: TDBDriver): string;
  function DateTimeToSQLFormat(const AValue: TDateTime; const ADBName: TDBDriver): string;

implementation

uses
  System.SysUtils,
  System.Dateutils,
  System.StrUtils;

function Quo(const AValue: String): String;
begin
  Result := QuotedStr(AValue);
end;

function Quo(const AValue: Integer): String;
begin
  Result := QuotedStr(AValue.ToString);
end;

function Quo(const AValue: Int64): String;
begin
  Result := QuotedStr(AValue.ToString);
end;

function Quo(const AValue: Double; const ADecimalPlaces: Integer = 2): String;
var
  LFormat: TFormatSettings;
begin
  LFormat.DecimalSeparator := '.';
  Result := QuotedStr(Format('%.' + IntToStr(ADecimalPlaces) + 'f', [AValue], LFormat));
end;

function Quo(const AValue: Currency; const ADecimalPlaces: Integer = 2): String;
var
  LFormat: TFormatSettings;
begin
  LFormat.DecimalSeparator := '.';
  Result := QuotedStr(Format('%.' + IntToStr(ADecimalPlaces) + 'f', [AValue], LFormat));
end;

function Quo(const AValue: TDate; const ADBName: TDBDriver): String;
begin
  Result := QuotedStr(DateToSQLFormat(AValue, ADBName));
end;

function Quo(const AValue: TDateTime; const ADBName: TDBDriver): String;
begin
  Result := QuotedStr(DateTimeToSQLFormat(AValue, ADBName));
end;

function QuoNull(const AValue: Integer): String;
begin
  Result := QuotedStr(AValue.ToString);
  if (AValue = 0) then
    Result := 'NULL';
end;

function QuoNull(const AValue: Int64): String;
begin
  Result := QuotedStr(AValue.ToString);
  if (AValue = 0) then
    Result := 'NULL';
end;

function DateToSQLFormat(const AValue: TDate; const ADBName: TDBDriver): string;
begin
  case ADBName of
    dbFB: Result := FormatDateTime('mm/dd/yyyy', AValue);
    dbMSSQL,
    dbMYSQL,
    dbSQLITE,
    dbORACLE,
    dbPG: Result := FormatDateTime('yyyy-mm-dd', AValue);
  end;
end;

function DateTimeToSQLFormat(const AValue: TDateTime; const ADBName: TDBDriver): string;
begin
  case ADBName of
    dbFB: Result := FormatDateTime('mm/dd/yyyy hh:nn:ss', AValue);
    dbMSSQL,
    dbMYSQL,
    dbSQLITE,
    dbORACLE,
    dbPG: Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', AValue);
  end;
end;

end.

