;; Title: PhilanthroChain - Transparent Impact Protocol

;; OVERVIEW:
;; PhilanthroChain is a decentralized infrastructure that redefines how 
;; communities contribute to causes. It enables frictionless donations, 
;; transparent fund management, and milestone-based accountability, ensuring 
;; every contribution is both visible and verifiable.
;;
;; PURPOSE:
;; Designed for trustless philanthropy, PhilanthroChain eliminates traditional 
;; bottlenecks in charitable giving. By leveraging the Stacks blockchain, 
;; it creates a permanent and auditable ledger of donations, beneficiaries, 
;; and fund utilization. 
;;
;;
;; With PhilanthroChain, giving is no longer just a gesture -it is an 
;; accountable, data-driven contribution toward measurable impact.

;; CONTRACT OWNERSHIP & GOVERNANCE

(define-data-var contract-owner principal tx-sender)

;; ERROR CODES & CONSTANTS

(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-ALREADY-REGISTERED (err u101))
(define-constant ERR-NOT-FOUND (err u102))
(define-constant ERR-INSUFFICIENT-FUNDS (err u103))
(define-constant ERR-BENEFICIARY-NOT-FOUND (err u104))
(define-constant ERR-UTILIZATION-NOT-FOUND (err u105))
(define-constant ERR-INVALID-INPUT (err u106))

;; ROLE DEFINITIONS & ACCESS LEVELS

(define-constant ROLE-ADMIN u1)
(define-constant ROLE-MODERATOR u2)
(define-constant ROLE-BENEFICIARY u3)

;; DATA STRUCTURES & STORAGE MAPS

;; User role assignments for access control
(define-map roles
  { user: principal }
  { role: uint }
)

;; Beneficiary registry with funding details
(define-map beneficiaries
  { id: uint }
  {
    name: (string-utf8 50),
    description: (string-utf8 255),
    target-amount: uint,
    received-amount: uint,
    status: (string-ascii 20),
  }
)

;; Complete donation transaction history
(define-map donations
  { id: uint }
  {
    donor: principal,
    beneficiary-id: uint,
    amount: uint,
    timestamp: uint,
  }
)

;; Fund utilization tracking and milestone management
(define-map utilization
  { id: uint }
  {
    beneficiary-id: uint,
    milestone: uint,
    description: (string-utf8 255),
    amount: uint,
    status: (string-ascii 20),
  }
)

;; GLOBAL COUNTERS & TRACKING VARIABLES

(define-data-var beneficiary-count uint u0)
(define-data-var donation-count uint u0)
(define-data-var utilization-count uint u0)

;; INTERNAL HELPER FUNCTIONS

;; Verify user authorization level
(define-private (is-authorized
    (user principal)
    (required-role uint)
  )
  (let ((role-data (default-to { role: u0 } (map-get? roles { user: user }))))
    (>= (get role role-data) required-role)
  )
)