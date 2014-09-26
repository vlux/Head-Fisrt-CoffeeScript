callback = (message) => @voicemail.push message

#在JS中转换为如下

var callback;
callback = (function(__this){
    var __func = function(message){        #包含我们想绑定当前上下文的代码块
        return this.voicemail.push(message);
    };
    return function(){                    #这里定义的匿名函数是真正的callback
        return __func.apply(__this,arguments);
    };
})(this);
