<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../common/bootup.jsp" %>
    <link rel="stylesheet" type="text/css" href="${theme_css}/modify-pass.css" />
    <title>修改密码</title>
</head>
<body class="body_1280 body_single"><!--1280居中，单个页面-->
<div class="frame-container">
    <div class="frame-header">
        <div class="system_name">上海移动管理信息系统</div>
    </div>
    <div class="content_full">
        <div class="main">
            <div class="frame-breadcrumb">修改密码</div>
            <div class="balance-bar">
                <ul id="modify_password_ul">
                    <li class="progress-current">
                        <div><span>1</span></div>
                        1.修改密码
                    </li>
                    <li>
                        <div><span>2</span></div>
                        2.完成
                    </li>
                </ul>
            </div>
            <div class="block_layout block_form">
                <div class="block_content" id="modify_password_content">
                    <table cellpadding="0" cellspacing="0" class="table_form"><!--普通表单填写表格使用table_form-->
                        <colgroup>
                            <col style="width:470px;" />
                            <col style="width:100px;" />
                            <col />
                            <col />
                        </colgroup><!--表单表格宽度控制使用colgroup，每个col对应下方的一个td，或者th，上下是对齐的-->
                        <thead></thead><!--表头-->
                        <tfoot><!--表尾，主要放表单按钮-->
                        <tr>
                            <td></td>
                            <td colspan="3">
                                <a id="btn_next"  href="#" class="a_blue"><em>下一步</em></a>
                                <!--<a href="#" class="a_green"><em>取消</em></a>-->
                        </tr>

                        </tfoot>
                        <tbody id = "modify_password_body"><!--表内容，th是蓝色字体，主要放字段名，td为字段内容-->
                        <tr>
                            <th>用户名：</th>
                            <td><input type="textfield" class="input_200" id="modify_password_username"></td>
                            <td><em style="color:#f00;" id="modify_password_checkerr">${error }</em></td>
                        </tr>
						<tr>
							<th>旧密码：</th>
							<td><input type="password" class="input_200" id="modify_password_old"></td>
							<td><em style="color:#f00;display:none" ></em></td>
						</tr>
						<tr>
							<th>新密码：</th>
							<td><input type="password" class="input_200" id="modify_password_new"></td>
							<td><em style="color:#f00;display:none" id="modify_password_checksame1">新密码和旧密码不能相同</em></td>
						</tr>
						<tr>
							<th>新密码：</th>
							<td><input type="password" class="input_200" id="modify_password_new2"></td>
							<td><em style="color:#f00;display:none" id="modify_password_checksame2" >新密码和确认密码不一致</em></td>
						</tr>
                        </tbody>


                    </table>
                </div>
            </div>
        </div>
    </div>

</div>
</body>

<script type="text/javascript">

