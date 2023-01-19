(in-package #:cl-game-spell)


(defconstant +pi+ (coerce pi 'single-float))


(defconstant +2pi+ (coerce (* 2 pi) 'single-float))


(declaim (inline v2))
(defun v2 (x y)
  (vec (coerce x 'single-float) (coerce y 'single-float)))


(declaim (inline v2-x))
(defun v2-x (v)
  (vx v))


(declaim (inline v2-y))
(defun v2-y (v)
  (vy v))


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


(defun v2-wrap (v2)
  (let* ((x (v2-x v2))
         (y (v2-y v2))
         (screen-max-x (get-screen-width))
         (screen-max-y (get-screen-height))
         (new-x (cond ((>= x screen-max-x)
                       0)
                      ((< x 0)
                       (1- screen-max-x))
                      (t
                       x)))
         (new-y (cond ((>= y screen-max-y)
                       0)
                      ((< y 0)
                       (1- screen-max-y))
                      (t
                       y))))
    (v2 new-x new-y)))


(defun keep-angle-in-range (angle)
  (let ((angle angle))
    (loop while (< angle 0)
          do (incf angle +2pi+))
    (loop while (> angle +2pi+)
          do (decf angle +2pi+))
    angle))
