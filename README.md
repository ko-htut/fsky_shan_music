# Fsky music application

## Feature

- Login
- Download
- Background Music Play
- Album List
- Artist List
- Search
- Download History


## Overview

Apiurl : http://dashboard.fskymusic.com/api/

For example,

Top (get) : /top

```json
{
    "data": [
        {
            "id": 28,
            "cover": "http://dashboard.fskymusic.com/source/song/cover/319523932.JPG",
            "name": "24 HOUR - ၸၼ်ႉၽဵင်း",
            "artist": {
                "artist_name": "ၸၼ်ႉၽဵင်း",
                "artist_detail": "http://dashboard.fskymusic.com/api/artist/7"
            },
            "album": {
                "album_name": "24 ၸူဝ်ႈမွင်း",
                "album_detail": "http://dashboard.fskymusic.com/api/album/7"
            },
            "lyric": null,
            "source": "http://dashboard.fskymusic.com/source/song/mp3/1314176717.MP3",
            "detail": "http://dashboard.fskymusic.com/api/song/28"
        },
    ]
 }
```

Banner (get)  : /banner

```json
{
    "data": {
        "path": "http://dashboard.fskymusic.com/source/banner/closeup-photography-of-jukebox-21088.jpg"
    }
}
```

music details (get)  : /song

```json
{
    "data": [
        {
            "id": 28,
            "cover": "http://dashboard.fskymusic.com/source/song/cover/319523932.JPG",
            "name": "24 HOUR - ၸၼ်ႉၽဵင်း",
            "artist": {
                "artist_name": "ၸၼ်ႉၽဵင်း",
                "artist_detail": "http://dashboard.fskymusic.com/api/artist/7"
            },
            "album": {
                "album_name": "24 ၸူဝ်ႈမွင်း",
                "album_detail": "http://dashboard.fskymusic.com/api/album/7"
            },
            "lyric": null,
            "source": "http://dashboard.fskymusic.com/source/song/mp3/1314176717.MP3",
            "detail": "http://dashboard.fskymusic.com/api/song/28"
        },
    ]
 }
```

artic search (post) : /search  ()
body :(form-data)
```
name : articname
```
```json
{
    "data": [
        {
            "id": 27,
            "cover": "http://dashboard.fskymusic.com/source/song/cover/1838534983.JPG",
            "name": "ဢၢႆႈလႅင်း ပဵၼ် AIK LENG",
            "artist": {
                "artist_name": "သႅင်လႅင်းမိူင်း",
                "artist_detail": "http://dashboard.fskymusic.com/api/artist/6"
            },
            "album": {
                "album_name": "ႁူဝ်ၸႂ်လဵၵ်ႉၼွႆႉ",
                "album_detail": "http://dashboard.fskymusic.com/api/album/6"
            },
            "lyric": null,
            "source": "http://dashboard.fskymusic.com/source/song/mp3/2023815807.MP3",
            "detail": "http://dashboard.fskymusic.com/api/song/27"
        }
       
    ]
}
```

All Album (get) : /album

```json
{
    "data": [
        {
            "id": 9,
            "cover": "http://dashboard.fskymusic.com/public/source/album/cover/567756478.JPG",
            "name": "ႁၵ်ႉဢမ်ႇထိုင်တီႈ",
            "about": "မႆၢ - 1",
            "artist": {
                "name": "ၸႆၢးၼုမ်ႇၸဵင်ၾႃႉ",
                "detail": "http://dashboard.fskymusic.com/public/api/artist/9"
            },
            "condition": true,
            "songs": [
                {
                    "id": 51,
                    "cover": "http://dashboard.fskymusic.com/public/source/song/cover/1869776564.JPG",
                    "name": "I hate you",
                    "artist": {
                        "artist_name": "ၸႆၢးၼုမ်ႇၸဵင်ၾႃႉ",
                        "artist_detail": "http://dashboard.fskymusic.com/public/api/artist/9"
                    },
                    "album": {
                        "album_name": "ႁၵ်ႉဢမ်ႇထိုင်တီႈ",
                        "album_detail": "http://dashboard.fskymusic.com/public/api/album/9"
                    },
                    "lyric": null,
                    "source": "http://dashboard.fskymusic.com/public/source/song/mp3/263401789.MP3",
                    "detail": "http://dashboard.fskymusic.com/public/api/song/51"
                },
            ],
            "detail": "http://dashboard.fskymusic.com/public/api/album/9"
        },
    ]
}
```
Artist (get) : /artist

```json
{
    "data": [
        {
            "id": 8,
            "profile": "http://dashboard.fskymusic.com/public/source/artist/profile/359974480.JPG",
            "name": "PK Zenith",
            "detail": "http://dashboard.fskymusic.com/public/api/artist/8"
        },
    ]
}

```
