(in-package #:cl)


(defpackage #:cl-game-spell
  (:nicknames #:game-spell)
  (:use #:cl
        #:cl-raylib
        #:3d-vectors)

  ;; util
  (:export #:define-class
           #:define-constructor)

  ;; math
  (:export #:+pi+
           #:+2pi+
           #:v2
           #:v2-x
           #:v2-y
           #:v2-add
           #:v2-scale
           #:v2-rotate
           #:<-v2
           #:v2-wrap
           #:keep-angle-in-range
           #:random-between)

  ;; main
  (:export #:define-game-object
           #:define-scene
           #:destroy
           #:destroy
           #:draw
           #:drawable
           #:frag
           #:fragable
           #:init
           #:make-scene
           #:scene
           #:update
           #:updateable)

  ;; raylib
  (:export #:run-scene))
