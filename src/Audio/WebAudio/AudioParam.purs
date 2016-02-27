module Audio.WebAudio.AudioParam where

import Prelude (Unit)

import Control.Monad.Eff (Eff)

import Audio.WebAudio.Types (AudioParam, WebAudio)

foreign import setValue :: forall eff. Number
                        -> AudioParam
                        -> (Eff (wau :: WebAudio | eff) Unit)

foreign import getValue :: forall eff. AudioParam
                        -> (Eff (wau :: WebAudio | eff) Number)

foreign import setValueAtTime :: forall eff. Number
                              -> Number
                              -> AudioParam
                              -> (Eff (wau :: WebAudio | eff) Number)

foreign import linearRampToValueAtTime :: forall eff. Number
                                       -> Number
                                       -> AudioParam
                                       -> (Eff (wau :: WebAudio | eff) Number)

foreign import exponentialRampToValueAtTime :: forall eff. Number
                                            -> Number
                                            -> AudioParam
                                            -> (Eff (wau :: WebAudio | eff) Number)

foreign import cancelScheduledValues :: forall eff. Number
                                     -> AudioParam
                                     -> (Eff (wau :: WebAudio | eff) Number)
