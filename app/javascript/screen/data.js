ggdm_array = new Array();

function ggdm_xieru(b, d, a) {
    if (typeof (ggdm_array[b]) == "undefined") {
        ggdm_array[b] = new Array()
    }
    var c = ggdm_array[b].length;
    ggdm_array[b][c] = new Array();
    ggdm_array[b][c]["mingan"] = d;
    ggdm_array[b][c]["daima"] = a
}

function ggdm_duqu(c, d) {
    if (c != "") {
        if (!jian_ce_yuan_su_shi_fou_ke_jian(c)) {
            return ""
        }
    }
    if (typeof (ggdm_array[d]) == "undefined") {
        if (c != "") {
            document.getElementById(c).style.display = "none"
        }
        return ""
    }
    var a = ggdm_array[d].shift();
    if (typeof (a) == "undefined") {
        if (c != "") {
            document.getElementById(c).style.display = "none"
        }
        return ""
    } else {
        if (typeof (ggdm_minganshezhi) != "undefined") {
            var f = a.mingan;
            var e = ggdm_minganshezhi.split("|");
            for (var b in e) {
                if (f.indexOf("|" + e[b] + "|") >= 0) {
                    return ggdm_duqu(c, d)
                }
            }
        }
    }
    if (c != "") {
        document.getElementById(c).style.textAlign = "center"
    }
    document.write(a.daima)
}

function xuan_ting(b, f) {
    if (jian_ce_yuan_su_shi_fou_ke_jian(f)) {
        var h = document.getElementById(b).clientHeight;
        var c = document.getElementById(f).clientHeight;
        if (h > c) {
            var e = document.getElementById(b).getBoundingClientRect().top;
            if (e < 0) {
                var a = document.documentElement.clientHeight;
                var d = a - e;
                if (d > a) {
                    d = a
                }
                if ((a - e) > h) {
                    d = h + e
                }
                if (d >= c) {
                    document.getElementById(f).style.position = "fixed";
                    document.getElementById(f).style.top = "0px";
                    document.getElementById(f).style.marginTop = "0px"
                } else {
                    if (d > (c + e)) {
                        var g = -e - (c - d) + "px";
                        document.getElementById(f).style.position = "static";
                        document.getElementById(f).style.marginTop = g
                    } else {
                        document.getElementById(f).style.position = "static";
                        document.getElementById(f).style.top = "0px";
                        document.getElementById(f).style.marginTop = "0px"
                    }
                }
            } else {
                document.getElementById(f).style.position = "static";
                document.getElementById(f).style.top = "0px";
                document.getElementById(f).style.marginTop = "0px"
            }
        }
    }
    setTimeout(function () {
        xuan_ting(b, f)
    }, 100)
}

ggdm_xieru("468x60", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="https://fpbbdx1.bmcx.com/production/lgpci/common/h_dd/resource/y.js"><\/script>');
ggdm_xieru("468x15", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/production/m/h/resource/qdj/i_eed.js"><\/script>');
ggdm_xieru("728x90", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/site/pkt/production/g/source/ml-h-hl.js"><\/script>');
ggdm_xieru("728x90", "|\u5e7f\u544a|\u8c37\u6b4c|\u6027|", '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"><\/script><ins class="adsbygoogle" style="display:inline-block;width:728px;height:90px" data-ad-client="ca-pub-6339460017086194" data-ad-slot="1752736410"></ins><script>(adsbygoogle = window.adsbygoogle || []).push({});<\/script>');
ggdm_xieru("728x90", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/source/l/gpci/common/hd/resource/fv.js"><\/script>');
ggdm_xieru("990x90", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/site/k/source/fuhc/resource/eu_ex.js"><\/script>');
ggdm_xieru("1040x90", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/source/n_i/x_kfhxhh.js"><\/script>');
ggdm_xieru("970x90", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/source/t/oxkq/source/pl/pw.js"><\/script>');
ggdm_xieru("970x90", "|\u5e7f\u544a|\u8c37\u6b4c|\u6027|", '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"><\/script><ins class="adsbygoogle" style="display:inline-block;width:970px;height:90px" data-ad-client="ca-pub-6339460017086194" data-ad-slot="4747455587"></ins><script>(adsbygoogle = window.adsbygoogle || []).push({});<\/script>');
ggdm_xieru("250x250", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/common/nir/production/e/static/k_j/common/fkx.js"><\/script>');
ggdm_xieru("250x250", "|\u5e7f\u544a|\u8c37\u6b4c|\u6027|", '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"><\/script><ins class="adsbygoogle" style="display:inline-block;width:250px;height:250px" data-ad-client="ca-pub-6339460017086194" data-ad-slot="4918702789"></ins><script>(adsbygoogle = window.adsbygoogle || []).push({});<\/script>');
ggdm_xieru("250x250", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/source/pk/source/z/q/static/zq/production/zth.js"><\/script>');
ggdm_xieru("250x250", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/source/ql/openjs/a/common/nik/resource/an_m.js"><\/script>');
ggdm_xieru("300x250", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/source/pktgm/source/l/openjs/h/m/production/g.js"><\/script>');
ggdm_xieru("300x250", "|\u5e7f\u544a|\u8c37\u6b4c|\u6027|", '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"><\/script><ins class="adsbygoogle" style="display:inline-block;width:300px;height:250px" data-ad-client="ca-pub-6339460017086194" data-ad-slot="4257724787"></ins><script>(adsbygoogle = window.adsbygoogle || []).push({});<\/script>');
ggdm_xieru("300x250", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/site/r/m_bsbs/b/common/lb.js"><\/script>');
ggdm_xieru("300x250", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/production/ql_u_hn/mi/static/ni.js"><\/script>');
ggdm_xieru("160x600", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/site/e-z/iwr/common/rw/resource/ry.js"><\/script>');
ggdm_xieru("160x260", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/source/vq/source/ppn/common/y/n/pp.js"><\/script>');
ggdm_xieru("zishiying", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/common/f/production/as/static/ji-gzj-b.js"><\/script>');
ggdm_xieru("zishiying", "|\u5e7f\u544a|\u8c37\u6b4c|\u6027|", '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"><\/script><ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-6339460017086194" data-ad-slot="4240640382" data-ad-format="auto"></ins><script>(adsbygoogle = window.adsbygoogle || []).push({});<\/script>');
ggdm_xieru("zishiying", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/production/ez_oo_h/resource/ohi_i.js"><\/script>');
ggdm_xieru("20bi20", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/production/n-ix/source/xq/openjs/rhj-k.js"><\/script>');
ggdm_xieru("sj_dbhf", "|\u5e7f\u544a|\u767e\u5ea6|", '<script src="//fpbbdx1.bmcx.com/production/qlu_h_n_mi/static/th.js"><\/script>');