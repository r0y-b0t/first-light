:- use_module(library(test_wizard)).

:- file_name_extension(query, log, File), set_prolog_flag(log_query_file, File).

:- public make_tests/1.

make_tests(Module) :-
    prolog_flag(log_query_file, File),
    make_tests(Module, File, current_output).

:- load_test_files([]).
