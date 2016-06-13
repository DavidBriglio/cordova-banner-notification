/* 
 * cordova-banner-notification
 * Created By David Briglio - 2016
 * https://github.com/DavidBriglio/cordova-banner-notification
 * Created under the MIT License.
 *
 */

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
    
    //Displays the banner
    show: function(options) {
        if(options.message === undefined || options.message === null) {
            return false;
        }
        cordova.exec(null, null, "Banner", "show", [options]);
        return true;
    },

    //Adds a function to be executed when a banner is clicked
    addListener: function(func){
        if(typeof(func) === "function"){
            this.__listeners.push(func);
            return true;
        }
        else{
            return false;
        }
    },

    //Clears all listeners
    removeListeners: function(){
        this.__listeners = [];
    }
};

module.exports = Banner;