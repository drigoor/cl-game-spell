(in-package #:cl)


(defpackage #:game-spell
  (:use #:cl
        #:cl-raylib)

  ;; util
  (:export #:define-class
           #:define-constructor)

  ;; main
  (:export #:with-scene
           #:define-scene
           #:scene
           #:init
           #:uninit
           #:act
           #:draw
           #:actable
           #:actables
           #:drawable
           #:drawables)

  ;;
  (:export #:run))
