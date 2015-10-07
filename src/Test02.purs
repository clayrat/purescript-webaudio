module Test02 where

import Prelude ( Unit()
               , (<$>), ($)
               , bind, return, unit )

import Control.Monad.Eff ( Eff() )
import Data.Maybe.Unsafe ( fromJust )
import Data.Nullable ( toMaybe )
import DOM ( DOM() )
import DOM.HTML ( window )
import DOM.HTML.Types (htmlDocumentToNonElementParentNode)
import DOM.HTML.Window ( document )
import DOM.Node.NonElementParentNode ( getElementById )
import DOM.Node.Types ( ElementId(..) )

import Audio.WebAudio.Types ( DestinationNode()
                            , MediaElementAudioSourceNode()
                            , WebAudio())
import Audio.WebAudio.AudioContext ( connect
                                   , createMediaElementSource
                                   , destination
                                   , makeAudioContext )


main :: forall wau eff. (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
main = do
  globalWindow <- window
  doc <- document globalWindow
  let noiseId = ElementId "noise"
      documentNode = htmlDocumentToNonElementParentNode doc
  elt <- fromJust <$> toMaybe <$> getElementById noiseId documentNode
  ctx <- makeAudioContext
  src <- createMediaElementSource ctx elt
  dest <- destination ctx
  connect src dest
  -- t <- currentTime cx
  return unit
