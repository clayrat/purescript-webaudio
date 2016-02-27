module Audio.WebAudio.AudioBufferSourceNode where

import Prelude (Unit)

import Control.Monad.Eff (Eff)

import Audio.WebAudio.Types (AudioBuffer, AudioBufferSourceNode, WebAudio)

foreign import setBuffer :: forall eff. AudioBuffer
                         -> AudioBufferSourceNode
                         -> (Eff (wau :: WebAudio | eff) Unit)

foreign import startBufferSource :: forall eff. Number
                                 -> AudioBufferSourceNode
                                 -> (Eff (wau :: WebAudio | eff) Unit)
