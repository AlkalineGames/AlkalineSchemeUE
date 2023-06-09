;;; Copyright 2023 Alkaline Games, LLC.
;;;
;;; This Source Code Form is subject to the terms of the Mozilla Public
;;; License, v. 2.0. If a copy of the MPL was not distributed with this
;;; file, You can obtain one at https://mozilla.org/MPL/2.0/.

;;; AlkalineScemeUE boot program

( ;; TODO: @@@ NEEDS TO BE A LIST OF EXPRESSIONS FOR NOW
(ue-log "TRACE SCHEME >>> BEGIN booting AlkalineSchemeUE")

(define trace-log #f)
(define trace-print #f)

(define (hook-player-input world device action durations func)
  ;; TODO: @@@ ASSUMING 'pointing DEVICE
  ;;(ue-log "TRACE SCHEME >>> BEGIN hook-input")
  (define (trace-event event finger location)
    (let ((info (format #f "TRACE SCHEME >>> ~S finger ~S at ~S" event finger location)))
      (if trace-log   (ue-log info))
      (if trace-print (ue-print-string world info))))
  (ue-bind-input-touch world 'pressed
    (lambda (finger location) (trace-event "pressed" finger location)))
  (ue-bind-input-touch world 'released
    (lambda (finger location) (trace-event "released" finger location)))
  (ue-bind-input-touch world 'repeated
    (lambda (finger location) (trace-event "repeated" finger location))))
  ;;(ue-log "TRACE SCHEME <<< END hook-input"))

(define (open-scheme-editor screen-pos)
  ;; TODO: ### IMPLEMENT
  (if trace-log (ue-log (format #f "TRACE SCHEME (open-scheme-editor ~S)" screen-pos))))

(ue-hook-on-world-begin-play
  (lambda (world)
    ;;(ue-log "TRACE SCHEME lambda from (ue-hook-on-world-initialized-actors)")
    (ue-print-string world "Alkaline Scheme is alive")
    (hook-player-input world 'pointing 'press '(200 0 200 0)
      (lambda (screen-pos) (open-scheme-editor screen-pos)))))

(ue-log "TRACE SCHEME <<< END booting AlkalineSchemeUE")
)
;; TODO: ### s7_eval_c_string(...) is reporting "syntax error"
;; here after the last expression successfully executes ?!?
