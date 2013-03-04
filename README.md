microtest
=========

Absolutely minimal yet pretty useful test framework

Usage
-----

Each test is a subdirectory of microtest directory. Name of this directory is a name of a test.

Directory may contain following files:
* args - contains arguments passed to tested executable. If PREPEND is not set then this file contains entire
         command to be executed
* in - contains data to be feed to tested process' stdin
* out - the only required file. Contains expected process output
* err - Contains expected stderr output. If it does not exist, stderr is ignored. [TODO]

Return code is number of failed tests.
