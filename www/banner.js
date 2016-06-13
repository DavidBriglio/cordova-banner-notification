

var exec = require("cordova/exec");

var Banner = {
    
    __listeners: [],
    
    //Handler function for when a banner is clicked
    __click: function(data){
        //Ececute all listening functions passing in the banner options
        for( var f of this.__listeners) {
            f(data);
        }
    },
    
    //Displays the notification
    show: function(options) {
        cordova.exec(null, null, "Banner", "show", [options]);
    },

    //Adds a function to be executed when a notification is clicked
    addListener: function(func){
        this.__listeners.push(func);
    },

    //Clears all listeners
    removeListeners: function(){
        this.__listeners = [];
    }
};

module.exports = Banner;