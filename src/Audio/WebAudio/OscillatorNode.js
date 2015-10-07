/* global exports */
"use strict";

// module Audio.WebAudio.OscillatorNode

exports.startOscillator = function(when) {
  return function(n) {
    return function() {
      return n[n.start ? 'start' : 'noteOn'](when);
    };
  };
};

exports.stopOscillator = function(when) {
  return function(n) {
    return function() {
      return n[n.stop ? 'stop' : 'noteOff'](when);
    };
  };
};
