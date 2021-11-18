(in-package #:cl-game-spell)


(defun run-scene (scene width height title)
  (with-window (width height title)
    (set-target-fps 60)
    (with-scene scene
      (init scene)
      (loop
        (when (window-should-close)     ; dectect window close button or ESC key
          (uninit scene)
          (return))
        (act scene)
        (with-drawing
          (draw scene))))))


(declaim (inline v2))
(defun v2 (x y)
  (make-vector2 :x (coerce x 'single-float) :y (coerce y 'single-float)))


(declaim (inline v2-x))
(defun v2-x (v)
  (vector2-x v))


(declaim (inline v2-y))
(defun v2-y (v)
  (vector2-y v))


(defun v2-add (v1 v2)
  (v2 (+ (v2-x v1) (v2-x v2))
      (+ (v2-y v1) (v2-y v2))))


(defun v2-scale (v scale)
  (v2 (* (v2-x v) scale)
      (* (v2-y v) scale)))


(defun v2-rotate (v angle)
  (let ((x (v2-x v))
        (y (v2-y v))
        (cos (cos angle))
        (sin (sin angle)))
    (v2 (- (* x cos) (* y sin))
          (+ (* y cos) (* x sin)))))


(defun <-v2 (&rest args)
  (loop for (x y) on args by #'cddr
        collect (v2 x y)))
