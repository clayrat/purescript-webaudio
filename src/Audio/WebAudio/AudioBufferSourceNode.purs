module Audio.WebAudio.AudioBufferSourceNode where

import Prelude (Unit(..))

import Control.Monad.Eff (Eff(..))

import Audio.WebAudio.Types ( AudioNode
                            , AudioBuffer(..)
                            , AudioBufferSourceNode(..)
                            , WebAudio(..))

foreign import setBuffer :: forall wau eff. AudioBuffer
                         -> AudioBufferSourceNode
                         -> (Eff (wau :: WebAudio | eff) Unit)

foreign import startBufferSource :: forall wau eff. Number
                                 -> AudioBufferSourceNode
                                 -> (Eff (wau :: WebAudio | eff) Unit)
