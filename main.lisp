(in-package #:cl-game-spell)


;; -------------------------------------


(defmacro define-game-object (name superclasses-names &rest slot-names)
  `(progn
     (define-class ,name ,superclasses-names ,@slot-names)
     (define-constructor ,name)))


;; -------------------------------------


(define-class updateable ())
(define-class drawable ())
(define-class fragable ())

(defgeneric update (updateable))
(defgeneric draw (drawable))
(defgeneric frag (fragable))

(defgeneric destroy (fragable))


;; -------------------------------------


(define-game-object scene ()
  updateables
  drawables
  fragged)


(defmethod init ((this scene)))
(defmethod destroy ((this scene)))
(defmethod update ((this scene)))
(defmethod draw ((this scene)))
(defmethod frag ((this scene))
  (error "These Are Not the Droids You Are Looking For"))


(defmethod update :around ((this scene))
  (when (next-method-p)
    (call-next-method))
  (with-slots (updateables) this
    (mapc #'update updateables)))


(defmethod draw :around ((this scene))
  (when (next-method-p)
    (call-next-method))
  (with-slots (drawables) this
    (mapc #'draw drawables)))


(defun clear-fragged (scene)
  (with-slots (fragged) scene
    (mapc #'destroy fragged)
    (setf fragged nil)))


;; -------------------------------------


(defparameter *current-scene* nil)


(defmacro with-scene (scene &body body)
  `(let ((*current-scene* ,scene))
     ,@body))


(defmethod destroy :around ((this updateable))
  (when (next-method-p)
    (call-next-method))
  (with-slots (updateables) *current-scene*
    (setf updateables (remove this updateables))))


(defmethod destroy :around ((this drawable))
  (when (next-method-p)
    (call-next-method))
  (with-slots (drawables) *current-scene*
    (setf drawables (remove this drawables))))


;; -------------------------------------


(defmethod initialize-instance :after ((this updateable) &key)
  (with-slots (updateables) *current-scene*
    (push this updateables)))


(defmethod initialize-instance :after ((this drawable) &key)
  (with-slots (drawables) *current-scene*
    (push this drawables)))


(defmethod frag ((this fragable))
  (with-slots (fragged) *current-scene*
    (push this fragged)))


;; (defmethod initialize-instance :before ((this updateable) &key)
;;   (with-slots (frame-counter frame-counter-to-update) this
;;     (setf frame-counter 0)
;;     (setf frame-counter-to-update 60)))
;;
;;
;; (defmethod update :around ((this updateable) &optional ignored)
;;   (declare (ignore ignored))
;;   (with-slots (frame-counter frame-counter-to-update) this
;;     (when (and (>= frame-counter frame-counter-to-update) ; can update?
;;                (next-method-p))
;;       (when (call-next-method)
;;         (setf frame-counter 0)))
;;     (incf frame-counter)))
;;
;;
;; (defgeneric update (updateable)
;;   (:documentation "Executes update method if frame-counter is above frame-counter-to-update (it should return t to reset the frame-counter)."))
