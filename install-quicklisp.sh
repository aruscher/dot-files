#!/usr/bin/env bash


curl -O https://beta.quicklisp.org/quicklisp.lisp
sbcl --load quicklisp.lisp --eval "(quicklisp-quickstart:install)" --eval "(exit)"
rm quicklisp.lisp
