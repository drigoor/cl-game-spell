(in-package #:cl-game-spell)


(defgeneric act (this))


(defgeneric draw (this))


(define-class scene ()
  actables
  drawables
  fragged)


(defmacro define-scene (name)
  `(progn
     (define-class ,name (scene))
     (define-constructor ,name)))


(defmethod init ((this scene)))


(defmethod uninit ((this scene)))


(defmethod act ((this scene)))


(defmethod draw ((this scene)))


(defmethod act :around ((this scene))
  (when (next-method-p)
    (call-next-method))
  (with-slots (actables) this
    (mapc #'act actables)))


(defmethod draw :around ((this scene))
  (when (next-method-p)
    (call-next-method))
  (with-slots (drawables) this
    (mapc #'draw drawables)))


(defmethod frag (object)
  (with-slots (fragged) *current-scene*
    (push object fragged)))


(defun clear-fragged (scene)
  (with-slots (fragged) scene
    (mapc #'destroy fragged)
    (setf fragged nil)))


(defparameter *current-scene* nil)


(defmacro with-scene (scene &body body)
  `(let ((*current-scene* ,scene))
     ,@body))


(define-class actable ()
  ;; frame-counter
  ;; frame-counter-to-act
  )


;; (defmethod initialize-instance :before ((this actable) &key)
;;   (with-slots (frame-counter frame-counter-to-act) this
;;     (setf frame-counter 0)
;;     (setf frame-counter-to-act 60)))


;; (defmethod act :around ((this actable) &optional ignored)
;;   (declare (ignore ignored))
;;   (with-slots (frame-counter frame-counter-to-act) this
;;     (when (and (>= frame-counter frame-counter-to-act) ; can act?
;;                (next-method-p))
;;       (when (call-next-method)
;;         (setf frame-counter 0)))
;;     (incf frame-counter)))
;;
;;
;; (defgeneric act (actable)
;;   (:documentation "Executes act method if frame-counter is above frame-counter-to-act (it should return t to reset the frame-counter)."))


(defmethod initialize-instance :after ((this actable) &key)
  (with-slots (actables) *current-scene*
    (push this actables)))


(defmethod destroy ((this actable))
  (with-slots (actables) *current-scene*
    (setf actables (remove this actables)))
  (when (next-method-p)
    (call-next-method)))


(define-class drawable ())


(defmethod initialize-instance :after ((this drawable) &key)
  (with-slots (drawables) *current-scene*
    (push this drawables)))


(defmethod destroy ((this drawable))
  (with-slots (drawables) *current-scene*
    (setf drawables (remove this drawables)))
  (when (next-method-p)
    (call-next-method)))
