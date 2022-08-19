package is.clipperz.backend

import zio.test.{ ZIOSpecDefault, assertTrue }
import is.clipperz.backend.data.HexString
import is.clipperz.backend.data.Base

object HexStringSuite extends ZIOSpecDefault:
  def spec = suite("hexString")(
    test("isHex") {
      def hexString = """EEAF0AB9ADB38DD69C33F80AFA8FC5E86072618775FF3C0B9EA2314C
                         9C256576D674DF7496EA81D3383B4813D692C6E0E0D5D8E250B98BE4
                         8E495C1D6089DAD15DC7D7B46154D6B6CE8EF4AD69B15D4982559B29
                         7BCF1885C529F566660E57EC68EDBC3C05726CC02FD4CBF4976EAA9A
                         FD5138FE8376435B9FC61D2FC0EB06E3"""
      def string = "tschüs"
         assertTrue(HexString.isHex(hexString)) &&
      (! assertTrue(HexString.isHex(string)))
    } +
    test("create HexString") {
      def hexString = "EEAF0AB9ADB38DD69C33F80AFA8FC5E86072618775FF3C0B9EA2314C"
                    + "9C256576D674DF7496EA81D3383B4813D692C6E0E0D5D8E250B98BE4"
                    + "8E495C1D6089DAD15DC7D7B46154D6B6CE8EF4AD69B15D4982559B29"
                    + "7BCF1885C529F566660E57EC68EDBC3C05726CC02FD4CBF4976EAA9A"
                    + "FD5138FE8376435B9FC61D2FC0EB06E3"
      def hexStringFromConstructor = HexString(hexString)
      assertTrue(hexString.toLowerCase.nn == hexStringFromConstructor.toString)
    } +
    test("compare HexString") {
      def hexStringEven = HexString("0EAF0AB9ADB38DD69C33F80AFA8FC5E86072618775FF3C0B9EA2314C"
                        + "9C256576D674DF7496EA81D3383B4813D692C6E0E0D5D8E250B98BE4"
                        + "8E495C1D6089DAD15DC7D7B46154D6B6CE8EF4AD69B15D4982559B29"
                        + "7BCF1885C529F566660E57EC68EDBC3C05726CC02FD4CBF4976EAA9A"
                        + "FD5138FE8376435B9FC61D2FC0EB06E3")
      def hexStringOdd  = HexString("EAF0AB9ADB38DD69C33F80AFA8FC5E86072618775FF3C0B9EA2314C"
                        + "9C256576D674DF7496EA81D3383B4813D692C6E0E0D5D8E250B98BE4"
                        + "8E495C1D6089DAD15DC7D7B46154D6B6CE8EF4AD69B15D4982559B29"
                        + "7BCF1885C529F566660E57EC68EDBC3C05726CC02FD4CBF4976EAA9A"
                        + "FD5138FE8376435B9FC61D2FC0EB06E3")
      assertTrue(hexStringEven == hexStringOdd)
    } +
    test("check hexEncode correctness") {
      def fromString = HexString("tschüs")
      def fromHex = HexString("74736368c3bc73")
      assertTrue(fromHex == fromString)
    } +
    test("check hexDecode correctness") {
      def str = "tschüs"
      def fromHex = HexString("74736368c3bc73").toString(Base.Dec)
      assertTrue(str == fromHex)
    }
  )
