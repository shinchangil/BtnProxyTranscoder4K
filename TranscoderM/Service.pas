// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://192.168.0.16:20012/CMS/Service.asmx?wsdl
//  >Import : http://192.168.0.16:20012/CMS/Service.asmx?wsdl>0
// Encoding : utf-8
// Version  : 1.0
// (2025-08-27 ¿ÀÀü 11:25:52 - - $Rev: 76228 $)
// ************************************************************************ //

unit Service;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:long            - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://www.castware.co.kr/
  // soapAction: http://www.castware.co.kr/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : ServiceSoap
  // service   : Service
  // port      : ServiceSoap
  // URL       : http://192.168.0.16:20012/CMS/Service.asmx
  // ************************************************************************ //
  ServiceSoap = interface(IInvokable)
  ['{DD9B287F-8B7F-39E3-C002-E95F0E4ED94A}']
    function  StorageList: string; stdcall;
    function  StorageListSearch(const F_SERVICE_TYPE: string): string; stdcall;
    function  StorageAdd(const F_USERID: string; const F_TITLE: string; const F_DESC: string; const F_SERVICE_TYPE: string; const F_ACTIVE_TYPE: string; const F_ACTIVE_PATH: string;
                         const F_LOCAL_YESNO: string; const F_SHARED_YESNO: string; const F_FTP_YESNO: string; const F_HTTP_YESNO: string; const F_MMS_YESNO: string;
                         const F_LOCAL_PATH: string; const F_SHARED_PATH: string; const F_SHARED_ID: string; const F_SHARED_PWD: string; const F_FTP_IP: string;
                         const F_FTP_PORT: Integer; const F_FTP_PATH: string; const F_FTP_ID: string; const F_FTP_PWD: string; const F_HTTP_PATH: string;
                         const F_HTTP_PORT: Integer; const F_HTTP_SUBPATH: string; const F_MMS_PATH: string): string; stdcall;
    function  StorageModify(const F_STORAGE_BASEKEY: Int64; const F_USERID: string; const F_TITLE: string; const F_DESC: string): string; stdcall;
    function  StorageDelete: string; stdcall;
    function  ContentAdd(const F_PROJECT_BASEKEY: Int64; const F_CTGRY_BASEKEY: Int64; const F_FILETRANS_YESNO: string; const F_REGIST_USERID: string; const F_CREATE_DAY: string; const F_CONTENT_PATH: string;
                         const F_CONTENT_SUBPATH: string; const F_CONTENT_FILENAME: string; const F_CONTENT_FILESIZE: Int64; const F_CONTENT_TITLE: string; const F_CONTENT_DESC: string;
                         const F_CONTENT_TYPE: string; const F_CONTENT_FORMAT: string; const F_CONTENT_WORKSTEP: string; const F_CONTENT_ORG_BASEKEY: Int64; const F_CONTENT_EDT_BASEKEY: Int64;
                         const F_CONTENT_RUNTIME: Int64; const F_CONTENT_RUNTIME_DSP: string; const F_STORAGE_CHECK: string; const F_STORAGE_BASEKEY: Int64; const F_SHARE_YESNO: string;
                         const F_CONTENT_THUMBPATH: string; const F_CONTENT_THUMBFILE: string; const F_VIDEO_WIDTH: Integer; const F_VIDEO_HEIGHT: Integer; const F_VIDEO_BITRATE: Integer;
                         const F_AUDIO_BITRATE: Integer; const F_STREAMING_YESNO: string; const F_EXTRA_INFO01: string; const F_EXTRA_INFO02: string; const F_EXTRA_INFO03: string;
                         const F_EXTRA_INFO04: string; const F_EXTRA_INFO05: string; const F_EXTRA_INFO06: string; const F_EXTRA_INFO07: string; const F_EXTRA_INFO08: string;
                         const F_EXTRA_INFO09: string; const F_EXTRA_INFO10: string; const F_EXTRA_INFO11: string; const F_EXTRA_INFO12: string; const F_EXTRA_INFO13: string;
                         const F_EXTRA_INFO14: string; const F_EXTRA_INFO15: string; const F_EXTRA_INFO16: string; const F_EXTRA_INFO17: string; const F_EXTRA_INFO18: string;
                         const F_EXTRA_INFO19: string; const F_EXTRA_INFO20: string): string; stdcall;
    function  ContentAdd_WatchFolder(const F_PROJECT_BASEKEY: string; const F_CTGRY_BASEKEY: string; const F_FILETRANS_YESNO: string; const F_REGIST_USERID: string; const F_CREATE_DAY: string; const F_CONTENT_PATH: string;
                                     const F_CONTENT_SUBPATH: string; const F_CONTENT_FILENAME: string; const F_CONTENT_FILESIZE: string; const F_CONTENT_TITLE: string; const F_CONTENT_DESC: string;
                                     const F_CONTENT_TYPE: string; const F_CONTENT_FORMAT: string; const F_CONTENT_WORKSTEP: string; const F_CONTENT_ORG_BASEKEY: string; const F_CONTENT_EDT_BASEKEY: string;
                                     const F_CONTENT_RUNTIME: string; const F_CONTENT_RUNTIME_DSP: string; const F_STORAGE_CHECK: string; const F_STORAGE_BASEKEY: string; const F_SHARE_YESNO: string;
                                     const F_CONTENT_THUMBPATH: string; const F_CONTENT_THUMBFILE: string; const F_VIDEO_WIDTH: string; const F_VIDEO_HEIGHT: string; const F_VIDEO_BITRATE: string;
                                     const F_AUDIO_BITRATE: string; const F_STREAMING_YESNO: string; const F_PREVIEW_PATH: string; const F_PREVIEW_FILENAME: string; const F_EXTRA_INFO01: string;
                                     const F_EXTRA_INFO02: string; const F_EXTRA_INFO03: string; const F_EXTRA_INFO04: string; const F_EXTRA_INFO05: string; const F_EXTRA_INFO06: string;
                                     const F_EXTRA_INFO07: string; const F_EXTRA_INFO08: string; const F_EXTRA_INFO09: string; const F_EXTRA_INFO10: string; const F_EXTRA_INFO11: string;
                                     const F_EXTRA_INFO12: string; const F_EXTRA_INFO13: string; const F_EXTRA_INFO14: string; const F_EXTRA_INFO15: string; const F_EXTRA_INFO16: string;
                                     const F_EXTRA_INFO17: string; const F_EXTRA_INFO18: string; const F_EXTRA_INFO19: string; const F_EXTRA_INFO20: string): string; stdcall;
    function  ContentFileInfoUpdate(const F_CONTENT_BASEKEY: Int64; const F_FILETRANS_YESNO: string; const F_REGIST_USERID: string; const F_CONTENT_PATH: string; const F_CONTENT_SUBPATH: string; const F_CONTENT_FILENAME: string;
                                    const F_CONTENT_FILESIZE: Int64; const F_CONTENT_RUNTIME: Int64; const F_CONTENT_RUNTIME_DSP: string; const F_STORAGE_CHECK: string; const F_STORAGE_BASEKEY: Int64;
                                    const F_VIDEO_WIDTH: Integer; const F_VIDEO_HEIGHT: Integer; const F_VIDEO_BITRATE: Integer; const F_AUDIO_BITRATE: Integer): string; stdcall;
    function  ContentFileInfoUpdateEx(const F_CONTENT_BASEKEY: Int64; const F_FILETRANS_YESNO: string; const F_REGIST_USERID: string; const F_CONTENT_PATH: string; const F_CONTENT_SUBPATH: string; const F_CONTENT_FILENAME: string;
                                      const F_CONTENT_FILESIZE: Int64; const F_CONTENT_RUNTIME: Int64; const F_CONTENT_RUNTIME_DSP: string; const F_STORAGE_CHECK: string; const F_STORAGE_BASEKEY: Int64;
                                      const F_VIDEO_WIDTH: Integer; const F_VIDEO_HEIGHT: Integer; const F_VIDEO_BITRATE: Integer; const F_AUDIO_BITRATE: Integer; const chkPreview: string;
                                      const sProductType: string; const sOrderType: string; const F_TRANSCODE_STATE: string; const F_PROCODER_DEVICE: string; const F_PCP_PATH: string;
                                      const F_PCP_NAME: string; const F_PCP_COUNT: Integer): string; stdcall;
    function  ContentFileInfoUpdateImage(const F_CONTENT_BASEKEY: Int64; const F_FILETRANS_YESNO: string; const F_REGIST_USERID: string; const F_CONTENT_FILENAME: string; const thumb_path: string; const thumb_file: string
                                         ): string; stdcall;
    function  ContentFileInfoUpdateAudio(const F_CONTENT_BASEKEY: Int64; const F_FILETRANS_YESNO: string; const F_REGIST_USERID: string; const F_CONTENT_FILENAME: string; const F_CONTENT_FILESIZE: Int64): string; stdcall;
    function  GetContentAbstractInfo(const F_CONTENT_BASEKEY: string): string; stdcall;
    function  ContentList(const ClientVerInfo: string; const PageCount: Integer; const ItemCountPerPage: Integer; const F_PROJECT_BASEKEY: Int64; const F_CONTENT_BASEKEY: Int64; const F_CTGRY_BASEKEY: Int64;
                          const F_CONTENT_TYPE: string; const F_CONTENT_WORKSTEP: string; const F_CONTENT_ORG_BASEKEY: string; const F_CONTENT_EDT_BASEKEY: string; const DELETE_FILTER: string;
                          const sqlSort: string; const sqlSearch: string): string; stdcall;
    function  ContentModify(const F_USERID: string; const F_CONTENT_BASEKEY: Int64; const F_CTGRY_BASEKEY: Int64; const F_CREATE_DAY: string; const F_CONTENT_TITLE: string; const F_CONTENT_DESC: string;
                            const F_SHARE_YESNO: string; const F_CONTENT_THUMBPATH: string; const F_CONTENT_THUMBFILE: string; const F_CONTENT_FILESIZE: Int64; const F_CONTENT_RUNTIME: Int64;
                            const F_CONTENT_RUNTIME_DSP: string; const F_VIDEO_WIDTH: Integer; const F_VIDEO_HEIGHT: Integer; const F_VIDEO_BITRATE: Integer; const F_AUDIO_BITRATE: Integer;
                            const F_STREAMING_YESNO: string; const F_EXTRA_INFO01: string; const F_EXTRA_INFO02: string; const F_EXTRA_INFO03: string; const F_EXTRA_INFO04: string;
                            const F_EXTRA_INFO05: string; const F_EXTRA_INFO06: string; const F_EXTRA_INFO07: string; const F_EXTRA_INFO08: string; const F_EXTRA_INFO09: string;
                            const F_EXTRA_INFO10: string; const F_EXTRA_INFO11: string; const F_EXTRA_INFO12: string; const F_EXTRA_INFO13: string; const F_EXTRA_INFO14: string;
                            const F_EXTRA_INFO15: string; const F_EXTRA_INFO16: string; const F_EXTRA_INFO17: string; const F_EXTRA_INFO18: string; const F_EXTRA_INFO19: string;
                            const F_EXTRA_INFO20: string): string; stdcall;
    function  ContentDelete(const F_USERID: string; const F_CONTENT_BASEKEY: Int64; const F_DELETE_META_YESNO: string; const F_DELETE_FILE_YESNO: string): string; stdcall;
    function  VideoContentDeleteMulti(const F_USERID: string; const content_id_list: string; const F_DELETE_META_YESNO: string; const F_DELETE_FILE_YESNO: string): string; stdcall;
    function  AudioContentDelete(const F_USERID: string; const F_CONTENT_BASEKEY: Int64; const F_DELETE_META_YESNO: string; const F_DELETE_FILE_YESNO: string): string; stdcall;
    function  AudioContentDeleteMulti(const F_USERID: string; const content_id_list: string; const F_DELETE_META_YESNO: string; const F_DELETE_FILE_YESNO: string): string; stdcall;
    function  ContentVanish(const F_USERID: string; const F_CONTENT_BASEKEY: Int64; const F_DELETE_META_YESNO: string; const F_DELETE_FILE_YESNO: string): string; stdcall;
    function  ContentRecovery(const F_CONTENT_BASEKEY: Int64; const F_REGIST_USERID: string; const F_STORAGE_CHECK: string; const F_CONTENT_FILENAME: string): string; stdcall;
    function  ContentSetPreview(const F_USERID: string; const F_CONTENT_BASEKEY: Int64; const F_PREVIEW_PATH: string; const F_PREVIEW_FILENAME: string): string; stdcall;
    function  ContentCheck(const F_CONTENT_BASEKEY: Int64; const F_CHECK_USERID: string; const F_CHECK_RESULT: string; const F_CHECK_REMARKS: string): string; stdcall;
    function  ContentDeleteList: string; stdcall;
    function  ContentDeleteUpdate(const F_DELETE_BASEKEY: string; const F_DELETED_FILE: string): string; stdcall;
    function  ContentDeletedList(const PageCount: Integer; const ItemCountPerPage: Integer; const F_PROJECT_BASEKEY: Int64; const F_CONTENT_BASEKEY: Int64; const F_CTGRY_BASEKEY: Int64; const F_CONTENT_TYPE: string;
                                 const F_CONTENT_WORKSTEP: string; const F_CONTENT_ORG_BASEKEY: string; const F_CONTENT_EDT_BASEKEY: string; const DELETE_FILTER: string; const sqlSort: string;
                                 const sqlSearch: string): string; stdcall;
    function  ContentDeletedListEx(const PageCount: Integer; const ItemCountPerPage: Integer; const F_PROJECT_BASEKEY: Int64; const F_CONTENT_BASEKEY: Int64; const F_CTGRY_BASEKEY: Int64; const F_CONTENT_TYPE: string;
                                   const F_CONTENT_WORKSTEP: string; const F_CONTENT_ORG_BASEKEY: string; const F_CONTENT_EDT_BASEKEY: string; const DELETE_FILTER: string; const sqlSort: string;
                                   const sqlSearch: string): string; stdcall;
    function  ContentLog(const F_CONTENT_BASEKEY: Int64): string; stdcall;
    function  EdiusPluginContentAddTemp(const F_PROJECT_BASEKEY: Int64; const F_CTGRY_BASEKEY: Int64; const F_STORAGE_BASEKEY: Int64; const F_CONTENT_PATH: string; const F_CONTENT_SUBPATH: string; const F_CONTENT_FILENAME: string;
                                        const F_CONTENT_TITLE: string; const F_CONTENT_DESC: string; const F_CONTENT_RUNTIME: Int64; const F_CONTENT_RUNTIME_DSP: string; const F_VIDEO_WIDTH: Integer;
                                        const F_VIDEO_HEIGHT: Integer; const F_VIDEO_BITRATE: Integer; const F_AUDIO_BITRATE: Integer): string; stdcall;
    function  EdiusPluginContentAddCompleteTemp(const F_CONTENT_BASEKEY: Int64; const F_FILETRANS_YESNO: string; const F_CONTENT_PATH: string; const F_CONTENT_SUBPATH: string; const F_CONTENT_FILENAME: string; const F_CONTENT_FILESIZE: Int64
                                                ): string; stdcall;
    function  PCPAdd(const F_PCP_PATH: string; const F_PCP_FILENAME: string; const F_PRESET_CNT: Integer; const F_REGIST_USERID: string; const F_TITLE: string; const F_DESC: string
                     ): string; stdcall;
    function  PCPListAll: string; stdcall;
    function  PCPListPageSearch(const PageCount: Integer; const ItemCountPerPage: Integer; const SEARCH_TERM: string): string; stdcall;
    function  PCPModify(const F_USERID: string; const F_PCP_BASEKEY: string; const F_TITLE: string; const F_DESC: string): string; stdcall;
    function  PCPDelete(const F_USERID: string; const F_PCP_BASEKEY: string): string; stdcall;
    function  TranscodeOrderUpdateEx(const F_TRANSCODEORDER_BASEKEY: string; const F_CONTENT_BASEKEY: string; const F_TRANSCODE_STATE: string; const F_SCD_SRCPATH: string; const F_SCD_SRCSUBPATH: string; const F_SCD_SRCFILENAME: string;
                                     const F_PROJECT_BASEKEY: Int64; const F_SCD_STATE: string): string; stdcall;
    function  SCDOrderList(const PageCount: Integer; const ItemCountPerPage: Integer; const sDeviceIP: string; const sOrderState: string): string; stdcall;
    function  SCDOrderUpdate(const F_SCDORDER_BASEKEY: string; const F_SCD_SRCFILENAME: string; const F_SCD_STATE: string; const sImageListData: string): string; stdcall;
    function  SCDImageList(const PageCount: Integer; const ItemCountPerPage: Integer; const F_CONTENT_FILENAME: string): string; stdcall;
    function  ProjectAdd(const F_PROJECT_KEY: string; const F_PROJECT_TITLE: string; const F_PROJECT_DESC: string; const F_PROJECT_CATEGORY: string; const F_STORAGE_BASEKEY: Int64; const F_REGIST_USERID: string;
                         const F_PROJECT_SUBJECT: string; const F_PROJECT_KEYWORD: string; const F_PROJECT_STATUS: string): string; stdcall;
    function  ProjectAdd_Auto(const F_PROJECT_KEY: string): string; stdcall;
    function  ProjectCategoryList: string; stdcall;
    function  ProjectList(const PageCount: Integer; const ItemCountPerPage: Integer; const F_PROJECT_CATEGORY: string; const sqlSort: string; const sqlFilter: string; const ClientVerInfo: string
                          ): string; stdcall;
    function  ProjectModify(const F_PROJECT_BASEKEY: Int64; const F_PROJECT_TITLE: string; const F_PROJECT_DESC: string; const F_PROJECT_CATEGORY: string; const F_PROJECT_SUBJECT: string; const F_PROJECT_KEYWORD: string;
                            const F_PROJECT_STATUS: string; const F_USERID: string): string; stdcall;
    function  ProjectDelete(const F_PROJECT_BASEKEY: Int64; const F_CONTENT_DELETE_YESNO_META: string; const F_CONTENT_DELETE_YESNO_FILE: string; const F_USERID: string): string; stdcall;
    function  ThumbnailListAll: string; stdcall;
    function  ThumbnailListSearch(const F_CONTENT_BASEKEY: string; const F_CONTENT_SUBKEY: string; const F_CONTENT_TYPE: string; const F_IMAGE_TYPE: string): string; stdcall;
    function  ThumbnailAdd(const F_CONTENT_BASEKEY: string; const F_CONTENT_SUBKEY: string; const F_CONTENT_TYPE: string; const F_STORAGE_BASEKEY: string; const F_IMAGE_FILENAME: string; const F_IMAGE_TYPE: string;
                           const F_USERID: string; const F_TITLE: string; const F_DESC: string): string; stdcall;
    function  ThumbnailModify(const F_CONTENT_BASEKEY: string; const F_CONTENT_SUBKEY: string; const F_CONTENT_TYPE: string; const F_STORAGE_BASEKEY: string; const F_IMAGE_FILENAME: string; const F_IMAGE_TYPE: string;
                              const F_USERID: string; const F_TITLE: string; const F_DESC: string): string; stdcall;
    function  ThumbnailDelete(const F_CONTENT_BASEKEY: string; const F_CONTENT_SUBKEY: string; const F_CONTENT_TYPE: string; const F_STORAGE_BASEKEY: string; const F_IMAGE_FILENAME: string; const F_IMAGE_TYPE: string;
                              const F_USERID: string): string; stdcall;
    function  ServerList(const F_WORK_TYPE: string): string; stdcall;
    function  ServerAdd(const F_USERID: string; const F_IP: string; const F_PORT: Integer; const F_WORK_TYPE: string; const F_TITLE: string): string; stdcall;
    function  ServerModify(const F_USERID: string; const F_KEY: Int64; const F_IP: string; const F_PORT: Integer; const F_WORK_TYPE: string; const F_TITLE: string
                           ): string; stdcall;
    function  ExtList(const F_FILE_TYPE: string): string; stdcall;
    function  ExtAdd(const F_USERID: string; const F_FILE_TYPE: string; const F_EXT_DESC: string; const F_EXT: string; const F_REL_APP: string): string; stdcall;
    function  ExtModify(const F_USERID: string; const F_KEY: Int64; const F_FILE_TYPE: string; const F_EXT_DESC: string; const F_EXT: string; const F_REL_APP: string
                        ): string; stdcall;
    function  RimageAgentList: string; stdcall;
    function  RimageAgentInfo: string; stdcall;
    function  RimageAgentAdd(const F_USERID: string; const F_IP: string; const F_PORT: Integer): string; stdcall;
    function  ProCoderAgentInfo: string; stdcall;
    function  ProCoderAgentList: string; stdcall;
    function  ProCoderAgentAdd(const F_USERID: string; const F_IP: string; const F_PORT: Integer): string; stdcall;
    function  SetMetaHead(const F_USERID: string; const FieldData: string): string; stdcall;
    function  GetMetaHead: string; stdcall;
    function  SetAudioMetaHead(const F_USERID: string; const FieldData: string): string; stdcall;
    function  GetAudioMetaHead: string; stdcall;
    function  SetAgilityPreset(const F_USERID: string; const FieldData: string): string; stdcall;
    function  GetAgilityPreset: string; stdcall;
    function  GetEngineConnectionString(const Code: string): string; stdcall;
    function  SetEngineConnectionString(const Code: string; const Value: string): string; stdcall;
    function  ReportingContents(const F_USERID: string; const QueryData: string): string; stdcall;
    function  ExecuteSQL(const Code: string; const bTransaction: Boolean; const sqlQuery: string): string; stdcall;
    function  CoverAdd(const F_COVER_PATH: string; const F_COVER_FILENAME: string; const F_COVER_IMAGEFILE: string; const F_PARAMETER_COUNT: Integer; const F_REGIST_USERID: string; const F_TITLE: string;
                       const F_DESC: string): string; stdcall;
    function  CoverListAll: string; stdcall;
    function  CoverListPageSearch(const PageCount: Integer; const ItemCountPerPage: Integer; const SEARCH_TERM: string): string; stdcall;
    function  CoverModify(const F_USERID: string; const F_COVER_BASEKEY: string; const F_TITLE: string; const F_DESC: string; const F_PARAMETER_COUNT: Integer): string; stdcall;
    function  CoverDelete(const F_USERID: string; const F_COVER_BASEKEY: string): string; stdcall;
    function  TestEngineAPI(const sData: string): string; stdcall;
    function  EngineAPI(const sData: string): string; stdcall;
    function  CategoryList: string; stdcall;
    function  CategoryAdd(const F_USERID: string; const F_CTGRY_SUBKEY1: Integer; const F_CTGRY_SUBKEY2: Integer; const F_CTGRY_SUBKEY3: Integer; const F_CTGRY_NAME: string): string; stdcall;
    function  CategoryModify(const F_USERID: string; const F_CTGRY_BASEKEY: Int64; const F_CTGRY_NAME: string): string; stdcall;
    function  CategoryDelete(const F_USERID: string; const F_CTGRY_BASEKEY: Int64): string; stdcall;
    function  AudioCategoryList: string; stdcall;
    function  AudioCategoryAdd(const F_USERID: string; const F_CTGRY_SUBKEY1: Integer; const F_CTGRY_SUBKEY2: Integer; const F_CTGRY_SUBKEY3: Integer; const F_CTGRY_NAME: string): string; stdcall;
    function  AudioCategoryModify(const F_USERID: string; const F_CTGRY_BASEKEY: Int64; const F_CTGRY_NAME: string): string; stdcall;
    function  AudioCategoryDelete(const F_USERID: string; const F_CTGRY_BASEKEY: Int64): string; stdcall;
    function  MemberLogin(const F_USERID: string; const F_USERPWD: string): string; stdcall;
    function  MemberLoginEx(const F_USERID: string; const F_USERPWD: string): string; stdcall;
    function  MemberAdd(const F_USERID: string; const F_USERPWD: string; const F_USERNAME: string; const F_USERLEVEL: Integer; const F_USER_EMAIL: string; const F_USER_TEL1: string;
                        const F_USER_TEL2: string; const F_USER_HP: string; const F_USER_PART: string; const F_PROJECTADD_AC: string; const F_PROJECTMODIFY_AC: string;
                        const F_PROJECTDELETE_AC: string; const F_CONTENTADD_AC: string; const F_CONTENTMODIFY_AC: string; const F_CONTENTDELETE_AC: string; const F_CATEGORYADD_AC: string;
                        const F_CATEGORYMODIFY_AC: string; const F_CATEGORYDELETE_AC: string; const F_MEMBERADD_AC: string; const F_MEMBERMODIFY_AC: string; const F_MEMBERDELETE_AC: string;
                        const F_STORAGEADD_AC: string; const F_STORAGEMODIFY_AC: string; const F_STORAGEDELETE_AC: string; const F_SYSTEMCONFIGADD_AC: string; const F_SYSTEMCONFIGMODIFY_AC: string;
                        const F_SYSTEMCONFIGDELETE_AC: string; const F_METAHEAD_AC: string; const F_EXTADD_AC: string; const F_EXTMODIFY_AC: string; const F_EXTDELETE_AC: string;
                        const F_CONTENTCHECK_AC: string; const F_TCWORK_AC: string; const F_RIMAGE_AC: string; const F_BACKUP_AC: string): string; stdcall;
    function  MemberList: string; stdcall;
    function  MemberModify(const F_USERID: string; const F_USERPWDOLD: string; const F_USERPWD: string; const F_USERNAME: string; const F_USERLEVEL: Integer; const F_USER_EMAIL: string;
                           const F_USER_TEL1: string; const F_USER_TEL2: string; const F_USER_HP: string; const F_USER_PART: string; const F_PROJECTADD_AC: string;
                           const F_PROJECTMODIFY_AC: string; const F_PROJECTDELETE_AC: string; const F_CONTENTADD_AC: string; const F_CONTENTMODIFY_AC: string; const F_CONTENTDELETE_AC: string;
                           const F_CATEGORYADD_AC: string; const F_CATEGORYMODIFY_AC: string; const F_CATEGORYDELETE_AC: string; const F_MEMBERADD_AC: string; const F_MEMBERMODIFY_AC: string;
                           const F_MEMBERDELETE_AC: string; const F_STORAGEADD_AC: string; const F_STORAGEMODIFY_AC: string; const F_STORAGEDELETE_AC: string; const F_SYSTEMCONFIGADD_AC: string;
                           const F_SYSTEMCONFIGMODIFY_AC: string; const F_SYSTEMCONFIGDELETE_AC: string; const F_METAHEAD_AC: string; const F_EXTADD_AC: string; const F_EXTMODIFY_AC: string;
                           const F_EXTDELETE_AC: string; const F_CONTENTCHECK_AC: string; const F_TCWORK_AC: string; const F_RIMAGE_AC: string; const F_BACKUP_AC: string
                           ): string; stdcall;
    function  MemberDelete(const F_USERID: string; const F_DELETE_USERID: string): string; stdcall;
    function  VersionInfo: string; stdcall;
    function  CheckFileExists(const F_CONTENT_FILENAME: string): Integer; stdcall;
  end;

