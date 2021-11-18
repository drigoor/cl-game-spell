(in-package #:cl)


(defpackage #:cl-game-spell
  (:nicknames #:game-spell)
  (:use #:cl
        #:cl-raylib)

  ;; util
  (:export #:define-class
           #:define-constructor
           #:random-between
           #:+pi+)

  ;; main
  (:export #:with-scene
           #:scene
           #:define-scene
           #:init
           #:uninit
           #:act
           #:draw
           #:actable
           #:drawable)

  ;; raylib
  (:export #:run-scene
           #:v2
           #:v2-x
           #:v2-y
           #:v2-add
           #:v2-scale
           #:v2-rotate
           #:<-v2))
