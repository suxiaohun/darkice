user_agent=navigator.userAgent.toLowerCase()
$(document).ready(function () {
    $("#resolution").html(screen.width + "x" + screen.height + "x" + screen.colorDepth);
    $("#bodysize").html($("#welcome").width() + "x" + $("#welcome").height());
    var slide = [];
    var current_slide = 0;
    var d = 1;
    $("#main li").each(function (j) {
        var l = $(this).attr("id");
        var k = $(this).data("title");
        var h = slide.push({id: l, title: k, description: $(this).data("desc")});
        $("#control_buttons").append($("<a />").attr("id", "btn-" + l).text(k).click(function () {
            go(h - 1)
        }))
    });
    var g = function () {
        var h = $("#btn-" + slide[current_slide].id);
        var j = h.offset().left;
        var l = ($("#container").width() - h.width()) / 2;
        var i = $("#control_buttons");
        var k = i.position();
        k.left += l - j;
        i.css("left", k.left)
    };
    var go = function (h) {
        if (slide.length > 0 && h >= 0 && h < slide.length) {
            location.hash = slide[h].id;
            current_slide = h;
            $("#control .top .title").text(slide[h].title);
            $("#control .top .description").text(slide[h].description)
        }
        setTimeout(function () {
            d = (h == 0)
        }, 100);
        g()
    };
    $("#main").bind("mousewheel", function (h, i) {
        if (d) {
            return
        }
        if (i > 0) {
            go(current_slide - 1)
        } else {
            go(current_slide + 1)
        }
    }).bind("click", function (h) {
        if (d) {
            return
        }
        go(current_slide + 1)
    });
    $(document).keyup(function (h) {
        if (d) {
            return
        }
        switch (h.keyCode) {
            case 37:
                go(current_slide - 1);
                break;
            case 39:
            case 13:
            case 32:
                go(current_slide + 1);
                break;
            case 27:
                go(0)
        }
    });
    var b = 0;
    var e = 0;
    var f = 0;
    $("#main").bind("mousemove", function () {
        if (slide[current_slide].id.substring(0, 5) == "test-") {
            e = $.now();
            $("#control").removeClass("control_hide").addClass("control_show");
            if (f == 0) {
                f = setInterval(function () {
                    if (!b && $.now() - e > 2000) {
                        $("#control").removeClass("control_show").addClass("control_hide");
                        clearInterval(f);
                        f = 0
                    }
                }, 200)
            }
        }
    });
    $("#control").mouseenter(function () {
        b = 1
    }).mouseleave(function () {
        b = 0
    });
    var c = 0;
    var a = 0;
    $(window).resize(function (h) {
        $("#resolution").html(screen.width + "x" + screen.height + "x" + screen.colorDepth);
        $("#bodysize").html($("#welcome").width() + "x" + $("#welcome").height());
        $("#resolution_tips").text($("#body").width() + "x" + $("#container").height()).show();
        c = $.now();
        if (a == 0) {
            a = setInterval(function () {
                if ($.now() - c > 1000) {
                    $("#resolution_tips").fadeOut();
                    clearInterval(a);
                    a = 0
                }
            }, 200)
        }
        g()
    });
    $("#start").click(function () {
        go(1);
        quanping_xianshi()
    });

    $("#quanping_tuichu").click(function () {
        quanping_tuichu()
    });
    $("#quanping_xianshi").click(function () {
        quanping_xianshi()
    });
    $("#jieshu_ceshi").click(function () {
        quanping_tuichu()
        go(0)
    });
    go(0)
});

function quanping_anniu() {
    if ($("#welcome").height() === window.screen.height && $("#welcome").width() === window.screen.width) {
        document.getElementById("quanping_xianshi").style.display = "none";
        document.getElementById("quanping_tuichu").style.display = "block"
    } else {
        document.getElementById("quanping_tuichu").style.display = "none";
        document.getElementById("quanping_xianshi").style.display = "block"
    }
}

window.setInterval(function () {
    quanping_anniu()
}, 1000);

function quanping_xianshi() {
    var a = document.documentElement;
    if (a.requestFullscreen) {
        a.requestFullscreen()
    } else {
        if (a.mozRequestFullScreen) {
            a.mozRequestFullScreen()
        } else {
            if (a.webkitRequestFullScreen) {
                a.webkitRequestFullScreen()
            }
        }
    }
}

function quanping_tuichu() {
    if (document.exitFullscreen) {
        document.exitFullscreen()
    } else {
        if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen()
        } else {
            if (document.webkitCancelFullScreen) {
                document.webkitCancelFullScreen()
            }
        }
    }
}


