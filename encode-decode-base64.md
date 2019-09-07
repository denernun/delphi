https://stackoverflow.com/questions/8768652/base64-to-binary-delphi

```delphi
procedure DecodeFile(const base64: AnsiString; const FileName: string);
var
  stream: TBytesStream;
begin
  stream := TBytesStream.Create(DecodeBase64(base64));
  try
    stream.SaveToFile(Filename);
  finally
    stream.Free;
  end;
end;
```

```delphi
procedure DecodeToFile(const base64: AnsiString; const FileName: string);
var
  stream: TFileStream;
  bytes: TBytes;
begin
  bytes := DecodeBase64(base64);
  stream := TFileStream.Create(FileName, fmCreate);
  try
    if bytes<>nil then
      stream.Write(bytes[0], Length(Bytes));
  finally
    stream.Free;
  end;
end;
```

