/**
 * 作者：黄晓华
 * 日期：2016/12/28
 * 联系方式：909833608@qq.com
 */
(function($) {
    /**
     * Namespace
     */
    $.extend({
        namespace: function () {
            var a = arguments, o = null, i, j, d, rt;
            for (i = 0; i < a.length; ++i) {
                d = a[i].split(".");
                rt = d[0];
                eval("if (typeof " + rt + " == \"undefined\"){" + rt
                    + " = {};} o = " + rt + ";");
                for (j = 1; j < d.length; ++j) {
                    o[d[j]] = o[d[j]] || {};
                    o = o[d[j]]
                }
            }
            return this;
        }
    });
})(jQuery);