function all_zhi_xing_js_head() {
    if (typeof (HL.Cookie.Get("all_jie_mian")) == "undefined") {
        if (window.screen.width >= 1280) {
            document.write('<link href="//f.bmcx.com/img/css/1040.css?v=' + cache_sjs + '" rel="stylesheet" type="text/css" />')
        }
        if (sj_jie_mian == "1") {
            document.write('<link href="//f.bmcx.com/img/css/sj.css?v=' + cache_sjs + '" rel="stylesheet" type="text/css" media="screen and (max-width:800px)" />');
            if (typeof (css_file_sj) != "undefined") {
                document.write('<link href="' + css_file_sj + "?v=" + cache_sjs + '" rel="stylesheet" type="text/css" media="screen and (max-width:800px)" />')
            }
        }
    } else {
        if (HL.Cookie.Get("all_jie_mian") == "sj" && sj_jie_mian == "1") {
            document.write('<link href="//f.bmcx.com/img/css/sj.css?v=' + cache_sjs + '" rel="stylesheet" type="text/css" />');
            if (typeof (css_file_sj) != "undefined") {
                document.write('<link href="' + css_file_sj + "?v=" + cache_sjs + '" rel="stylesheet" type="text/css" />')
            }
        } else {
            if (window.screen.width >= 1280) {
                document.write('<link href="//f.bmcx.com/img/css/1040.css?v=' + cache_sjs + '" rel="stylesheet" type="text/css" />')
            }
        }
    }
    try {
        parent.parent_ture();
        document.write('<link href="//f.bmcx.com/img/css/api.css?v=' + cache_sjs + '" rel="stylesheet" type="text/css" />')
    } catch (a) {
    }
    c_y_g_j_set()
}

function all_zhi_xing_js() {
    if (!jian_ce_yuan_su_shi_fou_ke_jian("top")) {
        lian_jie_xin_gai_dang_qian()
    }
    all_you_xia_jiao()
}

function jie_mian_qie_huan() {
    document.write('<div id="jie_mian_qie_huan" class="pmk_sj_show pmk_990_show pmk_1040_show">');
    if (sj_jie_mian == "1") {
        if (typeof (HL.Cookie.Get("all_jie_mian")) == "undefined") {
            document.write('<a href="#" onclick="jie_mian_qie_huan_set(\'pc\');">\u7535\u8111\u7248</a> - <a href="#" onclick="jie_mian_qie_huan_set(\'sj\');">\u624b\u673a\u7248</a> - \u81ea\u9002\u5e94')
        } else {
            if (HL.Cookie.Get("all_jie_mian") == "sj") {
                document.write('<a href="#" onclick="jie_mian_qie_huan_set(\'pc\');">\u7535\u8111\u7248</a> - \u624b\u673a\u7248 - <a href="#" onclick="jie_mian_qie_huan_del();">\u81ea\u9002\u5e94</a>')
            } else {
                document.write('\u7535\u8111\u7248 - <a href="#" onclick="jie_mian_qie_huan_set(\'sj\');">\u624b\u673a\u7248</a> - <a href="#" onclick="jie_mian_qie_huan_del();">\u81ea\u9002\u5e94</a>')
            }
        }
    } else {
        document.write("\u5f53\u524d\u9875\u9762\u6682\u65e0\u624b\u673a\u7248")
    }
    document.write("</div>")
}

function jie_mian_qie_huan_set(a) {
    HL.Cookie.Set("all_jie_mian", a, 60 * 60 * 24 * 365, "/", "bmcx.com");
    location.reload();
    return false
}

function jie_mian_qie_huan_del() {
    HL.Cookie.Del("all_jie_mian", "/", "bmcx.com");
    location.reload();
    return false
}

function all_you_xia_jiao() {
    var a = '<div class="you_xia_jiao pmk_1040_show">';
    a += '<div class="xiao_fang_kuai">';
    a += '<div class="xiao_fang_kuai_weixin">';
    a += "\u626b\u4e00\u626b\u5173\u6ce8\u5fae\u4fe1\u53f7<br>";
    a += "<span>\u4fbf\u6c11\u67e5\u8be2\u7f51</span>";
    a += '<img src="//f.bmcx.com/img/weixin.png" width="100" height="100" />';
    a += "</div>";
    a += '<a onclick="window.scrollTo(0,0);return false;" href="#top" class="xiao_fang_kuai_top"></a>';
    a += '<a href="//about.7x24s.com/contact/" target="_blank" class="xiao_fang_kuai_liu_yan"></a>';
    a += "</div>";
    a += "</div>";
    document.write(a)
}

