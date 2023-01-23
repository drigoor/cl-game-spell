(in-package #:cl-game-spell)


(defun run-scene (scene width height title)
  (with-window (width height title)
    (set-target-fps 60)
    (with-scene scene
      (init scene)
      (loop
        (when (window-should-close) ; dectect window close button or ESC key
          (destroy scene)
          (return))
        (clear-fragged scene)
        (update scene)
        (with-drawing
          (draw scene))))))
