
[Work with JSON: TJSONValue, TJSONWriter and Other Options from Delphi](https://community.idera.com/developer-tools/b/blog/posts/returning-json-tjsonvalue-tjsonwriter-and-other-options-from-rad-server)

[JSON](http://docwiki.embarcadero.com/RADStudio/Rio/en/JSON)
[JSON Readers and Writers](http://docwiki.embarcadero.com/RADStudio/Rio/en/Readers_and_Writers_JSON_Framework)

**RAD Studio provides two frameworks to handle JSON data:**

JSON Objects Framework – creates temporary objects to read and write JSON data.
The JSON objects framework requires the creation of a temporary object to parse or generate JSON data. To read or write JSON data, you have to create an intermediate memory object such as TJSONObject, TJSONArray, or TJSONString before reading and writing the JSON.

Readers and Writers JSON Framework – allows you to read and write JSON data directly.
The Readers and Writers JSON Framework allows applications to read and write JSON data directly to a stream, without creating a temporary object. Not having to create a temporary object to read and write the JSON provides better performance and improved memory consumption.




**2 Using JSONValue**
Use the JSON Objects Framework to create JSON strings by assembling them in code. JSONValue is the ancestor class for all the JSON classes used for defining JSON string, object, array, number, Boolean, true, false, and null values. Included in the RAD Studio JSON implementation are the following classes and methods:

TJSONObject – implements a JSON object. Methods in TJSONObject Include:

Parse – method to parse a JSON data stream and store the encountered JSON pairs into a TJSONObject instance.

ParseJSONValue – method to parse a byte array and create the corresponding JSON value from the data.

AddPair method – Adds a new JSON pair to a JSON object.

GetPair method – Returns the key-value pair that has the specified I index in the list of pairs of a JSON object, or nil if the specified I index is out of bounds.

GetPairByName method – returns a key-value pair, from a JSON object, that has a key part matching the specified PairName string, or nil if there is no key matching PairName.

SetPairs – Defines the list of key-value pairs that this JSON object contains.

FindValue – Finds and returns a TJSONValue instance located at the specified Apath JSON path. Otherwise, returns nil.

Get Value – Returns the value part from a key-value pair specified by the Name key in a JSON object, or nil if there is no key that matches Name.

Pairs – Accesses the Key-value pair that is located at the specified Index in the list of pairs of the JSON object, or nil if the specified Index is out of bounds.

GetCount – Returns the number of key-value pairs of a JSON object.

TJSONArray – Implements a JSON array. JSONArray methods include:

Add – Adds a non-null value given through the Element parameter to the current element list.

Get – Returns the element at the given index in the JSON array.

Pop – Removes the first element from the JSON array.

Size – Returns the size of the JSON array.

ToBytes – Serializes the current JSON array content into an array of bytes.

ToString – Serializes the current JSON array into a string and returns the resulting string.

Additional JSON classes include:

TJSONString – Implements a JSON string.

TJSONNumber – Implements a JSON number.

TJSONBool – JSON Boolean value.

TJSONTrue – Implements a JSON true value.

TJSONFalse – Implements a JSON false value.

TJSONNull – Implements a JSON null value.





```delphi

procedure TJSONValueDemoResource1.Get(const AContext: TendpointContext;
	const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  JSONColor : TJSONObject;
  JSONArray : TJSONArray;
  JSONObject : TJSONObject;
  JSONValue : TJSONValue;
begin
  // create some JSON objects
  JSONColor := TJSONObject.Create();
  JSONColor.AddPair('name', 'red');
  JSONColor.AddPair('hex', '#ff0000');
  JSONColor.AddPair('name', 'blue');
  JSONColor.AddPair('hex', '#0000FF');
  JSONArray := TJSONArray.Create();
  JSONArray.Add(JSONColor);
  JSONObject := TJSONObject.Create();
  JSONObject.AddPair('colors', JSONArray);
  JSONValue := TJSONObject.Create();
  JSONValue := TJSONObject.ParseJSONValue(JSONObject.ToJSON);
  AResponse.building.SetValue(
    TJSONString.Create(
      JSONColor.ToJSON
      + ','
      + JSONObject.ToJSON
      + ',{"name":"' + JSONValue.GetValue<string>('colors[0].name')
      + '","hex":"'+ JSONValue.GetValue<string>('colors[0].hex')
      + '"}'
  ), True);
end;
```

**2.2 VCL Client App using JSONValue classes**

The following VCL client application uses several of the JSONValue based classes to create, parse and display the results of TJSONArray and TJSONObject based operations.

```delphi
unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses
  JSON;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  JSONColor : TJSONObject;
  JSONArray : TJSONArray;
  JSONObject : TJSONObject;
  JSONValue : TJSONValue;
  mBoolean : boolean;
begin
  mBoolean := true;

  JSONColor := TJSONObject.Create();
  JSONColor.AddPair('name', 'red');
  JSONColor.AddPair('hex', '#f00');
  JSONColor.AddPair('mBoolean',TJSONBool.Create(mBoolean));

  JSONArray := TJSONArray.Create();
  JSONArray.Add(JSONColor);

  JSONObject := TJSONObject.Create();
  JSONObject.AddPair('colors', JSONArray);
  JSONObject.AddPair('mBoolean',TJSONBool.Create(mBoolean));

  Memo1.Lines.Clear();
  Memo1.Lines.Add('JSONColor: '+JSONColor.ToJSON);
  Memo1.Lines.Add('');
  Memo1.Lines.Add('JSONObject: '+JSONObject.ToJSON);
  Memo1.Lines.Add('');

  JSONValue := TJSONObject.Create();
  JSONValue := TJSONObject.ParseJSONValue(JSONObject.ToJSON);

  Memo1.Lines.Add('colors[0]');
  Memo1.Lines.Add('name: '+ JSONValue.GetValue<string>('colors[0].name'));
  Memo1.Lines.Add('hex: '+ JSONValue.GetValue<string>('colors[0].hex'));
  Memo1.Lines.Add('mBoolean: '+JSONValue.GetValue<string>('colors[0].mBoolean'));
end;
```

**3 Using JSONWriter**
Using JSONWriter simplifies RAD Server application development to craft custom JSON that delivers data for programming language clients to consume. Use JSONWriter to start your JSON object, write a property name and a value, keep writing properties and values until you end the JSON object.

**3.1 A Simple JSONWriter Example**
Here is an example GET method that returns some data using JSONWriter’s WriteStartArray, WriteStartObject, WritePropertyName, WriteValue, WriteEndObject, WriteEndArray methods.
Setting the JSONWriter.Formatting property value to Indented will produce a clean looking response in the Browser.

```delphi
implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
uses
  System.JSON.Types;

{$R *.dfm}

procedure TEmployeeResource1.Get(const AContext: TendpointContext;
	const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  // set the JSONWriter formatting to indented
  AResponse.building.JSONWriter.Formatting := TJSONFormatting.Indented;

  // start the JSON Array
  AResponse.building.JSONWriter.WriteStartArray;

  // start the JSON object

  AResponse.building.JSONWriter.WriteStartObject;
  AResponse.building.JSONWriter.WritePropertyName('Test');
  AResponse.building.JSONWriter.WriteValue('Foo bar');

  // add WritePropertyName and WriteValue statements as often as needed

  // end the JSON object
  AResponse.building.JSONWriter.WriteEndObject;

  // write as many additional JSON objects as you need

  // end the JSON array
  AResponse.building.JSONWriter.WriteEndArray;
end;
```