function lian_jie_xin_gai_dang_qian() {
    var c = document.getElementById("main").getElementsByTagName("a");
    for (var b = 0; b < c.length; b++) {
        var a = c[b];
        if (a.getAttribute("href") && a.getAttribute("target") == "_blank") {
            a.target = "_self"
        }
    }
}

function go_top(b, a) {
    var c = document.getElementById(b).offsetTop;
    go_top_timer = setInterval("run_to_top(" + (c + a) + ")", 1)
}

function run_to_top(b) {
    var c = document.documentElement.scrollTop || document.body.scrollTop;
    if (c > b) {
        var a = c - b;
        if (a < 10) {
            c -= a
        } else {
            c -= 10
        }
    } else {
        if (c < b) {
            var a = b - c;
            if (a < 10) {
                c += a
            } else {
                c += 10
            }
        }
    }
    window.scrollTo(0, c);
    if (c == b) {
        clearInterval(go_top_timer)
    }
}

function c_y_g_j_set() {
    var a = window.location.host.split(".")[0];
    if (a == "www" || a == "user") {
        return false
    }
    var b = HL.Cookie.Get("c_y_g_j");
    var d = a;
    var e = 1;
    if (typeof (b) !== "undefined") {
        var f = b.split(",");
        for (var c = 0; c < f.length; c++) {
            if (f[c] !== a) {
                e++;
                d += "," + f[c]
            }
            if (e > 7) {
                break
            }
        }
    }
    HL.Cookie.Set("c_y_g_j", d, 60 * 60 * 24 * 365, "/", "bmcx.com")
}

function sj_menu_qie_huan() {
    if (document.getElementById("pmk_sj_menu").offsetHeight < 1) {
        document.getElementById("pmk_sj_menu_an_niu").style.backgroundPosition = "-740px -72px";
        sj_menu_xian_shi()
    } else {
        document.getElementById("pmk_sj_menu_an_niu").style.backgroundPosition = "-740px -32px";
        sj_menu_yin_cang()
    }
}

function sj_menu_xian_shi() {
    var c = document.getElementById("pmk_sj_menu");
    c.style.height = "auto";
    var b = c.offsetHeight;
    c.style.height = "0px";
    sj_menu_she_zhi_height = 0;
    for (var a = 0; a < b; a++) {
        setTimeout(function () {
            sj_menu_xian_shi_2()
        }, 3 * a)
    }
}

function sj_menu_xian_shi_2() {
    sj_menu_she_zhi_height++;
    document.getElementById("pmk_sj_menu").style.height = sj_menu_she_zhi_height + "px"
}

function sj_menu_yin_cang() {
    var b = document.getElementById("pmk_sj_menu");
    sj_menu_height = b.offsetHeight;
    for (var a = 0; a < sj_menu_height; a++) {
        setTimeout(function () {
            sj_menu_yin_cang_2()
        }, 3 * a)
    }
}

function sj_menu_yin_cang_2() {
    sj_menu_height--;
    document.getElementById("pmk_sj_menu").style.height = sj_menu_height + "px"
}

function jian_ce_yuan_su_shi_fou_ke_jian(a) {
    if (document.getElementById(a) == null) {
        return false
    }
    if ((document.getElementById(a).getBoundingClientRect().right + document.getElementById(a).getBoundingClientRect().bottom) == 0) {
        return false
    }
    return true
}

function all_cookie_du_qu(b) {
    var a = HL.Cookie.Get(b);
    if (typeof (a) !== "undefined" && document.getElementById(b) !== null) {
        document.getElementById(b).value = a
    }
}

function quanjiao_zhuan_banjiao(b) {
    var c = b.value;
    var a = c;
    c = c.replace("\uff10", "0");
    c = c.replace("\uff11", "1");
    c = c.replace("\uff12", "2");
    c = c.replace("\uff13", "3");
    c = c.replace("\uff14", "4");
    c = c.replace("\uff15", "5");
    c = c.replace("\uff16", "6");
    c = c.replace("\uff17", "7");
    c = c.replace("\uff18", "8");
    c = c.replace("\uff19", "9");
    c = c.replace("\u00d7", "*");
    c = c.replace("\u00f7", "/");
    c = c.replace("\uff0d", "-");
    c = c.replace("\uff0b", "+");
    c = c.replace("\uff1d", "=");
    c = c.replace("\u3002", ".");
    c = c.replace("\u300b", ">");
    c = c.replace("\u300a", "<");
    c = c.replace(" ", "");
    if (c != a) {
        b.value = c
    }
}