(function(a,b){if(typeof exports==="object"){module.exports=exports=b()}else{if(typeof define==="function"&&define.amd){define([],b)}else{a.CryptoJS=b()}}}(this,function(){var a=a||(function(f,h){var b={};var c=b.lib={};var k=c.Base=(function(){function o(){}return{extend:function(q){o.prototype=this;var p=new o();if(q){p.mixIn(q)}if(!p.hasOwnProperty("init")){p.init=function(){p.$super.init.apply(this,arguments)}}p.init.prototype=p;p.$super=this;return p},create:function(){var p=this.extend();p.init.apply(p,arguments);return p},init:function(){},mixIn:function(q){for(var p in q){if(q.hasOwnProperty(p)){this[p]=q[p]}}if(q.hasOwnProperty("toString")){this.toString=q.toString}},clone:function(){return this.init.prototype.extend(this)}}}());var m=c.WordArray=k.extend({init:function(p,o){p=this.words=p||[];if(o!=h){this.sigBytes=o}else{this.sigBytes=p.length*4}},toString:function(o){return(o||i).stringify(this)},concat:function(u){var r=this.words;var q=u.words;var o=this.sigBytes;var t=u.sigBytes;this.clamp();if(o%4){for(var s=0;s<t;s++){var p=(q[s>>>2]>>>(24-(s%4)*8))&255;r[(o+s)>>>2]|=p<<(24-((o+s)%4)*8)}}else{for(var s=0;s<t;s+=4){r[(o+s)>>>2]=q[s>>>2]}}this.sigBytes+=t;return this},clamp:function(){var p=this.words;var o=this.sigBytes;p[o>>>2]&=4294967295<<(32-(o%4)*8);p.length=f.ceil(o/4)},clone:function(){var o=k.clone.call(this);o.words=this.words.slice(0);return o},random:function(u){var t=[];var q=(function(w){var w=w;var v=987654321;var r=4294967295;return function(){v=(36969*(v&65535)+(v>>16))&r;w=(18000*(w&65535)+(w>>16))&r;var x=((v<<16)+w)&r;x/=4294967296;x+=0.5;return x*(f.random()>0.5?1:-1)}});for(var p=0,o;p<u;p+=4){var s=q((o||f.random())*4294967296);o=s()*987654071;t.push((s()*4294967296)|0)}return new m.init(t,u)}});var n=b.enc={};var i=n.Hex={stringify:function(q){var s=q.words;var p=q.sigBytes;var r=[];for(var o=0;o<p;o++){var t=(s[o>>>2]>>>(24-(o%4)*8))&255;r.push((t>>>4).toString(16));r.push((t&15).toString(16))}return r.join("")},parse:function(q){var o=q.length;var r=[];for(var p=0;p<o;p+=2){r[p>>>3]|=parseInt(q.substr(p,2),16)<<(24-(p%8)*4)}return new m.init(r,o/2)}};var e=n.Latin1={stringify:function(r){var s=r.words;var q=r.sigBytes;var o=[];for(var p=0;p<q;p++){var t=(s[p>>>2]>>>(24-(p%4)*8))&255;o.push(String.fromCharCode(t))}return o.join("")},parse:function(q){var o=q.length;var r=[];for(var p=0;p<o;p++){r[p>>>2]|=(q.charCodeAt(p)&255)<<(24-(p%4)*8)}return new m.init(r,o)}};var d=n.Utf8={stringify:function(o){try{return decodeURIComponent(escape(e.stringify(o)))}catch(p){throw new Error("Malformed UTF-8 data")}},parse:function(o){return e.parse(unescape(encodeURIComponent(o)))}};var j=c.BufferedBlockAlgorithm=k.extend({reset:function(){this._data=new m.init();this._nDataBytes=0},_append:function(o){if(typeof o=="string"){o=d.parse(o)}this._data.concat(o);this._nDataBytes+=o.sigBytes},_process:function(x){var r=this._data;var y=r.words;var o=r.sigBytes;var u=this.blockSize;var w=u*4;var v=o/w;if(x){v=f.ceil(v)}else{v=f.max((v|0)-this._minBufferSize,0)}var t=v*u;var s=f.min(t*4,o);if(t){for(var q=0;q<t;q+=u){this._doProcessBlock(y,q)}var p=y.splice(0,t);r.sigBytes-=s}return new m.init(p,s)},clone:function(){var o=k.clone.call(this);o._data=this._data.clone();return o},_minBufferSize:0});var g=c.Hasher=j.extend({cfg:k.extend(),init:function(o){this.cfg=this.cfg.extend(o);this.reset()},reset:function(){j.reset.call(this);this._doReset()},update:function(o){this._append(o);this._process();return this},finalize:function(o){if(o){this._append(o)}var p=this._doFinalize();return p},blockSize:512/32,_createHelper:function(o){return function(q,p){return new o.init(p).finalize(q)}},_createHmacHelper:function(o){return function(q,p){return new l.HMAC.init(o,p).finalize(q)}}});var l=b.algo={};return b}(Math));a.lib.Cipher||(function(e){var n=a;var x=n.lib;var j=x.Base;var u=x.WordArray;var w=x.BufferedBlockAlgorithm;var s=n.enc;var g=s.Utf8;var m=s.Base64;var c=n.algo;var i=c.EvpKDF;var k=x.Cipher=w.extend({cfg:j.extend(),createEncryptor:function(C,B){return this.create(this._ENC_XFORM_MODE,C,B)},init:function(D,C,B){this.cfg=this.cfg.extend(B);this._xformMode=D;this._key=C;this.reset()},reset:function(){w.reset.call(this);this._doReset()},process:function(B){this._append(B);return this._process()},finalize:function(C){if(C){this._append(C)}var B=this._doFinalize();return B},keySize:128/32,ivSize:128/32,_ENC_XFORM_MODE:1,_DEC_XFORM_MODE:2,_createHelper:(function(){function B(C){if(typeof C=="string"){return h}else{return A}}return function(C){return{encrypt:function(F,E,D){return B(E).encrypt(C,F,E,D)}}}}())});var q=x.StreamCipher=k.extend({_doFinalize:function(){var B=this._process(!!"flush");return B},blockSize:1});var t=n.mode={};var z=x.BlockCipherMode=j.extend({createEncryptor:function(B,C){return this.Encryptor.create(B,C)},createDecryptor:function(B,C){return this.Decryptor.create(B,C)},init:function(B,C){this._cipher=B;this._iv=C}});var d=t.CBC=(function(){var B=z.extend();B.Encryptor=B.extend({processBlock:function(G,F){var D=this._cipher;var E=D.blockSize;C.call(this,G,F,E);D.encryptBlock(G,F);this._prevBlock=G.slice(F,F+E)}});function C(I,H,F){var D=this._iv;if(D){var G=D;this._iv=e}else{var G=this._prevBlock}for(var E=0;E<F;E++){I[H+E]^=G[E]}}return B}());var f=n.pad={};var b=f.Pkcs7={pad:function(G,E){var F=E*4;var I=F-G.sigBytes%F;var B=(I<<24)|(I<<16)|(I<<8)|I;var D=[];for(var C=0;C<I;C+=4){D.push(B)}var H=u.create(D,I);G.concat(H)}};var r=x.BlockCipher=k.extend({cfg:k.cfg.extend({mode:d,padding:b}),reset:function(){k.reset.call(this);var B=this.cfg;var C=B.iv;var E=B.mode;if(this._xformMode==this._ENC_XFORM_MODE){var D=E.createEncryptor}else{var D=E.createDecryptor;this._minBufferSize=1}this._mode=D.call(E,this,C&&C.words)},_doProcessBlock:function(C,B){this._mode.processBlock(C,B)},_doFinalize:function(){var C=this.cfg.padding;if(this._xformMode==this._ENC_XFORM_MODE){C.pad(this._data,this.blockSize);var B=this._process(!!"flush")}return B},blockSize:128/32});var p=x.CipherParams=j.extend({init:function(B){this.mixIn(B)},toString:function(B){return(B||this.formatter).stringify(this)}});var o=n.format={};var v=o.OpenSSL={stringify:function(B){var E=B.ciphertext;var C=B.salt;if(C){var D=u.create([1398893684,1701076831]).concat(C).concat(E)}else{var D=E}return D.toString(m)},parse:function(D){var C=m.parse(D);var E=C.words;if(E[0]==1398893684&&E[1]==1701076831){var B=u.create(E.slice(2,4));E.splice(0,4);C.sigBytes-=16}return p.create({ciphertext:C,salt:B})}};var A=x.SerializableCipher=j.extend({cfg:j.extend({format:v}),encrypt:function(B,G,E,C){C=this.cfg.extend(C);var D=B.createEncryptor(E,C);var H=D.finalize(G);var F=D.cfg;return p.create({ciphertext:H,key:E,iv:F.iv,algorithm:B,mode:F.mode,padding:F.padding,blockSize:B.blockSize,formatter:C.format})},_parse:function(B,C){if(typeof B=="string"){return C.parse(B,this)}else{return B}}});var l=n.kdf={};var y=l.OpenSSL={execute:function(D,G,B,F){if(!F){F=u.random(64/8)}var E=i.create({keySize:G+B}).compute(D,F);var C=u.create(E.words.slice(G),B*4);E.sigBytes=G*4;return p.create({key:E,iv:C,salt:F})}};var h=x.PasswordBasedCipher=A.extend({cfg:A.cfg.extend({kdf:y}),encrypt:function(B,E,D,C){C=this.cfg.extend(C);var G=C.kdf.execute(D,B.keySize,B.ivSize);C.iv=G.iv;var F=A.encrypt.call(this,B,E,G.key,C);F.mixIn(G);return F},decrypt:function(B,F,D,C){C=this.cfg.extend(C);F=this._parse(F,C.format);var G=C.kdf.execute(D,B.keySize,B.ivSize,F.salt);C.iv=G.iv;var E=A.decrypt.call(this,B,F,G.key,C);return E}})}());(function(h){var g=a;var d=g.lib;var c=d.CipherParams;var f=g.enc;var b=f.Hex;var i=g.format;var e=i.Hex={stringify:function(j){return j.ciphertext.toString(b)},parse:function(j){var k=b.parse(j);return c.create({ciphertext:k})}}}());(function(){var b=a;var c=b.lib;var q=c.BlockCipher;var l=b.algo;var e=[];var m=[];var p=[];var o=[];var n=[];var k=[];var j=[];var i=[];var h=[];var g=[];(function(){var u=[];for(var s=0;s<256;s++){if(s<128){u[s]=s<<1}else{u[s]=(s<<1)^283}}var y=0;var v=0;for(var s=0;s<256;s++){var w=v^(v<<1)^(v<<2)^(v<<3)^(v<<4);w=(w>>>8)^(w&255)^99;e[y]=w;m[w]=y;var r=u[y];var B=u[r];var z=u[B];var A=(u[w]*257)^(w*16843008);p[y]=(A<<24)|(A>>>8);o[y]=(A<<16)|(A>>>16);n[y]=(A<<8)|(A>>>24);k[y]=A;var A=(z*16843009)^(B*65537)^(r*257)^(y*16843008);j[w]=(A<<24)|(A>>>8);i[w]=(A<<16)|(A>>>16);h[w]=(A<<8)|(A>>>24);g[w]=A;if(!y){y=v=1}else{y=r^u[u[u[z^r]]];v^=u[u[v]]}}}());var d=[0,1,2,4,8,16,32,64,128,27,54];var f=l.AES=q.extend({_doReset:function(){var A=this._key;var s=A.words;var z=A.sigBytes/4;var y=this._nRounds=z+6;var r=(y+1)*4;var u=this._keySchedule=[];for(var x=0;x<r;x++){if(x<z){u[x]=s[x]}else{var B=u[x-1];if(!(x%z)){B=(B<<8)|(B>>>24);B=(e[B>>>24]<<24)|(e[(B>>>16)&255]<<16)|(e[(B>>>8)&255]<<8)|e[B&255];B^=d[(x/z)|0]<<24}else{if(z>6&&x%z==4){B=(e[B>>>24]<<24)|(e[(B>>>16)&255]<<16)|(e[(B>>>8)&255]<<8)|e[B&255]}}u[x]=u[x-z]^B}}var v=this._invKeySchedule=[];for(var w=0;w<r;w++){var x=r-w;if(w%4){var B=u[x]}else{var B=u[x-4]}if(w<4||x<=4){v[w]=B}else{v[w]=j[e[B>>>24]]^i[e[(B>>>16)&255]]^h[e[(B>>>8)&255]]^g[e[B&255]]}}},encryptBlock:function(s,r){this._doCryptBlock(s,r,this._keySchedule,p,o,n,k,e)},_doCryptBlock:function(A,z,I,w,u,s,r,H){var F=this._nRounds;var y=A[z]^I[0];var x=A[z+1]^I[1];var v=A[z+2]^I[2];var t=A[z+3]^I[3];var G=4;for(var J=1;J<F;J++){var E=w[y>>>24]^u[(x>>>16)&255]^s[(v>>>8)&255]^r[t&255]^I[G++];var D=w[x>>>24]^u[(v>>>16)&255]^s[(t>>>8)&255]^r[y&255]^I[G++];var C=w[v>>>24]^u[(t>>>16)&255]^s[(y>>>8)&255]^r[x&255]^I[G++];var B=w[t>>>24]^u[(y>>>16)&255]^s[(x>>>8)&255]^r[v&255]^I[G++];y=E;x=D;v=C;t=B}var E=((H[y>>>24]<<24)|(H[(x>>>16)&255]<<16)|(H[(v>>>8)&255]<<8)|H[t&255])^I[G++];var D=((H[x>>>24]<<24)|(H[(v>>>16)&255]<<16)|(H[(t>>>8)&255]<<8)|H[y&255])^I[G++];var C=((H[v>>>24]<<24)|(H[(t>>>16)&255]<<16)|(H[(y>>>8)&255]<<8)|H[x&255])^I[G++];var B=((H[t>>>24]<<24)|(H[(y>>>16)&255]<<16)|(H[(x>>>8)&255]<<8)|H[v&255])^I[G++];A[z]=E;A[z+1]=D;A[z+2]=C;A[z+3]=B},keySize:256/32});b.AES=q._createHelper(f)}());a.pad.ZeroPadding={pad:function(d,b){var c=b*4;d.clamp();d.sigBytes+=c-((d.sigBytes%c)||c)}};return a}));function encryptText(d,b,a){var b=CryptoJS.enc.Utf8.parse(b);var a=CryptoJS.enc.Utf8.parse(a);var d=CryptoJS.enc.Utf8.parse(d);var c=CryptoJS.AES.encrypt(d,b,{iv:a,mode:CryptoJS.mode.CBC,padding:CryptoJS.pad.Pkcs7});return c.ciphertext.toString();};

