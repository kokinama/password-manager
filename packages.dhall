let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.2-20220630/packages.dhall sha256:691aff166010760f18ab1f4842ba6184f43747756e00579a050a2a46fa22d014

in  upstream
  with bigints =
    { dependencies =
      [ "arrays"
      , "assert"
      , "console"
      , "effect"
      , "foldable-traversable"
      , "integers"
      , "maybe"
      , "numbers"
      , "partial"
      , "prelude"
      , "psci-support"
      , "quickcheck"
      , "quickcheck-laws"
      , "strings"
      ]
    , repo = "https://github.com/clipperz/purescript-bigints.git"
    , version = "clipperz"
    }
  with arraybuffer =
    { dependencies =
      [ "arraybuffer-types"
      , "arrays"
      , "effect"
      , "float32"
      , "functions"
      , "gen"
      , "maybe"
      , "nullable"
      , "prelude"
      , "tailrec"
      , "uint"
      , "unfoldable"
      ]
    , repo = "https://github.com/clipperz/purescript-arraybuffer"
    , version = "clipperz"
    }
  with concur-core =
    { dependencies =
      [ "aff"
      , "aff-bus"
      , "arrays"
      , "avar"
      , "console"
      , "foldable-traversable"
      , "free"
      , "profunctor-lenses"
      , "tailrec"
      , "control"
      , "datetime"
      , "effect"
      , "either"
      , "exceptions"
      , "identity"
      , "lazy"
      , "maybe"
      , "newtype"
      , "parallel"
      , "prelude"
      , "transformers"
      , "tuples"
      ]
    , repo = "https://github.com/clipperz/purescript-concur-core"
    , version = "clipperz"
    }
  with concur-react =
    { dependencies =
      [ "aff"
      , "arrays"
      , "avar"
      , "console"
      , "concur-core"
      , "foldable-traversable"
      , "free"
      , "nonempty"
      , "profunctor-lenses"
      , "react"
      , "react-dom"
      , "tailrec"
      , "web-dom"
      , "web-html"
      ]
    , repo = "https://github.com/clipperz/purescript-concur-react"
    , version = "clipperz"
    }
  with formless =
    { dependencies =
      [ "aff"
      , "datetime"
      , "effect"
      , "heterogeneous"
      , "profunctor-lenses"
      , "variant"
      , "control"
      , "either"
      , "lists"
      , "maybe"
      , "newtype"
      , "ordered-collections"
      , "prelude"
      , "record"
      , "tuples"
      , "unsafe-coerce"
      ]
    , repo = "https://github.com/clipperz/purescript-formless-independent"
    , version = "clipperz"
    }
  with fortuna =
    { dependencies =
      [ "arraybuffer-types"
      , "console"
      , "foldable-traversable"
      , "monad-control"
      , "psci-support"
      , "strings"
      , "test-unit"
      ]
    , repo = "https://github.com/clipperz/purescript-fortuna"
    , version = "clipperz"
    }
  with float32 =
    { dependencies =
      [ "console", "effect", "prelude", "psci-support", "quickcheck-laws", "gen", "maybe", "quickcheck" ]
    , repo = "https://github.com/clipperz/purescript-float32"
    , version = "clipperz"
    }
  with promises = {
    dependencies = [
      "console"
    , "datetime"
    , "effect"
    , "exceptions"
    , "functions"
    , "prelude"
    , "psci-support"
    , "transformers"
    , "arrays"
    , "either"
    , "foldable-traversable"
    , "unfoldable"
    , "maybe"
    ]
    , repo = "https://github.com/clipperz/purescript-promises"
    , version = "clipperz"
  }
  with subtlecrypto =
    { dependencies =
      [ "aff"
      , "arraybuffer-types"
      , "console"
      , "effect"
      , "either"
      , "exceptions"
      , "foreign"
      , "functions"
      , "maybe"
      , "prelude"
      , "promises"
      , "psci-support"
      , "tuples"
      , "unsafe-coerce"
      ]
    , repo = "https://github.com/clipperz/purescript-subtlecrypto"
    , version = "clipperz"
    }
  with uint =
    { dependencies =
      [ "prelude"
      , "maybe"
      , "numbers"
      , "enums"
      , "gen"
      ]
    , repo = "https://github.com/clipperz/purescript-uint"
    , version = "clipperz"
    }