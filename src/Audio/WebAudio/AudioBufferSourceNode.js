/* global exports */
"use strict";

// module Audio.WebAudio.AudioBufferSourceNode

exports.setBuffer = function(buf) {
  return function(src) {
    return function() {
      src.buffer = buf;
    };
  };
};

exports.startBufferSource = function(when) {
  return function(src) {
    return function() {
      src.start(when);
    };
  };
};