var encryptBySha1 = {};
encryptBySha1.str2binb = function(str){
    var chrsz = 8;
    var bin = Array();
    var mask = (1 << chrsz) - 1;
    for (var i = 0; i < str.length * chrsz; i += chrsz)
        bin[i >> 5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i % 32);
    return bin;
};
encryptBySha1.sha1_ft = function (t, b, c, d) {
    if (t < 20) return (b & c) | ((~b) & d);
    if (t < 40) return b ^ c ^ d;
    if (t < 60) return (b & c) | (b & d) | (c & d);
    return b ^ c ^ d;
};
encryptBySha1.sha1_kt = function(t) {
    return (t < 20) ? 1518500249 : (t < 40) ? 1859775393 : (t < 60) ? -1894007588 : -899497514;
}
encryptBySha1.safe_add = function(x, y) {
    var lsw = (x & 0xFFFF) + (y & 0xFFFF);
    var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
    return (msw << 16) | (lsw & 0xFFFF);
}
encryptBySha1.core_sha1 = function(x, len){
    x[len >> 5] |= 0x80 << (24 - len % 32);
    x[((len + 64 >> 9) << 4) + 15] = len;

    var w = Array(80);
    var a = 1732584193;
    var b = -271733879;
    var c = -1732584194;
    var d = 271733878;
    var e = -1009589776;

    function rol(num, cnt) {
        return (num << cnt) | (num >>> (32 - cnt));
    }

    for (var i = 0; i < x.length; i += 16) {
        var olda = a;
        var oldb = b;
        var oldc = c;
        var oldd = d;
        var olde = e;

        for (var j = 0; j < 80; j++) {
            if (j < 16) w[j] = x[i + j];
            else w[j] = rol(w[j - 3] ^ w[j - 8] ^ w[j - 14] ^ w[j - 16], 1);
            var t = encryptBySha1.safe_add(encryptBySha1.safe_add(rol(a, 5), encryptBySha1.sha1_ft(j, b, c, d)), encryptBySha1.safe_add(this.safe_add(e, w[j]), encryptBySha1.sha1_kt(j)));
            e = d;
            d = c;
            c = rol(b, 30);
            b = a;
            a = t;
        }

        a = encryptBySha1.safe_add(a, olda);
        b = encryptBySha1.safe_add(b, oldb);
        c = encryptBySha1.safe_add(c, oldc);
        d = encryptBySha1.safe_add(d, oldd);
        e = encryptBySha1.safe_add(e, olde);
    }

    return Array(a, b, c, d, e);
}
encryptBySha1.binb2hex = function(binarray){
    var hex_tab = 0 ? "0123456789ABCDEF" : "0123456789abcdef";
    var str = "";
    for (var i = 0; i < binarray.length * 4; i++) {
        str += hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8 + 4)) & 0xF) + hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8)) & 0xF);
    }
    return str;
}
encryptBySha1.encrypt = function (data, key){
    return encryptBySha1.binb2hex(encryptBySha1.core_sha1(encryptBySha1.str2binb(data+key), (data+key).length * 8));
};


	var pageIndex = 1;
	
	$('#btn_next').click(function(){
		

		
		
		modifyPassword();

		
	})
	
	
	
	function modifyPassword(){
		
		var username=  $('#modify_password_username').val();
		var oldPass = $('#modify_password_old').val();
		var newPass = $('#modify_password_new').val();
		var newPass2 = $('#modify_password_new2').val();

		if(oldPass == newPass){
			$('#modify_password_checksame1').show();
			return;
		}else{
			$('#modify_password_checksame1').hide();
		}

		if(newPass != newPass2){
			$('#modify_password_checksame2').show();
			return;
		}else{
			$('#modify_password_checksame2').hide();
		}
		var params = {
                'j_passwordtype':encryptText("1", '${EncryptKey}','${EncryptIv}'),
                'j_username': encryptText(username, '${EncryptKey}','${EncryptIv}'),
                'j_password': encryptText(encryptBySha1.encrypt(oldPass, '${ValidateCode}'+username),'${EncryptKey}','${EncryptIv}'),
                'j_newpassword': encryptText(newPass, '${EncryptKey}','${EncryptIv}'),
				'j_validcode':encryptText('${ValidateCode}', '${EncryptKey}','${EncryptIv}')
        }

	var form = document.createElement("form");
    var j_username = document.createElement("input");
    j_username.setAttribute("type", "hidden");
    j_username.setAttribute("name", "j_username");
    j_username.setAttribute("value", encryptText(username, '${EncryptKey}','${EncryptIv}'));

    var j_password = document.createElement("input");
    j_password.setAttribute("type", "hidden");
    j_password.setAttribute("name", "j_password");
    j_password.setAttribute("value", encryptText(encryptBySha1.encrypt(oldPass, '${ValidateCode}'+username),'${EncryptKey}','${EncryptIv}'));

    var j_verifycode = document.createElement("input");
    j_verifycode.setAttribute("type", "hidden");
    j_verifycode.setAttribute("name", "j_validcode");
    j_verifycode.setAttribute("value", encryptText('${ValidateCode}', '${EncryptKey}','${EncryptIv}'));

    var j_passwordtype = document.createElement("input");
    j_passwordtype.setAttribute("type", "hidden");
    j_passwordtype.setAttribute("name", "j_passwordtype");
    j_passwordtype.setAttribute("value", encryptText("1", '${EncryptKey}','${EncryptIv}'));

	var j_newpassword = document.createElement("input");
	j_newpassword.setAttribute("type", "hidden");
	j_newpassword.setAttribute("name", "j_newpassword");
	j_newpassword.setAttribute("value", encryptText(newPass,'${EncryptKey}','${EncryptIv}'));

    document.body.appendChild(form);
    form.appendChild(j_username);
    form.appendChild(j_password);
    form.appendChild(j_verifycode);
	form.appendChild(j_newpassword);
    form.appendChild(j_passwordtype);

    form.action = g_basePath + 'j_spring_security_check',
    form.method = "POST";
    form.submit();

	}
</script>
</html>