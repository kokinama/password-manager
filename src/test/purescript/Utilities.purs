module Test.Utilities where

import Control.Bind (bind, discard)
import Data.Argonaut.Core as A
import Data.BigInt (fromInt, toString, fromString)
import Data.Function (($))
import Data.HexString (hex, toArrayBuffer, fromArrayBuffer, toBigInt, Base(..))
import Data.HexString as HexString
import Data.Identity (Identity)
import Data.List (List(..), (:))
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Semigroup ((<>))
import Data.Unit (Unit)
import Effect.Aff (Aff)
import SRP (hashFuncSHA256)
import Test.Spec (describe, it, SpecT)
import Test.Spec.Assertions (shouldEqual)
import TestUtilities (makeTestableOnBrowser, failOnBrowser)
import Utilities (emptyByteArrayBuffer, xor, arrayBufferToBigInt, bigIntToArrayBuffer)

utilitiesSpec :: SpecT Aff Unit Identity Unit
utilitiesSpec =
  describe "Utilities" do
    
    let xorEmptyAb = "calculates xor between two emtpy arraybuffers of same length"
    it xorEmptyAb do
      let ab = emptyByteArrayBuffer 2
      let ab' = emptyByteArrayBuffer 2
      makeTestableOnBrowser xorEmptyAb (fromArrayBuffer (xor ab ab')) shouldEqual (fromArrayBuffer ab)
    
    let xorAbSameLength = "calculates xor between two different arraybuffers of same length"
    it xorAbSameLength do
      let ab = toArrayBuffer $ hex "ciao" -- TODO: these are not hex strings
      let ab' = toArrayBuffer $ hex "oaic"
      makeTestableOnBrowser xorAbSameLength (fromArrayBuffer (xor ab ab')) shouldEqual $ hex "0c08080c"
    
    let xorEmptyAbDifferentLength = "calculates xor between two empty arraybuffers of different length"
    it xorEmptyAbDifferentLength do
      let ab = emptyByteArrayBuffer 3
      let ab' = emptyByteArrayBuffer 2
      makeTestableOnBrowser (xorEmptyAbDifferentLength <> " 1") (fromArrayBuffer (xor ab ab')) shouldEqual (fromArrayBuffer ab)
      makeTestableOnBrowser (xorEmptyAbDifferentLength <> " 2") (fromArrayBuffer (xor ab' ab)) shouldEqual (fromArrayBuffer ab)
    
    let xorAbDifferenteLenght = "calculates xor between two different arraybuffers of different length"
    it xorAbDifferenteLenght do
      let ab = toArrayBuffer $ hex "ciao"
      let ab' = toArrayBuffer $ hex "hello"
      makeTestableOnBrowser xorAbDifferenteLenght (fromArrayBuffer (xor ab ab')) shouldEqual $ hex "6806050d00"
    
    let hexToBigInt = "converts hex string to bigInt"
    it hexToBigInt do
      let hexN = hex $ "EEAF0AB9 ADB38DD6 9C33F80A FA8FC5E8 60726187 75FF3C0B 9EA2314C"
               <> "9C256576 D674DF74 96EA81D3 383B4813 D692C6E0 E0D5D8E2 50B98BE4"
               <> "8E495C1D 6089DAD1 5DC7D7B4 6154D6B6 CE8EF4AD 69B15D49 82559B29"
               <> "7BCF1885 C529F566 660E57EC 68EDBC3C 05726CC0 2FD4CBF4 976EAA9A"
               <> "FD5138FE 8376435B 9FC61D2F C0EB06E3"
      let n = "167609434410335061345139523764350090260135525329813904557420930309800865859473551531551523800013916573891864789934747039010546328480848979516637673776605610374669426214776197828492691384519453218253702788022233205683635831626913357154941914129985489522629902540768368409482248290641036967659389658897350067939"
      makeTestableOnBrowser hexToBigInt (toString (fromMaybe (fromInt 0) (toBigInt hexN))) shouldEqual n

    let hexStringAb = "converts Hex String to ArrayBuffer and ArrayBuffer to Hex String"
    it hexStringAb do
      let initialString = hex $ "7556aa045aef2cdd07abaf0f665c3e818913186f"
      let s = fromArrayBuffer (toArrayBuffer initialString)
      makeTestableOnBrowser hexStringAb initialString shouldEqual s

    let hexStringToBigInt = "converts Hex String to BigInt and BigInt to Hex String"
    it hexStringToBigInt do
      let hexString = hex $ "8e450b3ad3793a4b7e83d01d312f745b84593eed5fe61da138d73d57579c06b72a3d7a8e139eb610c1d33d7f0fb20dfcde1feefffb1922667b0f1fecd524c403ad6a338c950db11724b45af9519ba19c4f09edbd86f2ba2a022fdcddf61a26ae74d26c137876136b470e131d8e0b2ba4a14488030bb1fbde2e3dc0b650880896"
      let bigInt = fromMaybe (fromInt 0) (fromString "99905182682926710034291505584774964118706026472968269892820516099472446894131080528280228945656820340253787827762984065893078244231584865127194615626559242385750842515189538992818614416042581168624977993291417312000510083931042565737037728892271188331053661275313041128939302890592560743204670369750965553302")
      makeTestableOnBrowser (hexStringToBigInt <> " 1 upper") bigInt shouldEqual (fromMaybe (fromInt 0) (toBigInt hexString))

    let stringToHexAndBack = "converts String to Hex String and Hex String to String"
    it stringToHexAndBack do
      let initialString = "tschüs"
      makeTestableOnBrowser stringToHexAndBack initialString shouldEqual (HexString.toString Dec $ hex initialString)

    let stringToHex = "converts String to Hex string"
    it stringToHex do
      let initialString = "tschüs"
      let hexString = hex $ "74736368c3bc73"
      makeTestableOnBrowser stringToHex hexString shouldEqual (hex initialString)
    
    let hexToString = "converts Hex string to String"
    it hexToString do
      let initialString = "tschüs"
      let hexString = hex $ "74736368c3bc73"
      makeTestableOnBrowser hexToString initialString shouldEqual (HexString.toString Dec hexString)

    let bigIntAb = "converts BigInt to ArrayBuffer and ArrayBuffer to BigInt"
    it bigIntAb do
      let initialBigInt = fromInt 94125839
      let bi = fromMaybe (fromInt 0) $ arrayBufferToBigInt (bigIntToArrayBuffer initialBigInt)
      makeTestableOnBrowser bigIntAb initialBigInt shouldEqual bi
    
    let bigIntAbHex = "converts BigInt to ArrayBuffer to Hex and back (fromArrayBuffer)"
    it bigIntAbHex do
      let initialBigInt = fromInt 94   
      let res = fromArrayBuffer (bigIntToArrayBuffer initialBigInt)
      let eebi = toBigInt res
      case eebi of
        Nothing -> failOnBrowser bigIntAbHex "fromArrayBuffer doesn't return an hex string"
        Just bi -> do
          makeTestableOnBrowser (bigIntAbHex) initialBigInt shouldEqual bi

    let hexToJson = "converts String to Json and Back"
    it hexToJson do
      let initialHexString = "7556AA045AEF2CDD07ABAF0F665C3E818913186F"
      let maybeHex = A.toString (A.fromString initialHexString)
      case maybeHex of
        Nothing  -> failOnBrowser hexToJson "Cannot convert json to string"
        Just hex -> do
          makeTestableOnBrowser hexToJson initialHexString shouldEqual hex

    let hashOfArrayBuffer = "computes hash of array buffer"
    it hashOfArrayBuffer do
      let hexS = hex $ "ae748c65c2fe54d4a39dac0229e8fe99ec07327c9629e2c50b0c20df46461dabd2145ae482197da64b20b66962b5f693f2e45acae2155c1f1e206abf2aa5625b149c518577b693d03191a5e7654aa94ae206ec49e6a4144110f5211427f9f7fb9d37736bcb8098f51f2a6024b9d5e2781b4a529b0b888136bbfe58ee0295451d"
      let ab = toArrayBuffer hexS
      hash <- hashFuncSHA256 (ab : Nil)
      let hexHash = fromArrayBuffer hash
      let result = hex $ "1e3fee047d1405f6c685e4954841e807cd32ff155f828bf4727bf2e67c0815f2"
      makeTestableOnBrowser hashOfArrayBuffer hexHash shouldEqual result
