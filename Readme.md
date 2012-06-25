spanish flashcards
==================

build all
---------

    $ bundle exec rake verbs:build_flashcards

filter by infinitives
---------------------

    $ bundle exec rake verbs:build_flashcards[list:of:infinitives]

filter by tenses
----------------

		$ bundle exec rake verbs:build_flashcards[all,list:of:tenses]

filter by infinitives and tenses
--------------------------------

    $ bundle exec rake verbs:build_flashcards[list:of:infinitives,list:of:tenses]



Generated file is flashcard_set.txt