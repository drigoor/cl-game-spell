(in-package #:game-spell)


(defmacro define-class (class-name superclasses-names &rest slots-names)
  (let ((slots (mapcar #'(lambda (slot-name)
                           (list slot-name
                                 :initarg (intern (string slot-name) :keyword)
                                 :initform nil))
                       slots-names)))
    `(defclass ,class-name ,superclasses-names
       (,@slots))))


(defmacro define-constructor (class)
  (let ((*print-case* :upcase)
        (name (intern (format nil "MAKE-~a" class))))
    `(defun ,name (&rest args)
       (apply #'make-instance ',class args))))