function GetServiceSoap(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ServiceSoap;


implementation
  uses System.SysUtils;

function GetServiceSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ServiceSoap;
const
  defWSDL = 'http://192.168.0.16:20012/CMS/Service.asmx?wsdl';
  defURL  = 'http://192.168.0.16:20012/CMS/Service.asmx';
  defSvc  = 'Service';
  defPrt  = 'ServiceSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ServiceSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { ServiceSoap }
  InvRegistry.RegisterInterface(TypeInfo(ServiceSoap), 'http://www.castware.co.kr/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ServiceSoap), 'http://www.castware.co.kr/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ServiceSoap), ioDocument);
  { ServiceSoap.StorageList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'StorageList', '',
                                 '[ReturnName="StorageListResult"]', IS_OPTN);
  { ServiceSoap.StorageListSearch }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'StorageListSearch', '',
                                 '[ReturnName="StorageListSearchResult"]', IS_OPTN);
  { ServiceSoap.StorageAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'StorageAdd', '',
                                 '[ReturnName="StorageAddResult"]', IS_OPTN);
  { ServiceSoap.StorageModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'StorageModify', '',
                                 '[ReturnName="StorageModifyResult"]', IS_OPTN);
  { ServiceSoap.StorageDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'StorageDelete', '',
                                 '[ReturnName="StorageDeleteResult"]', IS_OPTN);
  { ServiceSoap.ContentAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentAdd', '',
                                 '[ReturnName="ContentAddResult"]', IS_OPTN);
  { ServiceSoap.ContentAdd_WatchFolder }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentAdd_WatchFolder', '',
                                 '[ReturnName="ContentAdd_WatchFolderResult"]', IS_OPTN);
  { ServiceSoap.ContentFileInfoUpdate }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentFileInfoUpdate', '',
                                 '[ReturnName="ContentFileInfoUpdateResult"]', IS_OPTN);
  { ServiceSoap.ContentFileInfoUpdateEx }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentFileInfoUpdateEx', '',
                                 '[ReturnName="ContentFileInfoUpdateExResult"]', IS_OPTN);
  { ServiceSoap.ContentFileInfoUpdateImage }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentFileInfoUpdateImage', '',
                                 '[ReturnName="ContentFileInfoUpdateImageResult"]', IS_OPTN);
  { ServiceSoap.ContentFileInfoUpdateAudio }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentFileInfoUpdateAudio', '',
                                 '[ReturnName="ContentFileInfoUpdateAudioResult"]', IS_OPTN);
  { ServiceSoap.GetContentAbstractInfo }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetContentAbstractInfo', '',
                                 '[ReturnName="GetContentAbstractInfoResult"]', IS_OPTN);
  { ServiceSoap.ContentList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentList', '',
                                 '[ReturnName="ContentListResult"]', IS_OPTN);
  { ServiceSoap.ContentModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentModify', '',
                                 '[ReturnName="ContentModifyResult"]', IS_OPTN);
  { ServiceSoap.ContentDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentDelete', '',
                                 '[ReturnName="ContentDeleteResult"]', IS_OPTN);
  { ServiceSoap.VideoContentDeleteMulti }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'VideoContentDeleteMulti', '',
                                 '[ReturnName="VideoContentDeleteMultiResult"]', IS_OPTN);
  { ServiceSoap.AudioContentDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'AudioContentDelete', '',
                                 '[ReturnName="AudioContentDeleteResult"]', IS_OPTN);
  { ServiceSoap.AudioContentDeleteMulti }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'AudioContentDeleteMulti', '',
                                 '[ReturnName="AudioContentDeleteMultiResult"]', IS_OPTN);
  { ServiceSoap.ContentVanish }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentVanish', '',
                                 '[ReturnName="ContentVanishResult"]', IS_OPTN);
  { ServiceSoap.ContentRecovery }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentRecovery', '',
                                 '[ReturnName="ContentRecoveryResult"]', IS_OPTN);
  { ServiceSoap.ContentSetPreview }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentSetPreview', '',
                                 '[ReturnName="ContentSetPreviewResult"]', IS_OPTN);
  { ServiceSoap.ContentCheck }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentCheck', '',
                                 '[ReturnName="ContentCheckResult"]', IS_OPTN);
  { ServiceSoap.ContentDeleteList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentDeleteList', '',
                                 '[ReturnName="ContentDeleteListResult"]', IS_OPTN);
  { ServiceSoap.ContentDeleteUpdate }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentDeleteUpdate', '',
                                 '[ReturnName="ContentDeleteUpdateResult"]', IS_OPTN);
  { ServiceSoap.ContentDeletedList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentDeletedList', '',
                                 '[ReturnName="ContentDeletedListResult"]', IS_OPTN);
  { ServiceSoap.ContentDeletedListEx }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentDeletedListEx', '',
                                 '[ReturnName="ContentDeletedListExResult"]', IS_OPTN);
  { ServiceSoap.ContentLog }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ContentLog', '',
                                 '[ReturnName="ContentLogResult"]', IS_OPTN);
  { ServiceSoap.EdiusPluginContentAddTemp }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'EdiusPluginContentAddTemp', '',
                                 '[ReturnName="EdiusPluginContentAddTempResult"]', IS_OPTN);
  { ServiceSoap.EdiusPluginContentAddCompleteTemp }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'EdiusPluginContentAddCompleteTemp', '',
                                 '[ReturnName="EdiusPluginContentAddCompleteTempResult"]', IS_OPTN);
  { ServiceSoap.PCPAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'PCPAdd', '',
                                 '[ReturnName="PCPAddResult"]', IS_OPTN);
  { ServiceSoap.PCPListAll }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'PCPListAll', '',
                                 '[ReturnName="PCPListAllResult"]', IS_OPTN);
  { ServiceSoap.PCPListPageSearch }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'PCPListPageSearch', '',
                                 '[ReturnName="PCPListPageSearchResult"]', IS_OPTN);
  { ServiceSoap.PCPModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'PCPModify', '',
                                 '[ReturnName="PCPModifyResult"]', IS_OPTN);
  { ServiceSoap.PCPDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'PCPDelete', '',
                                 '[ReturnName="PCPDeleteResult"]', IS_OPTN);
  { ServiceSoap.TranscodeOrderUpdateEx }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'TranscodeOrderUpdateEx', '',
                                 '[ReturnName="TranscodeOrderUpdateExResult"]', IS_OPTN);
  { ServiceSoap.SCDOrderList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SCDOrderList', '',
                                 '[ReturnName="SCDOrderListResult"]', IS_OPTN);
  { ServiceSoap.SCDOrderUpdate }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SCDOrderUpdate', '',
                                 '[ReturnName="SCDOrderUpdateResult"]', IS_OPTN);
  { ServiceSoap.SCDImageList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SCDImageList', '',
                                 '[ReturnName="SCDImageListResult"]', IS_OPTN);
  { ServiceSoap.ProjectAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProjectAdd', '',
                                 '[ReturnName="ProjectAddResult"]', IS_OPTN);
  { ServiceSoap.ProjectAdd_Auto }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProjectAdd_Auto', '',
                                 '[ReturnName="ProjectAdd_AutoResult"]', IS_OPTN);
  { ServiceSoap.ProjectCategoryList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProjectCategoryList', '',
                                 '[ReturnName="ProjectCategoryListResult"]', IS_OPTN);
  { ServiceSoap.ProjectList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProjectList', '',
                                 '[ReturnName="ProjectListResult"]', IS_OPTN);
  { ServiceSoap.ProjectModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProjectModify', '',
                                 '[ReturnName="ProjectModifyResult"]', IS_OPTN);
  { ServiceSoap.ProjectDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProjectDelete', '',
                                 '[ReturnName="ProjectDeleteResult"]', IS_OPTN);
  { ServiceSoap.ThumbnailListAll }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ThumbnailListAll', '',
                                 '[ReturnName="ThumbnailListAllResult"]', IS_OPTN);
  { ServiceSoap.ThumbnailListSearch }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ThumbnailListSearch', '',
                                 '[ReturnName="ThumbnailListSearchResult"]', IS_OPTN);
  { ServiceSoap.ThumbnailAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ThumbnailAdd', '',
                                 '[ReturnName="ThumbnailAddResult"]', IS_OPTN);
  { ServiceSoap.ThumbnailModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ThumbnailModify', '',
                                 '[ReturnName="ThumbnailModifyResult"]', IS_OPTN);
  { ServiceSoap.ThumbnailDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ThumbnailDelete', '',
                                 '[ReturnName="ThumbnailDeleteResult"]', IS_OPTN);
  { ServiceSoap.ServerList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ServerList', '',
                                 '[ReturnName="ServerListResult"]', IS_OPTN);
  { ServiceSoap.ServerAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ServerAdd', '',
                                 '[ReturnName="ServerAddResult"]', IS_OPTN);
  { ServiceSoap.ServerModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ServerModify', '',
                                 '[ReturnName="ServerModifyResult"]', IS_OPTN);
  { ServiceSoap.ExtList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ExtList', '',
                                 '[ReturnName="ExtListResult"]', IS_OPTN);
  { ServiceSoap.ExtAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ExtAdd', '',
                                 '[ReturnName="ExtAddResult"]', IS_OPTN);
  { ServiceSoap.ExtModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ExtModify', '',
                                 '[ReturnName="ExtModifyResult"]', IS_OPTN);
  { ServiceSoap.RimageAgentList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'RimageAgentList', '',
                                 '[ReturnName="RimageAgentListResult"]', IS_OPTN);
  { ServiceSoap.RimageAgentInfo }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'RimageAgentInfo', '',
                                 '[ReturnName="RimageAgentInfoResult"]', IS_OPTN);
  { ServiceSoap.RimageAgentAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'RimageAgentAdd', '',
                                 '[ReturnName="RimageAgentAddResult"]', IS_OPTN);
  { ServiceSoap.ProCoderAgentInfo }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProCoderAgentInfo', '',
                                 '[ReturnName="ProCoderAgentInfoResult"]', IS_OPTN);
  { ServiceSoap.ProCoderAgentList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProCoderAgentList', '',
                                 '[ReturnName="ProCoderAgentListResult"]', IS_OPTN);
  { ServiceSoap.ProCoderAgentAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ProCoderAgentAdd', '',
                                 '[ReturnName="ProCoderAgentAddResult"]', IS_OPTN);
  { ServiceSoap.SetMetaHead }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SetMetaHead', '',
                                 '[ReturnName="SetMetaHeadResult"]', IS_OPTN);
  { ServiceSoap.GetMetaHead }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetMetaHead', '',
                                 '[ReturnName="GetMetaHeadResult"]', IS_OPTN);
  { ServiceSoap.SetAudioMetaHead }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SetAudioMetaHead', '',
                                 '[ReturnName="SetAudioMetaHeadResult"]', IS_OPTN);
  { ServiceSoap.GetAudioMetaHead }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetAudioMetaHead', '',
                                 '[ReturnName="GetAudioMetaHeadResult"]', IS_OPTN);
  { ServiceSoap.SetAgilityPreset }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SetAgilityPreset', '',
                                 '[ReturnName="SetAgilityPresetResult"]', IS_OPTN);
  { ServiceSoap.GetAgilityPreset }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetAgilityPreset', '',
                                 '[ReturnName="GetAgilityPresetResult"]', IS_OPTN);
  { ServiceSoap.GetEngineConnectionString }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'GetEngineConnectionString', '',
                                 '[ReturnName="GetEngineConnectionStringResult"]', IS_OPTN);
  { ServiceSoap.SetEngineConnectionString }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'SetEngineConnectionString', '',
                                 '[ReturnName="SetEngineConnectionStringResult"]', IS_OPTN);
  { ServiceSoap.ReportingContents }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ReportingContents', '',
                                 '[ReturnName="ReportingContentsResult"]', IS_OPTN);
  { ServiceSoap.ExecuteSQL }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'ExecuteSQL', '',
                                 '[ReturnName="ExecuteSQLResult"]', IS_OPTN);
  { ServiceSoap.CoverAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CoverAdd', '',
                                 '[ReturnName="CoverAddResult"]', IS_OPTN);
  { ServiceSoap.CoverListAll }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CoverListAll', '',
                                 '[ReturnName="CoverListAllResult"]', IS_OPTN);
  { ServiceSoap.CoverListPageSearch }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CoverListPageSearch', '',
                                 '[ReturnName="CoverListPageSearchResult"]', IS_OPTN);
  { ServiceSoap.CoverModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CoverModify', '',
                                 '[ReturnName="CoverModifyResult"]', IS_OPTN);
  { ServiceSoap.CoverDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CoverDelete', '',
                                 '[ReturnName="CoverDeleteResult"]', IS_OPTN);
  { ServiceSoap.TestEngineAPI }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'TestEngineAPI', '',
                                 '[ReturnName="TestEngineAPIResult"]', IS_OPTN);
  { ServiceSoap.EngineAPI }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'EngineAPI', '',
                                 '[ReturnName="EngineAPIResult"]', IS_OPTN);
  { ServiceSoap.CategoryList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CategoryList', '',
                                 '[ReturnName="CategoryListResult"]', IS_OPTN);
  { ServiceSoap.CategoryAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CategoryAdd', '',
                                 '[ReturnName="CategoryAddResult"]', IS_OPTN);
  { ServiceSoap.CategoryModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CategoryModify', '',
                                 '[ReturnName="CategoryModifyResult"]', IS_OPTN);
  { ServiceSoap.CategoryDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CategoryDelete', '',
                                 '[ReturnName="CategoryDeleteResult"]', IS_OPTN);
  { ServiceSoap.AudioCategoryList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'AudioCategoryList', '',
                                 '[ReturnName="AudioCategoryListResult"]', IS_OPTN);
  { ServiceSoap.AudioCategoryAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'AudioCategoryAdd', '',
                                 '[ReturnName="AudioCategoryAddResult"]', IS_OPTN);
  { ServiceSoap.AudioCategoryModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'AudioCategoryModify', '',
                                 '[ReturnName="AudioCategoryModifyResult"]', IS_OPTN);
  { ServiceSoap.AudioCategoryDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'AudioCategoryDelete', '',
                                 '[ReturnName="AudioCategoryDeleteResult"]', IS_OPTN);
  { ServiceSoap.MemberLogin }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MemberLogin', '',
                                 '[ReturnName="MemberLoginResult"]', IS_OPTN);
  { ServiceSoap.MemberLoginEx }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MemberLoginEx', '',
                                 '[ReturnName="MemberLoginExResult"]', IS_OPTN);
  { ServiceSoap.MemberAdd }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MemberAdd', '',
                                 '[ReturnName="MemberAddResult"]', IS_OPTN);
  { ServiceSoap.MemberList }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MemberList', '',
                                 '[ReturnName="MemberListResult"]', IS_OPTN);
  { ServiceSoap.MemberModify }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MemberModify', '',
                                 '[ReturnName="MemberModifyResult"]', IS_OPTN);
  { ServiceSoap.MemberDelete }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'MemberDelete', '',
                                 '[ReturnName="MemberDeleteResult"]', IS_OPTN);
  { ServiceSoap.VersionInfo }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'VersionInfo', '',
                                 '[ReturnName="VersionInfoResult"]', IS_OPTN);
  { ServiceSoap.CheckFileExists }
  InvRegistry.RegisterMethodInfo(TypeInfo(ServiceSoap), 'CheckFileExists', '',
                                 '[ReturnName="CheckFileExistsResult"]');

end.
