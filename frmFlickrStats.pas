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

unit frmFlickrStats;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdIOHandler, IdIOHandlerStream, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, XMLDoc, xmldom, XMLIntf, msxmldom, ComCtrls,
  flickr.repository,
  ExtCtrls, TeEngine, TeeProcs, Chart, Series, VclTee.TeeGDIPlus,
  System.UITypes, flickr.globals,
  Vcl.ImgList, Vcl.Buttons, System.Win.TaskbarCore, Vcl.Taskbar, System.Actions,
  Vcl.ActnList, IdHashMessageDigest, idHash, IdGlobal, Vcl.OleCtrls, SHDocVw,
  flickr.profiles, flickr.profile, flickr.filtered.list;

type
  TfrmFlickr = class(TForm)
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    XMLDocument1: TXMLDocument;
    Panel1: TPanel;
    btnSave: TButton;
    Panel2: TPanel;
    listPhotos: TListView;
    Splitter1: TSplitter;
    Panel3: TPanel;
    ProgressBar1: TProgressBar;
    rbViews: TRadioButton;
    rbLikes: TRadioButton;
    rbComments: TRadioButton;
    Panel5: TPanel;
    Label2: TLabel;
    photoId: TEdit;
    btnAdd: TButton;
    batchUpdate: TButton;
    PageControl1: TPageControl;
    Statistics: TTabSheet;
    Panel4: TPanel;
    Chart2: TChart;
    Series4: TBarSeries;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    globals: TTabSheet;
    Process: TLabel;
    ChartComments: TChart;
    LineSeries1: TLineSeries;
    ChartViews: TChart;
    LineSeries4: TLineSeries;
    ChartLikes: TChart;
    LineSeries7: TLineSeries;
    ImageList1: TImageList;
    TabSheet1: TTabSheet;
    Panel6: TPanel;
    btnGetList: TButton;
    Label4: TLabel;
    edtUserId: TEdit;
    listPhotosUser: TListView;
    Panel7: TPanel;
    btnAddItems: TButton;
    lblfetching: TLabel;
    progressfetching: TProgressBar;
    Taskbar1: TTaskbar;
    ActionList1: TActionList;
    TabSheet2: TTabSheet;
    Panel8: TPanel;
    btnGetGroups: TButton;
    progressfetchinggroups: TProgressBar;
    Authenticate: TButton;
    TabSheet3: TTabSheet;
    edtMax: TEdit;
    Label9: TLabel;
    btnExcel: TButton;
    TabSheet4: TTabSheet;
    dailyViews: TChart;
    LineSeries2: TBarSeries;
    dailyLikes: TChart;
    BarSeries1: TBarSeries;
    Label1: TLabel;
    apikey: TEdit;
    Label8: TLabel;
    secret: TEdit;
    TabSheet5: TTabSheet;
    mLogs: TMemo;
    TabSheet6: TTabSheet;
    Memo1: TMemo;
    Authentication: TTabSheet;
    WebBrowser1: TWebBrowser;
    btnGetToken: TButton;
    Splitter2: TSplitter;
    statsDay: TChart;
    BarSeries2: TBarSeries;
    TabSheet7: TTabSheet;
    listAlbums: TMemo;
    Button1: TButton;
    Button2: TButton;
    btnAddPhotos: TButton;
    Label5: TLabel;
    edtFilterGroup: TEdit;
    btnFilterOK: TButton;
    btnFilterCancel: TButton;
    PageControl2: TPageControl;
    tabList: TTabSheet;
    tabStatus: TTabSheet;
    Panel9: TPanel;
    Label10: TLabel;
    pstatus: TProgressBar;
    listGroups: TListView;
    Panel10: TPanel;
    mStatus: TMemo;
    profiles: TGroupBox;
    Label6: TLabel;
    ComboBox1: TComboBox;
    btnLoadProfile: TButton;
    Label7: TLabel;
    edtProfile: TEdit;
    btnSaveProfile: TButton;
    chkAddItem: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    btnLoad: TButton;
    chkReplaceProfile: TCheckBox;
    chkDisplayOnly: TCheckBox;
    Label11: TLabel;
    chkUpdate: TCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Panel11: TPanel;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Button3: TButton;
    procedure batchUpdateClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure listPhotosItemChecked(Sender: TObject; Item: TListItem);
    procedure FormDestroy(Sender: TObject);
    function isInSeries(id: string): Boolean;
    procedure listPhotosCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnGetListClick(Sender: TObject);
    procedure apikeyChange(Sender: TObject);
    procedure btnAddItemsClick(Sender: TObject);
    procedure btnGetGroupsClick(Sender: TObject);
    procedure AuthenticateClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
    procedure btnGetTokenClick(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAddPhotosClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure btnSaveProfileClick(Sender: TObject);
    procedure btnLoadProfileClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure listGroupsCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnFilterOKClick(Sender: TObject);
    procedure btnFilterCancelClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    procedure LoadForms(repository: IFlickrRepository);
    function ExistPhotoInList(id: string; var Item: TListItem): Boolean;
    procedure RequestInformation_REST_Flickr(id: string);
    procedure UpdateCounts;
    procedure UpdateTotals;
    procedure UpdateChart(totalViews, totalLikes, totalComments, totalPhotos: Integer);
    procedure UpdateGlobals();
    procedure UpdateAnalytics();
    procedure LoadHallOfFame(repository: IFlickrRepository);
    // function MD5(apikey, secret: string): string;
    function SaveToExcel(AView: TListView; ASheetName, AFileName: string): Boolean;
    function getTotalGroupCounts: Integer;
    procedure Log(s: string);
    procedure UpdateSingleStats(id: string);
    function SaveToExcelGroups(AView: TListView; ASheetName, AFileName: string): Boolean;
    { Private declarations }
  public
    repository: IFlickrRepository;
    globalsRepository: IFlickrGlobals;
    CheckedSeries: TStringList;
    userToken: string;
    userTokenSecret: string;
    flickrProfiles: IProfiles;
    FilteredGroupList: IFilteredList;
    NavigationUrl : String;
  end;

var
  frmFlickr: TfrmFlickr;

implementation

uses
  flickr.photos, flickr.stats, flickr.rest, flickr.top.stats, ComObj,
  flickr.oauth, StrUtils, flickr.access.token, flickr.lib.parallel, ActiveX,
  System.SyncObjs, generics.collections, flickr.rejected, flickr.base;

{$R *.dfm}

procedure TfrmFlickr.apikeyChange(Sender: TObject);
begin
  btnSave.Enabled := true;
end;

procedure TfrmFlickr.AuthenticateClick(Sender: TObject);
var
  OAuthUrl: string;
  response: string;
  oauth_callback_confirmed: string;
  oauth_token: string;
  oauth_token_secret: string;
begin
  // apikey.text 0edf6f13dc6309c822b59ae8bb783df6
  // secret.text b9e217d1c0333300
  if apikey.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  if secret.text = '' then
  begin
    showmessage('Secret key can''t be empty');
    exit;
  end;
  btnGetToken.Visible := false;
  Log('authentication started');
  // oauthr authentication
  Log('Generating request token query for ' + apikey.text + ' ' + secret.text);
  OAuthUrl := TOAuth.New(apikey.text, secret.text).GenerateRequestTokenQuery();
  // Example successful response
  // oauth_callback_confirmed=true&
  // oauth_token=72157650113637896-43aba062d96def83&
  // oauth_token_secret=153e53c592649722
  Log('Calling OAuth URL ' + OAuthUrl);
  response := IdHTTP1.Get(OAuthUrl);
  Log('OAuth URL response ' + response);

  // Parsing response
  Log('Parsing response');
  // oauth_callback_confirmed=true&oauth_token=72157650113637896-43aba062d96def83&oauth_token_secret=153e53c592649722
  response := response.Replace('oauth_callback_confirmed', '');
  response := response.Replace('oauth_token', '');
  response := response.Replace('_secret', '');
  // =true&=72157650113637896-43aba062d96def83&=153e53c592649722
  oauth_callback_confirmed := AnsiLeftStr(response, AnsiPos('&', response));
  // =true&
  response := AnsiRightStr(response, length(response) - length(oauth_callback_confirmed));
  // =72157650113637896-43aba062d96def83&=153e53c592649722
  oauth_token := AnsiLeftStr(response, AnsiPos('&', response));
  // =72157650113637896-43aba062d96def83&
  response := AnsiRightStr(response, length(response) - length(oauth_token));
  // =153e53c592649722
  oauth_token_secret := response;

  // Clean the parameters
  oauth_callback_confirmed := oauth_callback_confirmed.Replace('=', '').Replace('&', '');
  oauth_token := oauth_token.Replace('=', '').Replace('&', '');
  oauth_token_secret := oauth_token_secret.Replace('=', '').Replace('&', '');
  Log('oauth_callback_confirmed= ' + oauth_callback_confirmed);
  Log('oauth_token= ' + oauth_token);
  Log('oauth_token_secret= ' + oauth_token_secret);

  userTokenSecret := oauth_token_secret;

  PageControl1.ActivePage := Authentication;
  Log('Navigating to ' + 'https://www.flickr.com/services/oauth/authorize?oauth_token=' + oauth_token + '&perms=write');
  NavigationUrl := 'https://www.flickr.com/services/oauth/authorize?oauth_token=' + oauth_token + '&perms=write';
  WebBrowser1.Navigate('https://www.flickr.com/services/oauth/authorize?oauth_token=' + oauth_token + '&perms=write');
  showmessage('Authorise the application in the browser and once you get the example page, press Get token button');
  btnGetToken.Visible := true;
end;

procedure TfrmFlickr.Log(s: string);
begin
  mLogs.Lines.Add(DateTimeToStr(Now) + ' ' + s);
end;

procedure TfrmFlickr.batchUpdateClick(Sender: TObject);
var
  i: Integer;
begin
  if apikey.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  batchUpdate.Enabled := false;
  btnGetList.Enabled := false;
  ProgressBar1.Visible := true;
  photoId.Enabled := false;
  btnAdd.Enabled := false;
  Process.Visible := true;
  Taskbar1.ProgressState := TTaskBarProgressState.Normal;
  Taskbar1.ProgressMaxValue := listPhotos.Items.Count;

  ProgressBar1.Min := 0;
  ProgressBar1.Max := listPhotos.Items.Count;
  for i := 0 to listPhotos.Items.Count - 1 do
  begin
    Process.Caption := 'Processing image: ' + listPhotos.Items[i].Caption + ' ' + i.ToString + ' out of ' + listPhotos.Items.Count.ToString;
    ProgressBar1.position := i;
    Taskbar1.ProgressValue := i;
    Application.ProcessMessages;
    if chkUpdate.checked then
    begin
      if listPhotos.items[i].checked then
        RequestInformation_REST_Flickr(listPhotos.Items[i].Caption);
    end
    else
      RequestInformation_REST_Flickr(listPhotos.Items[i].Caption);
  end;

  // Use parallel looping
  // TParallel.ForEach(0, listPhotos.Items.Count - 1,8,
  // procedure(index: Integer; threadId: Integer)
  // begin
  // Process.Caption := 'Processing image: ' + listPhotos.Items[index].Caption
  // + ' ' + index.ToString + ' out of ' + listPhotos.Items.Count.ToString;
  // ProgressBar1.position := index;
  // Taskbar1.ProgressValue := index;
  // Application.ProcessMessages;
  // RequestInformation_REST_Flickr(listPhotos.Items[index].Caption);
  // end);

  ProgressBar1.Visible := false;
  Process.Visible := false;
  UpdateTotals();
  LoadHallOfFame(repository);
  btnSave.Enabled := true;
  photoId.Enabled := true;
  btnAdd.Enabled := true;
  Taskbar1.ProgressValue := 0;
  btnGetList.Enabled := true;
  batchUpdate.Enabled := true;
end;

procedure TfrmFlickr.UpdateTotals();
var
  i: Integer;
  Item: TListItem;
  totalViews, totalViewsacc: Integer;
  totalLikes, totalLikesacc: Integer;
  totalComments, totalCommentsacc: Integer;
  stat: IStat;
begin
  totalViewsacc := 0;
  totalLikesacc := 0;
  totalCommentsacc := 0;
  for i := 0 to listPhotos.Items.Count - 1 do
  begin
    Item := listPhotos.Items[i];
    totalViews := StrToInt(Item.SubItems.Strings[1]);
    totalViewsacc := totalViewsacc + totalViews;

    totalLikes := StrToInt(Item.SubItems.Strings[2]);;
    totalLikesacc := totalLikesacc + totalLikes;

    totalComments := StrToInt(Item.SubItems.Strings[3]);;
    totalCommentsacc := totalCommentsacc + totalComments;
  end;

  totalViewsacc := totalViewsacc + getTotalGroupCounts();

  stat := TStat.Create(Date, totalViewsacc, totalLikesacc, totalCommentsacc);
  globalsRepository.AddGlobals(stat);

  UpdateChart(totalViewsacc, totalLikesacc, totalCommentsacc, repository.photos.Count);
  UpdateGlobals();
  UpdateAnalytics();
end;

function TfrmFlickr.ExistPhotoInList(id: string; var Item: TListItem): Boolean;
var
  i: Integer;
  found: Boolean;
begin
  i := 0;
  found := false;
  while (not found) and (i < listPhotos.Items.Count) do
  begin
    found := listPhotos.Items[i].Caption = id;
    inc(i);
  end;
  if found then
    Item := listPhotos.Items[i - 1];
  Result := found;
end;

procedure TfrmFlickr.RequestInformation_REST_Flickr(id: string);
var
  Item, itemExisting: TListItem;
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4: IXMLNode;
  views, title, likes, comments: string;
  stat: IStat;
  photo, existing: IPhoto;
  IdHTTP: TIdHTTP;
  IdIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  xmlDocument: IXMLDocument;
  timedout: Boolean;
begin
  CoInitialize(nil);
  try
    IdIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdIOHandler.ReadTimeout := IdTimeoutInfinite;
    IdIOHandler.ConnectTimeout := IdTimeoutInfinite;
    xmlDocument := TXMLDocument.Create(nil);
    IdHTTP := TIdHTTP.Create(nil);
    try
      IdHTTP.IOHandler := IdIOHandler;
      timedout := false;
      while (not timedout) do
      begin
        try
          response := IdHTTP.Get(TFlickrRest.New().getInfo(apikey.text, id));
          timedout := true;
        except
          on e: exception do
          begin
            sleep(2000);
            timedout := false;
          end;
        end;

      end;

      // response := IdHTTP1.Get(TFlickrRest.new().getInfo(apikey.text, id));
      xmlDocument.LoadFromXML(response);
      iXMLRootNode := xmlDocument.ChildNodes.first; // <xml>
      iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
      iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photo>
      views := iXMLRootNode3.attributes['views'];
      iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <owner>
      while iXMLRootNode4 <> nil do
      begin
        if iXMLRootNode4.NodeName = 'title' then
          title := iXMLRootNode4.NodeValue;
        if iXMLRootNode4.NodeName = 'comments' then
          comments := iXMLRootNode4.NodeValue;
        iXMLRootNode4 := iXMLRootNode4.NextSibling;
      end;
    finally
      IdIOHandler.Free;
      IdHTTP.Free;
      xmlDocument := nil;
    end;

    IdIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdIOHandler.ReadTimeout := IdTimeoutInfinite;
    IdIOHandler.ConnectTimeout := IdTimeoutInfinite;
    xmlDocument := TXMLDocument.Create(nil);
    IdHTTP := TIdHTTP.Create(nil);
    try
      IdHTTP.IOHandler := IdIOHandler;
      timedout := false;
      while (not timedout) do
      begin
        try
          response := IdHTTP.Get(TFlickrRest.New().getFavorites(apikey.text, id));
          timedout := true;
        except
          on e: exception do
          begin
            sleep(2000);
            timedout := false;
          end;
        end;
      end;
      // response := IdHTTP1.Get(TFlickrRest.new().getFavorites(apikey.text, id));
      xmlDocument.LoadFromXML(response);
      iXMLRootNode := xmlDocument.ChildNodes.first; // <xml>
      iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
      iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photo>
      likes := iXMLRootNode3.attributes['total'];
    finally
      IdIOHandler.Free;
      IdHTTP.Free;
      xmlDocument := nil;
    end;

    photo := TPhoto.Create(id, title);
    stat := TStat.Create(Date, StrToInt(views), StrToInt(likes), StrToInt(comments));

    if repository.ExistPhoto(photo, existing) then
    begin
      photo := existing;
      photo.AddStats(stat);
      photo.LastUpdate := Date;
    end
    else
    begin
      photo.AddStats(stat);
      photo.LastUpdate := Date;
      repository.AddPhoto(photo);
    end;

    if not ExistPhotoInList(id, itemExisting) then
    begin
      // synchronize(
      // procedure
      // begin
      Item := frmFlickr.listPhotos.Items.Add;
      Item.Caption := frmFlickr.photoId.text;
      Item.SubItems.Add(title);
      Item.SubItems.Add(views);
      Item.SubItems.Add(likes);
      Item.SubItems.Add(comments);
      Item.SubItems.Add(DateToStr(Date));
      if views = '0' then
        views := '1';
      Item.SubItems.Add(FormatFloat('0.##%', (likes.ToInteger / views.ToInteger) * 100.0));
      // end);
    end
    else
    begin
      itemExisting.Caption := id;
      itemExisting.SubItems.Clear;
      itemExisting.SubItems.Add(title);
      itemExisting.SubItems.Add(views);
      itemExisting.SubItems.Add(likes);
      itemExisting.SubItems.Add(comments);
      itemExisting.SubItems.Add(DateToStr(Date));
      if views = '0' then
        views := '1';
      itemExisting.SubItems.Add(FormatFloat('0.##%', (likes.ToInteger / views.ToInteger) * 100.0));
    end;
  finally
    CoUninitialize;
  end;
end;

procedure TfrmFlickr.btnAddClick(Sender: TObject);
begin
  if apikey.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;

  RequestInformation_REST_Flickr(photoId.text);
  photoId.text := '';
  UpdateTotals();
  btnSave.Enabled := true;
end;

procedure TfrmFlickr.btnLoadClick(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(repository) then
  begin
    repository := nil;
    repository := TFlickrRepository.Create();
  end;
  repository.load('flickrRepository.xml');

  if Assigned(globalsRepository) then
  begin
    globalsRepository := nil;
    globalsRepository := TFlickrGlobals.Create();
  end;
  globalsRepository.load('flickrRepositoryGlobal.xml');

  LoadForms(repository);

  LoadHallOfFame(repository);

  if Assigned(flickrProfiles) then
  begin
    flickrProfiles := nil;
    flickrProfiles := TProfiles.Create();
  end;
  flickrProfiles.load('flickrProfiles.xml');
  for i := 0 to flickrProfiles.list.Count - 1 do
  begin
    ComboBox1.AddItem(flickrProfiles.list[i].Name, nil);
  end;
end;

procedure TfrmFlickr.LoadHallOfFame(repository: IFlickrRepository);
var
  topStats: TTopStats;
  maxValues: string;
begin
  topStats := TTopStats.Create(repository);
  Memo1.Lines.Clear;
  Memo1.Lines.Add('************************************');
  Memo1.Lines.Add('************ HALL OF FAME **********');
  Memo1.Lines.Add('************************************');

  maxValues := edtMax.text;
  Memo1.Lines.Add(topStats.GetTopXNumberOfViews(maxValues.ToInteger()));
  Memo1.Lines.Add(topStats.GetTopXNumberOfLikes(maxValues.ToInteger()));
  Memo1.Lines.Add(topStats.GetTopXNumberOfComments(maxValues.ToInteger()));
  topStats.Free;
end;

procedure TfrmFlickr.LoadForms(repository: IFlickrRepository);
begin
  apikey.text := repository.apikey;
  secret.text := repository.secret;
  edtUserId.text := repository.UserId;
  listPhotos.Clear;
  UpdateCounts();
end;

procedure TfrmFlickr.UpdateCounts();
var
  i: Integer;
  Item: TListItem;
  totalViews, totalViewsacc: Integer;
  totalLikes, totalLikesacc: Integer;
  totalComments, totalCommentsacc: Integer;
begin
  totalViewsacc := 0;
  totalLikesacc := 0;
  totalCommentsacc := 0;
  for i := 0 to repository.photos.Count - 1 do
  begin
    Item := listPhotos.Items.Add;
    Item.Caption := repository.photos[i].id;
    Item.SubItems.Add(repository.photos[i].title);
    totalViews := repository.photos[i].getTotalViews;
    totalViewsacc := totalViewsacc + totalViews;
    Item.SubItems.Add(IntToStr(totalViews));
    totalLikes := repository.photos[i].getTotalLikes;
    totalLikesacc := totalLikesacc + totalLikes;
    Item.SubItems.Add(IntToStr(totalLikes));
    totalComments := repository.photos[i].getTotalComments;
    totalCommentsacc := totalCommentsacc + totalComments;
    Item.SubItems.Add(IntToStr(totalComments));
    Item.SubItems.Add(DateToStr(repository.photos[i].LastUpdate));
    if totalViews = 0 then
      totalViews := 1;
    Item.SubItems.Add(FormatFloat('0.##%', (totalLikes / totalViews) * 100.0));
  end;

  UpdateChart(totalViewsacc, totalLikesacc, totalCommentsacc, repository.photos.Count);
  UpdateGlobals();
  UpdateAnalytics();
end;

procedure TfrmFlickr.UpdateGlobals;
var
  Series: TLineSeries;
  color: TColor;
  i: Integer;
begin
  if ChartViews.SeriesList.Count = 1 then
    ChartViews.RemoveAllSeries;

  Series := TLineSeries.Create(ChartViews);
  Series.Marks.Arrow.Visible := true;
  Series.Marks.Callout.Brush.color := clBlack;
  Series.Marks.Callout.Arrow.Visible := true;
  Series.Marks.DrawEvery := 10;
  Series.Marks.Shadow.color := 8487297;
  Series.Marks.Visible := true;
  Series.SeriesColor := 10708548;
  Series.LinePen.Width := 1;
  Series.LinePen.color := 10708548;
  Series.Pointer.InflateMargins := true;
  Series.Pointer.Style := psRectangle;
  Series.Pointer.Brush.Gradient.EndColor := 10708548;
  Series.Pointer.Gradient.EndColor := 10708548;
  Series.Pointer.InflateMargins := true;
  Series.Pointer.Visible := false;
  Series.XValues.DateTime := true;
  Series.XValues.Name := 'X';
  Series.XValues.Order := loAscending;
  Series.YValues.Name := 'Y';
  Series.YValues.Order := loNone;
  Series.ParentChart := ChartViews;
  color := RGB(Random(255), Random(255), Random(255));

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    Series.AddXY(globalsRepository.globals[i].Date, globalsRepository.globals[i].views, '', color);
  end;
  ChartViews.AddSeries(Series);

  Label12.Visible := true;
  Label13.Visible := true;
  Label14.Visible := true;
  Label15.Visible := true;
  Label16.Visible := true;
  Label17.Visible := true;
  Label18.Visible := true;

  Label16.Caption :=  InttoStr(globalsRepository.globals[globalsRepository.globals.Count-2].views-globalsRepository.globals[globalsRepository.globals.Count-3].views);
  Label17.Caption :=  InttoStr(globalsRepository.globals[globalsRepository.globals.Count-1].views-globalsRepository.globals[globalsRepository.globals.Count-2].views);
  Label18.Caption :=  InttoStr(globalsRepository.globals[globalsRepository.globals.Count-1].views);

  if ChartLikes.SeriesList.Count = 1 then
    ChartLikes.RemoveAllSeries;

  Series := TLineSeries.Create(ChartLikes);
  Series.Marks.Arrow.Visible := true;
  Series.Marks.Callout.Brush.color := clBlack;
  Series.Marks.Callout.Arrow.Visible := true;
  Series.Marks.DrawEvery := 10;
  Series.Marks.Shadow.color := 8487297;
  Series.Marks.Visible := true;
  Series.SeriesColor := 10708548;
  Series.LinePen.Width := 1;
  Series.LinePen.color := 10708548;
  Series.Pointer.InflateMargins := true;
  Series.Pointer.Style := psRectangle;
  Series.Pointer.Brush.Gradient.EndColor := 10708548;
  Series.Pointer.Gradient.EndColor := 10708548;
  Series.Pointer.InflateMargins := true;
  Series.Pointer.Visible := false;
  Series.XValues.DateTime := true;
  Series.XValues.Name := 'X';
  Series.XValues.Order := loAscending;
  Series.YValues.Name := 'Y';
  Series.YValues.Order := loNone;
  Series.ParentChart := ChartLikes;
  color := RGB(Random(255), Random(255), Random(255));

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    Series.AddXY(globalsRepository.globals[i].Date, globalsRepository.globals[i].likes, '', color);
  end;
  ChartLikes.AddSeries(Series);

  if ChartComments.SeriesList.Count = 1 then
    ChartComments.RemoveAllSeries;

  Series := TLineSeries.Create(ChartComments);
  Series.Marks.Arrow.Visible := true;
  Series.Marks.Callout.Brush.color := clBlack;
  Series.Marks.Callout.Arrow.Visible := true;
  Series.Marks.DrawEvery := 10;
  Series.Marks.Shadow.color := 8487297;
  Series.Marks.Visible := true;
  Series.SeriesColor := 10708548;
  Series.LinePen.Width := 1;
  Series.LinePen.color := 10708548;
  Series.Pointer.InflateMargins := true;
  Series.Pointer.Style := psRectangle;
  Series.Pointer.Brush.Gradient.EndColor := 10708548;
  Series.Pointer.Gradient.EndColor := 10708548;
  Series.Pointer.InflateMargins := true;
  Series.Pointer.Visible := false;
  Series.XValues.DateTime := true;
  Series.XValues.Name := 'X';
  Series.XValues.Order := loAscending;
  Series.YValues.Name := 'Y';
  Series.YValues.Order := loNone;
  Series.ParentChart := ChartComments;
  color := RGB(Random(255), Random(255), Random(255));

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    Series.AddXY(globalsRepository.globals[i].Date, globalsRepository.globals[i].numComments, '', color);
  end;
  ChartComments.AddSeries(Series);
end;

procedure TfrmFlickr.UpdateAnalytics;
var
  Series: TBarSeries;
  color: TColor;
  i: Integer;
  theDate: TDateTime;
  views, viewsTotal, average: Integer;
  averageSeries, averageLikes: TLineSeries;
begin
  if dailyViews.SeriesList.Count >= 1 then
    dailyViews.RemoveAllSeries;

  Series := TBarSeries.Create(dailyViews);
  Series.Marks.Arrow.Visible := true;
  Series.Marks.Callout.Brush.color := clBlack;
  Series.Marks.Callout.Arrow.Visible := true;
  Series.Marks.DrawEvery := 10;
  Series.Marks.Shadow.color := 8487297;
  Series.SeriesColor := 10708548;
  Series.XValues.DateTime := true;
  Series.XValues.Name := 'X';
  Series.XValues.Order := loAscending;
  Series.YValues.Name := 'Y';
  Series.YValues.Order := loNone;
  Series.ParentChart := Chart2;
  color := RGB(Random(255), Random(255), Random(255));

  for i := 1 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    views := globalsRepository.globals[i].views - globalsRepository.globals[i - 1].views;
    Series.AddXY(theDate, views, '', color);
  end;

  dailyViews.AddSeries(Series);

  // Add average views
  averageSeries := TLineSeries.Create(dailyViews);
  // averageSeries.Marks.Arrow.Visible := true;
  averageSeries.Marks.Callout.Brush.color := clBlack;
  averageSeries.Marks.Callout.Arrow.Visible := true;
  averageSeries.Marks.DrawEvery := 10;
  averageSeries.Marks.Shadow.color := 8487297;
  averageSeries.Marks.Visible := true;
  averageSeries.SeriesColor := 10708548;
  averageSeries.LinePen.Width := 1;
  averageSeries.LinePen.color := 10708548;
  averageSeries.Pointer.InflateMargins := true;
  averageSeries.Pointer.Style := psRectangle;
  averageSeries.Pointer.Brush.Gradient.EndColor := 10708548;
  averageSeries.Pointer.Gradient.EndColor := 10708548;
  averageSeries.Pointer.InflateMargins := true;
  averageSeries.Pointer.Visible := false;
  averageSeries.XValues.DateTime := true;
  averageSeries.XValues.Name := 'X';
  averageSeries.XValues.Order := loAscending;
  averageSeries.YValues.Name := 'Y';
  averageSeries.YValues.Order := loNone;
  averageSeries.ParentChart := ChartComments;
  color := clRed;

  viewsTotal := 0;
  for i := 1 to globalsRepository.globals.Count - 1 do
  begin
    // theDate := globalsRepository.globals[i].Date;
    viewsTotal := viewsTotal + (globalsRepository.globals[i].views - globalsRepository.globals[i - 1].views);
  end;

  average := round(viewsTotal / globalsRepository.globals.Count);

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    averageSeries.AddXY(theDate, average, '', color);
  end;

  dailyViews.AddSeries(averageSeries);

  /// //Likes

  if dailyLikes.SeriesList.Count >= 1 then
    dailyLikes.RemoveAllSeries;

  Series := TBarSeries.Create(dailyLikes);
  Series.Marks.Arrow.Visible := true;
  Series.Marks.Callout.Brush.color := clBlack;
  Series.Marks.Callout.Arrow.Visible := true;
  Series.Marks.DrawEvery := 10;
  Series.Marks.Shadow.color := 8487297;
  Series.SeriesColor := 10708548;
  Series.XValues.DateTime := true;
  Series.XValues.Name := 'X';
  Series.XValues.Order := loAscending;
  Series.YValues.Name := 'Y';
  Series.YValues.Order := loNone;
  Series.ParentChart := Chart2;
  color := RGB(Random(255), Random(255), Random(255));

  for i := 1 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    views := globalsRepository.globals[i].likes - globalsRepository.globals[i - 1].likes;
    Series.AddXY(theDate, views, '', color);
  end;

  dailyLikes.AddSeries(Series);

  // Add average views
  averageLikes := TLineSeries.Create(dailyLikes);
  // averageLikes.Marks.Arrow.Visible := true;
  averageLikes.Marks.Callout.Brush.color := clBlack;
  averageLikes.Marks.Callout.Arrow.Visible := true;
  averageLikes.Marks.DrawEvery := 10;
  averageLikes.Marks.Shadow.color := 8487297;
  averageLikes.Marks.Visible := true;
  averageLikes.SeriesColor := 10708548;
  averageLikes.LinePen.Width := 1;
  averageLikes.LinePen.color := 10708548;
  averageLikes.Pointer.InflateMargins := true;
  averageLikes.Pointer.Style := psRectangle;
  averageLikes.Pointer.Brush.Gradient.EndColor := 10708548;
  averageLikes.Pointer.Gradient.EndColor := 10708548;
  averageLikes.Pointer.InflateMargins := true;
  averageLikes.Pointer.Visible := false;
  averageLikes.XValues.DateTime := true;
  averageLikes.XValues.Name := 'X';
  averageLikes.XValues.Order := loAscending;
  averageLikes.YValues.Name := 'Y';
  averageLikes.YValues.Order := loNone;
  averageLikes.ParentChart := ChartComments;
  color := clRed;

  viewsTotal := 0;
  for i := 1 to globalsRepository.globals.Count - 1 do
  begin
    // theDate := globalsRepository.globals[i].Date;
    viewsTotal := viewsTotal + (globalsRepository.globals[i].likes - globalsRepository.globals[i - 1].likes);
  end;

  average := round(viewsTotal / globalsRepository.globals.Count);

  for i := 0 to globalsRepository.globals.Count - 1 do
  begin
    theDate := globalsRepository.globals[i].Date;
    averageLikes.AddXY(theDate, average, '', color);
  end;

  dailyLikes.AddSeries(averageLikes);

end;

procedure TfrmFlickr.UpdateSingleStats(id: string);
var
  Series: TBarSeries;
  color: TColor;
  i: Integer;
  theDate: TDateTime;
  views: Integer;
  photo: IPhoto;
begin
  Series := TBarSeries.Create(statsDay);
  Series.Marks.Arrow.Visible := true;
  Series.Marks.Callout.Brush.color := clBlack;
  Series.Marks.Callout.Arrow.Visible := true;
  Series.Marks.DrawEvery := 10;
  Series.title := id;
  Series.Marks.Shadow.color := 8487297;
  Series.SeriesColor := 10708548;
  Series.XValues.DateTime := true;
  Series.XValues.Name := 'X';
  Series.XValues.Order := loAscending;
  Series.YValues.Name := 'Y';
  Series.YValues.Order := loNone;
  Series.ParentChart := Chart2;
  color := RGB(Random(255), Random(255), Random(255));

  photo := repository.GetPhoto(id);

  for i := 1 to photo.stats.Count - 1 do
  begin
    theDate := photo.stats[i].Date;
    if rbViews.Checked then
    begin
      views := photo.stats[i].views - photo.stats[i - 1].views;
      Series.AddXY(theDate, views, '', color);
    end;
    if rbLikes.Checked then
    begin
      views := photo.stats[i].likes - photo.stats[i - 1].likes;
      Series.AddXY(theDate, views, '', color);
    end;
    if rbComments.Checked then
    begin
      views := photo.stats[i].numComments - photo.stats[i - 1].numComments;
      Series.AddXY(theDate, views, '', color);
    end;
  end;

  statsDay.AddSeries(Series);
end;

procedure TfrmFlickr.UpdateChart(totalViews, totalLikes, totalComments, totalPhotos: Integer);
var
  Series: TBarSeries;
  color: TColor;
begin
  if Chart2.SeriesList.Count = 1 then
    Chart2.RemoveAllSeries;

  Series := TBarSeries.Create(Chart2);
  Series.Marks.Arrow.Visible := true;
  Series.Marks.Callout.Brush.color := clBlack;
  Series.Marks.Callout.Arrow.Visible := true;
  Series.Marks.DrawEvery := 10;
  Series.Marks.Shadow.color := 8487297;
  // Series.Marks.Visible := true;
  Series.SeriesColor := 10708548;
  // Series.Stairs := true;
  Series.XValues.DateTime := true;
  Series.XValues.Name := 'X';
  Series.XValues.Order := loAscending;
  Series.YValues.Name := 'Y';
  Series.YValues.Order := loNone;
  Series.ParentChart := Chart2;
  color := RGB(Random(255), Random(255), Random(255));

  Series.AddBar(totalViews, 'Views', color);
  Series.AddBar(totalLikes, 'Likes', color);
  Series.AddBar(totalComments, 'Comments', color);
  Series.AddBar(totalPhotos, 'Photos', color);
  Chart2.AddSeries(Series);
end;

procedure TfrmFlickr.btnSaveClick(Sender: TObject);
begin
  repository.save(apikey.text, secret.text, edtUserId.text, 'flickrRepository.xml');
  globalsRepository.save('flickrRepositoryGlobal.xml');
  btnSave.Enabled := false;
end;

procedure TfrmFlickr.Button1Click(Sender: TObject);
var
  urlGroups: string;
  response: string;
begin
  urlGroups := TFlickrRest.New().getTestLogin(apikey.text, userToken, secret.text, userTokenSecret);
  response := IdHTTP1.Get(urlGroups);
  showmessage(response);
end;

procedure TfrmFlickr.Button2Click(Sender: TObject);
begin
  if SaveToExcelGroups(listGroups, 'Flickr Analytics', ExtractFilePath(ParamStr(0)) + 'FlickrAnalyticsGroups.xls') then
    showmessage('Data saved successfully!');
end;

procedure TfrmFlickr.Button3Click(Sender: TObject);
begin
  WebBrowser1.Navigate(Edit1.text);
end;

procedure TfrmFlickr.Button4Click(Sender: TObject);
begin
  WebBrowser1.Navigate(NavigationUrl);
end;

procedure TfrmFlickr.Button5Click(Sender: TObject);
var
	flags: OleVariant;
begin
	if not WebBrowser1.Busy then
	begin
		flags := REFRESH_COMPLETELY;
		WebBrowser1.Refresh2(flags);
	end;
end;

procedure TfrmFlickr.btnFilterCancelClick(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
begin
  pagecontrol2.TabIndex := 0;
  listGroups.Visible := false;
  listGroups.Items.Clear;

  for i := 0 to FilteredGroupList.list.Count - 1 do
  begin
    Item := listGroups.Items.Add;
    Item.Caption := FilteredGroupList.list[i].id;
    Item.SubItems.Add(FilteredGroupList.list[i].title);
  end;
  listGroups.Visible := true;
  Label11.Caption := 'Number of items: ' + InttoStr(listgroups.Items.Count-1);
end;

procedure TfrmFlickr.btnFilterOKClick(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
  description: string;
begin
  pagecontrol2.TabIndex := 0;
  listGroups.Visible := false;
  listGroups.Items.Clear;

  description := edtFilterGroup.text;
  for i := 0 to FilteredGroupList.list.Count - 1 do
  begin
    if FilteredGroupList.list[i].title.ToUpper.Contains(description.ToUpper) then
    begin
      Item := listGroups.Items.Add;
      Item.Caption := FilteredGroupList.list[i].id;
      Item.SubItems.Add(FilteredGroupList.list[i].title);
    end;
  end;
  listGroups.Visible := true;
  Label11.Caption := 'Number of items: ' + InttoStr(listgroups.Items.Count-1);
end;

procedure TfrmFlickr.btnAddPhotosClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
  k: Integer;
  photoId: string;
  groupId: string;
  urlAdd, response: string;
  photos: TList<string>;
  groups: TList<string>;
  timedout: Boolean;
  rejected: IRejected;
begin
  photos := TList<string>.Create;
  groups := TList<string>.Create;

  try
    PageControl2.ActivePage := tabStatus;
    for i := 0 to listPhotos.Items.Count - 1 do
    begin
      if listPhotos.Items[i].Checked then
        photos.Add(listPhotos.Items[i].Caption);
    end;
    for i := 0 to listGroups.Items.Count - 1 do
    begin
      if listGroups.Items[i].Checked then
        groups.Add(listGroups.Items[i].Caption);
    end;

    rejected := TRejected.Create;
    // add photos to the groups
    pstatus.Max := (photos.Count * groups.Count);
    pstatus.Min := 0;
    k := 0;

    for i := 0 to photos.Count - 1 do
    begin
      for j := 0 to groups.Count - 1 do
      begin
        photoId := photos[i];
        groupId := groups[j];
        timedout := false;
        if not rejected.Exists(groupId) then
        begin
          urlAdd := TFlickrRest.New().getPoolsAdd(apikey.text, userToken, secret.text, userTokenSecret, photoId, groupId);
          while (not timedout) do
          begin
            try
              response := IdHTTP1.Get(urlAdd);
              if response.Contains('Photo limit reached') then
                rejected.Add(groupId);
              timedout := true;
            except
              on e: exception do
              begin
                sleep(2000);
                timedout := false;
              end;
            end;
          end;
        end;
        inc(k);
        pstatus.position := k;
        response := response.Replace('<?xml version="1.0" encoding="utf-8" ?>', '');
        response := response.Replace('<rsp stat="', '');
        response := response.Replace('">', '');
        response := response.Replace('</rsp>', '');
        mStatus.Lines.Add('PhotoId: ' + photoId + ' GroupId: ' + groupId + ' response: ' + response);
        Application.ProcessMessages;
        sleep(10);
      end;
    end;
  finally
    photos.Free;
    groups.Free;
  end;
end;

procedure TfrmFlickr.btnLoadProfileClick(Sender: TObject);
var
  profileName: string;
  profile: IProfile;
  i: Integer;
  j: Integer;
  Item: TListItem;
begin
  try
    pagecontrol2.TabIndex := 0;
    profileName := ComboBox1.Items[ComboBox1.ItemIndex];
    // Now look for this profileName in the Main Object.
    profile := flickrProfiles.getProfile(profileName);

    if chkDisplayOnly.Checked then
    begin
      listGroups.Visible := false;
      listGroups.Items.Clear;
      edtProfile.text := profileName;
      for i := 0 to FilteredGroupList.list.Count - 1 do
      begin
        for j := 0 to profile.groupId.Count - 1 do
        begin
          if FilteredGroupList.list[i].id = (profile.groupId[j]) then
          begin
            Item := listGroups.Items.Add;
            Item.Caption := FilteredGroupList.list[i].id;
            Item.SubItems.Add(FilteredGroupList.list[i].title);
            Item.checked := true;
          end;
        end;
      end;
      listGroups.Visible := true;
    end
    else
    begin
      if profile <> nil then
      begin
        edtProfile.text := profileName;
        for i := 0 to profile.groupId.Count - 1 do
          for j := 0 to listGroups.Items.Count - 1 do
          begin
            if profile.groupId[i] = listGroups.Items[j].Caption then
            begin
              listGroups.Items[j].Checked := true;
            end;
          end;
      end;
    end;
  finally
    Label11.Caption := 'Number of items: ' + InttoStr(listgroups.Items.Count-1);
  end;
end;

procedure TfrmFlickr.btnSaveProfileClick(Sender: TObject);
var
  profile: IProfile;
  i: Integer;
begin
  if edtProfile.text = '' then
  begin
    showmessage('profile name can''t be empty');
    exit;
  end;

  // Give me the profile
  profile := flickrProfiles.getProfile(edtProfile.text);

  if profile = nil then
  begin
    // New Profile
    profile := TProfile.Create;
    profile.Name := edtProfile.text;
    for i := 0 to listGroups.Items.Count - 1 do
    begin
      if listGroups.Items[i].Checked then
      begin
        profile.AddId(listGroups.Items[i].Caption);
      end;
    end;
    flickrProfiles.Add(profile);
  end
  else
  begin
    if chkReplaceProfile.Checked then
    begin
      flickrProfiles.list.Remove(profile);
      profile := nil;

      // New Profile
      profile := TProfile.Create;
      profile.Name := edtProfile.text;
      for i := 0 to listGroups.Items.Count - 1 do
      begin
        if listGroups.Items[i].Checked then
        begin
          profile.AddId(listGroups.Items[i].Caption);
        end;
      end;
      flickrProfiles.Add(profile);
    end
    else
    begin
      for i := 0 to listGroups.Items.Count - 1 do
      begin
        if listGroups.Items[i].Checked then
        begin
          profile.AddId(listGroups.Items[i].Caption);
        end;
      end;
    end;
  end;
  flickrProfiles.save('flickrProfiles.xml');
end;

procedure TfrmFlickr.Button8Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to listGroups.Items.Count - 1 do
  begin
    listGroups.Items[i].Checked := false;
  end;
end;

procedure TfrmFlickr.CheckBox1Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to listGroups.Items.Count - 1 do
  begin
    listGroups.Items[i].Checked := CheckBox1.Checked;
  end;
end;

procedure TfrmFlickr.CheckBox2Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to listPhotos.Items.Count - 1 do
  begin
    listPhotos.Items[i].Checked := CheckBox2.Checked;
  end;
end;

procedure TfrmFlickr.ComboBox1Change(Sender: TObject);
begin
  btnLoadProfile.Enabled := true;
  edtProfile.Enabled := true;
  btnSaveProfile.Enabled := true;
end;

// returns MD5 has for a file
// function TfrmFlickr.MD5(apikey: string; secret: string): string;
// var
// idmd5: TIdHashMessageDigest5;
// begin
// idmd5 := TIdHashMessageDigest5.Create;
// try
// Result := idmd5.HashStringAsHex(secret + 'api_key' + apikey + 'permswrite',
// IndyTextEncoding_OSDefault());
// finally
// idmd5.Free;
// end;
// end;

procedure TfrmFlickr.btnGetGroupsClick(Sender: TObject);
var
  Item: TListItem;
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4: IXMLNode;
  pages, title, id, ismember, total, totalitems: string;
  numPages: Integer;
  urlGroups: string;
  i: Integer;
  timedout: Boolean;
begin
  if (apikey.text = '') or (userToken = '') then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  if (edtUserId.text = '') or (userTokenSecret = '') then
  begin
    showmessage('User ID key can''t be empty');
    exit;
  end;
  if Assigned(FilteredGroupList) then
  begin
    FilteredGroupList := nil;
    FilteredGroupList := TFilteredList.Create();
  end;
  pagecontrol2.TabIndex := 0;
  btnLoad.Enabled := false;
  btnAdd.Enabled := false;
  btnAddItems.Enabled := false;
  batchUpdate.Enabled := false;
  listGroups.Visible := false;
  progressfetchinggroups.Visible := true;
  Application.ProcessMessages;
  urlGroups := TFlickrRest.New().getGroups(apikey.text, '1', '500', userToken, secret.text, userTokenSecret);
  timedout := false;
  while (not timedout) do
  begin
    try
      response := IdHTTP1.Get(urlGroups);
      timedout := true;
    except
      on e: exception do
      begin
        sleep(2000);
        timedout := false;
      end;
    end;
  end;
  XMLDocument1.LoadFromXML(response);
  iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
  iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
  iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <groups>
  pages := iXMLRootNode3.attributes['page'];
  total := iXMLRootNode3.attributes['pages'];
  totalitems := iXMLRootNode3.attributes['total'];
  iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <group>
  listGroups.Clear;
  // numTotal := total.ToInteger();
  progressfetchinggroups.Max := totalitems.ToInteger();
  Taskbar1.ProgressState := TTaskBarProgressState.Normal;
  Taskbar1.ProgressMaxValue := totalitems.ToInteger();
  progressfetchinggroups.position := 0;
  while iXMLRootNode4 <> nil do
  begin
    if iXMLRootNode4.NodeName = 'group' then
    begin
      id := iXMLRootNode4.attributes['id'];
      ismember := iXMLRootNode4.attributes['member'];
      title := iXMLRootNode4.attributes['name'];
      if ismember = '1' then
        FilteredGroupList.Add(TBase.New(id, title));
    end;
    progressfetchinggroups.position := progressfetchinggroups.position + 1;
    Taskbar1.ProgressValue := progressfetchinggroups.position;
    Application.ProcessMessages;
    iXMLRootNode4 := iXMLRootNode4.NextSibling;
  end;

  // Load the remaining pages
  numPages := total.ToInteger;
  for i := 2 to numPages do
  begin
    sleep(100);
    urlGroups := TFlickrRest.New().getGroups(apikey.text, i.ToString, '500', userToken, secret.text, userTokenSecret);
    timedout := false;
    while (not timedout) do
    begin
      try
        response := IdHTTP1.Get(urlGroups);
        timedout := true;
      except
        on e: exception do
        begin
          sleep(2000);
          timedout := false;
        end;
      end;
    end;
    XMLDocument1.LoadFromXML(response);
    iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
    iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
    iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <groups>
    pages := iXMLRootNode3.attributes['page'];
    iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <group>
    while iXMLRootNode4 <> nil do
    begin
      if iXMLRootNode4.NodeName = 'group' then
      begin
        id := iXMLRootNode4.attributes['id'];
        ismember := iXMLRootNode4.attributes['member'];
        title := iXMLRootNode4.attributes['name'];
        if ismember = '1' then
          FilteredGroupList.Add(TBase.New(id, title));
      end;
      progressfetchinggroups.position := progressfetchinggroups.position + 1;
      Taskbar1.ProgressValue := progressfetchinggroups.position;
      Application.ProcessMessages;
      iXMLRootNode4 := iXMLRootNode4.NextSibling;
    end;
  end;
  // Add items to the listview
  for i := 0 to FilteredGroupList.list.Count - 1 do
  begin
    Item := listGroups.Items.Add;
    Item.Caption := FilteredGroupList.list[i].id;
    Item.SubItems.Add(FilteredGroupList.list[i].title);
  end;
  btnLoad.Enabled := true;
  btnAdd.Enabled := true;
  batchUpdate.Enabled := true;
  btnAddPhotos.Enabled := true;
  btnAddItems.Enabled := true;
  progressfetchinggroups.Visible := false;
  Taskbar1.ProgressValue := 0;
  listGroups.Visible := true;
end;

function TfrmFlickr.getTotalGroupCounts(): Integer;
var
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4, iXMLRootNode5: IXMLNode;
  pages, total: string;
  numPages, numTotal: Integer;
  i: Integer;
  totalViews: Integer;
  photosetId: string;
  title: string;
  countViews: Integer;
  numPhotos: Integer;
begin
  btnLoad.Enabled := false;
  btnAdd.Enabled := false;
  btnAddItems.Enabled := false;
  batchUpdate.Enabled := false;
  listPhotosUser.Visible := false;
  lblfetching.Visible := true;
  progressfetching.Visible := true;
  listAlbums.Clear;
  Application.ProcessMessages;
  response := IdHTTP1.Get(TFlickrRest.New().getPhotoSets(apikey.text, edtUserId.text, '1', '500'));
  XMLDocument1.LoadFromXML(response);
  iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
  iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
  iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photosets>
  pages := iXMLRootNode3.attributes['pages'];
  total := iXMLRootNode3.attributes['total'];
  iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photoset>
  numTotal := total.ToInteger();
  progressfetching.Max := numTotal;
  Taskbar1.ProgressState := TTaskBarProgressState.Normal;
  Taskbar1.ProgressMaxValue := numTotal;
  progressfetching.position := 0;
  totalViews := 0;
  while iXMLRootNode4 <> nil do
  begin
    if iXMLRootNode4.NodeName = 'photoset' then
    begin
      photosetId := iXMLRootNode4.attributes['id'];
      numPhotos := iXMLRootNode4.attributes['photos'];
      countViews := iXMLRootNode4.attributes['count_views'];
      iXMLRootNode5 := iXMLRootNode4.ChildNodes.first;
      title := iXMLRootNode5.text;
      totalViews := totalViews + countViews;
    end;
    progressfetching.position := progressfetching.position + 1;
    listAlbums.Lines.Add('Id: ' + photosetId + ' title: ' + title + ' Photos: ' + numPhotos.ToString() + ' Views: ' + countViews.ToString());
    Taskbar1.ProgressValue := progressfetching.position;
    Application.ProcessMessages;
    iXMLRootNode4 := iXMLRootNode4.NextSibling;
  end;

  // Load the remaining pages
  numPages := pages.ToInteger;
  for i := 2 to numPages do
  begin
    response := IdHTTP1.Get(TFlickrRest.New().getPhotoSets(apikey.text, edtUserId.text, i.ToString, '500'));
    XMLDocument1.LoadFromXML(response);
    iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
    iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
    iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photosets>
    pages := iXMLRootNode3.attributes['pages'];
    iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photoset>
    while iXMLRootNode4 <> nil do
    begin
      if iXMLRootNode4.NodeName = 'photoset' then
      begin
        photosetId := iXMLRootNode4.attributes['id'];
        numPhotos := iXMLRootNode4.attributes['photos'];
        countViews := iXMLRootNode4.attributes['count_views'];
        iXMLRootNode5 := iXMLRootNode4.ChildNodes.first;
        title := iXMLRootNode5.text;
        totalViews := totalViews + countViews;
      end;
      progressfetching.position := progressfetching.position + 1;
      listAlbums.Lines.Add('Id: ' + photosetId + ' title: ' + title + ' Photos: ' + numPhotos.ToString() + ' Views: ' + countViews.ToString());
      Taskbar1.ProgressValue := progressfetching.position;
      Application.ProcessMessages;
      iXMLRootNode4 := iXMLRootNode4.NextSibling;
    end;
  end;
  btnLoad.Enabled := true;
  btnAdd.Enabled := true;
  batchUpdate.Enabled := true;
  btnAddItems.Enabled := true;
  lblfetching.Visible := false;
  progressfetching.Visible := false;
  Taskbar1.ProgressValue := 0;
  listPhotosUser.Visible := true;
  Result := totalViews;
end;

procedure TfrmFlickr.btnGetListClick(Sender: TObject);
var
  Item: TListItem;
  response: string;
  iXMLRootNode, iXMLRootNode2, iXMLRootNode3, iXMLRootNode4: IXMLNode;
  pages, title, id, ispublic, total: string;
  numPages, numTotal: Integer;
  i: Integer;
begin
  if apikey.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  if edtUserId.text = '' then
  begin
    showmessage('Api key can''t be empty');
    exit;
  end;
  btnLoad.Enabled := false;
  btnAdd.Enabled := false;
  btnAddItems.Enabled := false;
  batchUpdate.Enabled := false;
  listPhotosUser.Visible := false;
  lblfetching.Visible := true;
  progressfetching.Visible := true;
  Application.ProcessMessages;
  response := IdHTTP1.Get(TFlickrRest.New().getPhotos(apikey.text, edtUserId.text, '1', '500'));
  XMLDocument1.LoadFromXML(response);
  iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
  iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
  iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photos>
  pages := iXMLRootNode3.attributes['pages'];
  total := iXMLRootNode3.attributes['total'];
  iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photo>
  listPhotosUser.Clear;
  numTotal := total.ToInteger();
  progressfetching.Max := numTotal;
  Taskbar1.ProgressState := TTaskBarProgressState.Normal;
  Taskbar1.ProgressMaxValue := numTotal;
  progressfetching.position := 0;
  while iXMLRootNode4 <> nil do
  begin
    if iXMLRootNode4.NodeName = 'photo' then
    begin
      id := iXMLRootNode4.attributes['id'];
      ispublic := iXMLRootNode4.attributes['ispublic'];
      title := iXMLRootNode4.attributes['title'];
      if ispublic = '1' then
      begin
        Item := listPhotosUser.Items.Add;
        Item.Caption := id;
        Item.SubItems.Add(title);
      end;
    end;
    progressfetching.position := progressfetching.position + 1;
    Taskbar1.ProgressValue := progressfetching.position;
    Application.ProcessMessages;
    iXMLRootNode4 := iXMLRootNode4.NextSibling;
  end;

  // Load the remaining pages
  numPages := pages.ToInteger;
  for i := 2 to numPages do
  begin
    response := IdHTTP1.Get(TFlickrRest.New().getPhotos(apikey.text, edtUserId.text, i.ToString, '500'));
    XMLDocument1.LoadFromXML(response);
    iXMLRootNode := XMLDocument1.ChildNodes.first; // <xml>
    iXMLRootNode2 := iXMLRootNode.NextSibling; // <rsp>
    iXMLRootNode3 := iXMLRootNode2.ChildNodes.first; // <photos>
    pages := iXMLRootNode3.attributes['pages'];
    iXMLRootNode4 := iXMLRootNode3.ChildNodes.first; // <photo>
    while iXMLRootNode4 <> nil do
    begin
      if iXMLRootNode4.NodeName = 'photo' then
      begin
        id := iXMLRootNode4.attributes['id'];
        ispublic := iXMLRootNode4.attributes['ispublic'];
        title := iXMLRootNode4.attributes['title'];
        if ispublic = '1' then
        begin
          Item := listPhotosUser.Items.Add;
          Item.Caption := id;
          Item.SubItems.Add(title);
        end;
      end;
      progressfetching.position := progressfetching.position + 1;
      Taskbar1.ProgressValue := progressfetching.position;
      Application.ProcessMessages;
      iXMLRootNode4 := iXMLRootNode4.NextSibling;
    end;
  end;
  btnLoad.Enabled := true;
  btnAdd.Enabled := true;
  batchUpdate.Enabled := true;
  btnAddItems.Enabled := true;
  lblfetching.Visible := false;
  progressfetching.Visible := false;
  Taskbar1.ProgressValue := 0;
  listPhotosUser.Visible := true;
end;

procedure TfrmFlickr.btnGetTokenClick(Sender: TObject);
var
  response: string;
  oauth_token: string;
  oauth_verifier: string;
  OAccessTokenUrl: string;
  fullname: string;
  oauth_token_secret: string;
  user_nsid: string;
  username: string;
begin
  // 'http://www.example.com/?oauth_token=72157648370759854-32e3740fbaef246b&oauth_verifier=d46f58e4a5780b25'
  response := WebBrowser1.LocationURL;
  Log('response url ' + response);
  response := response.Replace('http://www.example.com/?', '');
  response := response.Replace('oauth_token', '');
  response := response.Replace('oauth_verifier', '');

  // '=72157648370759854-32e3740fbaef246b&=d46f58e4a5780b25'
  oauth_token := AnsiLeftStr(response, AnsiPos('&', response));
  // =72157648370759854-32e3740fbaef246b&
  response := AnsiRightStr(response, length(response) - length(oauth_token));
  // =d46f58e4a5780b25
  oauth_verifier := response;

  // Clean the parameters
  oauth_token := oauth_token.Replace('=', '').Replace('&', '');
  oauth_verifier := oauth_verifier.Replace('=', '').Replace('&', '');
  Log('oauth_token= ' + oauth_token);
  Log('oauth_verifier= ' + oauth_verifier);

  // Now we have the request token
  // we need to exchange it for an Access token
  OAccessTokenUrl := TAccessToken.New(oauth_verifier, apikey.text, oauth_token, secret.text, userTokenSecret).GenerateRequestAccessToken();
  Log('Calling OAuth URL ' + OAccessTokenUrl);
  response := IdHTTP1.Get(OAccessTokenUrl);
  Log('OAuth URL response ' + response);

  // Example response
  // fullname=Jordi%20Corbilla&
  // oauth_token=72157639942921845-e4f73de08dc774e6&
  // oauth_token_secret=3eefb68a488fbb63&
  // user_nsid=96100496%40N05&
  // username=Jordi%20Corbilla%20Photography

  response := response.Replace('fullname', '');
  response := response.Replace('oauth_token', '');
  response := response.Replace('_secret', '');
  response := response.Replace('user_nsid', '');
  response := response.Replace('username', '');

  fullname := AnsiLeftStr(response, AnsiPos('&', response));
  response := AnsiRightStr(response, length(response) - length(fullname));

  oauth_token := AnsiLeftStr(response, AnsiPos('&', response));
  response := AnsiRightStr(response, length(response) - length(oauth_token));

  oauth_token_secret := AnsiLeftStr(response, AnsiPos('&', response));
  response := AnsiRightStr(response, length(response) - length(oauth_token_secret));

  user_nsid := AnsiLeftStr(response, AnsiPos('&', response));
  response := AnsiRightStr(response, length(response) - length(user_nsid));

  username := response;

  fullname := fullname.Replace('=', '').Replace('&', '');
  oauth_token := oauth_token.Replace('=', '').Replace('&', '');
  oauth_token_secret := oauth_token_secret.Replace('=', '').Replace('&', '');
  user_nsid := user_nsid.Replace('=', '').Replace('&', '');
  username := username.Replace('=', '').Replace('&', '');

  Log('fullname= ' + fullname);
  Log('oauth_token= ' + oauth_token);
  Log('oauth_token_secret= ' + oauth_token_secret);
  Log('user_nsid= ' + user_nsid);
  Log('username= ' + username);

  userToken := oauth_token;
  userTokenSecret := oauth_token_secret;
  showmessage('Congratulations, application authenticated with token ' + oauth_token);
end;

procedure TfrmFlickr.btnAddItemsClick(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
begin
  btnAddItems.Enabled := false;
  ProgressBar1.Visible := true;
  photoId.Enabled := false;
  btnAdd.Enabled := false;
  batchUpdate.Enabled := false;
  Process.Visible := true;
  ProgressBar1.Min := 0;
  ProgressBar1.Max := listPhotos.Items.Count;
  for i := 0 to listPhotosUser.Items.Count - 1 do
  begin
    Process.Caption := 'Processing image: ' + listPhotosUser.Items[i].Caption + ' ' + i.ToString + ' out of ' + listPhotosUser.Items.Count.ToString;
    ProgressBar1.position := i;
    Application.ProcessMessages;

    if not ExistPhotoInList(listPhotosUser.Items[i].Caption, Item) then
    begin
      photoId.text := listPhotosUser.Items[i].Caption;
      btnAddClick(Sender);
    end;
  end;
  photoId.text := '';
  ProgressBar1.Visible := false;
  Process.Visible := false;
  UpdateTotals();
  LoadHallOfFame(repository);
  btnSave.Enabled := true;
  batchUpdate.Enabled := true;
  photoId.Enabled := true;
  btnAdd.Enabled := true;
  btnAddItems.Enabled := true;
end;

function TfrmFlickr.SaveToExcel(AView: TListView; ASheetName, AFileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  Row: Integer;
  ExcelOLE, Sheet: OLEVariant;
  i: Integer;
begin
  // Create Excel-OLE Object
  Result := false;
  ExcelOLE := CreateOleObject('Excel.Application');
  try
    // Hide Excel
    ExcelOLE.Visible := false;

    ExcelOLE.Workbooks.Add(xlWBATWorksheet);
    Sheet := ExcelOLE.Workbooks[1].WorkSheets[1];
    Sheet.Name := ASheetName;

    Sheet.Cells[1, 1] := 'Id';
    Sheet.Cells[1, 2] := 'Title';
    Sheet.Cells[1, 3] := 'Views';
    Sheet.Cells[1, 4] := 'Likes';
    Sheet.Cells[1, 5] := 'Comments';
    Sheet.Cells[1, 6] := 'Last Update';
    Sheet.Cells[1, 7] := 'Affection';

    Row := 2;
    for i := 0 to AView.Items.Count - 1 do
    begin
      Sheet.Cells[Row, 1] := AView.Items.Item[i].Caption;
      Sheet.Cells[Row, 2] := AView.Items.Item[i].SubItems[0];
      Sheet.Cells[Row, 3] := AView.Items.Item[i].SubItems[1];
      Sheet.Cells[Row, 4] := AView.Items.Item[i].SubItems[2];
      Sheet.Cells[Row, 5] := AView.Items.Item[i].SubItems[3];
      Sheet.Cells[Row, 6] := AView.Items.Item[i].SubItems[4];
      Sheet.Cells[Row, 7] := AView.Items.Item[i].SubItems[5];
      inc(Row);
    end;

    try
      ExcelOLE.Workbooks[1].SaveAs(AFileName);
      Result := true;
    except

    end;
  finally
    if not VarIsEmpty(ExcelOLE) then
    begin
      ExcelOLE.DisplayAlerts := false;
      ExcelOLE.Quit;
      ExcelOLE := Unassigned;
      Sheet := Unassigned;
    end;
  end;
end;

function TfrmFlickr.SaveToExcelGroups(AView: TListView; ASheetName, AFileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  Row: Integer;
  ExcelOLE, Sheet: OLEVariant;
  i: Integer;
begin
  // Create Excel-OLE Object
  Result := false;
  ExcelOLE := CreateOleObject('Excel.Application');
  try
    // Hide Excel
    ExcelOLE.Visible := false;

    ExcelOLE.Workbooks.Add(xlWBATWorksheet);
    Sheet := ExcelOLE.Workbooks[1].WorkSheets[1];
    Sheet.Name := ASheetName;

    Sheet.Cells[1, 1] := 'Id';
    Sheet.Cells[1, 2] := 'Title';

    Row := 2;
    for i := 0 to AView.Items.Count - 1 do
    begin
      Sheet.Cells[Row, 1] := AView.Items.Item[i].Caption;
      Sheet.Cells[Row, 2] := AView.Items.Item[i].SubItems[0];
      inc(Row);
    end;

    try
      ExcelOLE.Workbooks[1].SaveAs(AFileName);
      Result := true;
    except

    end;
  finally
    if not VarIsEmpty(ExcelOLE) then
    begin
      ExcelOLE.DisplayAlerts := false;
      ExcelOLE.Quit;
      ExcelOLE := Unassigned;
      Sheet := Unassigned;
    end;
  end;
end;

procedure TfrmFlickr.btnExcelClick(Sender: TObject);
begin
  if SaveToExcel(listPhotos, 'Flickr Analytics', ExtractFilePath(ParamStr(0)) + 'FlickrAnalytics.xls') then
    showmessage('Data saved successfully!');
end;

procedure TfrmFlickr.FormCreate(Sender: TObject);
begin
  repository := TFlickrRepository.Create();
  flickrProfiles := TProfiles.Create();
  FilteredGroupList := TFilteredList.Create;
  globalsRepository := TFlickrGlobals.Create();
  CheckedSeries := TStringList.Create;
  Process.Visible := false;
  PageControl1.ActivePage := Statistics;
end;

procedure TfrmFlickr.FormDestroy(Sender: TObject);
begin
  FreeAndNil(CheckedSeries);
  repository := nil;
  flickrProfiles := nil;
  FilteredGroupList := nil;
  globalsRepository := nil;
end;

function TfrmFlickr.isInSeries(id: string): Boolean;
var
  i: Integer;
  found: Boolean;
begin
  i := 0;
  found := false;
  while (not found) and (i < CheckedSeries.Count) do
  begin
    found := CheckedSeries[i] = id;
    inc(i);
  end;
  Result := found;
end;

procedure TfrmFlickr.Label2DblClick(Sender: TObject);
begin
  batchUpdate.Enabled := true;
end;

procedure TfrmFlickr.listGroupsCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  color, Color2: TColor;
begin
  color := Sender.Canvas.Font.color;
  Color2 := Sender.Canvas.Brush.color;
  if Item.Checked then
  begin
    Sender.Canvas.Font.color := clBlue;
    Sender.Canvas.Brush.color := Color2;
  end
  else
  begin
    Sender.Canvas.Font.color := color;
    Sender.Canvas.Brush.color := Color2;
  end;
end;

procedure TfrmFlickr.listPhotosCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  color, Color2: TColor;
begin
  color := Sender.Canvas.Font.color;
  Color2 := Sender.Canvas.Brush.color;
  if SubItem = 1 then
  begin
    if ((Item.SubItems.Strings[1].ToInteger >= 1000) and (Item.SubItems.Strings[1].ToInteger < 3000)) then
    begin
      Sender.Canvas.Font.color := clBlue;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[1].ToInteger >= 3000) and (Item.SubItems.Strings[1].ToInteger < 5000)) then
    begin
      Sender.Canvas.Font.color := clGreen;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[1].ToInteger >= 5000) and (Item.SubItems.Strings[1].ToInteger < 8000)) then
    begin
      Sender.Canvas.Font.color := clOlive;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[1].ToInteger >= 8000) and (Item.SubItems.Strings[1].ToInteger < 10000)) then
    begin
      Sender.Canvas.Font.color := clFuchsia;
      Sender.Canvas.Brush.color := Color2;
    end;
    if ((Item.SubItems.Strings[1].ToInteger >= 10000)) then
    begin
      Sender.Canvas.Font.color := clRed;
      Sender.Canvas.Brush.color := Color2;
    end;
  end
  else
  begin
    Sender.Canvas.Font.color := color;
    Sender.Canvas.Brush.color := Color2;
  end;
end;

procedure TfrmFlickr.listPhotosItemChecked(Sender: TObject; Item: TListItem);
var
  id, title, views, likes, comments, LastUpdate: string;
  photo: IPhoto;
  stat: IStat;
  i: Integer;
  Series: TLineSeries;
  barSeries: TBarSeries;
  colour: TColor;
begin
  if (Item.Checked) and (not chkAddItem.Checked) then
  begin
    id := Item.Caption;
    title := Item.SubItems.Strings[0];
    views := Item.SubItems.Strings[1];
    likes := Item.SubItems.Strings[2];
    comments := Item.SubItems.Strings[3];
    LastUpdate := Item.SubItems.Strings[4];

    photo := repository.GetPhoto(id);
    if photo <> nil then
    begin
      Series := TLineSeries.Create(Chart1);
      Series.Marks.Arrow.Visible := true;
      Series.Marks.Callout.Brush.color := clBlack;
      Series.Marks.Callout.Arrow.Visible := true;
      Series.Marks.DrawEvery := 10;
      Series.Marks.Shadow.color := 8487297;
      Series.Marks.Visible := true;
      Series.SeriesColor := 10708548;
      Series.title := id;
      // Series.Stairs := true;
      Series.LinePen.Width := 1;
      Series.LinePen.color := 10708548;
      Series.Pointer.InflateMargins := true;
      Series.Pointer.Style := psRectangle;
      Series.Pointer.Brush.Gradient.EndColor := 10708548;
      Series.Pointer.Gradient.EndColor := 10708548;
      Series.Pointer.InflateMargins := true;
      Series.Pointer.Visible := false;
      Series.XValues.DateTime := true;
      Series.XValues.Name := 'X';
      Series.XValues.Order := loAscending;
      Series.YValues.Name := 'Y';
      Series.YValues.Order := loNone;
      Series.ParentChart := Chart1;
      CheckedSeries.Add(id);
      colour := RGB(Random(255), Random(255), Random(255));
      for i := 0 to photo.stats.Count - 1 do
      begin
        stat := photo.stats[i];
        if rbViews.Checked then
          Series.AddXY(stat.Date, stat.views, '', colour);
        if rbLikes.Checked then
          Series.AddXY(stat.Date, stat.likes, '', colour);
        if rbComments.Checked then
          Series.AddXY(stat.Date, stat.numComments, '', colour);
      end;
      Chart1.AddSeries(Series);
      UpdateSingleStats(id);
    end;
  end
  else
  begin
    id := Item.Caption;
    if isInSeries(id) then
    begin
      Series := nil;
      for i := 0 to Chart1.SeriesList.Count - 1 do
      begin
        if Chart1.SeriesList[i].title = id then
        begin
          Series := TLineSeries(Chart1.SeriesList[i]);
          Break;
        end;
      end;
      if Series <> nil then
        Chart1.RemoveSeries(Series);

      barSeries := nil;
      for i := 0 to statsDay.SeriesList.Count - 1 do
      begin
        if statsDay.SeriesList[i].title = id then
        begin
          barSeries := TBarSeries(statsDay.SeriesList[i]);
          Break;
        end;
      end;
      if barSeries <> nil then
        statsDay.RemoveSeries(barSeries);
    end;
  end;
end;

end.