function zhengze_xiuzheng_shuruneirong(obj, zhengze) {
    var str = obj.value;
    var jieguo = str.replace(eval("/" + zhengze + "/gi"), "");
    if (str != jieguo) {
        obj.value = jieguo
    }
}

function shan_chu_qian_hou_kong_ge(a) {
    return a.replace(/(^\s*)|(\s*$)/g, "")
}

function select_sheng_cheng(g, k, h, l, c, b) {
    if (typeof l == "undefined") {
        l = false
    }
    if (typeof c == "undefined") {
        c = ""
    }
    if (typeof b == "undefined") {
        b = ""
    }
    var e = document.getElementById(g);
    for (i = k; i <= h; i++) {
        if (l == true) {
            var a = bu_0(i, h.toString().length) + c;
            var d = bu_0(i, h.toString().length)
        } else {
            var a = i + c;
            var d = i
        }
        e.options.add(new Option(a, d))
    }
    if (b !== "") {
        if (l == true) {
            document.getElementById(g).value = bu_0(b, h.toString().length)
        } else {
            document.getElementById(g).value = b
        }
    }
}

function bu_0(b, a) {
    b = "0000000" + b;
    return b.substring(b.length - a, b.length)
}

function Ajax(b, e, a, d, c) {
    this.before = b;
    this.after = e;
    this.timeout = a;
    this.time = d ? d : 10000;
    this.async = c ? false : true;
    this._request = null;
    this._response = null
}

Ajax.prototype = {
    formatParam: function (c) {
        if (!c || typeof c != "object") {
            return c
        }
        var a, b = [];
        for (a in c) {
            b.push([a, "=", encodeURIComponent(c[a])].join(""))
        }
        return b.join("&")
    }, create: function () {
        if (window.XMLHttpRequest) {
            this._request = new XMLHttpRequest()
        } else {
            try {
                this._request = new window.ActiveXObject("Microsoft.XMLHTTP")
            } catch (a) {
            }
        }
    }, send: function (b, e, g, d) {
        if (typeof this.before == "function") {
            this.before()
        }
        g = g.toUpperCase();
        this.create();
        var a = this;
        var f = setTimeout(function () {
            if (typeof a.timeout == "function") {
                a.timeout()
            }
            if (a._request) {
                a._request.abort();
                a._request = null
            }
            return true
        }, this.time);
        var c = this.formatParam(e);
        if ("GET" == g) {
            b = [b, (b.indexOf("?") == -1 ? "?" : "&"), c].join("");
            c = null
        }
        if (!d) {
            b = [b, (b.indexOf("?") == -1 ? "?" : "&"), "ajaxtimestamp=", (new Date()).getTime()].join("")
        }
        this._request.open(g, b, this.async);
        if ("POST" == g) {
            this._request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
        }
        this._request.onreadystatechange = function () {
            if (a._request.readyState == 4) {
                if (a._request.status == 200) {
                    if (f) {
                        clearTimeout(f)
                    }
                    a._response = a._request.responseText;
                    if (typeof a.after == "function") {
                        a.after(a._response)
                    }
                }
            }
        };
        this._request.send(c)
    }, get: function (b, d, f, g, c) {
        if (typeof f == "string") {
            f = document.getElementById(f)
        }
        if (g) {
            var a = /\.(gif|jpg|jpeg|png|bmp)$/i;
            if (a.test(g)) {
                g = ['<img src="', g, '"  align="absmiddle" />'].join("")
            }
            this.before = function () {
                f.innerHTML = g
            }
        }
        this.after = function (e) {
            f.innerHTML = e
        };
        this.timeout = function () {
            f.innerHTML = " \u8bf7\u6c42\u8d85\u65f6! "
        };
        this.send(b, d, "GET", c ? true : false)
    }
};

function ajax_run_script(ajaxLoadedData) {
    var regDetectJs = /<script(.|\n)*?>(.|\n|\r\n)*?<\/script>/ig;
    var jsContained = ajaxLoadedData.match(regDetectJs);
    if (jsContained) {
        var regGetJS = /<script(.|\n)*?>((.|\n|\r\n)*)?<\/script>/im;
        var jsNums = jsContained.length;
        for (var i = 0; i < jsNums; i++) {
            var jsSection = jsContained[i].match(regGetJS);
            if (jsSection[2]) {
                if (window.execScript) {
                    window.execScript(jsSection[2])
                } else {
                    window.eval(jsSection[2])
                }
            }
        }
    }
}

