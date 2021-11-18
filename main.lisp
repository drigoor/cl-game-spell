(in-package #:cl-game-spell)


(defparameter *current-scene* nil)


(defmacro with-scene (scene &body body)
  `(let ((*current-scene* ,scene))
     ,@body))


(define-class scene ()
  actables
  drawables)


(defmacro define-scene (name)
  `(progn
     (define-class ,name (scene))
     (define-constructor ,name)))


(defgeneric init (scene))


(defgeneric uninit (scene))


(defgeneric act (scene))


(defgeneric draw (scene))


(define-class actable ()
  frame-counter
  frame-counter-to-act)


(defmethod initialize-instance :before ((this actable) &key)
  (with-slots (frame-counter frame-counter-to-act) this
    (setf frame-counter 0)
    (setf frame-counter-to-act 60)))


(defmethod initialize-instance :after ((this actable) &key)
  (with-slots (actables) *current-scene*
    (push this actables)))


(defgeneric act (scene)
  (:documentation "Executes act method if frame-counter is above frame-counter-to-act (it should return t to reset the frame-counter)."))


(define-class drawable ())


(defmethod initialize-instance :after ((this drawable) &key)
  (with-slots (drawables) *current-scene*
    (push this drawables)))


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


