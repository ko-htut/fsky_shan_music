# Fsky music application

## Overview

Apiurl : http://dashboard.fskymusic.com/api/

For example,

Top (get) : /top

```javascript
{
  "by" : "dhouston",
  "descendants" : 71,
  "id" : 8863,
  "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
  "score" : 111,
  "time" : 1175714200,
  "title" : "My YC app: Dropbox - Throw away your USB drive",
  "type" : "story",
  "url" : "http://www.getdropbox.com/u/2/screencast.html"
}
```

Banner (get)  : /banner

```javascript
{
  "by" : "dhouston",
  "descendants" : 71,
  "id" : 8863,
  "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
  "score" : 111,
  "time" : 1175714200,
  "title" : "My YC app: Dropbox - Throw away your USB drive",
  "type" : "story",
  "url" : "http://www.getdropbox.com/u/2/screencast.html"
}
```

music details (get)  : /songs

```javascript
{
  "by" : "dhouston",
  "descendants" : 71,
  "id" : 8863,
  "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
  "score" : 111,
  "time" : 1175714200,
  "title" : "My YC app: Dropbox - Throw away your USB drive",
  "type" : "story",
  "url" : "http://www.getdropbox.com/u/2/screencast.html"
}
```

artic search (post) : /search  ()
body :(form-data)
```
name : articname
```
```javascript
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