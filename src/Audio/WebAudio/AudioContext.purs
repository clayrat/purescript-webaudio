module Audio.WebAudio.AudioContext where

import Prelude (Unit)

import Control.Monad.Eff (Eff)
import Data.ArrayBuffer.Types ( ArrayBuffer() )
import Data.Maybe (Maybe)

import Audio.WebAudio.Types ( class AudioNode
                            , AudioBuffer
                            , AudioBufferSourceNode
                            , AudioContext
                            , DestinationNode
                            , GainNode
                            , MediaElementAudioSourceNode
                            , OscillatorNode
                            , WebAudio)
import Audio.WebAudio.Utils (unsafeGetProp)

foreign import makeAudioContext :: forall eff. (Eff (wau :: WebAudio | eff) AudioContext)

foreign import createOscillator :: forall eff. AudioContext
                                -> (Eff (wau :: WebAudio | eff) OscillatorNode)

foreign import createGain :: forall eff. AudioContext
                          -> (Eff (wau :: WebAudio | eff) GainNode)

foreign import createMediaElementSource :: forall elt eff. AudioContext
                                        -> elt -- |^ a DOM element from which to construct the source node
                                        -> (Eff (wau :: WebAudio | eff) MediaElementAudioSourceNode)

destination :: forall eff. AudioContext
            -> (Eff (wau :: WebAudio | eff) DestinationNode)
destination = unsafeGetProp "destination"

foreign import currentTime :: forall eff. AudioContext
                           -> (Eff (wau :: WebAudio | eff) Number)

foreign import decodeAudioData :: forall e f. AudioContext
                               -> ArrayBuffer
                               -> (Maybe AudioBuffer -> Eff (wau :: WebAudio | e) Unit)
                               -> (Eff (wau :: WebAudio | f) Unit)

foreign import createBufferSource :: forall eff. AudioContext
                                  -> (Eff (wau :: WebAudio | eff) AudioBufferSourceNode)

-- XXX this is really a method on an AudioNode.

foreign import connect :: forall m n eff. (AudioNode m, AudioNode n) => m
                       -> n
                       -> (Eff (wau :: WebAudio | eff) Unit)
