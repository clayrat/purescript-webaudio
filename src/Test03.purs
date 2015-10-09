module Test03 where

import Prelude ( Unit()
               , ($)
               , bind, return, unit )

import Control.Monad.Aff ( Aff()
                         , launchAff)
import Control.Monad.Eff ( Eff() )
import Control.Monad.Eff.Class ( liftEff )
import Data.ArrayBuffer.Types ( ArrayBuffer() )
import Data.Foreign ( unsafeReadTagged )
import Data.Maybe ( Maybe(..) )
import DOM ( DOM() )
import DOM.File.Types ( Blob() )
import Network.HTTP.Affjax ( AffjaxResponse()
                           , AJAX()
                           , get )
import Network.HTTP.Affjax.Response ( Respondable
                                    , ResponseType(..) )

import Audio.WebAudio.Types ( AudioBuffer()
                            , AudioBufferSourceNode()
                            , DestinationNode()
                            , WebAudio() )
import Audio.WebAudio.AudioBufferSourceNode ( setBuffer
                                            , startBufferSource )
import Audio.WebAudio.AudioContext ( connect
                                   , createBufferSource
                                   , decodeAudioData
                                   , destination
                                   , makeAudioContext)

main = launchAff $ do
  -- I have no idea why I have explicitly specify the type here but I kept
  -- encountering the error discussed here and used the poster's workaround:
  --
  -- http://chrisdone.com:10001/browse/purescript?events_page=3428
  --
  -- Also, I needed to set the response type to ArrayBuffer because that's
  -- what the underlying JavaScript call to decodeAudioData requires.
  -- This then meant at change to purescript-affjax to add a Respondable
  -- instance to Network.HTTP.Affjax.Response. (It couldn't be added here
  -- because PureScript doesn't allow "orphan instances" anymore.)
  affjaxResponse <- get "/html/siren.wav" :: Aff ( ajax :: AJAX ) (AffjaxResponse ArrayBuffer)

  -- This is needed to lift everything in the Eff monad into the Aff monad...
  -- I think... :S
  liftEff $ do
    let audioData = affjaxResponse.response
    ctx <- makeAudioContext
    src <- createBufferSource ctx
    dst <- destination ctx
    connect src dst
    decodeAudioData ctx audioData $ play' src

play' :: forall eff. AudioBufferSourceNode
      -> (Maybe AudioBuffer)
      -> (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
play' src (Just buf) = do
  setBuffer buf src
  startBufferSource 0.0 src

play' _ Nothing = return unit
