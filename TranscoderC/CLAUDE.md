# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

TranscoderC is a Delphi VCL application that processes 4K media files for transcoding and thumbnail generation. The application is a command-line tool that takes media files as input and produces MP4 preview files with thumbnails for a content management system.

## Architecture

### Core Components

- **UnitMain.pas**: Main application form containing the transcoding logic using FFmpeg components
- **UnitGlobal.pas**: Global variables, configuration management, and utility functions
- **UnitCommunicateSoap.pas**: SOAP client for communicating with the CMS engine
- **Service.pas**: Auto-generated SOAP service interface (large file, contains WSDL definitions)

### Key Dependencies

- FFmpeg components (`TFFEncoder`, `TFFDecoder`) for video processing
- SOAP web services for engine communication
- LibAV libraries dynamically loaded from `LibAV` subdirectory

### Application Flow

1. Application starts with command-line parameters: ContentID, Filename, StoragePath, StorageSubpath
2. Loads configuration from `CFG\config.ini`
3. Initializes FFmpeg libraries and SOAP communication
4. Transcodes input media file to MP4 preview format
5. Extracts thumbnail images at 60-second intervals
6. Reports progress and completion status via SOAP API
7. Terminates automatically after completion

## Build Commands

This is a Delphi project using MSBuild:

### Debug Build
```
msbuild TranscoderC.dproj /p:Config=Debug /p:Platform=Win32
```

### Release Build
```
msbuild TranscoderC.dproj /p:Config=Release /p:Platform=Win32
```

### Build Output Locations
- Debug: `.\Debug\Win32\`
- Release: `.\Release\Win32\`
- Test builds output to: `..\RunTest\`

## Configuration

### Required Configuration File
- **Location**: `CFG\config.ini`
- **Required sections**:
  ```ini
  [INFO]
  ENGINE_IP=127.0.0.1
  WORK_MAX=4
  PREVIEW_PATH=<path_to_preview_output>
  ```

### Runtime Dependencies
- LibAV libraries in `LibAV` subdirectory with version-specific naming
- FFmpeg license key defined as constant in UnitMain.pas

## Command Line Usage

```
TranscoderC.exe [ContentID] [InputFileName] [StoragePath] [StorageSubPath]
```

Example:
```
TranscoderC.exe "20160128153313105" "video.mxf" "E:\Storage" "\201601\Content\Video\"
```

## Video Processing Logic

### Input Processing
- Supports various video formats via FFmpeg
- Handles both 4K (2160p+) and HD content with different encoding parameters
- Uses GPU acceleration (h264_nvenc) for 4K content

### Output Generation
- **Preview MP4**: Low-bitrate proxy file (500k video, 126k audio)
- **Thumbnails**: 320x180 JPEG images extracted every 60 seconds
- **Timecode handling**: Supports drop-frame timecode for broadcast content

### Processing States
- **시작**: Starting/Initializing
- **진행중**: Processing in progress
- **완료**: Completed successfully
- **오류**: Error occurred

## Debugging

### Debug Parameters
Set in project properties or use:
```
"20160128153313105" "NA-STHD0_18_000_000_20160317130615_time.mxf" "E:\Project\2012-12-04-불교\Program\Transcoder" "\201601\Content\Video\"
```

### Log Files
- Work history: `History\[timestamp]_[contentId].ini`
- Application logs: `Log\TranscodeM\[date]\TranscodeM.txt`

## Key Constants and Paths

- **LICENSE_KEY**: FFmpeg component license (hardcoded in UnitMain.pas:10)
- **LibAV Path**: Dynamic library loading from `LibAV` + process number
- **AV_TIME_BASE**: Used for duration/timecode calculations
- **Frame rate**: 29.97 fps assumed for timecode calculations