var HL = HL || {};
HL.Cookie = {
    Get: function (d) {
        var c = document.cookie.split("; ");
        var g = [], a = [], h = [], b;
        for (i = 0; i < c.length; i++) {
            b = c[i].split("=");
            if (b[0].indexOf("_divide_") > 0) {
                h[b[0]] = b[1]
            } else {
                if (b[0] != "") {
                    a[i] = [b[0], b[1]]
                }
            }
        }
        for (i = 0; i < a.length; i++) {
            if (a[i]) {
                if (a[i][1].substr(0, 8) != "^divide|") {
                    g[a[i][0]] = unescape(a[i][1])
                } else {
                    var f = a[i][1].indexOf("$"), e = a[i][1].substring(8, f);
                    g[a[i][0]] = a[i][1].substring(f + 1);
                    for (j = 1; j < e; j++) {
                        g[a[i][0]] += h[a[i][0] + "_divide_" + j]
                    }
                    g[a[i][0]] = unescape(g[a[i][0]])
                }
            }
        }
        if (d) {
            return g[d]
        } else {
            return g
        }
    }, Set: function (b, k, c, l, d, a, f) {
        if (!f) {
            var k = escape(k)
        }
        if (!b || !k) {
            return false
        }
        if (b == "" || k == "") {
            return false
        }
        if (c) {
            if (/^[0-9]+$/.test(c)) {
                var g = new Date();
                c = new Date(g.getTime() + c * 1000).toGMTString()
            } else {
                if (!/^wed, \d{2} \w{3} \d{4} \d{2}\:\d{2}\:\d{2} GMT$/.test(c)) {
                    c = undefined
                }
            }
        }
        if (b.indexOf("_divide_") < 1 && !f) {
            this.Del(b, l, d)
        }
        var e = b + "=" + k + ";" + ((c) ? " expires=" + c + ";" : "") + ((l) ? "path=" + l + ";" : "") + ((d) ? "domain=" + d + ";" : "") + ((a && a != 0) ? "secure" : "");
        if (e.length < 4096) {
            document.cookie = e
        } else {
            var h = Math.floor(k.length / 3800) + 1;
            for (i = 0; i < h; i++) {
                if (i == 0) {
                    this.Set(b, "^divide|" + h + "$" + k.substr(0, 3800), c, l, d, a, true)
                } else {
                    this.Set(b + "_divide_" + i, k.substr(i * 3800, 3800), c, l, d, a, true)
                }
            }
        }
        return true
    }, Del: function (b, d, c) {
        if (!b) {
            return false
        }
        if (b == "") {
            return false
        }
        if (!this.Get(b)) {
            return false
        }
        if (escape(this.Get(b)).length > 3800) {
            var a = Math.floor(escape(this.Get(b)).length / 3800) + 1;
            for (i = 1; i < a; i++) {
                document.cookie = b + "_divide_" + i + "=;" + ((d) ? "path=" + d + ";" : "") + ((c) ? "domain=" + c + ";" : "") + "expires=Thu, 01-Jan-1970 00:00:01 GMT;"
            }
        }
        document.cookie = b + "=;" + ((d) ? "path=" + d + ";" : "") + ((c) ? "domain=" + c + ";" : "") + "expires=Thu, 01-Jan-1970 00:00:01 GMT;";
        return true
    }
};

function throttle(c, a, e) {
    var d = null, b = new Date();
    return function () {
        var f = new Date();
        clearTimeout(d);
        if (f - b >= e) {
            c();
            b = f
        } else {
            d = setTimeout(c, a)
        }
    }
}

function lazyload() {
    var b = document.getElementsByTagName("img");
    var a = b.length;
    var c = 0;
    return function () {
        var d = document.documentElement.clientHeight;
        var g = document.documentElement.scrollTop || document.body.scrollTop;
        var f;
        for (var e = c; e < a; e++) {
            if (b[e].offsetTop < d + g) {
                f = b[e].getAttribute("l-l-c");
                if (f) {
                    b[e].style.backgroundImage = "url(" + f + ")"
                }
                c = c + 1
            } else {
                return
            }
        }
    }
}

function _push_state_(a) {
    try {
        if (typeof history.pushState === "function") {
            var b = {};
            var d = null;
            history.pushState(b, d, a)
        }
    } catch (c) {
    }
}

function isJSON(c) {
    if (typeof c == "string") {
        try {
            var b = JSON.parse(c);
            if (typeof b == "object" && b) {
                return true
            } else {
                return false
            }
        } catch (a) {
            return false
        }
    }
}
