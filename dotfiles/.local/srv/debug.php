<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js"><!--<![endif]--><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Debug Information</title>
    <meta name="description" content="TODO: Page Description">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <!-- <link rel="stylesheet" href="css/main.css"> -->
    <style type="text/css">
      html, body {
        background: #efefef;
        border: 0;
        box-sizing: border-box;
        color: #444;
        font: 200 100%/1.4em "Helvetica Neue", Arial, Helvetica, sans-serif;
        margin: 0;
        padding: 0;
      }
      *, *:before, *:after { box-sizing: inherit; }

      h1 {
        line-height: 1.2;
        overflow-wrap: break-word;
        word-wrap: break-word;
      }

      textarea {
        border: 1px solid #ddd;
        font-size: .8em;
        height: 20em;
        padding: 1em;
        width: 100%;
      }

      .container {
        border-radius: 0.2em;
        background: #fff;
        margin: 2em auto;
        padding: 2em 3em;
        width: 60%;
max-width: 48em;
      }
    </style>
  </head>
  <body>

    <div class="container">
      <h1>Debug Information</h1>
      <p><strong>Please copy/paste the output below and send it back our way.</strong> We sincerely apologize for any issues you may have experienced and appreciate your help!</p>
      <p>We will use this information to setup up test suites and check log files.</p>
    </div>

    <div class="container">
      <textarea id="output">Loading...</textarea>
    </div>

    <script type="text/javascript">


      var checkFlash = function () {
        var a = !1,
            b = "";

        function c(d) {
            d = d.match(/[\d]+/g);
            d.length = 3;
            return d.join(".")
        }
        if (navigator.plugins && navigator.plugins.length) {
            var e = navigator.plugins["Shockwave Flash"];
            e && (a = !0, e.description && (b = c(e.description)));
            navigator.plugins["Shockwave Flash 2.0"] && (a = !0, b = "2.0.0.11")
        } else {
            if (navigator.mimeTypes && navigator.mimeTypes.length) {
                var f = navigator.mimeTypes["application/x-shockwave-flash"];
                (a = f && f.enabledPlugin) && (b = c(f.enabledPlugin.description))
            } else {
                try {
                    var g = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7"),
                        a = !0,
                        b = c(g.GetVariable("$version"))
                } catch (h) {
                    try {
                        g = new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6"), a = !0, b = "6.0.21"
                    } catch (i) {
                        try {
                            g = new ActiveXObject("ShockwaveFlash.ShockwaveFlash"), a = !0, b = c(g.GetVariable("$version"))
                        } catch (j) {}
                    }
                }
            }
        }
        var k = b;
        return a ? k : '0';
      };

      function checkCookies(){
          var cookieEnabled=(navigator.cookieEnabled)? true : false;
          if (typeof navigator.cookieEnabled=="undefined" && !cookieEnabled){ 
              document.cookie="testcookie";
              cookieEnabled=(document.cookie.indexOf("testcookie")!=-1)? true : false;
          }
          return (cookieEnabled)?true:false;
      }


      function checkBrowser(){
          var ua=navigator.userAgent,tem,M=ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || []; 
          if(/trident/i.test(M[1])){
              tem=/\brv[ :]+(\d+)/g.exec(ua) || []; 
              return {name:'IE',version:(tem[1]||'')};
              }   
          if(M[1]==='Chrome'){
              tem=ua.match(/\bOPR\/(\d+)/)
              if(tem!=null)   {return {name:'Opera', version:tem[1]};}
              }   
          M=M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
          if((tem=ua.match(/version\/(\d+)/i))!=null) {M.splice(1,1,tem[1]);}
          return {
            name: M[0],
            version: M[1]
          };
      };

function checkResolution() {
    return [window.screen.width,
            window.screen.height].join('x')
}

function checkResolutionAvail() {
    return [window.screen.availWidth,
            window.screen.availHeight].join('x')
}

function checkOrientation() {
  var orientation = screen.orientation || screen.mozOrientation || screen.msOrientation;

  if (orientation['type']) {
    orientation = orientation['type'];
  }

  return orientation;
}

function log(label, value) {
  var o = document.getElementById('output');
  o.value += label + ': ' + value + "\n";
};

      var o = document.getElementById('output');
      o.value = '';
      o.onclick = function(evt) {
        this.select();
      };

      browserNice = checkBrowser();
      log('browser', browserNice['name'] + ' (' + browserNice['version'] + ')');
      log('useragent', navigator.userAgent);
      log('platform', navigator.platform)
      log('oscpu', navigator.oscpu)
      log('flash', checkFlash());
      log('cookies', checkCookies());
      log('resolution', checkResolution());
      log('resolutionavail', checkResolutionAvail());
      log('colordepth', window.screen.colorDepth);
      log('orientation', checkOrientation());

      <?php // PHP in JS in HTML?! WWWEEEEEEEEEEEEEEEEEEEEEEEEEEE

        $ip = $_SERVER['REMOTE_ADDR'];

        if (array_key_exists('HTTP_X_FORWARDED_FOR', $_SERVER)) {
          $ip = array_pop(explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']));
        }

        echo "log('remoteaddr', '$ip');";
      ?>

      <?php
        foreach ($_COOKIE as $key=>$val) {
          echo "log('cookie[$key]', ". json_encode($val) .");";
        }
      ?>

      // TODO: navigator.geolocation?
      // TODO: modernizer for all of this?

    </script>
</body></html>
