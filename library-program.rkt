#lang racket
(require test-engine/racket-tests)
(require data/gvector)
;(require data/order)

;;; This program will take the input of books and according information, and provide a sorted list of every book entered.


(define-struct Book (title author pages) #:transparent)

(define book1 (make-Book "The Great Gatsby" "Fitzgerald" 180))
(define book2 (make-Book "The Bible" "Jesus" 15000))
(define book3 (make-Book "Eragon" "Paolini" 694))

(define my-library (list book1 book2 book3))

;;; this function takes a list of Books and returns the titles of those books
(check-expect (extract-titles
               (list (Book "The Great Gatsby" "Fitzgerald" 180)
                     (Book "Eragon" "Paolini" 694)
                     (Book "The Bible" "Jesus" 15000)))
              (list "The Great Gatsby" "Eragon" "The Bible"))

(check-expect (extract-titles my-library)
              (list "The Great Gatsby" "The Bible" "Eragon"))

(define (extract-titles books)
  (define result (gvector))
  (for ([i (in-range 0 (length books))]) ;; for(int i = 0; i < books.length; i++) { ... }
    (gvector-add! result (Book-title (list-ref books i))))
  (gvector->list result))


;; this function takes a list of Books and returns a list of the titles in ascending order of number of pages

(check-expect (sort-by-pages my-library)
              (list "The Great Gatsby" "Eragon" "The Bible"))

(check-expect (sort-by-pages (list book1 book2 book3))
              (list "The Great Gatsby" "Eragon" "The Bible"))

(define (sort-by-pages books)
  (extract-titles (sort books < #:key Book-pages)))

;; this function takes a list of Books, and returns a list of the titles in lexicographical order according to title
(check-expect (sort-by-title (list book1 book2 book3))
              (list "Eragon" "The Bible" "The Great Gatsby"))

(check-expect (sort-by-title my-library)
              (list "Eragon" "The Bible" "The Great Gatsby"))

(define (sort-by-title books)
  (extract-titles (sort books string<? #:key Book-title)))

;; this function takes a list of Books, and returns a list of titles in lexicographical order according to author

(check-expect (sort-by-author (list book1 book2 book3))
              (list "The Great Gatsby" "The Bible" "Eragon"))

(check-expect (sort-by-author my-library)
              (list "The Great Gatsby" "The Bible" "Eragon"))

(define (sort-by-author books)
  (extract-titles (sort books string<? #:key Book-author)))

;; this function takes a list of Books and a string (of either author, title, or pages) and returns a list of titles sorted accordingly.
;; list and string -> list

(check-expect (sort-how my-library "title")
              (list "Eragon" "The Bible" "The Great Gatsby"))

(check-expect (sort-how my-library "author")
              (list "The Great Gatsby" "The Bible" "Eragon"))

(check-expect (sort-how my-library "pages")
              (list "The Great Gatsby" "Eragon" "The Bible"))

(define (sort-how books how)
  (if (string=? how "author")
      (sort-by-author books)
      
      (if (string=? how "title")
          (sort-by-title books)
          (sort-by-pages books))))

;; this function asks the user for information (the title, author, and number of pages of a book) and returns the Book
;; void -> Book

#; (check-expect (read-Book) (make-Book "Hoot" "Joe" 100))

(define (read-Book)
  (println "Enter the book title.")
  (define title (read-line))
  
  (println "Enter the author's name.")
  (define author (read-line))
  
  (println "Enter the number of pages.")
  (define pages (read-line))
  
  (make-Book title author (string->number pages)))

;; this function asks the user for the information about many books and returns a list of those Books

#;(check-expect (read-library)
              (list (Book "Hoot" "Joe" 100)))

;;  (for ([i (in-range 0 (length books))]) ;; for(int i = 0; i < books.length; i++) { ... }
;;  (gvector-add! result (Book-title (list-ref books i))))
;;  (gvector->list result))

(define (read-library)
  (println "How many books would you like to enter?")
  (define num (string->number (read-line)))
  
  (define result (gvector))
  
  (for ([i (in-range 0 num)])
    (gvector-add! result (read-Book)))
  (gvector->list result))

;; this function takes a list of Books, then asks the user how the given list should be sorted (author, title, or pages), and returns the sorted list
;; list-of-Books -> list-of-Books

#;(check-expect (UI-sort-library my-library)
              (list "Eragon" "The Bible" "The Great Gatsby"))

(define (UI-sort-library library)
  (println "How should these books be sorted? (author, title, or pages?")
  (sort-how library (read-line)))

;; this function reads a library and how to sort it, then returns the sorted list of titles
;; void -> list

#; (check-expect (read-library-and-sort)
              (list "Hoot" "Cookbook"))

(define (read-library-and-sort)
  (UI-sort-library (read-library)))

(test)