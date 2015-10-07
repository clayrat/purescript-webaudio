module Audio.WebAudio.AudioParam where

import Prelude (Unit(..))

import Control.Monad.Eff (Eff(..))

import Audio.WebAudio.Types ( AudioParam(..)
                            , WebAudio(..))

foreign import setValue :: forall wau eff. Number
                        -> AudioParam
                        -> (Eff (wau :: WebAudio | eff) Unit)

foreign import getValue :: forall wau eff. AudioParam
                        -> (Eff (wau :: WebAudio | eff) Number)

foreign import setValueAtTime :: forall wau eff. Number
                              -> Number
                              -> AudioParam
                              -> (Eff (wau :: WebAudio | eff) Number)

foreign import linearRampToValueAtTime :: forall wau eff. Number
                                       -> Number
                                       -> AudioParam
                                       -> (Eff (wau :: WebAudio | eff) Number)

foreign import exponentialRampToValueAtTime :: forall wau eff. Number
                                            -> Number
                                            -> AudioParam
                                            -> (Eff (wau :: WebAudio | eff) Number)

foreign import cancelScheduledValues :: forall wau eff. Number
                                     -> AudioParam
                                     -> (Eff (wau :: WebAudio | eff) Number)
