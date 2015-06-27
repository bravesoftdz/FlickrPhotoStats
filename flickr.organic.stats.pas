// Copyright (c) 2015, Jordi Corbilla
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// - Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
// - Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
// - Neither the name of this library nor the names of its contributors may be
// used to endorse or promote products derived from this software without
// specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

unit flickr.organic.stats;

interface

uses
  XMLDoc, xmldom, XMLIntf;

type
  IFlickrOrganicStats = Interface
    function GetDate: TDateTime;
    function GetNegativeComments: Integer;
    function GetNegativeLikes: Integer;
    function GetNegativeViews: Integer;
    function GetPositiveComments: Integer;
    function GetPositiveLikes: Integer;
    function GetPositiveViews: Integer;
    procedure SetDate(const Value: TDateTime);
    procedure SetNegativeComments(const Value: Integer);
    procedure SetNegativeLikes(const Value: Integer);
    procedure SetNegativeViews(const Value: Integer);
    procedure SetPositiveComments(const Value: Integer);
    procedure SetPositiveLikes(const Value: Integer);
    procedure SetPositiveViews(const Value: Integer);
    property date: TDateTime read GetDate write SetDate;
    property positiveViews: Integer read GetPositiveViews write SetPositiveViews;
    property negativeViews: Integer read GetNegativeViews write SetNegativeViews;
    property positiveLikes: Integer read GetPositiveLikes write SetPositiveLikes;
    property negativeLikes: Integer read GetNegativeLikes write SetNegativeLikes;
    property positiveComments: Integer read GetPositiveComments write SetPositiveComments;
    property negativeComments: Integer read GetNegativeComments write SetNegativeComments;
    procedure Save(iNode: IXMLNode);
    procedure Load(iNode: IXMLNode);
    procedure Copy(stat: IFlickrOrganicStats);
  End;

  TFlickrOrganicStats = class(TInterfacedObject, IFlickrOrganicStats)
  private
    FDate : TDateTime;
    FNegativeComments : integer;
    FNegativeLikes : integer;
    FNegativeViews : integer;
    FPositiveComments : integer;
    FPositiveLikes : integer;
    FPositiveViews : integer;
    function GetDate: TDateTime;
    function GetNegativeComments: Integer;
    function GetNegativeLikes: Integer;
    function GetNegativeViews: Integer;
    function GetPositiveComments: Integer;
    function GetPositiveLikes: Integer;
    function GetPositiveViews: Integer;
    procedure SetDate(const Value: TDateTime);
    procedure SetNegativeComments(const Value: Integer);
    procedure SetNegativeLikes(const Value: Integer);
    procedure SetNegativeViews(const Value: Integer);
    procedure SetPositiveComments(const Value: Integer);
    procedure SetPositiveLikes(const Value: Integer);
    procedure SetPositiveViews(const Value: Integer);
  public
    property date: TDateTime read GetDate write SetDate;
    property positiveViews: Integer read GetPositiveViews write SetPositiveViews;
    property negativeViews: Integer read GetNegativeViews write SetNegativeViews;
    property positiveLikes: Integer read GetPositiveLikes write SetPositiveLikes;
    property negativeLikes: Integer read GetNegativeLikes write SetNegativeLikes;
    property positiveComments: Integer read GetPositiveComments write SetPositiveComments;
    property negativeComments: Integer read GetNegativeComments write SetNegativeComments;
    procedure Save(iNode: IXMLNode);
    procedure Load(iNode: IXMLNode);
    procedure Copy(stat: IFlickrOrganicStats);
  end;

implementation

uses
  System.SysUtils;

{ TFlickrOrganicStats }

procedure TFlickrOrganicStats.Copy(stat: IFlickrOrganicStats);
begin
  SetPositiveViews(stat.positiveViews);
  SetPositiveLikes(stat.PositiveLikes);
  SetPositiveComments(stat.PositiveComments);
  SetNegativeViews(stat.NegativeViews);
  SetNegativeLikes(stat.NegativeLikes);
  SetNegativeComments(stat.NegativeComments);
end;

function TFlickrOrganicStats.GetDate: TDateTime;
begin
  result := FDate;
end;

function TFlickrOrganicStats.GetNegativeComments: Integer;
begin
  result := FNegativeComments;
end;

function TFlickrOrganicStats.GetNegativeLikes: Integer;
begin
  result := FNegativeLikes;
end;

function TFlickrOrganicStats.GetNegativeViews: Integer;
begin
  result := FNegativeViews;
end;

function TFlickrOrganicStats.GetPositiveComments: Integer;
begin
  result := FPositiveComments;
end;

function TFlickrOrganicStats.GetPositiveLikes: Integer;
begin
  result := FPositiveLikes;
end;

function TFlickrOrganicStats.GetPositiveViews: Integer;
begin
  result := FPositiveViews;
end;

procedure TFlickrOrganicStats.Load(iNode: IXMLNode);
begin
  FDate := StrToDate(iNode.Attributes['Date']);
  FPositiveViews := StrToInt(iNode.Attributes['PositiveViews']);
  FNegativeViews := StrToInt(iNode.Attributes['NegativeViews']);
  FPositiveLikes := StrToInt(iNode.Attributes['PositiveLikes']);
  FNegativeLikes := StrToInt(iNode.Attributes['NegativeLikes']);
  FPositiveComments := StrToInt(iNode.Attributes['PositiveComments']);
  FNegativeComments := StrToInt(iNode.Attributes['NegativeComments']);
end;

procedure TFlickrOrganicStats.Save(iNode: IXMLNode);
var
  iNode2: IXMLNode;
begin
  iNode2 := iNode.AddChild('Stats');
  iNode2.Attributes['Date'] := DateToStr(FDate);
  iNode2.Attributes['PositiveViews'] := IntToStr(FPositiveViews);
  iNode2.Attributes['NegativeViews'] := IntToStr(FNegativeViews);
  iNode2.Attributes['PositiveLikes'] := IntToStr(FPositiveLikes);
  iNode2.Attributes['NegativeLikes'] := IntToStr(FNegativeLikes);
  iNode2.Attributes['PositiveComments'] := IntToStr(FPositiveComments);
  iNode2.Attributes['NegativeComments'] := IntToStr(FNegativeComments);
end;

procedure TFlickrOrganicStats.SetDate(const Value: TDateTime);
begin
  Fdate := value;
end;

procedure TFlickrOrganicStats.SetNegativeComments(const Value: Integer);
begin
  FNegativeComments := value;
end;

procedure TFlickrOrganicStats.SetNegativeLikes(const Value: Integer);
begin
  FNegativeLikes := value;
end;

procedure TFlickrOrganicStats.SetNegativeViews(const Value: Integer);
begin
  FNegativeViews := value;
end;

procedure TFlickrOrganicStats.SetPositiveComments(const Value: Integer);
begin
  FPositiveComments := Value;
end;

procedure TFlickrOrganicStats.SetPositiveLikes(const Value: Integer);
begin
  FPositiveLikes := Value;
end;

procedure TFlickrOrganicStats.SetPositiveViews(const Value: Integer);
begin
  FPositiveViews := value;
end;

end.
