(asdf:defsystem #:cl-game-spell
  :description "A Common Lisp Game Spell"
  :author "Rodrigo Correia <https://github.com/drigoor>"
  :license "MIT License"
  :version "0.0.1"
  :serial t
  :depends-on (#:cl-raylib)
  :components ((:file "package")
               (:file "util")
               (:file "math")
               (:file "main")
               (:file "raylib")))
